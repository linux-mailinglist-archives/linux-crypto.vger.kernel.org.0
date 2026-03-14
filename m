Return-Path: <linux-crypto+bounces-21943-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNoXKQ/utGm/uQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21943-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 06:11:43 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 477AF28BB53
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 06:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6A0E301673F
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1F2FE078;
	Sat, 14 Mar 2026 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="kVl7ZJIu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18F230270;
	Sat, 14 Mar 2026 05:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773465101; cv=none; b=vGf6G37g8eiYxwZPZsUPGj4nX/9Rxt3aHleu3PkNXJRUresenPgqqIV4QuP7TaskhA2X1aFGg48BhpwZY3bSW504j4QWs+wklEeKohUwosZ5151PEBGH/YN9Qd8bkSXx4as+TGBXq5hzuWNkipIBgpb+0VH8Td/oWu1PcnxDlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773465101; c=relaxed/simple;
	bh=TXjVXVxGG3t/2ztaX9R4f2FBNerQjR6bBLTnRbOp550=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDDZMkt0ViZ86VVWiSETD88QYX56R6y7PhcrmU2Y7v7RRILpvx41G7D9pbEb1Tj3HsoQBmSolMLiCcmzBRTkcryWwl1Yl07D7n3h6kfAIKJDr7hxeRw02rDI8ZJsgKn+odKLTEtt92neQnslMkPORj2YD1vrte22tbl7yHchfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=kVl7ZJIu; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=5//6MAnVROxk1OhCdNgq2wXDoUExF4rMsbOyjQ5WDXo=; 
	b=kVl7ZJIunef1TYsmInPjj+OsPDuKMhTZj0WgsuEp/0nUfiLG2AqVIN7pp9TJsAw+MREkpffDsn3
	Em66xvthMdKfxcV0/jFzJNFVzeIff96XrrWx516O6i9mQk25QOTc2cwRlE4vrhoilzYoLus1ik6cS
	sTNA8jU8NRdFYy6JjRFuaPFLtLw0ogb8AlJp3oBaOYIjnwRYv/INvCTuWiy1utcj7rb4WaxVh3fWu
	/63tD2BrxTOOoIPOIqmDOZWzo2J68YQ110N//0yKqKsxVr2u++cG6mlE3Y+5lHbfCYIECVFA4lm2S
	sV62Uz5p8UmhUUQeoTftnVQGOgfrXWNkEAvA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1HHa-00EL7S-2L;
	Sat, 14 Mar 2026 13:11:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 14:11:26 +0900
Date: Sat, 14 Mar 2026 14:11:26 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: davem@davemloft.net, ebiggers@kernel.org, ardb@kernel.org,
	geert@linux-m68k.org, kees@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: tcrypt: clamp num_mb to avoid divide-by-zero
Message-ID: <abTt_hB6vcjm1JVJ@gondor.apana.org.au>
References: <20260302235916.769942-1-saeed.mirzamohammadi@oracle.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302235916.769942-1-saeed.mirzamohammadi@oracle.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TAGGED_FROM(0.00)[bounces-21943-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 477AF28BB53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 02, 2026 at 03:59:14PM -0800, Saeed Mirzamohammadi wrote:
> Passing num_mb=0 to the multibuffer speed tests leaves test_mb_aead_cycles()
> and test_mb_acipher_cycles() dividing by (8 * num_mb). With sec=0 (the
> default), the module prints "1 operation in ..." and hits a divide-by-zero
> fault.
> 
> Force num_mb to at least 1 during module init and warn the caller so the
> warm-up loop and the final report stay well-defined.
> 
> To reproduce:
> sudo modprobe tcrypt mode=600 num_mb=0
> 
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> ---
>  crypto/tcrypt.c | 5 +++++
>  1 file changed, 5 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


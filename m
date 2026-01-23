Return-Path: <linux-crypto+bounces-20286-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ2hLPkMc2ncrwAAu9opvQ
	(envelope-from <linux-crypto+bounces-20286-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:54:01 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761770943
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 06:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7313F30158A3
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0039F307;
	Fri, 23 Jan 2026 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="kWomijlT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48C39E19A;
	Fri, 23 Jan 2026 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147632; cv=none; b=FwSzqTz1xNDlFvhPYooYuC15ocsJaT+cHDh2CctfO2ieLXKXdUEjNm94kdRPg612Xn2lsiVPMelHtjwXcKhPEcj4vcKJj8/Wl5H7dPyfukyjPyQNWqWSdzf8UvMGVnaxaV7lOySFbBSVLJNgjsCEEbRq9kCwy0JazQN62+bGONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147632; c=relaxed/simple;
	bh=uNTxZ+Yox70Pa5t4GuDCRswP7fRT+r1vdh2egeiSV6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKwVSl1ka4XOGue04BIkCm0pBEovEA5nGXvuk3ehkd1ey8o4x3cYEnUVyUvvnwJO94ge1ThjRnjaUebXPnFqHqQGcRYL7XDZaiL2vB40GX4lEfzAsMvAtsMgNc82j61vqRyvrT5nEetUCCoN8OBLMX6ry8xRrCDd8N+C8+CfUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=kWomijlT; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=FYqXWC4AN6OTKVrSMvOeym0x0RrRL6mOANNNyCeSsVM=; 
	b=kWomijlT27yZjBzJmWgcGXSxJ/ndfddQTziAbl1dsiWVnJoFdQxUUx6F3Jo7tZbxHdu7LFsOesf
	7iRep3LTcKN0f/5CfkGswJ2AD/J8vhGmhXkLF/vCC7M2IKV99MMdcm/9ExDrbFeOUA7SgfOtqigjk
	geeQ1QoTzUuNSzw90QVc5dSfGmE6iVTk9fZDtA26/umae1lSU8ioIHb5H0GP9IwqhbrlnPUV72eRZ
	zL+9SEheDXn/PY54Lo3z+kOM+y9/6psxuHbBjjrhN8KnUq/HTuytLUVbjTD2vTw3bWCJErhD985Bu
	2ywnAwbYvb+BMzzfvkpfE74QJG/MWB5TZTNQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vjA6u-001VKf-1P;
	Fri, 23 Jan 2026 13:53:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jan 2026 13:53:32 +0800
Date: Fri, 23 Jan 2026 13:53:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] crypto: acomp - Use unregister_acomps in
 register_acomps
Message-ID: <aXMM3MhHlpQq85KP@gondor.apana.org.au>
References: <20251219145124.36792-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219145124.36792-1-thorsten.blum@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20286-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7761770943
X-Rspamd-Action: no action

On Fri, Dec 19, 2025 at 03:51:17PM +0100, Thorsten Blum wrote:
> Replace the for loop with a call to crypto_unregister_acomps(). Return
> 'ret' immediately and remove the goto statement to simplify the error
> handling code.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  crypto/acompress.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


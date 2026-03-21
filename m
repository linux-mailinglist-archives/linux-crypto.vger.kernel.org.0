Return-Path: <linux-crypto+bounces-22190-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAczJO9ZvmmYNQMAu9opvQ
	(envelope-from <linux-crypto+bounces-22190-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:42:23 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6122E432B
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841A53034E05
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C23351C3D;
	Sat, 21 Mar 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="m3o7dTNy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548B3502A3;
	Sat, 21 Mar 2026 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774082517; cv=none; b=qOqzhb797zJgYH84x5yMto2zkxryUSZv65NcYABwB+MJUM7rwyLyq1xtvj4FMzUht4Yc+Sl+y31om1AdyUxAWYpV1xsyHSVP1F1q+D8spybR45Pi+oToBx+Z0uJDJkvCF/+W2xm8TzZe1DrPVJjvLt47ek9o9E6Sc9Mn6r8tviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774082517; c=relaxed/simple;
	bh=BUetTRhkxdQWfs0le0sjotn07EfTu62f0LNIZv865Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+VXC/N5XvKlvZ6sZHR8kp5uOEjiQt7yIXqansn0D/rB6AKVssklTIxhqS5dSmEBjCwGKQH1AgwihC6IEMoJf2ZY8dWoD96dQFS/kXnndy0jOKUoPf3C1jMd6CZRrD7pepG1uW1BQuUcUWqVegFT+oJ8vDgzh0KF8SH2PteIaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=m3o7dTNy; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=R9boKfUgb1sWuyro63MYYbVoVEMu2ElqOcoSMt/jWGA=; 
	b=m3o7dTNyfcMIidEDeLkcs8KJdsCpWA1cNP2kqmDlNYY98UfjQChF9PkvEpPBj3h7JhAA8luRuId
	vNc/w/kdX2VU8RDOrQRZP2AXW+g7YQks6a6qsz3up1beDY7dUxA7hp9kEDpf8qVHWt4yGB/KEUaoz
	i4X6m1+hjXI3/DB0ZZ2FgQB81BQwWD7A7MEN1ozW5VM9JlW1rHiG6sXFuM/6LRsH+wBjn2pVpwNpf
	69inLEUAOZGUbMnCEyXBvis4stwZv/ShhsNjIRnmxuoym3sVjJhdgvujgjemAyySScAw5Ct7i/a3m
	zm1kwXAYdz50P/0A+S+fkeoVGOyx6imXsegA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3ru0-00GJ4b-2p;
	Sat, 21 Mar 2026 16:41:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:41:48 +0900
Date: Sat, 21 Mar 2026 17:41:48 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: krb5enc - fix sleepable flag handling in encrypt
 dispatch
Message-ID: <ab5ZzInm455TO7O-@gondor.apana.org.au>
References: <20260309062624.1848239-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309062624.1848239-1-atwellwea@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22190-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: EB6122E432B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 12:26:24AM -0600, Wesley Atwell wrote:
> krb5enc_encrypt_ahash_done() continues encryption from an ahash
> completion callback by calling krb5enc_dispatch_encrypt().
> 
> That helper takes a flags argument for this continuation path, but it
> ignored that argument and reused aead_request_flags(req) when setting
> up the skcipher subrequest callback. This can incorrectly preserve
> CRYPTO_TFM_REQ_MAY_SLEEP when the encrypt step is started from callback
> context.
> 
> Preserve the original request flags but clear
> CRYPTO_TFM_REQ_MAY_SLEEP for the callback continuation path, and use
> the caller-supplied flags when setting up the skcipher subrequest.
> 
> Fixes: d1775a177f7f ("crypto: Add 'krb5enc' hash and cipher AEAD algorithm")
> Assisted-by: Codex:GPT-5
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  crypto/krb5enc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


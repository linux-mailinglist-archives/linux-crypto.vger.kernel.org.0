Return-Path: <linux-crypto+bounces-23622-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d8acEBNc9mlYUQIAu9opvQ
	(envelope-from <linux-crypto+bounces-23622-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 22:18:27 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F64B36BA
	for <lists+linux-crypto@lfdr.de>; Sat, 02 May 2026 22:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0A3E300A4CA
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2026 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866136D513;
	Sat,  2 May 2026 20:18:20 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B92D7DEF;
	Sat,  2 May 2026 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777753100; cv=none; b=F2ZwMDCgkH+awq+TUxA2nobTpVX6me2zdbLHYGWGU0FHb2GgfIpIruMWTXIKtYct2l4WkPLCFNkQElbPnWmKHyepwnQ1mliKR26pyfeGMRf74/N3FLDq4DO5nBOFf8yxf0N16uuxGoC2lYa6uFGqLLZkTPwy5UxpyeLQlS4+tKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777753100; c=relaxed/simple;
	bh=Oc8JqvCsGcw3Cn8xm1DWHPB5ZvHWKHt4sXz5mP9fVDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxrd/7gcx7RsUU/9utYybCaAyEsLOmkkvO7Iqse3IIMg/QYHv1YFyCmDNg78bKn62YXxYiCXyMvbXb2fV2FqZvTsGSR8G5XivVSPzK8ElerpYrYhqRSm4xrsxz5Zzz8eutkRLw9pSalYRh/o0HFThG6v+/j9p5SMpgwuUN4Ega4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id C9AF135F;
	Sat, 02 May 2026 22:08:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B5841600D3A9; Sat,  2 May 2026 22:08:12 +0200 (CEST)
Date: Sat, 2 May 2026 22:08:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Vitaly Chikunov <vt@altlinux.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ecrdsa - fix unknown OID check in
 ecrdsa_param_curve
Message-ID: <afZZrCNmn3Bfwauf@wunner.de>
References: <20260502190903.252061-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502190903.252061-3-thorsten.blum@linux.dev>
X-Rspamd-Queue-Id: A09F64B36BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23622-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:mid,wunner.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]

On Sat, May 02, 2026 at 09:09:04PM +0200, Thorsten Blum wrote:
> The ->curve_oid check in ecrdsa_param_curve() rejects the valid enum
> value 0 (OID_id_dsa_with_sha1), but look_up_OID() returns OID__NR on
> lookup failure. Compare ->curve_oid with OID__NR instead to ensure that
> only unknown OIDs return -EINVAL.
> 
> Fixes: 0d7a78643f69 ("crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

> +++ b/crypto/ecrdsa.c
> @@ -145,7 +145,7 @@ int ecrdsa_param_curve(void *context, size_t hdrlen, unsigned char tag,
>  	struct ecrdsa_ctx *ctx = context;
>  
>  	ctx->curve_oid = look_up_OID(value, vlen);
> -	if (!ctx->curve_oid)
> +	if (ctx->curve_oid == OID__NR)
>  		return -EINVAL;
>  	ctx->curve = get_curve_by_oid(ctx->curve_oid);
>  	return 0;

This is a fairly harmless logic bug:  OID_id_dsa_with_sha1 is not
a valid curve and so get_curve_by_oid() returns NULL, which is
assigned to ctx->curve.

The function you're changing, ecrdsa_param_curve(), is called
from the ecrdsa_params ASN.1 parser, which is invoked from
ecrdsa_set_pub_key().  That function does perform a NULL pointer
check for ctx->curve right after the ASN.1 parser returns.

Your patch will change the return value for an unknown OID from
-ENOPKG to -EINVAL, but that probably doesn't matter much.

Thanks,

Lukas


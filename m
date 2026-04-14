Return-Path: <linux-crypto+bounces-23010-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAumDtB73mkHEwAAu9opvQ
	(envelope-from <linux-crypto+bounces-23010-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 19:39:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7C3FD2AF
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 353953018B7F
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Apr 2026 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604271FF7C8;
	Tue, 14 Apr 2026 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxmtW9Gy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2B3F0774;
	Tue, 14 Apr 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188358; cv=none; b=RkJy+MFOqFMMnQDrjEFyYNO3+01Pz+PNwrIkVpegWchxwMKFKSdZ6SzUvRditLs+2/rX/sWlCR6AO4DevzKIFIc9iB/nZIVLEgscjhnveSfWdJxhMFSebWn+5fyNl7yn2uYTXxOmasb03DM4YVnkL6RmLpDCK3THpG94czRI/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188358; c=relaxed/simple;
	bh=NRshPJLZzPSYtGUVUS3Pur9Y7qRXn/DFifa5EeqysCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpVmTdhlK/kIYG0hk+deRWQSALfxc7Cm5nm90IPlALGeDR91hvpoEOPNC2pqCAeLd0JK3UBSw2gmdPyOJdWCRy9eioTvV2fdAofCO00MCHw5yzW1WfWh/FnvGObFpYTfjRUkgkkUdQbUGC+3Jccn6nHKMq+1w13WpXQWWDcb3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxmtW9Gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D844C2BCB4;
	Tue, 14 Apr 2026 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776188357;
	bh=NRshPJLZzPSYtGUVUS3Pur9Y7qRXn/DFifa5EeqysCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxmtW9GyA8OAOXiJKlt7O7hpPuMNP04BvanoChc0gGgQ6LZC3h848SaAUKicyJG7A
	 w4KU4hQi46RaLC9MPjvrOuOMik6fL074vUBiQI5MmjmV+f12knWX+Hj/TlbdeHJeUs
	 tdG6LQSZ/Z4Gk1Z43tluz/VVUaMGhWX7vsgJTB4FLcqY7ghew9Nwh//mFqCJ6AzJVT
	 VszFEEvVzPBxRvJ3iF3veMw09LPXyCBTGBKtgMYM6DV4tcBraUgF3tB8If22e3egMV
	 nmjxl6TX1jsv+unTpRwaQxfsKpIqqeVIT9ps02UGXu7s2+951xZzviW9bu2EtXqwmJ
	 tuQZXrKdLI+8Q==
Date: Tue, 14 Apr 2026 10:39:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: blake2s - use memcpy_and_pad in
 __blake2s_init
Message-ID: <20260414173915.GB24456@quark>
References: <20260414154902.344182-3-thorsten.blum@linux.dev>
 <20260414154902.344182-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414154902.344182-4-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23010-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: B7E7C3FD2AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 05:49:04PM +0200, Thorsten Blum wrote:
> Use memcpy_and_pad() instead of memcpy() followed by memset() to
> simplify __blake2s_init(). Use sizeof(ctx->buf) instead of the macro
> BLAKE2S_BLOCK_SIZE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/crypto/blake2s.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
> index 648cb7824358..f0e0ce0b30a5 100644
> --- a/include/crypto/blake2s.h
> +++ b/include/crypto/blake2s.h
> @@ -70,9 +70,8 @@ static inline void __blake2s_init(struct blake2s_ctx *ctx, size_t outlen,
>  	ctx->buflen = 0;
>  	ctx->outlen = outlen;
>  	if (keylen) {
> -		memcpy(ctx->buf, key, keylen);
> -		memset(&ctx->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
> -		ctx->buflen = BLAKE2S_BLOCK_SIZE;
> +		memcpy_and_pad(ctx->buf, sizeof(ctx->buf), key, keylen, 0);
> +		ctx->buflen = sizeof(ctx->buf);

I'm wondering if this is actually better.  It's another helper function
to remember.  Also 'keylen' can be a compile-time constant here, and
compilers know what memcpy() and memset() do, so they will optimize the
code accordingly.  The helper function takes away the compiler's ability
to perform this optimization.  If this was already an out-of-line
function, it would be a bit more convincing.

- Eric


Return-Path: <linux-crypto+bounces-20582-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DfsAYnDgWmgJgMAu9opvQ
	(envelope-from <linux-crypto+bounces-20582-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Feb 2026 10:44:41 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E9D7043
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Feb 2026 10:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8DC3086AC5
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Feb 2026 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47047396D1A;
	Tue,  3 Feb 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOMnrh7L"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA3310774;
	Tue,  3 Feb 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111745; cv=none; b=TPlxwRUXZmWszM4JYcwpT73egEUB/Ze2Fy/tGxO2b0tzyYUnphCCnAgcmW6h87M+uxg4yf2tbgFC+ixonwyMbwbjgmOkvysUdW4qNpkGuujyLpy/Wq3lffjCss0L6NWg1HBnjRErMZ+jvT7qaQnNFrrkBViLyPT4hinzPnv3QiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111745; c=relaxed/simple;
	bh=6pMsV8sf8HRYnNFFTfHlVUOrAP/8f0LluKt7cl+SlNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8PabA/xY6nuO/y5TbCpj2DJoSxxYGnxPUXnpgflQFKhq2aXod85U9WFLEVbg1mTtVcnYbJ+X+WZr3NmDrgUlwLcJqqX6eCnV2X0fjt04ug61ePFJZsJ1FxkDurTq3WTXMnPYsF1QyTNV19hJFkXZIA77BrcyMUGLX9qsdVTfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOMnrh7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130CAC116D0;
	Tue,  3 Feb 2026 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111744;
	bh=6pMsV8sf8HRYnNFFTfHlVUOrAP/8f0LluKt7cl+SlNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOMnrh7L1k2rMAJBoDDBlgrnHc7sjLzd1tZuMXG8tk8vKfm7bwHp/VZRndfXrsDUF
	 9wxDfWLA5whC0iYU9V1jdEFQDcHKqokqxUW2KqTWQDJl+XCtKDou2xIzi3VZRJpUeL
	 79MXw6DRfOZ73hau/6giG6raNMJBECQS1pUy8Bs7pwJp1jL7QAhXGbt6biSAOlNE3u
	 FVuTNoOebsMHnC3LaTn/48HcWXYrLh+Sh1fLnIC41/7WT1D/tf8O8YtQt/ns3jJNKT
	 jVOrJHPZJQNWpy+MvV0mNMKzdfMyaBStuI5xceakEVjVS6s9k7AfjY0lZGiOt0wjP6
	 qusSII5R1sTxA==
Date: Tue, 3 Feb 2026 10:42:21 +0100
From: Antoine Tenart <atenart@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: safexcel - Group authenc ciphersuites
Message-ID: <aYHC31jHukTIPRxy@kwain>
References: <20260202202203.124015-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202202203.124015-1-olek2@wp.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[wp.pl];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20582-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wp.pl:email]
X-Rspamd-Queue-Id: 759E9D7043
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 09:21:07PM +0100, Aleksander Jan Bajkowski wrote:
> Move authenc(sha1,des) and authenc(sha1,3des) ciphersuites to appropriate
> groups. No functional changes intended.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Acked-by: Antoine Tenart <atenart@kernel.org>

Thanks!

> ---
>  drivers/crypto/inside-secure/safexcel.c | 4 ++--
>  drivers/crypto/inside-secure/safexcel.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> index c3b2b22934b7..9c00573abd8c 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -1209,7 +1209,6 @@ static struct safexcel_alg_template *safexcel_algs[] = {
>  	&safexcel_alg_authenc_hmac_sha256_cbc_aes,
>  	&safexcel_alg_authenc_hmac_sha384_cbc_aes,
>  	&safexcel_alg_authenc_hmac_sha512_cbc_aes,
> -	&safexcel_alg_authenc_hmac_sha1_cbc_des3_ede,
>  	&safexcel_alg_authenc_hmac_sha1_ctr_aes,
>  	&safexcel_alg_authenc_hmac_sha224_ctr_aes,
>  	&safexcel_alg_authenc_hmac_sha256_ctr_aes,
> @@ -1241,11 +1240,12 @@ static struct safexcel_alg_template *safexcel_algs[] = {
>  	&safexcel_alg_hmac_sha3_256,
>  	&safexcel_alg_hmac_sha3_384,
>  	&safexcel_alg_hmac_sha3_512,
> -	&safexcel_alg_authenc_hmac_sha1_cbc_des,
> +	&safexcel_alg_authenc_hmac_sha1_cbc_des3_ede,
>  	&safexcel_alg_authenc_hmac_sha256_cbc_des3_ede,
>  	&safexcel_alg_authenc_hmac_sha224_cbc_des3_ede,
>  	&safexcel_alg_authenc_hmac_sha512_cbc_des3_ede,
>  	&safexcel_alg_authenc_hmac_sha384_cbc_des3_ede,
> +	&safexcel_alg_authenc_hmac_sha1_cbc_des,
>  	&safexcel_alg_authenc_hmac_sha256_cbc_des,
>  	&safexcel_alg_authenc_hmac_sha224_cbc_des,
>  	&safexcel_alg_authenc_hmac_sha512_cbc_des,
> diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
> index 0f27367a85fa..ca012e2845f7 100644
> --- a/drivers/crypto/inside-secure/safexcel.h
> +++ b/drivers/crypto/inside-secure/safexcel.h
> @@ -950,7 +950,6 @@ extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_aes;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_aes;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha384_cbc_aes;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_aes;
> -extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des3_ede;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_ctr_aes;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_ctr_aes;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_ctr_aes;
> @@ -982,11 +981,12 @@ extern struct safexcel_alg_template safexcel_alg_hmac_sha3_224;
>  extern struct safexcel_alg_template safexcel_alg_hmac_sha3_256;
>  extern struct safexcel_alg_template safexcel_alg_hmac_sha3_384;
>  extern struct safexcel_alg_template safexcel_alg_hmac_sha3_512;
> -extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des;
> +extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des3_ede;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_des3_ede;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_des3_ede;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_des3_ede;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha384_cbc_des3_ede;
> +extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_des;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_des;
>  extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_des;
> -- 
> 2.47.3
> 


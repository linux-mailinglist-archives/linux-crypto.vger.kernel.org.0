Return-Path: <linux-crypto+bounces-24799-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FhvFkB1HWqebAkAu9opvQ
	(envelope-from <linux-crypto+bounces-24799-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 14:04:16 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B266461EC7B
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6783062F68
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338C436F917;
	Mon,  1 Jun 2026 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cABExE2q"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6B1DA60D;
	Mon,  1 Jun 2026 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315163; cv=none; b=DEDh5xMzwm7pI5dr3CsJyEkc7pyCutZusnfpybTe8d+HH9yVMyvMmG5AZm3GuaLEMs7/hHbXD8xMqQMIOcfvjTkCqIx8igmHsGEuUPRQI1U4jHUeCmp/iPq6KdQIpQvyDlFrBq+vSzd9H1OWkrgJKh2zetFR7sGDlkwy9tLFg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315163; c=relaxed/simple;
	bh=/a7dYcLesTrSq0GO8cdge+23Ut7WPkzOMP14MV+b6aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM2RbKJ1+92G5MuYlQS8jWx3bCnP6nYGh2DQJk0JVgaGNGmUdw0u2qhbmMvtToJtZLqpVamosTe3/e0qUbn+EQPe5UnylM4rnxNMxkCvOw+tcVfV+Kt8ioy5qm4bzViuirBq+iTM/DNVQplVCPk0IITQ4iwrcYzwHEaNnbVaRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cABExE2q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AAD1F00893;
	Mon,  1 Jun 2026 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780315161;
	bh=NVvdUWOzunW6ggQBLOK/LY34w78bMs33Hy27o4f5dTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cABExE2qdKH7UYtlH57/LKhN+al86hSAaPVgXjFR+bqPaYoYccuQqI2fV28ENoPxV
	 eUgKavrwDeMynn1cfirNmZaWNDpkFnagdy833QPxg46WOSFxybksQtZqpAuMoayWso
	 k8XEHzUnkmSBNSGr91fogbPWJkxK99MgPuvVFCPMrwsy4CjtcJCB9+nghdvXRsDoBt
	 /+58Lx2h5+SJhoBw+jQzkFUACVvB+0MKjeTZqqvTkoz021K3ivV7KTN0MfySF+nf6Q
	 Kkc9G4VR3C2NaherAf55xl5wuMUvr1+bCCI+0Mjk6m91pOt4ZQSPzJ01bbQ4PkVIEz
	 1CGMdD1EBflxw==
Message-ID: <5c25a511-39c7-43aa-a2e2-7690ca4d074a@kernel.org>
Date: Mon, 1 Jun 2026 13:59:17 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] crypto: talitos/aead - Convert to init/exit
 type-specific API
To: Paul Louvel <paul.louvel@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-7-1-rc1_talitos_cleanup-v1-0-cb1ad6cdea49@bootlin.com>
 <20260528-7-1-rc1_talitos_cleanup-v1-14-cb1ad6cdea49@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260528-7-1-rc1_talitos_cleanup-v1-14-cb1ad6cdea49@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24799-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B266461EC7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 28/05/2026 à 11:08, Paul Louvel a écrit :
> Since commit 6eed1e3552fc0 ("crypto: api - Mark cra_init/cra_exit as
> deprecated"), both cra_{init,exit} are deprecated.
> 
> Restore the type-specific talitos_cra_exit_aead() wrapper and use
> aead_alg->exit instead of the generic cra_exit field, matching the
> pattern used by init.

When you say "restore", do you mean it was removed at some point in the 
past ?

> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/crypto/talitos/talitos-aead.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/talitos/talitos-aead.c b/drivers/crypto/talitos/talitos-aead.c
> index c09ed08be2ef..38df616c9b22 100644
> --- a/drivers/crypto/talitos/talitos-aead.c
> +++ b/drivers/crypto/talitos/talitos-aead.c
> @@ -400,6 +400,11 @@ static int talitos_cra_init_aead(struct crypto_aead *tfm)
>   	return talitos_init_common(ctx, talitos_alg);
>   }
>   
> +static void talitos_cra_exit_aead(struct crypto_aead *tfm)
> +{
> +	talitos_cra_exit(crypto_aead_tfm(tfm));
> +}
> +
>   static struct talitos_alg_template aead_driver_algs[] = {
>   	{	.type = CRYPTO_ALG_TYPE_AEAD,
>   		.alg.aead = {
> @@ -950,8 +955,8 @@ int talitos_register_aead(struct device *dev)
>   		if (has_ftr_sec1(priv))
>   			alg->cra_alignmask = 3;
>   
> -		alg->cra_exit = talitos_cra_exit;
>   		aead_alg->init = talitos_cra_init_aead;
> +		aead_alg->exit = talitos_cra_exit_aead;
>   		aead_alg->setkey = aead_alg->setkey ?: aead_setkey;
>   		aead_alg->encrypt = aead_encrypt;
>   		aead_alg->decrypt = aead_decrypt;
> 



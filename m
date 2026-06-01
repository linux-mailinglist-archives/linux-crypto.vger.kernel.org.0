Return-Path: <linux-crypto+bounces-24773-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEuWFG4cHWoeVwkAu9opvQ
	(envelope-from <linux-crypto+bounces-24773-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 07:45:18 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC4D619C4A
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97AA33009B36
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BCA1509AB;
	Mon,  1 Jun 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjUeimzL"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820423393F;
	Mon,  1 Jun 2026 05:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292714; cv=none; b=oqngO2zJ46yTpXGbD4u5Xsz6OpLcm9LzMCcVEk/aYW3HaNfgxFcBudADOJvKfoaXon3Gqe96pYindCy2BHKPHFvYlzqvDX7AxMpoRVpy/LZmWxvT+3C5Bql59sNUfbXE7pMA5JohVdRRk/GygIQn5WglwJOZ8McQbgmemYY/BFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292714; c=relaxed/simple;
	bh=UQb9WvUVtGDSOtU9joHlkN2OcVqCc0uhf5gyUX8QFUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE9RS1D/2fVLz+ZGIYfFEBnwxpqZidatqntT3pg9FXnxyW1NqWrpLyLa17sPxpiPd+i3qFA912xTTVKPQtF7weFxftkzUOLNV5fleHsmbR7H8dguDQpcZQfNOlm1xA7P5BXjUBkSDUJ7iEHQOr8SRIDh6GIft2z8MEbt8hv6BrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjUeimzL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B00D1F00893;
	Mon,  1 Jun 2026 05:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780292713;
	bh=0zFqODFZUFvPc/7rf3LztlV3dKuNc4xuahuIHG/8cX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OjUeimzLZ/AQal/uHvFdz2r5Gh7f7lLerfEFn/LXXmZpbI0gofecpFGNgghXTvO4P
	 2Xki+FN1yWREmiiZtqZ8lYzDzKunjgVxBWl3+7fYIeimEP5fC30cnOX/FsIlY+BbnN
	 6SBmcedT72aXt7OAm2/UWIxzwcm5cHO/8Cnw7FE7uQc0o4J1dB2Chaa7yBB1OLs872
	 IeJaV/s2+9AJ6rQG+uVfG17HEoMCtTo7Cf+dkfCu9AN6nhrmVpP7EmXoaZDbPU79Md
	 L6RLfflVs+p8VnKcaypcwAhPBEgLfTTHStQRnDVTZKDVdpRXyqh1ztrSX31izTH+y/
	 +4iSA2uSEFsag==
Message-ID: <1fb3fcea-4a3a-444a-815f-4ecb0e06a933@kernel.org>
Date: Mon, 1 Jun 2026 07:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] crypto: talitos - Introduce registration helper
To: Paul Louvel <paul.louvel@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-7-1-rc1_talitos_cleanup-v1-0-cb1ad6cdea49@bootlin.com>
 <20260528-7-1-rc1_talitos_cleanup-v1-6-cb1ad6cdea49@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260528-7-1-rc1_talitos_cleanup-v1-6-cb1ad6cdea49@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24773-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: 9EC4D619C4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 28/05/2026 à 11:08, Paul Louvel a écrit :
> Add talitos_register_common() that will be called in each respective
> crypto implementation file.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

Build warning:

   DESCEND objtool
   INSTALL libsubcmd_headers
   CC      drivers/crypto/talitos/talitos.o
drivers/crypto/talitos/talitos.c:3097:13: warning: 
'talitos_alg_set_common' defined but not used [-Wunused-function]
  3097 | static void talitos_alg_set_common(struct talitos_private *priv,
       |             ^~~~~~~~~~~~~~~~~~~~~~
   CC      drivers/crypto/talitos/talitos-rng.o
   AR      drivers/crypto/talitos/built-in.a


> ---
>   drivers/crypto/talitos/talitos.c | 53 ++++++++++++++++++++++++++++++++++++++++
>   drivers/crypto/talitos/talitos.h |  3 +++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/crypto/talitos/talitos.c b/drivers/crypto/talitos/talitos.c
> index 3fc1069062da..869739dcc4d7 100644
> --- a/drivers/crypto/talitos/talitos.c
> +++ b/drivers/crypto/talitos/talitos.c
> @@ -3095,6 +3095,59 @@ static void talitos_remove(struct platform_device *ofdev)
>   		tasklet_kill(&priv->done_task[1]);
>   }
>   
> +static void talitos_alg_set_common(struct talitos_private *priv,
> +				   struct crypto_alg *alg, u32 custom_priority,
> +				   u32 type)
> +{
> +	alg->cra_module = THIS_MODULE;
> +	if (custom_priority)
> +		alg->cra_priority = custom_priority;
> +	else
> +		alg->cra_priority = TALITOS_CRA_PRIORITY;
> +	if (has_ftr_sec1(priv) && type != CRYPTO_ALG_TYPE_AHASH)
> +		alg->cra_alignmask = 3;
> +	else
> +		alg->cra_alignmask = 0;
> +	alg->cra_ctxsize = sizeof(struct talitos_ctx);
> +	alg->cra_flags |= CRYPTO_ALG_KERN_DRIVER_ONLY;
> +}
> +
> +int talitos_register_common(struct device *dev,
> +			    struct talitos_alg_template *template)
> +{
> +	struct talitos_private *priv = dev_get_drvdata(dev);
> +	struct talitos_crypto_alg *t_alg;
> +	struct crypto_alg *alg;
> +	int ret;
> +
> +	t_alg = devm_kzalloc(dev, sizeof(struct talitos_crypto_alg),
> +			     GFP_KERNEL);
> +	if (!t_alg)
> +		return -ENOMEM;
> +
> +	t_alg->algt = *template;
> +
> +	switch (t_alg->algt.type) {
> +	default:
> +		dev_err(dev, "unknown algorithm type %d\n", t_alg->algt.type);
> +		devm_kfree(dev, t_alg);
> +		return -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(dev, "%s alg registration failed\n",
> +			alg->cra_driver_name);
> +		devm_kfree(dev, t_alg);
> +		return 0;
> +	}
> +
> +	t_alg->dev = dev;
> +
> +	list_add_tail(&t_alg->entry, &priv->alg_list);
> +
> +	return 0;
> +}
> +
>   static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
>   						    struct talitos_alg_template
>   						           *template)
> diff --git a/drivers/crypto/talitos/talitos.h b/drivers/crypto/talitos/talitos.h
> index 1f81d336dae8..afed9947f4c0 100644
> --- a/drivers/crypto/talitos/talitos.h
> +++ b/drivers/crypto/talitos/talitos.h
> @@ -523,6 +523,9 @@ int talitos_init_common(struct talitos_ctx *ctx,
>   			struct talitos_crypto_alg *talitos_alg);
>   void talitos_cra_exit(struct crypto_tfm *tfm);
>   
> +int talitos_register_common(struct device *dev,
> +			    struct talitos_alg_template *template);
> +
>   /* Hardware RNG */
>   
>   int talitos_register_rng(struct device *dev);
> 



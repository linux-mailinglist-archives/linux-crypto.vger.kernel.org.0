Return-Path: <linux-crypto+bounces-24890-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QngRM1RaIWpmEwEAu9opvQ
	(envelope-from <linux-crypto+bounces-24890-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 12:58:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320463F3F0
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 12:58:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s7K23d4t;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24890-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24890-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 436DB3009B3A
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1953E121A;
	Thu,  4 Jun 2026 10:47:51 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C68379C49
	for <linux-crypto@vger.kernel.org>; Thu,  4 Jun 2026 10:47:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570071; cv=none; b=p/brGGAtNZRZsIbcyBMOdEdJyEQQpte8T6+iMgkaAqPXSF4w6ugWWNe0XxzvN1PdC5W+x/P/my4VU/d41o4urQ5lz1GoSL5uXzPYWWrzXqLcDkeRPAGCqtUvU2OuaOJUYw9rSzaefaTVfJPk5CXf/TuWaye5HPVwPk5tm48fUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570071; c=relaxed/simple;
	bh=hKJbxc8NsHsFUvDDH6xySveIIcdPNbn0KUG3fWPXg+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewtottwwpkIoB+lAfMwUaMLpgt0Qdl0Jf7l1HwhqSHtjAdV8oVAqGCxgYbq4TYvBOPzSq/TAhH/w+vx1d0NuJQ9hRLu8p1jdtuwaBlvz2+QHhnfv6c1uNCr9jznkMzlEPGXyZJtRSuvjh+dhry3SnFUs+qpm0YJZvL7lAXf9w2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7K23d4t; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec429c2bb1so79192866b.1
        for <linux-crypto@vger.kernel.org>; Thu, 04 Jun 2026 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570068; x=1781174868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwJB9cBfnfHdEwA/fwRLYD3Mdm/VM1ICLl5KQOk5Qu0=;
        b=s7K23d4tZvUdj8REaaKKMf0cycohR56cuaf2+iS05GqZvPkAD58BYrzvC+t/ykoIGE
         YRPk1a/HXk7AaczjaLbealrCU2XtYpHVynK13KO9b48X3nxmr9C9dewo/MchZVgwVXAO
         +/Y9z+dEZlFIAAhyye3qPsIrYJKBiqw/HCskRE7xJLVnSTL5k7kboe2sOgoc/PzMBE5d
         fnFk5qyAPlatRHsnM38tArB0x3eQW/GrYbVmtaCkdwll3SvzRMetwCD3ze1lmro4IeA3
         rkZyHzdRWXFhlN15qYKTAoh3e0TvOqGQ/wwH9rmVRg8Lz+jlG5hawIPOWyzVHxGFfHFV
         B83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570068; x=1781174868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwJB9cBfnfHdEwA/fwRLYD3Mdm/VM1ICLl5KQOk5Qu0=;
        b=hHHxAQYFLVDjQ7pxZaKseX9VEbkco0p+hVKSLRrcPwv2mKoEx7TK1lol3aDUpYgwbd
         Pm1qqGev9ZYDSJdBa/AR4qvhIQdiwg7Qm4qQZRy4SefA/K9t55BsFkEjOogn3BJUxdBn
         fUzUYvhuHFHhdF28Yh/tZipbafjo8dS/WuBQM8ID+H4qcqqKmaDfN9q9NJTGToG9k7c6
         I6Se+XeYutIQTQbFZQ7Bwp3O95Tk8uh4wCc5GLHkvcspImf+EEVEbBRZnwyQhsGr039u
         uMIj8pArKpHG/qyTkELGCll5sHRDU8jamZKpUSxS8idBfb0rzb3T2TCZS7OixmPLtH6t
         lihg==
X-Forwarded-Encrypted: i=1; AFNElJ8Xh87nJlzRF1P9vH5rwFHKOMTTy2tCBgxjQcUxzyht1MzwVpzbHgtgc8rFDENJ8wJt7GjELgIZJc4JocA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdZlzJEX62vnb929zguwg0F/472A1wD1yNpUVdHugi7JlLRoN
	dkZCyvuk9yF7DFMhoCpCjC8J1V7JJok3tEIhOfUKvEgoY38Y9WZUMZ9N
X-Gm-Gg: Acq92OGNRrAX2x5mN7vyxUhjxgVO7DjaL2XK4MS2bBZvhTcZWY6PU0ocfgli6cgn9xT
	lIGqFWtDyjpJ+zaHtu7iWS8K6tkABelS9c+b/ntVgFaAcDFs0EEYUo6SmHXybxz+RL9yWuDLwtO
	CeFJ2oFvfY/faV2IdyRkcoGznr/N1OLzsx86dBE/oUWEzyNJoLNJJmCRaYZrS1UvdbqtdH3vM92
	OWD8/nDBra8GzBOXjhWz5OYtExOpntYWRgeMIWATo27CbM4DkTasNNfAMJE8TaPxqWsQ/YbyeFs
	MobOzgg7huCGvAVPmbEyA7Pff7twdI/n4uawH1kjv5mvE09XLdJGcTa/FgKR8sTIQFmHRCFBZr9
	4xoKvHuTf+PRxmSlnf/dV72NhlOPlmTdzB36RmjVecyG4WkPOukhar8e19EyXd+DdeCGz6TsASM
	Bp921Kh8ch9AAKa5v0zoEJBg4LJ75mUPCpjshzrwUETUfliDQPyXdrkzK5dBGr5XgBbFC6q+c+1
	la7IBO7oIqConw+ZIXKxQ==
X-Received: by 2002:a17:907:3c8e:b0:bec:157:a63a with SMTP id a640c23a62f3a-bf0ac20eb8emr362199666b.1.1780570067915;
        Thu, 04 Jun 2026 03:47:47 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307aacsm289054766b.47.2026.06.04.03.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:47:47 -0700 (PDT)
Message-ID: <a56c9f94-e694-44cf-85ac-c4bcc8d18f70@gmail.com>
Date: Thu, 4 Jun 2026 11:47:44 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rhashtable: Use irq work for shrinking
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev, Tejun Heo <tj@kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
 <4d811506109736528d816b6a1f613becd9460079ee7bfc67c509e67e7d2f44af@mail.kernel.org>
 <3960ffc3-78f3-46da-baaf-ce72b6495698@gmail.com>
 <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-24890-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:kafai@meta.com,m:kernel-team@meta.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:yatsenko@meta.com,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:tj@kernel.org,m:linux-crypto@vger.kernel.org,m:bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mykytayatsenko5@gmail.com,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,meta.com,gmail.com,linux.dev];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,bpf-ci];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4320463F3F0


On 6/4/26 3:17 AM, Herbert Xu wrote:
> On Wed, Jun 03, 2026 at 02:08:25PM +0100, Mykyta Yatsenko wrote:
>>
>> For v7 I'm dropping automatic_shrinking, because it adds a risk of
>> calling schedule_work() on element deletion path (__rhashtable_remove_fast_one())
>> when hashtable size drops below 30% of the capacity.
> 
> Now that expansion uses irq work I think shrinking should switch
> to that as well.
> 

Makes sense, thanks, I'll include your patch below in this series then.

> ---8<---
> Use irq work for automatic shrinking so that this may be called
> in NMI context.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index ef5230cece36..0693bce6f890 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -1117,7 +1117,7 @@ static __always_inline int __rhashtable_remove_fast_one(
>  		atomic_dec(&ht->nelems);
>  		if (unlikely(ht->p.automatic_shrinking &&
>  			     rht_shrink_below_30(ht, tbl)))
> -			schedule_work(&ht->run_work);
> +			irq_work_queue(&ht->run_irq_work);
>  		err = 0;
>  	}
>  
> Cheers,



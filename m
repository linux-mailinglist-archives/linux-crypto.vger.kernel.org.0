Return-Path: <linux-crypto+bounces-2304-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC2862624
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Feb 2024 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD31F21C0A
	for <lists+linux-crypto@lfdr.de>; Sat, 24 Feb 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49917588;
	Sat, 24 Feb 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAXqseTh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA64C6B
	for <linux-crypto@vger.kernel.org>; Sat, 24 Feb 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793591; cv=none; b=lKiNoOGRBvdkiTw9zF+jVa5HbGjHDnmXQaDkYyvH2gzqfUtwa9XYqvjEAWo/btO7h/1EywpHkl/cZEs8jfIAhHUJ8IwSLjptHW/Z7KmYHDTL3t+BC3AIminusJL+I37aCTgHJQk//ZPP9FJPNlDrZe2ZBAWleow/5kpSGwYbmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793591; c=relaxed/simple;
	bh=Tfm5vL4QfZKNlU2j8c6/gIq0W0rievB9CY/7Swb9hPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRZNATRmBT8gi5R0vFmOYWSn5kqVwss2koILuCStizTdZ8oFmLBkhmIv1HnfbsNkUc2h7kX8d0LsP/gDqMSSElkbrfNKpmypPBhFm6qldMxC+14pw+p+gjNAxMZ30MTAaPrT/g7Qbk0vcVMQMLSLnrVtXW2rI+80Cp6tRNzkICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAXqseTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870BBC43390
	for <linux-crypto@vger.kernel.org>; Sat, 24 Feb 2024 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708793590;
	bh=Tfm5vL4QfZKNlU2j8c6/gIq0W0rievB9CY/7Swb9hPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FAXqseTh5vYvdvl8IWFawUCV7PpiFA1YomIqeokjSNEnbKYU47a5CzoeX6Gc7oCkv
	 RmUqbA8Y7leZTzdDisDqBIy0N7kDQ1XLGW5hQCrSkBeYfuhdYKfDvSQsZHCo8Peeba
	 a7trVps5PO/7nMTXE80SpdMosncxeKP82UqlQseKvnPkPBkfylMyeE9i0dSmCzY3BM
	 xIJh/IofhbBOhSA97EZJ4FxLVY9XXY7TRzKAXm2HehwSnqn/a9w7WHVjVcbjHaDmsT
	 ES+cE9cC0bkBCyRXSigBzZ9yVtihE9STOKfggmu+YKvZux7szU+6o7NYDsxqEmg0ZE
	 UvaC0Z+omtuCg==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-364f791a428so4690945ab.3
        for <linux-crypto@vger.kernel.org>; Sat, 24 Feb 2024 08:53:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNl/CJt02EseCIOWoW527ywCvo/Ns0bvwcD0/o37vzFx+Tjq+/5O1sNkkHr0rwwnrTDha0FC5Y5CQEaLvLRvkpO24/NLXhNMJTec27
X-Gm-Message-State: AOJu0YwMbCYs4VIGE3AIUe25QEJsw/LboQ6eHNjZmgLVywFyX3tPX1nv
	uO47zqsMHH3MZNsXvdpcHm0n83jYKEXtLsrp4gV/uyqNOPZBkVGeasv4rDeUVYs4LWUPc18026X
	BfFveOrLnxHvGTcnAIwXL1KDGyui553nOTliK
X-Google-Smtp-Source: AGHT+IET/vQwF9sNTEZtiDwCGllyEYJS5225ocQgvaHlCzNjk/1CUgLtTdfYdNes+92RKN878GTYPqLQjt9oyH+bxHY=
X-Received: by 2002:a92:ce4e:0:b0:364:21b0:6050 with SMTP id
 a14-20020a92ce4e000000b0036421b06050mr3242498ilr.6.1708793589855; Sat, 24 Feb
 2024 08:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com> <20240222081135.173040-2-21cnbao@gmail.com>
In-Reply-To: <20240222081135.173040-2-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 24 Feb 2024 08:52:57 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO13XoRQE+qqZ9gy6s4_0Qrvv4kWAQJE7UGExLcyWP6cg@mail.gmail.com>
Message-ID: <CAF8kJuO13XoRQE+qqZ9gy6s4_0Qrvv4kWAQJE7UGExLcyWP6cg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] crypto: introduce: acomp_is_async to expose if
 comp drivers might sleep
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, yosryahmed@google.com, zhouchengming@bytedance.com, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> acomp's users might want to know if acomp is really async to
> optimize themselves. One typical user which can benefit from
> exposed async stat is zswap.
>
> In zswap, zsmalloc is the most commonly used allocator for
> (and perhaps the only one). For zsmalloc, we cannot sleep
> while we map the compressed memory, so we copy it to a
> temporary buffer. By knowing the alg won't sleep can help
> zswap to avoid the need for a buffer. This shows noticeable
> improvement in load/store latency of zswap.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  include/crypto/acompress.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
> index 574cffc90730..80e243611fe2 100644
> --- a/include/crypto/acompress.h
> +++ b/include/crypto/acompress.h
> @@ -160,6 +160,12 @@ static inline void acomp_request_set_tfm(struct acom=
p_req *req,
>         req->base.tfm =3D crypto_acomp_tfm(tfm);
>  }
>
> +static inline bool acomp_is_async(struct crypto_acomp *tfm)
> +{
> +       return crypto_comp_alg_common(tfm)->base.cra_flags &
> +              CRYPTO_ALG_ASYNC;
> +}
> +
>  static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req =
*req)
>  {
>         return __crypto_acomp_tfm(req->base.tfm);
> --
> 2.34.1
>


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2A164D80
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2020 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSSQ5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Feb 2020 13:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBSSQ4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Feb 2020 13:16:56 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D420C24656;
        Wed, 19 Feb 2020 18:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582136216;
        bh=7crgeJqOXjvpVZqlMX7ni5vWNV3EHF/0EQ0glLP1wVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFYds0gXOo7Pn45RvT16No9BzJ28dvhr3iXd/o2uMXprsiGXz884d33e7lTxiY3dC
         gLCnwsKGTPCUCHv2+Aip38hTuA80WHAhboMjTMzPJIRRfcTH5ZQ1BpNmxIjAfJI+NG
         PMPXhfcnpxUpDfHsf5Y+nOzoXzYrl0OCqJ6CNItw=
Date:   Wed, 19 Feb 2020 10:16:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] crypto: arm64: CE: implement export/import
Message-ID: <20200219181654.GB2312@sol.localdomain>
References: <1582128037-18644-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582128037-18644-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 19, 2020 at 04:00:37PM +0000, Corentin Labbe wrote:
> When an ahash algorithm fallback to another ahash and that fallback is
> shaXXX-CE, doing export/import lead to error like this:
> alg: ahash: sha1-sun8i-ce export() overran state buffer on test vector 0, cfg=\"import/export\"
> 
> This is due to the descsize of shaxxx-ce larger than struct shaxxx_state off by an u32.
> For fixing this, let's implement export/import which rip the finalize
> variant instead of using generic export/import.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm64/crypto/sha1-ce-glue.c | 20 ++++++++++++++++++++
>  arch/arm64/crypto/sha2-ce-glue.c | 23 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> index 63c875d3314b..dc44d48415cd 100644
> --- a/arch/arm64/crypto/sha1-ce-glue.c
> +++ b/arch/arm64/crypto/sha1-ce-glue.c
> @@ -91,12 +91,32 @@ static int sha1_ce_final(struct shash_desc *desc, u8 *out)
>  	return sha1_base_finish(desc, out);
>  }
>  
> +static int sha1_ce_export(struct shash_desc *desc, void *out)
> +{
> +	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
> +
> +	memcpy(out, sctx, sizeof(struct sha1_state));
> +	return 0;
> +}
> +
> +static int sha1_ce_import(struct shash_desc *desc, const void *in)
> +{
> +	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
> +
> +	memcpy(sctx, in, sizeof(struct sha1_state));
> +	sctx->finalize = 0;
> +	return 0;
> +}

Can you use '&sctx->sst' instead of 'sctx' so that we aren't relying on the
'struct sha1_state' being located at the beginning of the struct?

Likewise for SHA-2.

- Eric

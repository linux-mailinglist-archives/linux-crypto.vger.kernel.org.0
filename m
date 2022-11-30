Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0113363E067
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Nov 2022 20:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiK3TFR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 30 Nov 2022 14:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiK3TFJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 30 Nov 2022 14:05:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199354451
        for <linux-crypto@vger.kernel.org>; Wed, 30 Nov 2022 11:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6894961D76
        for <linux-crypto@vger.kernel.org>; Wed, 30 Nov 2022 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50DC433C1;
        Wed, 30 Nov 2022 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669835064;
        bh=0YtOwGBuUzbsgyDemTbhrFfwn9UOMTDJGix/bKi24vA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=A+1UBsnWQBbvmRyTREpnrYERJOyNg12POv2+Mf9y79AHuWHfaeZcoLGk5RpxMpvop
         VcyVQE8q+rvoze5JgMkodC1llRzzU/S968Z5+fgrw1SFYmuWTwPR0wG2+0GXRy6+9n
         ghFEvTszlmnEuGlcOqY2AKgxtLuacbf2Q73vCmO2vtLumClBzhq+0K/X5d+1asM1c2
         jmTN39DqzAjvAj1nToSz1j/9R49qkMqkrKlwaOuiyqaZcxipyyU/zh2OdltdhyXRjy
         s74sBG7h2I2v4h+Sj6oJrE3wymEQdsG07/l3jQlQHtVj1LR5eMde4+ytPMndtYRKcl
         wHCHdPK5wvbow==
Date:   Wed, 30 Nov 2022 19:04:23 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 2/6] crypto: optimize registration of internal
 algorithms
Message-ID: <Y4epN07Qi7pPCrWb@gmail.com>
References: <20221114001238.163209-1-ebiggers@kernel.org>
 <20221114001238.163209-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114001238.163209-3-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Nov 13, 2022 at 04:12:34PM -0800, Eric Biggers wrote:
> diff --git a/crypto/algboss.c b/crypto/algboss.c
> index eb5fe84efb83e..13d37320a66eb 100644
> --- a/crypto/algboss.c
> +++ b/crypto/algboss.c
> @@ -181,12 +181,8 @@ static int cryptomgr_test(void *data)
>  	goto skiptest;
>  #endif
>  
> -	if (type & CRYPTO_ALG_TESTED)
> -		goto skiptest;
> -
>  	err = alg_test(param->driver, param->alg, type, CRYPTO_ALG_TESTED);
>  
> -skiptest:
>  	crypto_alg_tested(param->driver, err);

Ard pointed out that there's a bisection hazard here, since this patch deletes
the skiptest label, but the last goto to it isn't deleted until patch 6.  Sorry
about that.  Herbert, do you want to fix this by rebasing, or is it too late?

- Eric

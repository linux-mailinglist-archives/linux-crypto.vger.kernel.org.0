Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E84BC494
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Feb 2022 02:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiBSB2m (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Feb 2022 20:28:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240872AbiBSB2i (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Feb 2022 20:28:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4224F606E2
        for <linux-crypto@vger.kernel.org>; Fri, 18 Feb 2022 17:28:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39AA62023
        for <linux-crypto@vger.kernel.org>; Sat, 19 Feb 2022 01:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBDBC340E9;
        Sat, 19 Feb 2022 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645234100;
        bh=meqdSYQ17as6D2gC+1QtuY2/hf013mG8sWxTTeQxu50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqVYBLLtb2HpAM9zDNnWMjpNt/bhxVYAPdnZA5rFCUvFDZhvilxvQrhtudrBlzWkw
         SfZBluri6VRZPXo63A1Q7DyGe1+22dVBCgLNmFElrTyNudB/Kv3tCL1E5gd3FGTiZn
         ruE9586qkAnkzHYHiXwI4UeJLTb1+45yX+oBo0GBf5Ne3n4KXu6XRJ05F4HXs8yevZ
         mMkwJGECmIxDUKLK+CJ4HE8RSfIp1r+mCYlnel47GRDse/HAkOK0Jubktqa6np9L0X
         IcDQZK9eqa4HKZ1n9Fcb4eVc8YrprENfIEEQRLgecFnpum/hoySDD8DO2dLQzaGtHV
         i28Rsy9W7q1yg==
Date:   Fri, 18 Feb 2022 17:28:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Paul Crowley <paulcrowley@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC PATCH v2 4/7] crypto: x86/aesni-xctr: Add accelerated
 implementation of XCTR
Message-ID: <YhBHsmRClcrbYFN1@sol.localdomain>
References: <20220210232812.798387-1-nhuck@google.com>
 <20220210232812.798387-5-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210232812.798387-5-nhuck@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 10, 2022 at 11:28:09PM +0000, Nathan Huckleberry wrote:
> diff --git a/arch/x86/crypto/aes_xctrby8_avx-x86_64.S b/arch/x86/crypto/aes_xctrby8_avx-x86_64.S
> new file mode 100644
> index 000000000000..53d70cab9474
> --- /dev/null
> +++ b/arch/x86/crypto/aes_xctrby8_avx-x86_64.S
> @@ -0,0 +1,529 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> +/*
> + * AES XCTR mode by8 optimization with AVX instructions. (x86_64)
> + *
> + * Copyright(c) 2014 Intel Corporation.
> + *
> + * Contact Information:
> + * James Guilford <james.guilford@intel.com>
> + * Sean Gulley <sean.m.gulley@intel.com>
> + * Chandramouli Narayanan <mouli@linux.intel.com>
> + */
> +/*
> + * Implement AES XCTR mode with AVX instructions. This code is a modified
> + * version of the Linux kernel's AES CTR by8 implementation.
> + *
> + * This is AES128/192/256 XCTR mode optimization implementation. It requires
> + * the support of Intel(R) AESNI and AVX instructions.
> + *
> + * This work was inspired by the AES XCTR mode optimization published
> + * in Intel Optimized IPSEC Cryptographic library.
> + * Additional information on it can be found at:
> + *    https://github.com/intel/intel-ipsec-mb
> + */

So I haven't looked at this closely yet, but one thing I noticed is that this
file is pretty long, and it's almost identical to aes_ctrby8_avx-x86_64.S.
Perhaps it would make sense to add XCTR support to that file rather than
duplicating most of it into this new file?  You could add an is_xctr argument to
the macros to allow making parts conditional on CTR or XCTR when needed.

- Eric

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF404AE550
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Feb 2022 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiBHXMA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Feb 2022 18:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBHXL5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Feb 2022 18:11:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D50BC061577;
        Tue,  8 Feb 2022 15:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC08461739;
        Tue,  8 Feb 2022 23:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3691AC004E1;
        Tue,  8 Feb 2022 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644361916;
        bh=nw+uf9wvKa73hGNCmVrxgt0kMmNoNkoijmbtiF4AL9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUxz3DXrxZMNn49lIk3sAdLK097Od7HCAB8I13bzYi9uwil6PrP13LIXRGZB7ePlQ
         vp2pgNTplFqdLOrKxSvnER7HNC+VzjkGlhI/DgCEbAa3/EBeE6DBH52aVm8VoDZoKS
         9crnSl73wufRlPq3b6U8quBYgU7TtHUQkTcFZWCN3BvOvSdRHMSBt8eYEbi3XNXHqZ
         G3MPdMGRStOEqY9qC4cnR3Ct//vWLC7x9dgdwE+H5ftxphE3lCndx0O8E/zofvWPCL
         FzDit/4hy5/NqlUwCDf+ziJo87r/gqVDwZHuXQFeP47yRAU/Mq8XU5av5/6dlPc8GK
         l+xdpChR0e08w==
Date:   Tue, 8 Feb 2022 15:11:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v1 5/7] random: do not xor RDRAND when writing into
 /dev/random
Message-ID: <YgL4umsyljm0R4Th@sol.localdomain>
References: <20220208155335.378318-1-Jason@zx2c4.com>
 <20220208155335.378318-6-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208155335.378318-6-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 08, 2022 at 04:53:33PM +0100, Jason A. Donenfeld wrote:
> Continuing the reasoning of "random: ensure early RDSEED goes through
> mixer on init", we don't want RDRAND interacting with anything without
> going through the mixer function, as a backdoored CPU could presumably
> cancel out data during an xor, which it'd have a harder time doing when
> being forced through a cryptographic hash function. There's actually no
> need at all to be calling RDRAND in write_pool(), because before we
> extract from the pool, we always do so with 32 bytes of RDSEED hashed in
> at that stage. Xoring at this stage is needless and introduces a minor
> liability.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

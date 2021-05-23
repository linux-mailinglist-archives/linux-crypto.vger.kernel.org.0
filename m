Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2249A38D80C
	for <lists+linux-crypto@lfdr.de>; Sun, 23 May 2021 02:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhEWA5x (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 22 May 2021 20:57:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42856 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhEWA5v (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 22 May 2021 20:57:51 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lkcPg-0002r7-TX; Sun, 23 May 2021 08:56:16 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lkcPV-0002XJ-9a; Sun, 23 May 2021 08:56:05 +0800
Date:   Sun, 23 May 2021 08:56:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>
Cc:     Suman Anna <s-anna@ti.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-crypto@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [cryptodev:master 43/53]
 drivers/char/hw_random/ixp4xx-rng.c:26:10: fatal error: 'mach/hardware.h'
 file not found
Message-ID: <20210523005605.2qy7exr67pg2nz3a@gondor.apana.org.au>
References: <202105222208.Ay7upVmB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105222208.Ay7upVmB-lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, May 22, 2021 at 10:48:19PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> head:   acbc3fb26feed173d9ca6b0a16d0bed01c40f339
> commit: 3c0907bc4c47475734ffe21accc31261527dbdf5 [43/53] hwrng: omap - Enable driver for TI K3 family
> config: arm64-randconfig-r026-20210522 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project e84a9b9bb3051c35dea993cdad7b3d2575638f85)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=3c0907bc4c47475734ffe21accc31261527dbdf5
>         git remote add cryptodev https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>         git fetch --no-tags cryptodev master
>         git checkout 3c0907bc4c47475734ffe21accc31261527dbdf5
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Please ignore this.  It was a merge error on my part.  I've fixed
it in the crypto tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

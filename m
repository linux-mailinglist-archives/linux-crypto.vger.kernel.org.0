Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5769D40F056
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Sep 2021 05:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhIQDV4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Sep 2021 23:21:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55250 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240837AbhIQDVz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Sep 2021 23:21:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mR4QT-0006Dj-Bv; Fri, 17 Sep 2021 11:20:33 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mR4QT-0001l9-8i; Fri, 17 Sep 2021 11:20:33 +0800
Date:   Fri, 17 Sep 2021 11:20:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        kernel test robot <lkp@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: Re: [PATCH] crypto: qat - remove unneeded packed attribute
Message-ID: <20210917032033.GA6741@gondor.apana.org.au>
References: <20210902083459.238983-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902083459.238983-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 02, 2021 at 09:34:59AM +0100, Giovanni Cabiddu wrote:
> Remove packed attribute from structures that do not need to be packed.
> These are just used internally and not shared with firmware.
> 
> This also fixes a series of warning when compiling the driver with the
> flag -Waddress-of-packed-member, similar to the following:
> 
>     drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c:102:28: warning: taking address of packed member 'csr_ops' of class or structure 'adf_hw_device_data' may result in an unaligned pointer value
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
> ---
>  drivers/crypto/qat/qat_common/adf_accel_devices.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

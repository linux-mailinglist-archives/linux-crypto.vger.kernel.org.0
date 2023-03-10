Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88A6B3DD7
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Mar 2023 12:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCJLdH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Mar 2023 06:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCJLdC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Mar 2023 06:33:02 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8DE166F3
        for <linux-crypto@vger.kernel.org>; Fri, 10 Mar 2023 03:32:59 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paazW-002YBW-Kq; Fri, 10 Mar 2023 19:32:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:32:54 +0800
Date:   Fri, 10 Mar 2023 19:32:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Damian Muszynski <damian.muszynski@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - add support for 402xx devices
Message-ID: <ZAsVZt5nrCGzd6uL@gondor.apana.org.au>
References: <20230303165650.81405-1-damian.muszynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303165650.81405-1-damian.muszynski@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 03, 2023 at 05:56:50PM +0100, Damian Muszynski wrote:
> QAT_402xx is a derivative of 4xxx. Add support for that device in the
> qat_4xxx driver by including the DIDs (both PF and VF), extending the
> probe and the firmware loader.
> 
> 402xx uses different firmware images than 4xxx. To allow that the logic
> that selects the firmware images was modified.
> 
> Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    | 43 ++++++++++++++++---
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  9 +++-
>  drivers/crypto/qat/qat_4xxx/adf_drv.c         |  3 +-
>  .../crypto/qat/qat_common/adf_accel_devices.h |  2 +
>  drivers/crypto/qat/qat_common/qat_hal.c       |  1 +
>  drivers/crypto/qat/qat_common/qat_uclo.c      |  1 +
>  6 files changed, 52 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

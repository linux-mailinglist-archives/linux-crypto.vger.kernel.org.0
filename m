Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A228733153
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Jun 2023 14:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjFPMf3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Jun 2023 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbjFPMfZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Jun 2023 08:35:25 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2830E1
        for <linux-crypto@vger.kernel.org>; Fri, 16 Jun 2023 05:35:24 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA8ff-003p22-B3; Fri, 16 Jun 2023 20:35:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 20:35:19 +0800
Date:   Fri, 16 Jun 2023 20:35:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] crypto: qat - expose pm_idle_enabled through sysfs
Message-ID: <ZIxXB4+eVjDQQ1gr@gondor.apana.org.au>
References: <20230609170614.28237-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609170614.28237-1-lucas.segarra.fernandez@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 09, 2023 at 07:06:14PM +0200, Lucas Segarra Fernandez wrote:
> Expose 'pm_idle_enabled' sysfs attribute. This attribute controls how
> idle conditions are handled. If it is set to 1 (idle support enabled)
> when the device detects an idle condition, the driver will transition
> the device to the 'MIN' power configuration.
> 
> In order to set the value of this attribute for a device, the device
> must be in the 'down' state.
> 
> This only applies to qat_4xxx generation.
> 
> Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat    | 35 ++++++++++++
>  .../intel/qat/qat_common/adf_cfg_strings.h    |  1 +
>  .../crypto/intel/qat/qat_common/adf_gen4_pm.c | 12 ++++-
>  .../crypto/intel/qat/qat_common/adf_gen4_pm.h |  1 +
>  .../crypto/intel/qat/qat_common/adf_sysfs.c   | 53 +++++++++++++++++++
>  5 files changed, 101 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

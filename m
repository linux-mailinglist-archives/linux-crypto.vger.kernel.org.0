Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE07535B2
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Jul 2023 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjGNIwf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Jul 2023 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjGNIwa (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Jul 2023 04:52:30 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DF2719
        for <linux-crypto@vger.kernel.org>; Fri, 14 Jul 2023 01:52:29 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEXK-001Rdn-39; Fri, 14 Jul 2023 18:52:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:52:19 +1000
Date:   Fri, 14 Jul 2023 18:52:19 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Damian Muszynski <damian.muszynski@intel.com>
Subject: Re: [PATCH] crypto: qat - change value of default idle filter
Message-ID: <ZLEMw9BZty9zVej2@gondor.apana.org.au>
References: <20230622092635.6175-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622092635.6175-1-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 22, 2023 at 10:26:35AM +0100, Giovanni Cabiddu wrote:
> The power management configuration of 4xxx devices is too aggressive
> and in some conditions the device might be prematurely put to a low
> power state.
> Increase the idle filter value to prevent that.
> In future, this will be set by firmware.
> 
> Fixes: e5745f34113b ("crypto: qat - enable power management for QAT GEN4")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1675AAD06
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Sep 2022 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbiIBLBt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Sep 2022 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiIBLBs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Sep 2022 07:01:48 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CCC9C1DA
        for <linux-crypto@vger.kernel.org>; Fri,  2 Sep 2022 04:01:48 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oU4Qj-000LQ0-2y; Fri, 02 Sep 2022 21:01:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Sep 2022 19:01:45 +0800
Date:   Fri, 2 Sep 2022 19:01:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - fix default value of WDT timer
Message-ID: <YxHimQynFG3q7l2a@gondor.apana.org.au>
References: <20220825103216.4948-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825103216.4948-1-lucas.segarra.fernandez@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 25, 2022 at 12:32:16PM +0200, Lucas Segarra Fernandez wrote:
> The QAT HW supports an hardware mechanism to detect an accelerator hang.
> The reporting of a hang occurs after a watchdog timer (WDT) expires.
> 
> The value of the WDT set previously was too small and was causing false
> positives.
> Change the default value of the WDT to 0x7000000ULL to avoid this.
> 
> Fixes: 1c4d9d5bbb5a ("crypto: qat - enable detection of accelerators hang")
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> ---
>  drivers/crypto/qat/qat_common/adf_gen4_hw_data.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

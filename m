Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F886599A53
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Aug 2022 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347652AbiHSK7C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Aug 2022 06:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347036AbiHSK7C (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Aug 2022 06:59:02 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED54564C7
        for <linux-crypto@vger.kernel.org>; Fri, 19 Aug 2022 03:59:00 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oOziI-00CpU8-Sq; Fri, 19 Aug 2022 20:58:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Aug 2022 18:58:54 +0800
Date:   Fri, 19 Aug 2022 18:58:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srinivas Kerekare <srinivas.kerekare@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: Re: [PATCH RESEND] crypto: qat - add check to validate firmware
 images
Message-ID: <Yv9s7gdv+TEPpVFV@gondor.apana.org.au>
References: <20220725104009.76267-1-srinivas.kerekare@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725104009.76267-1-srinivas.kerekare@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 25, 2022 at 11:40:09AM +0100, Srinivas Kerekare wrote:
> The function qat_uclo_check_image() validates the MMP and AE firmware
> images. If the QAT device supports firmware authentication (indicated
> by the handle to firmware loader), the input signed binary MMP and AE
> images are validated by parsing the following information:
> - Header length
> - Full size of the binary
> - Type of binary image (MMP or AE Firmware)
> 
> Firmware binaries use RSA3K for signing and verification.
> The header length for the RSA3k is 0x384 bytes.
> 
> All the size field values in the binary are quantified
> as DWORDS (1 DWORD = 4bytes).
> 
> On an invalid value the function prints an error message and returns
> with an error code "EINVAL".
> 
> Signed-off-by: Srinivas Kerekare <srinivas.kerekare@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
> ---
>  drivers/crypto/qat/qat_common/icp_qat_uclo.h |  3 +-
>  drivers/crypto/qat/qat_common/qat_uclo.c     | 56 +++++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E47D95AF
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Oct 2023 12:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjJ0KzG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Oct 2023 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345598AbjJ0KzF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Oct 2023 06:55:05 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8EC192
        for <linux-crypto@vger.kernel.org>; Fri, 27 Oct 2023 03:55:03 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qwKUU-00Beap-PR; Fri, 27 Oct 2023 18:54:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Oct 2023 18:55:05 +0800
Date:   Fri, 27 Oct 2023 18:55:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Damian Muszynski <damian.muszynski@intel.com>
Subject: Re: [PATCH] crypto: qat - move adf_cfg_services
Message-ID: <ZTuXCTP8GN3iF1AC@gondor.apana.org.au>
References: <20231020145257.61933-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020145257.61933-1-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 20, 2023 at 03:52:51PM +0100, Giovanni Cabiddu wrote:
> The file adf_cfg_services.h cannot be included in header files since it
> instantiates the structure adf_cfg_services. Move that structure to its
> own file and export the symbol.
> 
> This does not introduce any functional change.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> ---
>  .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |  2 +-
>  drivers/crypto/intel/qat/qat_common/Makefile  |  1 +
>  .../intel/qat/qat_common/adf_cfg_services.c   | 21 +++++++++++++++++++
>  .../intel/qat/qat_common/adf_cfg_services.h   | 14 ++-----------
>  4 files changed, 25 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/crypto/intel/qat/qat_common/adf_cfg_services.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

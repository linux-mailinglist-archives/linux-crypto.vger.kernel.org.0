Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD281688EC4
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Feb 2023 06:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBCFEx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Feb 2023 00:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBCFEw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Feb 2023 00:04:52 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B530E078
        for <linux-crypto@vger.kernel.org>; Thu,  2 Feb 2023 21:04:19 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNoEo-0071RW-EF; Fri, 03 Feb 2023 13:03:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Feb 2023 13:03:50 +0800
Date:   Fri, 3 Feb 2023 13:03:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        lucas.segarra.fernandez@intel.com, giovanni.cabiddu@intel.com
Subject: Re: [PATCH 1/2] crypto: qat - extend buffer list logic interface
Message-ID: <Y9yVtiMn/KDoxFwK@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123104222.131643-1-lucas.segarra.fernandez@intel.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com> wrote:
> Extend qat_bl_sgl_to_bufl() to allow skipping the mapping of a region
> of the source and the destination scatter lists starting from byte
> zero.
> 
> This is to support the ZLIB format (RFC 1950) in the qat driver.
> The ZLIB format is made of deflate compressed data surrounded by a
> header and a footer. The QAT accelerators support only the deflate
> algorithm, therefore the header should not be mapped since it is
> inserted in software.
> 
> Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
> drivers/crypto/qat/qat_common/qat_bl.c        | 37 ++++++++++++++++---
> drivers/crypto/qat/qat_common/qat_bl.h        |  2 +
> drivers/crypto/qat/qat_common/qat_comp_algs.c |  3 ++
> 3 files changed, 37 insertions(+), 5 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

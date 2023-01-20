Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0298675297
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Jan 2023 11:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjATKe7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Jan 2023 05:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjATKe5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Jan 2023 05:34:57 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6565473ED2
        for <linux-crypto@vger.kernel.org>; Fri, 20 Jan 2023 02:34:54 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pIojS-002BbD-NF; Fri, 20 Jan 2023 18:34:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 18:34:50 +0800
Date:   Fri, 20 Jan 2023 18:34:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Meadhbh <meadhbh.fitzpatrick@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - fix spelling mistakes from 'bufer' to
 'buffer'
Message-ID: <Y8puSi7rwIoqZLJ0@gondor.apana.org.au>
References: <20230112145154.8766-1-meadhbh.fitzpatrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112145154.8766-1-meadhbh.fitzpatrick@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jan 12, 2023 at 03:51:54PM +0100, Meadhbh wrote:
> From: Meadhbh Fitzpatrick <meadhbh.fitzpatrick@intel.com>
> 
> Fix spelling mistakes from 'bufer' to 'buffer' in qat_common.
> Also fix indentation issue caused by the spelling change.
> 
> Signed-off-by: Meadhbh Fitzpatrick <meadhbh.fitzpatrick@intel.com>
> Reviewed-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  .../qat_common/adf_transport_access_macros.h  |  2 +-
>  drivers/crypto/qat/qat_common/qat_bl.c        | 86 +++++++++----------
>  drivers/crypto/qat/qat_common/qat_bl.h        |  2 +-
>  3 files changed, 45 insertions(+), 45 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

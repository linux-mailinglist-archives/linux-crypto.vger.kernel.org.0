Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C795393DBA
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhE1H0V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:26:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50174 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhE1H0V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:26:21 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWrO-0003XE-AG; Fri, 28 May 2021 15:24:46 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWrC-0001vv-3w; Fri, 28 May 2021 15:24:34 +0800
Date:   Fri, 28 May 2021 15:24:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jack Xu <jack.xu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH 0/5] crypto: qat - fix firmware loader
Message-ID: <20210528072434.GA7392@gondor.apana.org.au>
References: <20210517091316.69630-1-jack.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517091316.69630-1-jack.xu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 17, 2021 at 05:13:11AM -0400, Jack Xu wrote:
> This patchset is to fix some issues in the QAT firmware loader:
> * Patches #1 to #3, check the MMP binary size and return error if too large
> * Patch #4 fixes a problem detected by clang static
> * Patch #5 fixes a compiling warnings when building with clang
> 
> 
> Jack Xu (5):
>   crypto: qat - return error when failing to map FW
>   crypto: qat - check MMP size before writing to the SRAM
>   crypto: qat - report an error if MMP file size is too large
>   crypto: qat - check return code of qat_hal_rd_rel_reg()
>   crypto: qat - remove unused macro in FW loader
> 
>  .../qat/qat_common/icp_qat_fw_loader_handle.h      |  2 +-
>  drivers/crypto/qat/qat_common/qat_hal.c            | 14 +++++++++-----
>  drivers/crypto/qat/qat_common/qat_uclo.c           | 12 +++++-------
>  3 files changed, 15 insertions(+), 13 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

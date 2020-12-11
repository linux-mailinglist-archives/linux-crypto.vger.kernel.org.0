Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCE42D7457
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 11:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394299AbgLKK4b (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Dec 2020 05:56:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33510 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394280AbgLKKzw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Dec 2020 05:55:52 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kng4r-0005fD-MS; Fri, 11 Dec 2020 21:55:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Dec 2020 21:55:09 +1100
Date:   Fri, 11 Dec 2020 21:55:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH 0/3] crypto: qat - add support for AES-CTR and AES-XTS in
 qat_4xxx
Message-ID: <20201211105509.GA4466@gondor.apana.org.au>
References: <20201201142451.138221-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201142451.138221-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 01, 2020 at 02:24:48PM +0000, Giovanni Cabiddu wrote:
> This set adds support for AES-CTR and AES-XTS for QAT GEN4 devices and
> adds logic to detect and enable crypto capabilities in the qat_4xxx
> driver.
> 
> Marco Chiappero (3):
>   crypto: qat - add AES-CTR support for QAT GEN4 devices
>   crypto: qat - add AES-XTS support for QAT GEN4 devices
>   crypto: qat - add capability detection logic in qat_4xxx
> 
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |  24 ++++
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  11 ++
>  drivers/crypto/qat/qat_4xxx/adf_drv.c         |   3 +
>  drivers/crypto/qat/qat_common/icp_qat_fw_la.h |   7 ++
>  drivers/crypto/qat/qat_common/icp_qat_hw.h    |  17 ++-
>  drivers/crypto/qat/qat_common/qat_algs.c      | 111 ++++++++++++++++--
>  6 files changed, 165 insertions(+), 8 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

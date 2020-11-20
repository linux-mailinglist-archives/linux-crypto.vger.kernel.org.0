Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20CD2BA2C2
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 08:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgKTG6b (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:58:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34242 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTG6b (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:58:31 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg0NG-0007lr-Ds; Fri, 20 Nov 2020 17:58:27 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:58:26 +1100
Date:   Fri, 20 Nov 2020 17:58:26 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH 0/3] crypto: qat - add qat_4xxx driver
Message-ID: <20201120065826.GG20581@gondor.apana.org.au>
References: <20201113164643.103383-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113164643.103383-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 13, 2020 at 04:46:40PM +0000, Giovanni Cabiddu wrote:
> Add support for QAT 4xxx devices.
> 
> The first patch reworks the logic that loads the firmware images to
> allow for for devices that require multiple firmware images to work.
> The second patch introduces an hook to program the vector routing table,
> which is introduced in QAT 4XXX, to allow to change the vector associated
> with the interrupt source.
> The third patch implements the QAT 4xxx driver.
> 
> Giovanni Cabiddu (3):
>   crypto: qat - target fw images to specific AEs
>   crypto: qat - add hook to initialize vector routing table
>   crypto: qat - add qat_4xxx driver
> 
>  drivers/crypto/qat/Kconfig                    |  11 +
>  drivers/crypto/qat/Makefile                   |   1 +
>  drivers/crypto/qat/qat_4xxx/Makefile          |   4 +
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    | 218 ++++++++++++
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  75 ++++
>  drivers/crypto/qat/qat_4xxx/adf_drv.c         | 320 ++++++++++++++++++
>  drivers/crypto/qat/qat_common/Makefile        |   1 +
>  .../crypto/qat/qat_common/adf_accel_devices.h |   5 +
>  .../crypto/qat/qat_common/adf_accel_engine.c  |  58 +++-
>  .../crypto/qat/qat_common/adf_cfg_common.h    |   3 +-
>  .../crypto/qat/qat_common/adf_gen4_hw_data.c  | 101 ++++++
>  .../crypto/qat/qat_common/adf_gen4_hw_data.h  |  99 ++++++
>  drivers/crypto/qat/qat_common/adf_isr.c       |   3 +
>  13 files changed, 893 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/crypto/qat/qat_4xxx/Makefile
>  create mode 100644 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c
>  create mode 100644 drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.h
>  create mode 100644 drivers/crypto/qat/qat_4xxx/adf_drv.c
>  create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_hw_data.c
>  create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_hw_data.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

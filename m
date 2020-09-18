Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65D826F6F3
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 09:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIRH3V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 03:29:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57630 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgIRH3U (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 03:29:20 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kJApX-0003Wt-C5; Fri, 18 Sep 2020 17:29:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Sep 2020 17:29:15 +1000
Date:   Fri, 18 Sep 2020 17:29:15 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH RESEND 0/2] crypto: qat - replace DIDs macros
Message-ID: <20200918072915.GF23319@gondor.apana.org.au>
References: <20200909105940.203532-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909105940.203532-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 09, 2020 at 11:59:38AM +0100, Giovanni Cabiddu wrote:
> Resending patches 4 and 5 from the series "vfio/pci: add denylist and
> disable qat" that didn't get apply.
> 
> This set replaces the device IDs defined in the qat drivers with the ones
> in linux/pci_ids.h and replaces the custom ADF_SYSTEM_DEVICE macro with
> PCI_VDEVICE.
> 
> Giovanni Cabiddu (2):
>   crypto: qat - replace device ids defines
>   crypto: qat - use PCI_VDEVICE
> 
>  drivers/crypto/qat/qat_c3xxx/adf_drv.c            | 11 ++++-------
>  drivers/crypto/qat/qat_c3xxxvf/adf_drv.c          | 11 ++++-------
>  drivers/crypto/qat/qat_c62x/adf_drv.c             | 11 ++++-------
>  drivers/crypto/qat/qat_c62xvf/adf_drv.c           | 11 ++++-------
>  drivers/crypto/qat/qat_common/adf_accel_devices.h |  6 ------
>  drivers/crypto/qat/qat_common/qat_hal.c           |  7 ++++---
>  drivers/crypto/qat/qat_common/qat_uclo.c          |  9 +++++----
>  drivers/crypto/qat/qat_dh895xcc/adf_drv.c         | 11 ++++-------
>  drivers/crypto/qat/qat_dh895xccvf/adf_drv.c       | 11 ++++-------
>  9 files changed, 33 insertions(+), 55 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

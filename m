Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0D52659D1
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgIKG7j (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Sep 2020 02:59:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59040 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgIKG7i (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Sep 2020 02:59:38 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGd1u-0007yb-PA; Fri, 11 Sep 2020 16:59:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:59:30 +1000
Date:   Fri, 11 Sep 2020 16:59:30 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] crypto: qat - include domain in top level debugfs path
Message-ID: <20200911065930.GK32150@gondor.apana.org.au>
References: <20200904080415.75039-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904080415.75039-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 04, 2020 at 09:04:15AM +0100, Giovanni Cabiddu wrote:
> Use pci_name() when creating debugfs entries in order to include PCI
> domain in the path.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/crypto/qat/qat_c3xxx/adf_drv.c      | 6 ++----
>  drivers/crypto/qat/qat_c3xxxvf/adf_drv.c    | 6 ++----
>  drivers/crypto/qat/qat_c62x/adf_drv.c       | 6 ++----
>  drivers/crypto/qat/qat_c62xvf/adf_drv.c     | 6 ++----
>  drivers/crypto/qat/qat_dh895xcc/adf_drv.c   | 6 ++----
>  drivers/crypto/qat/qat_dh895xccvf/adf_drv.c | 6 ++----
>  6 files changed, 12 insertions(+), 24 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC64816BC0B
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Feb 2020 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgBYIpJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Feb 2020 03:45:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgBYIpJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Feb 2020 03:45:09 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4B06844C2A59F67CC37;
        Tue, 25 Feb 2020 16:45:05 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Feb 2020
 16:44:58 +0800
Subject: Re: [PATCH -next] crypto: hisilicon - qm depends on UACCE
To:     Hongbo Yao <yaohongbo@huawei.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
References: <20200225030356.44008-1-yaohongbo@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <chenzhou10@huawei.com>, <xuzaibo@huawei.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E54DE89.2030703@hisilicon.com>
Date:   Tue, 25 Feb 2020 16:44:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200225030356.44008-1-yaohongbo@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020/2/25 11:03, Hongbo Yao wrote:
> If UACCE=m and CRYPTO_DEV_HISI_QM=y, the following error
> is seen while building qm.o:
> 
> drivers/crypto/hisilicon/qm.o: In function `hisi_qm_init':
> (.text+0x23c6): undefined reference to `uacce_alloc'
> (.text+0x2474): undefined reference to `uacce_remove'
> (.text+0x286b): undefined reference to `uacce_remove'
> drivers/crypto/hisilicon/qm.o: In function `hisi_qm_uninit':
> (.text+0x2918): undefined reference to `uacce_remove'
> make[1]: *** [vmlinux] Error 1
> make: *** [autoksyms_recursive] Error 2
> 
> It has the similar issue while CONFIG_CRYPTO_DEV_HISI_ZIP=y, fix
> the config dependency for QM or ZIP here.
> 
> reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  drivers/crypto/hisilicon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index 8851161f722f..b35c2ec15bc2 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -40,6 +40,7 @@ config CRYPTO_DEV_HISI_QM
>  	tristate
>  	depends on ARM64 || COMPILE_TEST
>  	depends on PCI && PCI_MSI
> +	depends on UACCE
>  	help
>  	  HiSilicon accelerator engines use a common queue management
>  	  interface. Specific engine driver may use this module.
>

Indeed, this driver does not depend on uacce fully, as if there is no uacce, it still can
register to kernel crypto.

Seems that changing uacce config to bool can avoid this problem.

Best,
Zhou



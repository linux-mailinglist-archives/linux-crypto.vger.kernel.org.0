Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A02106DC7
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Nov 2019 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfKVLDG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Nov 2019 06:03:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53314 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfKVLDE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:04 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iY6iM-0004SZ-L7; Fri, 22 Nov 2019 19:03:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iY6iM-0002du-1f; Fri, 22 Nov 2019 19:03:02 +0800
Date:   Fri, 22 Nov 2019 19:03:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zaibo Xu <xuzaibo@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
        linuxarm@huawei.com, fanghao11@huawei.com, yekai13@huawei.com,
        zhangwei375@huawei.com, forest.zhouchang@huawei.com
Subject: Re: [PATCH v3 0/5] crypto: hisilicon - add HiSilicon SEC V2 support
Message-ID: <20191122110301.gajrhialmozc2fm6@gondor.apana.org.au>
References: <1573643468-1812-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573643468-1812-1-git-send-email-xuzaibo@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 13, 2019 at 07:11:03PM +0800, Zaibo Xu wrote:
> This series adds HiSilicon Security Engine (SEC) version 2 controller
> driver in Crypto subsystem. It includes PCIe enabling, Skcipher, DebugFS
> and SRIOV support of SEC.
> 
> This patchset rebases on:
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> 
> This patchset is based on:
> https://www.spinics.net/lists/linux-crypto/msg43520.html
> 
> Changes on v3:
>  - bugfixed as running CRYPTO extra tests.
> 
> Changes on v2:
>  - delete checking return value of debugfs_create_xxx functions.
> 
> Change log:
> v3:    - bugfixed as running CRTPTO extra tests.
> v2:    - remove checking return value of debugfs_create_xxx functions.
> 
> Longfang Liu (1):
>   Documentation: add DebugFS doc for HiSilicon SEC
> 
> Zaibo Xu (4):
>   crypto: hisilicon - add HiSilicon SEC V2 driver
>   crypto: hisilicon - add SRIOV for HiSilicon SEC
>   crypto: hisilicon - add DebugFS for HiSilicon SEC
>   MAINTAINERS: Add maintainer for HiSilicon SEC V2 driver
> 
>  Documentation/ABI/testing/debugfs-hisi-sec |   43 ++
>  MAINTAINERS                                |   10 +
>  drivers/crypto/hisilicon/Kconfig           |   16 +
>  drivers/crypto/hisilicon/Makefile          |    1 +
>  drivers/crypto/hisilicon/sec2/Makefile     |    2 +
>  drivers/crypto/hisilicon/sec2/sec.h        |  156 ++++
>  drivers/crypto/hisilicon/sec2/sec_crypto.c |  889 ++++++++++++++++++++++
>  drivers/crypto/hisilicon/sec2/sec_crypto.h |  198 +++++
>  drivers/crypto/hisilicon/sec2/sec_main.c   | 1095 ++++++++++++++++++++++++++++
>  9 files changed, 2410 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-hisi-sec
>  create mode 100644 drivers/crypto/hisilicon/sec2/Makefile
>  create mode 100644 drivers/crypto/hisilicon/sec2/sec.h
>  create mode 100644 drivers/crypto/hisilicon/sec2/sec_crypto.c
>  create mode 100644 drivers/crypto/hisilicon/sec2/sec_crypto.h
>  create mode 100644 drivers/crypto/hisilicon/sec2/sec_main.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

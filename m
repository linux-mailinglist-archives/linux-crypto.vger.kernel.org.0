Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB302D703D
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 07:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391098AbgLKGdW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Dec 2020 01:33:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9507 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbgLKGdR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Dec 2020 01:33:17 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsgtS3byXzhqfq;
        Fri, 11 Dec 2020 14:32:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 14:32:27 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/5] add ECDH and CURVE25519 algorithms support for Kunpeng 930
Date:   Fri, 11 Dec 2020 14:30:29 +0800
Message-ID: <1607668234-46130-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1. Move elliptic curve parameter definitions out to "include/crypto";
2. Add some new elliptic curve parameters definitions, and reorder
   ECC 'Curves IDs';
3. Add ECDH and CURVE25519 algorithms support for Kunpeng 930.

These patches depend on:
[v2,1/6] crypto: hisilicon/hpre - add version adapt to new algorithms,
https://patchwork.kernel.org/project/linux-crypto/patch/1607598607-8728-
2-git-send-email-liulongfang@huawei.com/

v3 -> v4:
- patch #3: add new, move ecc_curve params to "include/crypto"

v2 -> v3:
- patch #5: fix sparse warnings
- patch #5: add 'CRYPTO_LIB_CURVE25519_GENERIC' in 'Kconfig'

v1 -> v2:
- patch #5: delete `curve25519_null_point'

Hui Tang (1):
  crypto: hisilicon/hpre - add some updates to adapt to Kunpeng 930

Meng Yu (4):
  crypto: hisilicon/hpre - add algorithm type
  crypto: expose elliptic curve parameters as Crypto APIs
  crypto: hisilicon/hpre - add 'ECDH' algorithm
  crypto: hisilicon/hpre - add 'CURVE25519' algorithm

 crypto/ecc.c                                |   5 +-
 crypto/ecc.h                                |  37 +-
 crypto/ecc_curve_defs.h                     |  57 --
 crypto/ecrdsa_defs.h                        |   2 +-
 crypto/testmgr.h                            |  12 +-
 drivers/crypto/hisilicon/Kconfig            |   1 +
 drivers/crypto/hisilicon/hpre/hpre.h        |  22 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 868 +++++++++++++++++++++++++++-
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 105 +++-
 include/crypto/ecc_curve_defs.h             | 261 +++++++++
 include/crypto/ecdh.h                       |   9 +-
 11 files changed, 1228 insertions(+), 151 deletions(-)
 delete mode 100644 crypto/ecc_curve_defs.h
 create mode 100644 include/crypto/ecc_curve_defs.h

-- 
2.8.1


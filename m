Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E142E8CF92
	for <lists+linux-crypto@lfdr.de>; Wed, 14 Aug 2019 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHNJa6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Aug 2019 05:30:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfHNJa6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Aug 2019 05:30:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3EA8BAFA9CB883CE19DB;
        Wed, 14 Aug 2019 17:30:56 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 17:30:48 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 0/5] crypto: hisilicon: Misc fixes
Date:   Wed, 14 Aug 2019 17:28:34 +0800
Message-ID: <1565774919-31853-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Patch 1~3 are fixes about kbuild errors, patch 4,5 are tiny fixes about qm
and zip.

This series is based on cryptodev-2.6.

Zhou Wang (5):
  crypto: hisilicon - fix kbuild warnings
  crypto: hisilicon - add dependency for CRYPTO_DEV_HISI_ZIP
  crypto: hisilicon - init curr_sgl_dma to fix compile warning
  crypto: hisilicon - add missing single_release
  crypto: hisilicon - fix error handle in hisi_zip_create_req_q

 drivers/crypto/hisilicon/Kconfig          | 1 +
 drivers/crypto/hisilicon/qm.c             | 7 ++++---
 drivers/crypto/hisilicon/sgl.c            | 2 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c | 6 ++++--
 4 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.8.1


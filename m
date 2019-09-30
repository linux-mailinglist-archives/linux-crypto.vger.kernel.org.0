Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AAC1BEF
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2019 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfI3HMX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Sep 2019 03:12:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729478AbfI3HMX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Sep 2019 03:12:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 380D5ECA9688446599DE;
        Mon, 30 Sep 2019 15:12:19 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 15:12:10 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 0/4] crypto: hisilicon: misc sgl fixes
Date:   Mon, 30 Sep 2019 15:08:51 +0800
Message-ID: <1569827335-21822-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series fixes some preblems in sgl code. The main change is merging sgl
code into hisi_qm module. 

These problem are also fixed:
 - Let user driver to pass the configure of sge number in one sgl when
   creating hardware sgl resources.
 - When disabling SMMU, it may fail to allocate large continuous memory. We
   fixes this by allocating memory by blocks.

This series is based on Arnd's patch: https://lkml.org/lkml/2019/9/19/455

Shunkun Tan (1):
  crypto: hisilicon - add sgl_sge_nr module param for zip

Zhou Wang (3):
  crypto: hisilicon - merge sgl support to hisi_qm module
  crypto: hisilicon - fix large sgl memory allocation problem when
    disable smmu
  crypto: hisilicon - misc fix about sgl

 MAINTAINERS                               |   1 -
 drivers/crypto/hisilicon/Kconfig          |   9 --
 drivers/crypto/hisilicon/Makefile         |   4 +-
 drivers/crypto/hisilicon/qm.h             |  13 +++
 drivers/crypto/hisilicon/sgl.c            | 182 +++++++++++++++++++-----------
 drivers/crypto/hisilicon/sgl.h            |  24 ----
 drivers/crypto/hisilicon/zip/zip.h        |   1 -
 drivers/crypto/hisilicon/zip/zip_crypto.c |  44 ++++++--
 8 files changed, 167 insertions(+), 111 deletions(-)
 delete mode 100644 drivers/crypto/hisilicon/sgl.h

-- 
2.8.1


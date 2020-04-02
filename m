Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC3019BC12
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Apr 2020 08:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgDBGyE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Apr 2020 02:54:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbgDBGyE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Apr 2020 02:54:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9BE1C709AB347948F67D;
        Thu,  2 Apr 2020 14:53:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Apr 2020 14:53:45 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        Shukun Tan <tanshukun1@huawei.com>
Subject: [PATCH 0/3] crypto: hisilicon - refactor vfs_num related codes
Date:   Thu, 2 Apr 2020 14:53:00 +0800
Message-ID: <1585810383-49392-1-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series clean the vfs_num related redundant code in this series,
move all into QM.

Hao Fang (1):
  crypto: hisilicon - add vfs_num module parameter for hpre/sec

Shukun Tan (2):
  crypto: hisilicon - put vfs_num into struct hisi_qm
  crypto: hisilicon - unify SR-IOV related codes into QM

 drivers/crypto/hisilicon/hpre/hpre.h      |   1 -
 drivers/crypto/hisilicon/hpre/hpre_main.c | 130 +++++-----------------------
 drivers/crypto/hisilicon/qm.c             | 136 +++++++++++++++++++++++++++--
 drivers/crypto/hisilicon/qm.h             |  25 +++++-
 drivers/crypto/hisilicon/sec2/sec.h       |   1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  | 137 ++++++------------------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 131 ++++------------------------
 7 files changed, 215 insertions(+), 346 deletions(-)

-- 
2.7.4


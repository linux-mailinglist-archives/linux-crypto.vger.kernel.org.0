Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A826545D
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Sep 2020 23:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgIJVmo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Sep 2020 17:42:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730900AbgIJM6O (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Sep 2020 08:58:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A7900B03051B6D129BF8
        for <linux-crypto@vger.kernel.org>; Thu, 10 Sep 2020 20:57:57 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 20:57:56 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 0/5] crypto: hisilicon - update ACC module parameter
Date:   Thu, 10 Sep 2020 20:56:48 +0800
Message-ID: <1599742610-33571-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In order to pass kernel crypto test, the ACC module parameter
pf_q_num needs to be set to an integer greater than 1,
and then fixed two bugs.

Longfang Liu (5):
  crypto: hisilicon - update mininum queue
  crypto: hisilicon - update HPRE module parameter description
  crypto: hisilicon - update SEC module parameter description
  crypto: hisilicon - update ZIP module parameter description
  crypto: hisilicon - fixed memory allocation error

 drivers/crypto/hisilicon/hpre/hpre_main.c  |  2 +-
 drivers/crypto/hisilicon/qm.h              |  4 ++--
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 16 ++++++++++++----
 drivers/crypto/hisilicon/sec2/sec_main.c   |  2 +-
 drivers/crypto/hisilicon/zip/zip_main.c    |  2 +-
 5 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.8.1


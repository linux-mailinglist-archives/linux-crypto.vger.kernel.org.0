Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F0025C0B5
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Sep 2020 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgICMDm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Sep 2020 08:03:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728778AbgICL4V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Sep 2020 07:56:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F13BC5AE4028A08F9A90;
        Thu,  3 Sep 2020 19:55:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 19:55:03 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 0/2] crypto: hisilicon - misc fixes
Date:   Thu, 3 Sep 2020 19:53:58 +0800
Message-ID: <1599134040-55860-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset fix some driver bugs

Weili Qian (1):
  crypto: hisilicon/qm - remove the update of flags

Yang Shen (1):
  crypto: hisilicon/qm - fix wrong return type of 'pci_get_drvdata'

 drivers/crypto/hisilicon/hpre/hpre_main.c | 3 +--
 drivers/crypto/hisilicon/qm.c             | 1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  | 3 +--
 drivers/crypto/hisilicon/zip/zip_main.c   | 3 +--
 4 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.8.1


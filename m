Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E474432E250
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Mar 2021 07:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhCEGhb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Mar 2021 01:37:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13435 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCEGha (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Mar 2021 01:37:30 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DsJ0N38LkzjVjs;
        Fri,  5 Mar 2021 14:36:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 14:37:17 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marco.chiappero@intel.com>, <ebiggers@google.com>,
        <tomaszx.kowalik@intel.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] crypto: qat - fixes related to 'dma_map_single'
Date:   Fri, 5 Mar 2021 14:35:00 +0800
Message-ID: <1614926102-44388-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset fix bugs related to 'dma_map_single' use:

Hui Tang (2):
  crypto: qat - fix 'dma_unmap_single' invalid address
  crypto: qat - fix use of 'dma_map_single'


v1 -> v2:
	1.fix build warning reported by kernel test rebot
	2.add patch #1

 drivers/crypto/qat/qat_common/qat_algs.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--
2.8.1


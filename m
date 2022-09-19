Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116535BCB6F
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Sep 2022 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiISMIG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Sep 2022 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiISMIE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Sep 2022 08:08:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20212B268;
        Mon, 19 Sep 2022 05:08:02 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWNd40hNGzmVVp;
        Mon, 19 Sep 2022 20:04:08 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:08:00 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 6/6] MAINTAINERS: add crypto benchmark MAINTAINER
Date:   Mon, 19 Sep 2022 20:05:37 +0800
Message-ID: <20220919120537.39258-7-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220919120537.39258-1-shenyang39@huawei.com>
References: <20220919120537.39258-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add the maintainer information for the crypto benchmark.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 164f67e59e5f..89beaebfab23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5445,6 +5445,13 @@ F:	include/crypto/
 F:	include/linux/crypto*
 F:	lib/crypto/
 
+CRYPTO BENCHMARK TOOL
+M:	Yang Shen <shenyang39@huawei.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/crypto/benchmark.rst
+F:	crypto/benchmark/
+
 CRYPTOGRAPHIC RANDOM NUMBER GENERATOR
 M:	Neil Horman <nhorman@tuxdriver.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.24.0


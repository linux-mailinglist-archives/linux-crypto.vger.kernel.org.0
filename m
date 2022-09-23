Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F85E7679
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Sep 2022 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiIWJIp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 23 Sep 2022 05:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIWJId (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 23 Sep 2022 05:08:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2E12DE83
        for <linux-crypto@vger.kernel.org>; Fri, 23 Sep 2022 02:08:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYmRf4gYwz1P6t7;
        Fri, 23 Sep 2022 17:04:14 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:08:23 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ardb@kernel.org>, <t-kristo@ti.com>, <cuigaosheng1@huawei.com>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 0/3] A few cleanup patches for crypto
Date:   Fri, 23 Sep 2022 17:08:20 +0800
Message-ID: <20220923090823.509656-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series contains a few cleanup patches, to remove orphan
inline functions and simplify some code. Thanks!

Gaosheng Cui (3):
  crypto: bcm - Simplify obtain the name for cipher
  crypto: aead - Remove unused inline functions from aead
  crypto: scatterwalk - Remove unused inline function
    scatterwalk_aligned()

 drivers/crypto/bcm/cipher.c    |  4 ++--
 include/crypto/internal/aead.h | 25 -------------------------
 include/crypto/scatterwalk.h   |  6 ------
 3 files changed, 2 insertions(+), 33 deletions(-)

-- 
2.25.1


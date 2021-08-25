Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E161F3F743F
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Aug 2021 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbhHYLWm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Aug 2021 07:22:42 -0400
Received: from mx21.baidu.com ([220.181.3.85]:52146 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239394AbhHYLWm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Aug 2021 07:22:42 -0400
Received: from BC-Mail-Ex20.internal.baidu.com (unknown [172.31.51.14])
        by Forcepoint Email with ESMTPS id DD899E7C4B9B76EDE2D1;
        Wed, 25 Aug 2021 19:21:54 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex20.internal.baidu.com (172.31.51.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 25 Aug 2021 19:21:54 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 25 Aug 2021 19:21:54 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <nicolas.toromanoff@st.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 0/2] crypto: stm32 - Add support of COMPILE_TEST
Date:   Wed, 25 Aug 2021 19:21:45 +0800
Message-ID: <20210825112147.2669-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

it's helpful for complie test in other platform(e.g.X86

Cai Huoqing (2):
  crypto: stm32 - Add support of COMPILE_TEST
  crypto: stm32 - open the configuration for COMPILE_TEST

 drivers/crypto/Makefile      | 2 +-
 drivers/crypto/stm32/Kconfig | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748A93EA55D
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Aug 2021 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhHLNSz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 09:18:55 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49462 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236474AbhHLNSQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 09:18:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UinuYNO_1628774268;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UinuYNO_1628774268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 21:17:48 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 0/3] support test GCM/CCM mode for SM4
Date:   Thu, 12 Aug 2021 21:17:45 +0800
Message-Id: <20210812131748.81620-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The GCM/CCM mode of SM4 is defined in the RFC 8998 specification:
https://datatracker.ietf.org/doc/html/rfc8998

At the same time, a minor issue in tcrypt is fixed.

Tianjia Zhang (3):
  crypto: tcrypt - Fix the wrong position of return value test statement
  crypto: testmgr - Add GCM/CCM mode test of SM4 algorithm
  crypto: tcrypt: add GCM/CCM mode test for SM4 algorithm

 crypto/tcrypt.c  |  58 ++++++++++++++++---
 crypto/testmgr.c |  29 ++++++++++
 crypto/testmgr.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 7 deletions(-)

-- 
2.19.1.3.ge56e4f7


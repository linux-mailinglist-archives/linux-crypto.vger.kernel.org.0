Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781AA60F0CC
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Oct 2022 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiJ0G4r (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Oct 2022 02:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiJ0Gzy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Oct 2022 02:55:54 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51939BBC;
        Wed, 26 Oct 2022 23:55:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VTAHLqG_1666853722;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VTAHLqG_1666853722)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 14:55:23 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 08/13] crypto: arm64/sm4 - export reusable CE acceleration functions
Date:   Thu, 27 Oct 2022 14:55:00 +0800
Message-Id: <20221027065505.15306-9-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221027065505.15306-1-tianjia.zhang@linux.alibaba.com>
References: <20221027065505.15306-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In the accelerated implementation of the SM4 algorithm using the Crypto
Extension instructions, there are some functions that can be reused in
the upcoming accelerated implementation of the GCM/CCM mode, and the
CBC/CFB encryption is reused in the optimized implementation of SVESM4.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/arm64/crypto/sm4-ce-glue.c |  5 +++++
 arch/arm64/crypto/sm4-ce.h      | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/arm64/crypto/sm4-ce.h

diff --git a/arch/arm64/crypto/sm4-ce-glue.c b/arch/arm64/crypto/sm4-ce-glue.c
index ff2d8442d473..63abcadc684b 100644
--- a/arch/arm64/crypto/sm4-ce-glue.c
+++ b/arch/arm64/crypto/sm4-ce-glue.c
@@ -36,6 +36,11 @@ asmlinkage void sm4_ce_cfb_dec(const u32 *rkey, u8 *dst, const u8 *src,
 asmlinkage void sm4_ce_ctr_enc(const u32 *rkey, u8 *dst, const u8 *src,
 			       u8 *iv, unsigned int nblks);
 
+EXPORT_SYMBOL(sm4_ce_expand_key);
+EXPORT_SYMBOL(sm4_ce_crypt_block);
+EXPORT_SYMBOL(sm4_ce_cbc_enc);
+EXPORT_SYMBOL(sm4_ce_cfb_enc);
+
 static int sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		      unsigned int key_len)
 {
diff --git a/arch/arm64/crypto/sm4-ce.h b/arch/arm64/crypto/sm4-ce.h
new file mode 100644
index 000000000000..109c21b37590
--- /dev/null
+++ b/arch/arm64/crypto/sm4-ce.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 common functions for Crypto Extensions
+ * Copyright (C) 2022 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+void sm4_ce_expand_key(const u8 *key, u32 *rkey_enc, u32 *rkey_dec,
+		       const u32 *fk, const u32 *ck);
+
+void sm4_ce_crypt_block(const u32 *rkey, u8 *dst, const u8 *src);
+
+void sm4_ce_cbc_enc(const u32 *rkey_enc, u8 *dst, const u8 *src,
+		    u8 *iv, unsigned int nblocks);
+
+void sm4_ce_cfb_enc(const u32 *rkey_enc, u8 *dst, const u8 *src,
+		    u8 *iv, unsigned int nblocks);
-- 
2.24.3 (Apple Git-128)


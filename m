Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8070E639184
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Nov 2022 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKYWdO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Nov 2022 17:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiKYWcp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Nov 2022 17:32:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C20633D
        for <linux-crypto@vger.kernel.org>; Fri, 25 Nov 2022 14:32:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r12so8817020lfp.1
        for <linux-crypto@vger.kernel.org>; Fri, 25 Nov 2022 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CELXSye0H3PsiZ6mUOmHH2+boDTXAjiAAWk8iu9psA=;
        b=jRrpiHAss9fNFDFpR2Nlil1Zxgz8dIboMaTn/UuW+7Fy/WRkTpUwSj6GFmZzlPsG7j
         9GROppNEUcFHHlOK0i0q+EMtN2Ngujz+oDwFIBHj53p4ILkFPGCp9eJ5Zk4oDvkutIlL
         bPOLB2j+uo6DUB92yFearun5wPQC2CtECCYO1i7aGSj2SjTMplmPyuwsQ0RwfcYGtIPK
         xvXfgntQH+bCIzaUyLEzl3XTGkHgy/P+TGG6ZB1/vvfnG4Z9yNnN1dyM224dKv4wlxd7
         G3cd/mrDT+vM+BjM5SkvZEcahlisKJGogeEivKeNQxFRS2/jbkAAmvzdQtmmEWXEsR9p
         grJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CELXSye0H3PsiZ6mUOmHH2+boDTXAjiAAWk8iu9psA=;
        b=7MFOlHXDyGuoRzSl2CuNmLPr9jcOKHkixn08CaeQqcaDIIVLjn/WYi0O/7i6TKxHDJ
         hYFDd16l8OHvRleCLRAvqSI0Adp0EG/RlSAthboXxL3JbpR9a1v8S9uXoAhFYUQcHH/I
         O8XxPxLjqq3eAzxSu7cOYs3TVIOfO86Lzr/BUrAb3KOopH4Ue6HW5Fp84xOGDBz7MHr0
         rijR7na+FJaqjGmPaxGWd/8efT+QPaNADfWv8BgRhDRdL/y281ueni+v5rgQ9tyP+122
         ed/iMtasSzPoKXsrHcUXSKY2+jWk6RBZvZV6HBVLhOf89+6BuBr4qADl2LhwjSDbbGUH
         mYZw==
X-Gm-Message-State: ANoB5pmNWJjxE/+5KQENPCAJV77gwBbMy3pJOPQpwakc0a90ilVYezzE
        BlnSt3VCMYMqNy3EuYFD0LJdSQf9RrU/AA==
X-Google-Smtp-Source: AA0mqf6KKquTD8iDkqaEoKYymqI9QaiD3mj2WiGba88FFHEvpjm9vGEoJyUrGTTEEBF4T0GG78zqFg==
X-Received: by 2002:a05:6512:4c8:b0:4a2:7d11:80e8 with SMTP id w8-20020a05651204c800b004a27d1180e8mr13087650lfq.464.1669415547901;
        Fri, 25 Nov 2022 14:32:27 -0800 (PST)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id f7-20020a05651201c700b004b4e9580b1asm676582lfp.66.2022.11.25.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 14:32:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     phone-devel@vger.kernel.org, Stefan Hansson <newbyte@disroot.org>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 3/4] crypto: stm32/cryp - enable for use with Ux500
Date:   Fri, 25 Nov 2022 23:32:16 +0100
Message-Id: <20221125223217.2409659-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125223217.2409659-1-linus.walleij@linaro.org>
References: <20221125223217.2409659-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This adds a few small quirks to handle the differences between
the STM32 and Ux500 cryp blocks. The following differences
are handled with special bool switch bits in the capabilities:

- The main difference is that some registers are removed, so we
  add register offsets for all registers in the
  per-variant data. Then we assign the right offsets for Ux500
  vs the STM32 variants.

- The Ux500 does not support the aeads algorithms; gcm(aes)
  and ccm(aes). Avoid registering them when running on Ux500.

- The Ux500 has a special "linear" key format and does some
  elaborare bit swizzling of the key bits before writing them
  into the key registers. This is written as an "application
  note" inside the DB8500 design specification, and seems to
  be the result of some mishap when assigning the data lines
  to register bits. (STM32 has clearly fixed this.)

- The Ux500 does not have the KP "key prepare" bit in the
  CR register. Instead, we need to set the KSE bit,
  "key schedule encryption" bit which does the same thing
  but is in bit 11 rather than being a special "algorithm
  type" as on STM32. The algorithm must however be specified
  as AES ECB while doing this.

- The Ux500 cannot just read out IV registers, we need to
  set the KEYRDEN "key read enable" bit, as this protects
  not just the key but also the IV from being read out.
  Enable this bit before reading out the IV and disable it
  afterwards.

Cc: Lionel Debieve <lionel.debieve@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Use per-variant register offsets also for CR and SR.
---
 drivers/crypto/stm32/stm32-cryp.c | 413 +++++++++++++++++++++++-------
 1 file changed, 322 insertions(+), 91 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 59ef541123ae..669d2ec60145 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) STMicroelectronics SA 2017
  * Author: Fabien Dessenne <fabien.dessenne@st.com>
+ * Ux500 support taken from snippets in the old Ux500 cryp driver
  */
 
 #include <linux/clk.h>
@@ -62,6 +63,29 @@
 #define CRYP_CSGCMCCM0R         0x00000050
 #define CRYP_CSGCM0R            0x00000070
 
+#define UX500_CRYP_CR		0x00000000
+#define UX500_CRYP_SR		0x00000004
+#define UX500_CRYP_DIN		0x00000008
+#define UX500_CRYP_DINSIZE	0x0000000C
+#define UX500_CRYP_DOUT		0x00000010
+#define UX500_CRYP_DOUSIZE	0x00000014
+#define UX500_CRYP_DMACR	0x00000018
+#define UX500_CRYP_IMSC		0x0000001C
+#define UX500_CRYP_RIS		0x00000020
+#define UX500_CRYP_MIS		0x00000024
+#define UX500_CRYP_K1L		0x00000028
+#define UX500_CRYP_K1R		0x0000002C
+#define UX500_CRYP_K2L		0x00000030
+#define UX500_CRYP_K2R		0x00000034
+#define UX500_CRYP_K3L		0x00000038
+#define UX500_CRYP_K3R		0x0000003C
+#define UX500_CRYP_K4L		0x00000040
+#define UX500_CRYP_K4R		0x00000044
+#define UX500_CRYP_IV0L		0x00000048
+#define UX500_CRYP_IV0R		0x0000004C
+#define UX500_CRYP_IV1L		0x00000050
+#define UX500_CRYP_IV1R		0x00000054
+
 /* Registers values */
 #define CR_DEC_NOT_ENC          0x00000004
 #define CR_TDES_ECB             0x00000000
@@ -71,7 +95,8 @@
 #define CR_AES_ECB              0x00000020
 #define CR_AES_CBC              0x00000028
 #define CR_AES_CTR              0x00000030
-#define CR_AES_KP               0x00000038
+#define CR_AES_KP               0x00000038 /* Not on Ux500 */
+#define CR_AES_XTS              0x00000038 /* Only on Ux500 */
 #define CR_AES_GCM              0x00080000
 #define CR_AES_CCM              0x00080008
 #define CR_AES_UNKNOWN          0xFFFFFFFF
@@ -83,6 +108,8 @@
 #define CR_KEY128               0x00000000
 #define CR_KEY192               0x00000100
 #define CR_KEY256               0x00000200
+#define CR_KEYRDEN              0x00000400 /* Only on Ux500 */
+#define CR_KSE                  0x00000800 /* Only on Ux500 */
 #define CR_FFLUSH               0x00004000
 #define CR_CRYPEN               0x00008000
 #define CR_PH_INIT              0x00000000
@@ -107,8 +134,25 @@
 #define CRYP_AUTOSUSPEND_DELAY	50
 
 struct stm32_cryp_caps {
-	bool                    swap_final;
-	bool                    padding_wa;
+	bool			aeads_support;
+	bool			linear_aes_key;
+	bool			kp_mode;
+	bool			iv_protection;
+	bool			swap_final;
+	bool			padding_wa;
+	u32			cr;
+	u32			sr;
+	u32			din;
+	u32			dout;
+	u32			imsc;
+	u32			mis;
+	u32			k1l;
+	u32			k1r;
+	u32			k3r;
+	u32			iv0l;
+	u32			iv0r;
+	u32			iv1l;
+	u32			iv1r;
 };
 
 struct stm32_cryp_ctx {
@@ -228,20 +272,21 @@ static inline int stm32_cryp_wait_busy(struct stm32_cryp *cryp)
 {
 	u32 status;
 
-	return readl_relaxed_poll_timeout(cryp->regs + CRYP_SR, status,
+	return readl_relaxed_poll_timeout(cryp->regs + cryp->caps->sr, status,
 			!(status & SR_BUSY), 10, 100000);
 }
 
 static inline void stm32_cryp_enable(struct stm32_cryp *cryp)
 {
-	writel_relaxed(readl_relaxed(cryp->regs + CRYP_CR) | CR_CRYPEN, cryp->regs + CRYP_CR);
+	writel_relaxed(readl_relaxed(cryp->regs + cryp->caps->cr) | CR_CRYPEN,
+		       cryp->regs + cryp->caps->cr);
 }
 
 static inline int stm32_cryp_wait_enable(struct stm32_cryp *cryp)
 {
 	u32 status;
 
-	return readl_relaxed_poll_timeout(cryp->regs + CRYP_CR, status,
+	return readl_relaxed_poll_timeout(cryp->regs + cryp->caps->cr, status,
 			!(status & CR_CRYPEN), 10, 100000);
 }
 
@@ -249,10 +294,22 @@ static inline int stm32_cryp_wait_output(struct stm32_cryp *cryp)
 {
 	u32 status;
 
-	return readl_relaxed_poll_timeout(cryp->regs + CRYP_SR, status,
+	return readl_relaxed_poll_timeout(cryp->regs + cryp->caps->sr, status,
 			status & SR_OFNE, 10, 100000);
 }
 
+static inline void stm32_cryp_key_read_enable(struct stm32_cryp *cryp)
+{
+	writel_relaxed(readl_relaxed(cryp->regs + cryp->caps->cr) | CR_KEYRDEN,
+		       cryp->regs + cryp->caps->cr);
+}
+
+static inline void stm32_cryp_key_read_disable(struct stm32_cryp *cryp)
+{
+	writel_relaxed(readl_relaxed(cryp->regs + cryp->caps->cr) & ~CR_KEYRDEN,
+		       cryp->regs + cryp->caps->cr);
+}
+
 static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp);
 static void stm32_cryp_finish_req(struct stm32_cryp *cryp, int err);
 
@@ -281,12 +338,12 @@ static void stm32_cryp_hw_write_iv(struct stm32_cryp *cryp, __be32 *iv)
 	if (!iv)
 		return;
 
-	stm32_cryp_write(cryp, CRYP_IV0LR, be32_to_cpu(*iv++));
-	stm32_cryp_write(cryp, CRYP_IV0RR, be32_to_cpu(*iv++));
+	stm32_cryp_write(cryp, cryp->caps->iv0l, be32_to_cpu(*iv++));
+	stm32_cryp_write(cryp, cryp->caps->iv0r, be32_to_cpu(*iv++));
 
 	if (is_aes(cryp)) {
-		stm32_cryp_write(cryp, CRYP_IV1LR, be32_to_cpu(*iv++));
-		stm32_cryp_write(cryp, CRYP_IV1RR, be32_to_cpu(*iv++));
+		stm32_cryp_write(cryp, cryp->caps->iv1l, be32_to_cpu(*iv++));
+		stm32_cryp_write(cryp, cryp->caps->iv1r, be32_to_cpu(*iv++));
 	}
 }
 
@@ -298,12 +355,102 @@ static void stm32_cryp_get_iv(struct stm32_cryp *cryp)
 	if (!tmp)
 		return;
 
-	*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV0LR));
-	*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV0RR));
+	if (cryp->caps->iv_protection)
+		stm32_cryp_key_read_enable(cryp);
+
+	*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv0l));
+	*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv0r));
 
 	if (is_aes(cryp)) {
-		*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV1LR));
-		*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV1RR));
+		*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv1l));
+		*tmp++ = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv1r));
+	}
+
+	if (cryp->caps->iv_protection)
+		stm32_cryp_key_read_disable(cryp);
+}
+
+/**
+ * swap_bits_in_byte() - mirror the bits in a byte
+ * @b: the byte to be mirrored
+ *
+ * The bits are swapped the following way:
+ *  Byte b include bits 0-7, nibble 1 (n1) include bits 0-3 and
+ *  nibble 2 (n2) bits 4-7.
+ *
+ *  Nibble 1 (n1):
+ *  (The "old" (moved) bit is replaced with a zero)
+ *  1. Move bit 6 and 7, 4 positions to the left.
+ *  2. Move bit 3 and 5, 2 positions to the left.
+ *  3. Move bit 1-4, 1 position to the left.
+ *
+ *  Nibble 2 (n2):
+ *  1. Move bit 0 and 1, 4 positions to the right.
+ *  2. Move bit 2 and 4, 2 positions to the right.
+ *  3. Move bit 3-6, 1 position to the right.
+ *
+ *  Combine the two nibbles to a complete and swapped byte.
+ */
+static inline u8 ux500_swap_bits_in_byte(u8 b)
+{
+#define R_SHIFT_4_MASK  0xc0 /* Bits 6 and 7, right shift 4 */
+#define R_SHIFT_2_MASK  0x28 /* (After right shift 4) Bits 3 and 5,
+				  right shift 2 */
+#define R_SHIFT_1_MASK  0x1e /* (After right shift 2) Bits 1-4,
+				  right shift 1 */
+#define L_SHIFT_4_MASK  0x03 /* Bits 0 and 1, left shift 4 */
+#define L_SHIFT_2_MASK  0x14 /* (After left shift 4) Bits 2 and 4,
+				  left shift 2 */
+#define L_SHIFT_1_MASK  0x78 /* (After left shift 1) Bits 3-6,
+				  left shift 1 */
+
+	u8 n1;
+	u8 n2;
+
+	/* Swap most significant nibble */
+	/* Right shift 4, bits 6 and 7 */
+	n1 = ((b  & R_SHIFT_4_MASK) >> 4) | (b  & ~(R_SHIFT_4_MASK >> 4));
+	/* Right shift 2, bits 3 and 5 */
+	n1 = ((n1 & R_SHIFT_2_MASK) >> 2) | (n1 & ~(R_SHIFT_2_MASK >> 2));
+	/* Right shift 1, bits 1-4 */
+	n1 = (n1  & R_SHIFT_1_MASK) >> 1;
+
+	/* Swap least significant nibble */
+	/* Left shift 4, bits 0 and 1 */
+	n2 = ((b  & L_SHIFT_4_MASK) << 4) | (b  & ~(L_SHIFT_4_MASK << 4));
+	/* Left shift 2, bits 2 and 4 */
+	n2 = ((n2 & L_SHIFT_2_MASK) << 2) | (n2 & ~(L_SHIFT_2_MASK << 2));
+	/* Left shift 1, bits 3-6 */
+	n2 = (n2  & L_SHIFT_1_MASK) << 1;
+
+	return n1 | n2;
+}
+
+/**
+ * ux500_swizzle_key() - Shuffle around words and bits in the AES key
+ * @in: key to swizzle
+ * @out: swizzled key
+ * @len: length of key, in bytes
+ *
+ * This "key swizzling procedure" is described in the examples in the
+ * DB8500 design specification. There is no real description of why
+ * the bits have been arranged like this in the hardware.
+ */
+static inline void ux500_swizzle_key(const u8 *in, u8 *out, u32 len)
+{
+	int i = 0;
+	int bpw = sizeof(u32);
+	int j;
+	int index = 0;
+
+	j = len - bpw;
+	while (j >= 0) {
+		for (i = 0; i < bpw; i++) {
+			index = len - j - bpw + i;
+			out[j + i] =
+				ux500_swap_bits_in_byte(in[index]);
+		}
+		j -= bpw;
 	}
 }
 
@@ -313,14 +460,33 @@ static void stm32_cryp_hw_write_key(struct stm32_cryp *c)
 	int r_id;
 
 	if (is_des(c)) {
-		stm32_cryp_write(c, CRYP_K1LR, be32_to_cpu(c->ctx->key[0]));
-		stm32_cryp_write(c, CRYP_K1RR, be32_to_cpu(c->ctx->key[1]));
-	} else {
-		r_id = CRYP_K3RR;
-		for (i = c->ctx->keylen / sizeof(u32); i > 0; i--, r_id -= 4)
-			stm32_cryp_write(c, r_id,
-					 be32_to_cpu(c->ctx->key[i - 1]));
+		stm32_cryp_write(c, c->caps->k1l, be32_to_cpu(c->ctx->key[0]));
+		stm32_cryp_write(c, c->caps->k1r, be32_to_cpu(c->ctx->key[1]));
+		return;
 	}
+
+	/*
+	 * On the Ux500 the AES key is considered as a single bit sequence
+	 * of 128, 192 or 256 bits length. It is written linearly into the
+	 * registers from K1L and down, and need to be processed to become
+	 * a proper big-endian bit sequence.
+	 */
+	if (is_aes(c) && c->caps->linear_aes_key) {
+		u32 tmpkey[8];
+
+		ux500_swizzle_key((u8 *)c->ctx->key,
+				  (u8 *)tmpkey, c->ctx->keylen);
+
+		r_id = c->caps->k1l;
+		for (i = 0; i < c->ctx->keylen / sizeof(u32); i++, r_id += 4)
+			stm32_cryp_write(c, r_id, tmpkey[i]);
+
+		return;
+	}
+
+	r_id = c->caps->k3r;
+	for (i = c->ctx->keylen / sizeof(u32); i > 0; i--, r_id -= 4)
+		stm32_cryp_write(c, r_id, be32_to_cpu(c->ctx->key[i - 1]));
 }
 
 static u32 stm32_cryp_get_hw_mode(struct stm32_cryp *cryp)
@@ -373,7 +539,7 @@ static int stm32_cryp_gcm_init(struct stm32_cryp *cryp, u32 cfg)
 	cryp->gcm_ctr = GCM_CTR_INIT;
 	stm32_cryp_hw_write_iv(cryp, iv);
 
-	stm32_cryp_write(cryp, CRYP_CR, cfg | CR_PH_INIT | CR_CRYPEN);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg | CR_PH_INIT | CR_CRYPEN);
 
 	/* Wait for end of processing */
 	ret = stm32_cryp_wait_enable(cryp);
@@ -385,10 +551,10 @@ static int stm32_cryp_gcm_init(struct stm32_cryp *cryp, u32 cfg)
 	/* Prepare next phase */
 	if (cryp->areq->assoclen) {
 		cfg |= CR_PH_HEADER;
-		stm32_cryp_write(cryp, CRYP_CR, cfg);
+		stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 	} else if (stm32_cryp_get_input_text_len(cryp)) {
 		cfg |= CR_PH_PAYLOAD;
-		stm32_cryp_write(cryp, CRYP_CR, cfg);
+		stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 	}
 
 	return 0;
@@ -405,20 +571,20 @@ static void stm32_crypt_gcmccm_end_header(struct stm32_cryp *cryp)
 		err = stm32_cryp_wait_busy(cryp);
 		if (err) {
 			dev_err(cryp->dev, "Timeout (gcm/ccm header)\n");
-			stm32_cryp_write(cryp, CRYP_IMSCR, 0);
+			stm32_cryp_write(cryp, cryp->caps->imsc, 0);
 			stm32_cryp_finish_req(cryp, err);
 			return;
 		}
 
 		if (stm32_cryp_get_input_text_len(cryp)) {
 			/* Phase 3 : payload */
-			cfg = stm32_cryp_read(cryp, CRYP_CR);
+			cfg = stm32_cryp_read(cryp, cryp->caps->cr);
 			cfg &= ~CR_CRYPEN;
-			stm32_cryp_write(cryp, CRYP_CR, cfg);
+			stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 			cfg &= ~CR_PH_MASK;
 			cfg |= CR_PH_PAYLOAD | CR_CRYPEN;
-			stm32_cryp_write(cryp, CRYP_CR, cfg);
+			stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 		} else {
 			/*
 			 * Phase 4 : tag.
@@ -458,7 +624,7 @@ static void stm32_cryp_write_ccm_first_header(struct stm32_cryp *cryp)
 
 	scatterwalk_copychunks((char *)block + len, &cryp->in_walk, written, 0);
 	for (i = 0; i < AES_BLOCK_32; i++)
-		stm32_cryp_write(cryp, CRYP_DIN, block[i]);
+		stm32_cryp_write(cryp, cryp->caps->din, block[i]);
 
 	cryp->header_in -= written;
 
@@ -494,7 +660,7 @@ static int stm32_cryp_ccm_init(struct stm32_cryp *cryp, u32 cfg)
 	b0[AES_BLOCK_SIZE - 1] = textlen & 0xFF;
 
 	/* Enable HW */
-	stm32_cryp_write(cryp, CRYP_CR, cfg | CR_PH_INIT | CR_CRYPEN);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg | CR_PH_INIT | CR_CRYPEN);
 
 	/* Write B0 */
 	d = (u32 *)b0;
@@ -505,7 +671,7 @@ static int stm32_cryp_ccm_init(struct stm32_cryp *cryp, u32 cfg)
 
 		if (!cryp->caps->padding_wa)
 			xd = be32_to_cpu(bd[i]);
-		stm32_cryp_write(cryp, CRYP_DIN, xd);
+		stm32_cryp_write(cryp, cryp->caps->din, xd);
 	}
 
 	/* Wait for end of processing */
@@ -518,13 +684,13 @@ static int stm32_cryp_ccm_init(struct stm32_cryp *cryp, u32 cfg)
 	/* Prepare next phase */
 	if (cryp->areq->assoclen) {
 		cfg |= CR_PH_HEADER | CR_CRYPEN;
-		stm32_cryp_write(cryp, CRYP_CR, cfg);
+		stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 		/* Write first (special) block (may move to next phase [payload]) */
 		stm32_cryp_write_ccm_first_header(cryp);
 	} else if (stm32_cryp_get_input_text_len(cryp)) {
 		cfg |= CR_PH_PAYLOAD;
-		stm32_cryp_write(cryp, CRYP_CR, cfg);
+		stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 	}
 
 	return 0;
@@ -538,7 +704,7 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 	pm_runtime_get_sync(cryp->dev);
 
 	/* Disable interrupt */
-	stm32_cryp_write(cryp, CRYP_IMSCR, 0);
+	stm32_cryp_write(cryp, cryp->caps->imsc, 0);
 
 	/* Set configuration */
 	cfg = CR_DATA8 | CR_FFLUSH;
@@ -566,7 +732,12 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 	if (is_decrypt(cryp) &&
 	    ((hw_mode == CR_AES_ECB) || (hw_mode == CR_AES_CBC))) {
 		/* Configure in key preparation mode */
-		stm32_cryp_write(cryp, CRYP_CR, cfg | CR_AES_KP);
+		if (cryp->caps->kp_mode)
+			stm32_cryp_write(cryp, cryp->caps->cr,
+				cfg | CR_AES_KP);
+		else
+			stm32_cryp_write(cryp,
+				cryp->caps->cr, cfg | CR_AES_ECB | CR_KSE);
 
 		/* Set key only after full configuration done */
 		stm32_cryp_hw_write_key(cryp);
@@ -583,14 +754,14 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 		cfg |= hw_mode | CR_DEC_NOT_ENC;
 
 		/* Apply updated config (Decrypt + algo) and flush */
-		stm32_cryp_write(cryp, CRYP_CR, cfg);
+		stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 	} else {
 		cfg |= hw_mode;
 		if (is_decrypt(cryp))
 			cfg |= CR_DEC_NOT_ENC;
 
 		/* Apply config and flush */
-		stm32_cryp_write(cryp, CRYP_CR, cfg);
+		stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 		/* Set key only after configuration done */
 		stm32_cryp_hw_write_key(cryp);
@@ -649,7 +820,7 @@ static void stm32_cryp_finish_req(struct stm32_cryp *cryp, int err)
 static int stm32_cryp_cpu_start(struct stm32_cryp *cryp)
 {
 	/* Enable interrupt and let the IRQ handler do everything */
-	stm32_cryp_write(cryp, CRYP_IMSCR, IMSCR_IN | IMSCR_OUT);
+	stm32_cryp_write(cryp, cryp->caps->imsc, IMSCR_IN | IMSCR_OUT);
 
 	return 0;
 }
@@ -1137,14 +1308,14 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 	int ret = 0;
 
 	/* Update Config */
-	cfg = stm32_cryp_read(cryp, CRYP_CR);
+	cfg = stm32_cryp_read(cryp, cryp->caps->cr);
 
 	cfg &= ~CR_PH_MASK;
 	cfg |= CR_PH_FINAL;
 	cfg &= ~CR_DEC_NOT_ENC;
 	cfg |= CR_CRYPEN;
 
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	if (is_gcm(cryp)) {
 		/* GCM: write aad and payload size (in bits) */
@@ -1152,8 +1323,8 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 		if (cryp->caps->swap_final)
 			size_bit = (__force u32)cpu_to_be32(size_bit);
 
-		stm32_cryp_write(cryp, CRYP_DIN, 0);
-		stm32_cryp_write(cryp, CRYP_DIN, size_bit);
+		stm32_cryp_write(cryp, cryp->caps->din, 0);
+		stm32_cryp_write(cryp, cryp->caps->din, size_bit);
 
 		size_bit = is_encrypt(cryp) ? cryp->areq->cryptlen :
 				cryp->areq->cryptlen - cryp->authsize;
@@ -1161,8 +1332,8 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 		if (cryp->caps->swap_final)
 			size_bit = (__force u32)cpu_to_be32(size_bit);
 
-		stm32_cryp_write(cryp, CRYP_DIN, 0);
-		stm32_cryp_write(cryp, CRYP_DIN, size_bit);
+		stm32_cryp_write(cryp, cryp->caps->din, 0);
+		stm32_cryp_write(cryp, cryp->caps->din, size_bit);
 	} else {
 		/* CCM: write CTR0 */
 		u32 iv32[AES_BLOCK_32];
@@ -1177,7 +1348,7 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 
 			if (!cryp->caps->padding_wa)
 				xiv = be32_to_cpu(biv[i]);
-			stm32_cryp_write(cryp, CRYP_DIN, xiv);
+			stm32_cryp_write(cryp, cryp->caps->din, xiv);
 		}
 	}
 
@@ -1193,7 +1364,7 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 
 		/* Get and write tag */
 		for (i = 0; i < AES_BLOCK_32; i++)
-			out_tag[i] = stm32_cryp_read(cryp, CRYP_DOUT);
+			out_tag[i] = stm32_cryp_read(cryp, cryp->caps->dout);
 
 		scatterwalk_copychunks(out_tag, &cryp->out_walk, cryp->authsize, 1);
 	} else {
@@ -1203,7 +1374,7 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 		scatterwalk_copychunks(in_tag, &cryp->in_walk, cryp->authsize, 0);
 
 		for (i = 0; i < AES_BLOCK_32; i++)
-			out_tag[i] = stm32_cryp_read(cryp, CRYP_DOUT);
+			out_tag[i] = stm32_cryp_read(cryp, cryp->caps->dout);
 
 		if (crypto_memneq(in_tag, out_tag, cryp->authsize))
 			ret = -EBADMSG;
@@ -1211,7 +1382,7 @@ static int stm32_cryp_read_auth_tag(struct stm32_cryp *cryp)
 
 	/* Disable cryp */
 	cfg &= ~CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	return ret;
 }
@@ -1227,19 +1398,19 @@ static void stm32_cryp_check_ctr_counter(struct stm32_cryp *cryp)
 		 */
 		crypto_inc((u8 *)cryp->last_ctr, sizeof(cryp->last_ctr));
 
-		cr = stm32_cryp_read(cryp, CRYP_CR);
-		stm32_cryp_write(cryp, CRYP_CR, cr & ~CR_CRYPEN);
+		cr = stm32_cryp_read(cryp, cryp->caps->cr);
+		stm32_cryp_write(cryp, cryp->caps->cr, cr & ~CR_CRYPEN);
 
 		stm32_cryp_hw_write_iv(cryp, cryp->last_ctr);
 
-		stm32_cryp_write(cryp, CRYP_CR, cr);
+		stm32_cryp_write(cryp, cryp->caps->cr, cr);
 	}
 
 	/* The IV registers are BE  */
-	cryp->last_ctr[0] = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV0LR));
-	cryp->last_ctr[1] = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV0RR));
-	cryp->last_ctr[2] = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV1LR));
-	cryp->last_ctr[3] = cpu_to_be32(stm32_cryp_read(cryp, CRYP_IV1RR));
+	cryp->last_ctr[0] = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv0l));
+	cryp->last_ctr[1] = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv0r));
+	cryp->last_ctr[2] = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv1l));
+	cryp->last_ctr[3] = cpu_to_be32(stm32_cryp_read(cryp, cryp->caps->iv1r));
 }
 
 static void stm32_cryp_irq_read_data(struct stm32_cryp *cryp)
@@ -1248,7 +1419,7 @@ static void stm32_cryp_irq_read_data(struct stm32_cryp *cryp)
 	u32 block[AES_BLOCK_32];
 
 	for (i = 0; i < cryp->hw_blocksize / sizeof(u32); i++)
-		block[i] = stm32_cryp_read(cryp, CRYP_DOUT);
+		block[i] = stm32_cryp_read(cryp, cryp->caps->dout);
 
 	scatterwalk_copychunks(block, &cryp->out_walk, min_t(size_t, cryp->hw_blocksize,
 							     cryp->payload_out), 1);
@@ -1264,7 +1435,7 @@ static void stm32_cryp_irq_write_block(struct stm32_cryp *cryp)
 	scatterwalk_copychunks(block, &cryp->in_walk, min_t(size_t, cryp->hw_blocksize,
 							    cryp->payload_in), 0);
 	for (i = 0; i < cryp->hw_blocksize / sizeof(u32); i++)
-		stm32_cryp_write(cryp, CRYP_DIN, block[i]);
+		stm32_cryp_write(cryp, cryp->caps->din, block[i]);
 
 	cryp->payload_in -= min_t(size_t, cryp->hw_blocksize, cryp->payload_in);
 }
@@ -1278,22 +1449,22 @@ static void stm32_cryp_irq_write_gcm_padded_data(struct stm32_cryp *cryp)
 	/* 'Special workaround' procedure described in the datasheet */
 
 	/* a) disable ip */
-	stm32_cryp_write(cryp, CRYP_IMSCR, 0);
-	cfg = stm32_cryp_read(cryp, CRYP_CR);
+	stm32_cryp_write(cryp, cryp->caps->imsc, 0);
+	cfg = stm32_cryp_read(cryp, cryp->caps->cr);
 	cfg &= ~CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* b) Update IV1R */
-	stm32_cryp_write(cryp, CRYP_IV1RR, cryp->gcm_ctr - 2);
+	stm32_cryp_write(cryp, cryp->caps->iv1r, cryp->gcm_ctr - 2);
 
 	/* c) change mode to CTR */
 	cfg &= ~CR_ALGO_MASK;
 	cfg |= CR_AES_CTR;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* a) enable IP */
 	cfg |= CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* b) pad and write the last block */
 	stm32_cryp_irq_write_block(cryp);
@@ -1310,7 +1481,7 @@ static void stm32_cryp_irq_write_gcm_padded_data(struct stm32_cryp *cryp)
 	 * block value
 	 */
 	for (i = 0; i < cryp->hw_blocksize / sizeof(u32); i++)
-		block[i] = stm32_cryp_read(cryp, CRYP_DOUT);
+		block[i] = stm32_cryp_read(cryp, cryp->caps->dout);
 
 	scatterwalk_copychunks(block, &cryp->out_walk, min_t(size_t, cryp->hw_blocksize,
 							     cryp->payload_out), 1);
@@ -1320,16 +1491,16 @@ static void stm32_cryp_irq_write_gcm_padded_data(struct stm32_cryp *cryp)
 	/* d) change mode back to AES GCM */
 	cfg &= ~CR_ALGO_MASK;
 	cfg |= CR_AES_GCM;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* e) change phase to Final */
 	cfg &= ~CR_PH_MASK;
 	cfg |= CR_PH_FINAL;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* f) write padded data */
 	for (i = 0; i < AES_BLOCK_32; i++)
-		stm32_cryp_write(cryp, CRYP_DIN, block[i]);
+		stm32_cryp_write(cryp, cryp->caps->din, block[i]);
 
 	/* g) Empty fifo out */
 	err = stm32_cryp_wait_output(cryp);
@@ -1339,7 +1510,7 @@ static void stm32_cryp_irq_write_gcm_padded_data(struct stm32_cryp *cryp)
 	}
 
 	for (i = 0; i < AES_BLOCK_32; i++)
-		stm32_cryp_read(cryp, CRYP_DOUT);
+		stm32_cryp_read(cryp, cryp->caps->dout);
 
 	/* h) run the he normal Final phase */
 	stm32_cryp_finish_req(cryp, 0);
@@ -1350,13 +1521,13 @@ static void stm32_cryp_irq_set_npblb(struct stm32_cryp *cryp)
 	u32 cfg;
 
 	/* disable ip, set NPBLB and reneable ip */
-	cfg = stm32_cryp_read(cryp, CRYP_CR);
+	cfg = stm32_cryp_read(cryp, cryp->caps->cr);
 	cfg &= ~CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	cfg |= (cryp->hw_blocksize - cryp->payload_in) << CR_NBPBL_SHIFT;
 	cfg |= CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 }
 
 static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
@@ -1370,11 +1541,11 @@ static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
 	/* 'Special workaround' procedure described in the datasheet */
 
 	/* a) disable ip */
-	stm32_cryp_write(cryp, CRYP_IMSCR, 0);
+	stm32_cryp_write(cryp, cryp->caps->imsc, 0);
 
-	cfg = stm32_cryp_read(cryp, CRYP_CR);
+	cfg = stm32_cryp_read(cryp, cryp->caps->cr);
 	cfg &= ~CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* b) get IV1 from CRYP_CSGCMCCM7 */
 	iv1tmp = stm32_cryp_read(cryp, CRYP_CSGCMCCM0R + 7 * 4);
@@ -1384,16 +1555,16 @@ static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
 		cstmp1[i] = stm32_cryp_read(cryp, CRYP_CSGCMCCM0R + i * 4);
 
 	/* d) Write IV1R */
-	stm32_cryp_write(cryp, CRYP_IV1RR, iv1tmp);
+	stm32_cryp_write(cryp, cryp->caps->iv1r, iv1tmp);
 
 	/* e) change mode to CTR */
 	cfg &= ~CR_ALGO_MASK;
 	cfg |= CR_AES_CTR;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* a) enable IP */
 	cfg |= CR_CRYPEN;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* b) pad and write the last block */
 	stm32_cryp_irq_write_block(cryp);
@@ -1410,7 +1581,7 @@ static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
 	 * block value
 	 */
 	for (i = 0; i < cryp->hw_blocksize / sizeof(u32); i++)
-		block[i] = stm32_cryp_read(cryp, CRYP_DOUT);
+		block[i] = stm32_cryp_read(cryp, cryp->caps->dout);
 
 	scatterwalk_copychunks(block, &cryp->out_walk, min_t(size_t, cryp->hw_blocksize,
 							     cryp->payload_out), 1);
@@ -1423,18 +1594,18 @@ static void stm32_cryp_irq_write_ccm_padded_data(struct stm32_cryp *cryp)
 	/* e) change mode back to AES CCM */
 	cfg &= ~CR_ALGO_MASK;
 	cfg |= CR_AES_CCM;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* f) change phase to header */
 	cfg &= ~CR_PH_MASK;
 	cfg |= CR_PH_HEADER;
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_write(cryp, cryp->caps->cr, cfg);
 
 	/* g) XOR and write padded data */
 	for (i = 0; i < ARRAY_SIZE(block); i++) {
 		block[i] ^= cstmp1[i];
 		block[i] ^= cstmp2[i];
-		stm32_cryp_write(cryp, CRYP_DIN, block[i]);
+		stm32_cryp_write(cryp, cryp->caps->din, block[i]);
 	}
 
 	/* h) wait for completion */
@@ -1497,7 +1668,7 @@ static void stm32_cryp_irq_write_gcmccm_header(struct stm32_cryp *cryp)
 
 	scatterwalk_copychunks(block, &cryp->in_walk, written, 0);
 	for (i = 0; i < AES_BLOCK_32; i++)
-		stm32_cryp_write(cryp, CRYP_DIN, block[i]);
+		stm32_cryp_write(cryp, cryp->caps->din, block[i]);
 
 	cryp->header_in -= written;
 
@@ -1508,7 +1679,7 @@ static irqreturn_t stm32_cryp_irq_thread(int irq, void *arg)
 {
 	struct stm32_cryp *cryp = arg;
 	u32 ph;
-	u32 it_mask = stm32_cryp_read(cryp, CRYP_IMSCR);
+	u32 it_mask = stm32_cryp_read(cryp, cryp->caps->imsc);
 
 	if (cryp->irq_status & MISR_OUT)
 		/* Output FIFO IRQ: read data */
@@ -1516,7 +1687,7 @@ static irqreturn_t stm32_cryp_irq_thread(int irq, void *arg)
 
 	if (cryp->irq_status & MISR_IN) {
 		if (is_gcm(cryp) || is_ccm(cryp)) {
-			ph = stm32_cryp_read(cryp, CRYP_CR) & CR_PH_MASK;
+			ph = stm32_cryp_read(cryp, cryp->caps->cr) & CR_PH_MASK;
 			if (unlikely(ph == CR_PH_HEADER))
 				/* Write Header */
 				stm32_cryp_irq_write_gcmccm_header(cryp);
@@ -1536,7 +1707,7 @@ static irqreturn_t stm32_cryp_irq_thread(int irq, void *arg)
 		it_mask &= ~IMSCR_IN;
 	if (!cryp->payload_out)
 		it_mask &= ~IMSCR_OUT;
-	stm32_cryp_write(cryp, CRYP_IMSCR, it_mask);
+	stm32_cryp_write(cryp, cryp->caps->imsc, it_mask);
 
 	if (!cryp->payload_in && !cryp->header_in && !cryp->payload_out)
 		stm32_cryp_finish_req(cryp, 0);
@@ -1548,7 +1719,7 @@ static irqreturn_t stm32_cryp_irq(int irq, void *arg)
 {
 	struct stm32_cryp *cryp = arg;
 
-	cryp->irq_status = stm32_cryp_read(cryp, CRYP_MISR);
+	cryp->irq_status = stm32_cryp_read(cryp, cryp->caps->mis);
 
 	return IRQ_WAKE_THREAD;
 }
@@ -1722,17 +1893,74 @@ static struct aead_alg aead_algs[] = {
 },
 };
 
+static const struct stm32_cryp_caps ux500_data = {
+	.aeads_support = false,
+	.linear_aes_key = true,
+	.kp_mode = false,
+	.iv_protection = true,
+	.swap_final = true,
+	.padding_wa = true,
+	.cr = UX500_CRYP_CR,
+	.sr = UX500_CRYP_SR,
+	.din = UX500_CRYP_DIN,
+	.dout = UX500_CRYP_DOUT,
+	.imsc = UX500_CRYP_IMSC,
+	.mis = UX500_CRYP_MIS,
+	.k1l = UX500_CRYP_K1L,
+	.k1r = UX500_CRYP_K1R,
+	.k3r = UX500_CRYP_K3R,
+	.iv0l = UX500_CRYP_IV0L,
+	.iv0r = UX500_CRYP_IV0R,
+	.iv1l = UX500_CRYP_IV1L,
+	.iv1r = UX500_CRYP_IV1R,
+};
+
 static const struct stm32_cryp_caps f7_data = {
+	.aeads_support = true,
+	.linear_aes_key = false,
+	.kp_mode = true,
+	.iv_protection = false,
 	.swap_final = true,
 	.padding_wa = true,
+	.cr = CRYP_CR,
+	.sr = CRYP_SR,
+	.din = CRYP_DIN,
+	.dout = CRYP_DOUT,
+	.imsc = CRYP_IMSCR,
+	.mis = CRYP_MISR,
+	.k1l = CRYP_K1LR,
+	.k1r = CRYP_K1RR,
+	.k3r = CRYP_K3RR,
+	.iv0l = CRYP_IV0LR,
+	.iv0r = CRYP_IV0RR,
+	.iv1l = CRYP_IV1LR,
+	.iv1r = CRYP_IV1RR,
 };
 
 static const struct stm32_cryp_caps mp1_data = {
+	.aeads_support = true,
+	.linear_aes_key = false,
+	.kp_mode = true,
+	.iv_protection = false,
 	.swap_final = false,
 	.padding_wa = false,
+	.cr = CRYP_CR,
+	.sr = CRYP_SR,
+	.din = CRYP_DIN,
+	.dout = CRYP_DOUT,
+	.imsc = CRYP_IMSCR,
+	.mis = CRYP_MISR,
+	.k1l = CRYP_K1LR,
+	.k1r = CRYP_K1RR,
+	.k3r = CRYP_K3RR,
+	.iv0l = CRYP_IV0LR,
+	.iv0r = CRYP_IV0RR,
+	.iv1l = CRYP_IV1LR,
+	.iv1r = CRYP_IV1RR,
 };
 
 static const struct of_device_id stm32_dt_ids[] = {
+	{ .compatible = "stericsson,ux500-cryp", .data = &ux500_data},
 	{ .compatible = "st,stm32f756-cryp", .data = &f7_data},
 	{ .compatible = "st,stm32mp1-cryp", .data = &mp1_data},
 	{},
@@ -1829,9 +2057,11 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 		goto err_algs;
 	}
 
-	ret = crypto_register_aeads(aead_algs, ARRAY_SIZE(aead_algs));
-	if (ret)
-		goto err_aead_algs;
+	if (cryp->caps->aeads_support) {
+		ret = crypto_register_aeads(aead_algs, ARRAY_SIZE(aead_algs));
+		if (ret)
+			goto err_aead_algs;
+	}
 
 	dev_info(dev, "Initialized\n");
 
@@ -1869,7 +2099,8 @@ static int stm32_cryp_remove(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	crypto_unregister_aeads(aead_algs, ARRAY_SIZE(aead_algs));
+	if (cryp->caps->aeads_support)
+		crypto_unregister_aeads(aead_algs, ARRAY_SIZE(aead_algs));
 	crypto_unregister_skciphers(crypto_algs, ARRAY_SIZE(crypto_algs));
 
 	crypto_engine_exit(cryp->engine);
-- 
2.38.1


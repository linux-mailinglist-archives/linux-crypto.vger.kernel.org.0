Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5921F287C
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Jun 2020 01:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgFHXxa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 8 Jun 2020 19:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgFHXY0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ED920842;
        Mon,  8 Jun 2020 23:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658666;
        bh=ZTU3zThxyPlECEFoIX7cZNwQcTmXBmQX+MGobFN3YjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nB+Q/mFTAL2xjSt/5L/FycPrNM8nC05QXpVJezZrn1aTd+7XEVEfhoXOGStI1802w
         gNgyUcrZevRtSlFdoD1L7DsoWGloF8TafXI6E0g1q4muIAvsb6fBYijc8v1t4EYMk2
         LDkQI1FjXZxal1YN8BefWCYKt2DstP9Jm5k26Ons=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Toromanoff <nicolas.toromanoff@st.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 081/106] crypto: stm32/crc32 - fix ext4 chksum BUG_ON()
Date:   Mon,  8 Jun 2020 19:22:13 -0400
Message-Id: <20200608232238.3368589-81-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Nicolas Toromanoff <nicolas.toromanoff@st.com>

[ Upstream commit 49c2c082e00e0bc4f5cbb7c21c7f0f873b35ab09 ]

Allow use of crc_update without prior call to crc_init.
And change (and fix) driver to use CRC device even on unaligned buffers.

Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")

Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/stm32/stm32_crc32.c | 98 +++++++++++++++---------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index 29d2095d9dfd..749b51762b18 100644
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -28,8 +28,10 @@
 
 /* Registers values */
 #define CRC_CR_RESET            BIT(0)
-#define CRC_CR_REVERSE          (BIT(7) | BIT(6) | BIT(5))
 #define CRC_INIT_DEFAULT        0xFFFFFFFF
+#define CRC_CR_REV_IN_WORD      (BIT(6) | BIT(5))
+#define CRC_CR_REV_IN_BYTE      BIT(5)
+#define CRC_CR_REV_OUT          BIT(7)
 
 #define CRC_AUTOSUSPEND_DELAY	50
 
@@ -38,8 +40,6 @@ struct stm32_crc {
 	struct device    *dev;
 	void __iomem     *regs;
 	struct clk       *clk;
-	u8               pending_data[sizeof(u32)];
-	size_t           nb_pending_bytes;
 };
 
 struct stm32_crc_list {
@@ -59,7 +59,6 @@ struct stm32_crc_ctx {
 
 struct stm32_crc_desc_ctx {
 	u32    partial; /* crc32c: partial in first 4 bytes of that struct */
-	struct stm32_crc *crc;
 };
 
 static int stm32_crc32_cra_init(struct crypto_tfm *tfm)
@@ -101,25 +100,22 @@ static int stm32_crc_init(struct shash_desc *desc)
 	struct stm32_crc *crc;
 
 	spin_lock_bh(&crc_list.lock);
-	list_for_each_entry(crc, &crc_list.dev_list, list) {
-		ctx->crc = crc;
-		break;
-	}
+	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
 	spin_unlock_bh(&crc_list.lock);
 
-	pm_runtime_get_sync(ctx->crc->dev);
+	pm_runtime_get_sync(crc->dev);
 
 	/* Reset, set key, poly and configure in bit reverse mode */
-	writel_relaxed(bitrev32(mctx->key), ctx->crc->regs + CRC_INIT);
-	writel_relaxed(bitrev32(mctx->poly), ctx->crc->regs + CRC_POL);
-	writel_relaxed(CRC_CR_RESET | CRC_CR_REVERSE, ctx->crc->regs + CRC_CR);
+	writel_relaxed(bitrev32(mctx->key), crc->regs + CRC_INIT);
+	writel_relaxed(bitrev32(mctx->poly), crc->regs + CRC_POL);
+	writel_relaxed(CRC_CR_RESET | CRC_CR_REV_IN_WORD | CRC_CR_REV_OUT,
+		       crc->regs + CRC_CR);
 
 	/* Store partial result */
-	ctx->partial = readl_relaxed(ctx->crc->regs + CRC_DR);
-	ctx->crc->nb_pending_bytes = 0;
+	ctx->partial = readl_relaxed(crc->regs + CRC_DR);
 
-	pm_runtime_mark_last_busy(ctx->crc->dev);
-	pm_runtime_put_autosuspend(ctx->crc->dev);
+	pm_runtime_mark_last_busy(crc->dev);
+	pm_runtime_put_autosuspend(crc->dev);
 
 	return 0;
 }
@@ -128,31 +124,49 @@ static int stm32_crc_update(struct shash_desc *desc, const u8 *d8,
 			    unsigned int length)
 {
 	struct stm32_crc_desc_ctx *ctx = shash_desc_ctx(desc);
-	struct stm32_crc *crc = ctx->crc;
-	u32 *d32;
-	unsigned int i;
+	struct stm32_crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
+	struct stm32_crc *crc;
+
+	spin_lock_bh(&crc_list.lock);
+	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
+	spin_unlock_bh(&crc_list.lock);
 
 	pm_runtime_get_sync(crc->dev);
 
-	if (unlikely(crc->nb_pending_bytes)) {
-		while (crc->nb_pending_bytes != sizeof(u32) && length) {
-			/* Fill in pending data */
-			crc->pending_data[crc->nb_pending_bytes++] = *(d8++);
+	/*
+	 * Restore previously calculated CRC for this context as init value
+	 * Restore polynomial configuration
+	 * Configure in register for word input data,
+	 * Configure out register in reversed bit mode data.
+	 */
+	writel_relaxed(bitrev32(ctx->partial), crc->regs + CRC_INIT);
+	writel_relaxed(bitrev32(mctx->poly), crc->regs + CRC_POL);
+	writel_relaxed(CRC_CR_RESET | CRC_CR_REV_IN_WORD | CRC_CR_REV_OUT,
+		       crc->regs + CRC_CR);
+
+	if (d8 != PTR_ALIGN(d8, sizeof(u32))) {
+		/* Configure for byte data */
+		writel_relaxed(CRC_CR_REV_IN_BYTE | CRC_CR_REV_OUT,
+			       crc->regs + CRC_CR);
+		while (d8 != PTR_ALIGN(d8, sizeof(u32)) && length) {
+			writeb_relaxed(*d8++, crc->regs + CRC_DR);
 			length--;
 		}
-
-		if (crc->nb_pending_bytes == sizeof(u32)) {
-			/* Process completed pending data */
-			writel_relaxed(*(u32 *)crc->pending_data,
-				       crc->regs + CRC_DR);
-			crc->nb_pending_bytes = 0;
-		}
+		/* Configure for word data */
+		writel_relaxed(CRC_CR_REV_IN_WORD | CRC_CR_REV_OUT,
+			       crc->regs + CRC_CR);
 	}
 
-	d32 = (u32 *)d8;
-	for (i = 0; i < length >> 2; i++)
-		/* Process 32 bits data */
-		writel_relaxed(*(d32++), crc->regs + CRC_DR);
+	for (; length >= sizeof(u32); d8 += sizeof(u32), length -= sizeof(u32))
+		writel_relaxed(*((u32 *)d8), crc->regs + CRC_DR);
+
+	if (length) {
+		/* Configure for byte data */
+		writel_relaxed(CRC_CR_REV_IN_BYTE | CRC_CR_REV_OUT,
+			       crc->regs + CRC_CR);
+		while (length--)
+			writeb_relaxed(*d8++, crc->regs + CRC_DR);
+	}
 
 	/* Store partial result */
 	ctx->partial = readl_relaxed(crc->regs + CRC_DR);
@@ -160,22 +174,6 @@ static int stm32_crc_update(struct shash_desc *desc, const u8 *d8,
 	pm_runtime_mark_last_busy(crc->dev);
 	pm_runtime_put_autosuspend(crc->dev);
 
-	/* Check for pending data (non 32 bits) */
-	length &= 3;
-	if (likely(!length))
-		return 0;
-
-	if ((crc->nb_pending_bytes + length) >= sizeof(u32)) {
-		/* Shall not happen */
-		dev_err(crc->dev, "Pending data overflow\n");
-		return -EINVAL;
-	}
-
-	d8 = (const u8 *)d32;
-	for (i = 0; i < length; i++)
-		/* Store pending data */
-		crc->pending_data[crc->nb_pending_bytes++] = *(d8++);
-
 	return 0;
 }
 
-- 
2.25.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA87A619
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfG3Kdw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jul 2019 06:33:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39976 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbfG3Kdu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jul 2019 06:33:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCBA420065F;
        Tue, 30 Jul 2019 12:33:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDB3F200652;
        Tue, 30 Jul 2019 12:33:48 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 687EA204D6;
        Tue, 30 Jul 2019 12:33:48 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 2/2] crypto: aes - helper function to validate key length for AES algorithms
Date:   Tue, 30 Jul 2019 13:33:44 +0300
Message-Id: <1564482824-26581-3-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564482824-26581-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564482824-26581-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add inline helper function to check key length for AES algorithms.
The key can be 128, 192 or 256 bits size.
This function is used in the generic aes implementation.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 include/crypto/aes.h | 17 +++++++++++++++++
 lib/crypto/aes.c     |  8 ++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 8e0f4cf..8ee07a8 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -31,6 +31,23 @@ struct crypto_aes_ctx {
 extern const u32 crypto_ft_tab[4][256] ____cacheline_aligned;
 extern const u32 crypto_it_tab[4][256] ____cacheline_aligned;
 
+/*
+ * validate key length for AES algorithms
+ */
+static inline int crypto_aes_check_keylen(unsigned int keylen)
+{
+	switch (keylen) {
+	case AES_KEYSIZE_128:
+	case AES_KEYSIZE_192:
+	case AES_KEYSIZE_256:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int crypto_aes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 		unsigned int key_len);
 
diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
index 4e100af..3407b01 100644
--- a/lib/crypto/aes.c
+++ b/lib/crypto/aes.c
@@ -187,11 +187,11 @@ int aes_expandkey(struct crypto_aes_ctx *ctx, const u8 *in_key,
 {
 	u32 kwords = key_len / sizeof(u32);
 	u32 rc, i, j;
+	int err;
 
-	if (key_len != AES_KEYSIZE_128 &&
-	    key_len != AES_KEYSIZE_192 &&
-	    key_len != AES_KEYSIZE_256)
-		return -EINVAL;
+	err = crypto_aes_check_keylen(key_len);
+	if (err)
+		return err;
 
 	ctx->key_length = key_len;
 
-- 
2.1.0


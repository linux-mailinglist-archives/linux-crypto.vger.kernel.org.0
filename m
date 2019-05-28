Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823062C8DE
	for <lists+linux-crypto@lfdr.de>; Tue, 28 May 2019 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfE1OfU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 May 2019 10:35:20 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34523 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfE1OfU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 May 2019 10:35:20 -0400
Received: by mail-qk1-f202.google.com with SMTP id h11so28059453qkk.1
        for <linux-crypto@vger.kernel.org>; Tue, 28 May 2019 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u6Hmqn+VoyKdzrtqe2ho0SlGWPLtiXGeTWqFLUr85co=;
        b=NL9yD5jUYvPP4qO7lNiSZk/ZyRLfJT27GCzl2DrrIySI1M4qxs8VLhV9Ij/1iHZbeL
         DYgibIRy9GaEfaRewIgFK2nDCGKCtzIAGfW4B8M+/jDP/Tc2E/RAQ7S7zLUzkBZllV79
         pJpAl+Z356uejo4Q8EnxoiHmVSEXpclqN83l22WLXyJyRBg7BFVqYkE1R31nhm5TE7+A
         516KZ+V951PWR3Imh1zxvsmJH+LtKKdvukLVx18bhH5qKhhyU5tlSC7evYFodJwTzjAu
         2oXNs8+rgMXzrUgoce5qtzwgKMsmZX3tnKMzQ62n9vgOWavkcD8+Xmp0ZfG1IdJngvEG
         y4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u6Hmqn+VoyKdzrtqe2ho0SlGWPLtiXGeTWqFLUr85co=;
        b=djqt1E7EmNwGztjAlFqDc+sNcoL35zBVqKMV7jTUtq5D+i2aAfDQbG2VV76pQ4Iq/E
         3eo52yVl4xd5X43vlfNm4rglw9Jff3c4aGq4+5iU9IRIOGurlHT59do292QUXEDPLInj
         5lz9aKmgH4K93kGlRWgtwIZda5uXF4Yl4PhR/ShTfRuh96QFYZPgEw9IHA991uaR/3lG
         VSoAvSxPpUrl9CP0sGLlVXkEFWnF8y5mdD3GWOI0xth3UqpA2o7TZo98puQzYH7rDbe6
         raP0RwQvJKrMUsQJg89bzTDb7aCfuI3mbUZctUdXeNFdQAgGuI5m/V7X44PniXJuXvVr
         aCaA==
X-Gm-Message-State: APjAAAUpRJzb79djhRfdjuhLKUNga+MC9TL0ZyxfEvhzUXX3BZ3bsRC3
        g8MK37w+KYLtLVuotpUWd4Vndu45mNMqh23UpYkWJV9Ih3h4+fF1unAuWtEzYTLj7w7InuZipbB
        Rk6mR8P4VR1IWWdP+KLUsYI7xkkc3X4N6MsOHp8z/Tljh5bKunQiUdHYOfsPl+OM5w7/Pjd0Z
X-Google-Smtp-Source: APXvYqwMBBtjjJq05ANZM9pV7i8dJ/KKpmWn4lIpusn+/tr/Hp2FtsNKbxPRvuPOWbwz2LSSEip6w8TJNCUs
X-Received: by 2002:a0c:b626:: with SMTP id f38mr39955266qve.223.1559054119482;
 Tue, 28 May 2019 07:35:19 -0700 (PDT)
Date:   Tue, 28 May 2019 15:35:06 +0100
Message-Id: <20190528143506.212198-1-lenaptr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] arm64 sha2-ce finup: correct digest for empty data
From:   Elena Petrova <lenaptr@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     Elena Petrova <lenaptr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The sha256-ce finup implementation for ARM64 produces wrong digest
for empty input (len=0). Expected: the actual digest, result: initial
value of SHA internal state. The error is in sha256_ce_finup:
for empty data `finalize` will be 1, so the code is relying on
sha2_ce_transform to make the final round. However, in
sha256_base_do_update, the block function will not be called when
len == 0.

Fix it by setting finalize to 0 if data is empty.

Fixes: 03802f6a80b3a ("crypto: arm64/sha2-ce - move SHA-224/256 ARMv8 implementation to base layer")
Cc: stable@vger.kernel.org
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/crypto/sha2-ce-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
index a725997e55f2..6a5ade974a35 100644
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -60,7 +60,7 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
 			   unsigned int len, u8 *out)
 {
 	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
-	bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE);
+	bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE) && len;
 
 	if (!crypto_simd_usable()) {
 		if (len)
-- 
2.22.0.rc1.257.g3120a18244-goog


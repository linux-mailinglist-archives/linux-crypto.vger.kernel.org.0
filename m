Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5BA3319
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Aug 2019 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfH3IpM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Aug 2019 04:45:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36923 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfH3IpM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Aug 2019 04:45:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id f22so7143280edt.4
        for <linux-crypto@vger.kernel.org>; Fri, 30 Aug 2019 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3rugOcHN8vf9Yb86Fith4KoYHA5CzJpICVeqVFSm31k=;
        b=dihkYpgMUzw7xg27IyVvbXMQovY0oSh9X67bnxbDKUbiMaGZ5JkfyU9JJHgchNzrPX
         UB96ThgzYp8VnChXJ2F5Zx0ibkJrkDfjILOQsqv+BiyGIZOhRJX9NUVxaxOuYpmNtlT1
         +bmIrAs358T366a0eZiX+tuWxsqK9DASH8IXjGNn8obn4nxureF6hBDSwPCy0YmRxOtg
         3IEiO1HsvJh23XoTi1kAcsNG3nQpCCY/E89xXvtajld1Rh0dx+hnIZHeBoUTZ8k21Ab0
         MqYxYZR+ahNqE0VgGh5GSbpqo+3XQWjm/0xsYpTEiQsjgMR2MOJofUU+odsIGls49Xo9
         keNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3rugOcHN8vf9Yb86Fith4KoYHA5CzJpICVeqVFSm31k=;
        b=ltB2LmjTmOc229jtge6vHpIA3CJ6+9mymgiH/kx5II53bx8LMCug5J8xropa1UHRGx
         rjQ0ZlAweW/Xlilskc6ok9u1E16R2s+3xpGhPIteN8jzBvkxoG1PsIh5kJuTQMIFGr+i
         P2qjVhIT2WPxJFDoYQUITVTO3RJBMp58eaDF/948jujApKdvHy8QZz12tp/CNj2b0f0L
         uPr8Dod9LAUFpgGnTT/KaiJegW8M82ei1oeAjJB5XDvtHh/xRS7zWTgdnF1notXeOyDm
         7mOYQny7sTDExM1BuwUgUFYguh579GvrGy4DkqGJm6pW5hO1MhVvkK92BnCKAEerYiX1
         vTKA==
X-Gm-Message-State: APjAAAULSvOaZby4IHmdvVPV9tvvsySG26KWSzmtDBaGKoy6DUURtMXP
        fU6v+NB+Zoa+8YhE2e7yf9BEck/g
X-Google-Smtp-Source: APXvYqzjV0BLrgZl5DSEI6xRdQjC5hiQ/fC3QmD2HhJLe+6yYJZctyj7Wp60gkxlnREAtue+eKnq4Q==
X-Received: by 2002:aa7:c712:: with SMTP id i18mr14014660edq.213.1567154710381;
        Fri, 30 Aug 2019 01:45:10 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id d30sm701757ejo.50.2019.08.30.01.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 01:45:09 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH] crypto: inside-secure - Minor optimization recognizing CTR is always AES
Date:   Fri, 30 Aug 2019 09:42:29 +0200
Message-Id: <1567150949-10799-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Moved counter mode handling code in front as it doesn't depend on the
rest of the code to be executed, it can just do its thing and exit.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 7656678..917a4b7 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -65,6 +65,19 @@ static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx, u8 *iv,
 {
 	u32 block_sz = 0;
 
+	if (ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_CTR_LOAD) {
+		cdesc->control_data.options |= EIP197_OPTION_4_TOKEN_IV_CMD;
+
+		/* 32 bit nonce */
+		cdesc->control_data.token[0] = ctx->nonce;
+		/* 64 bit IV part */
+		memcpy(&cdesc->control_data.token[1], iv, 8);
+		/* 32 bit counter, start at 1 (big endian!) */
+		cdesc->control_data.token[3] = cpu_to_be32(1);
+
+		return;
+	}
+
 	if (ctx->mode != CONTEXT_CONTROL_CRYPTO_MODE_ECB) {
 		switch (ctx->alg) {
 		case SAFEXCEL_DES:
@@ -80,17 +93,7 @@ static void safexcel_cipher_token(struct safexcel_cipher_ctx *ctx, u8 *iv,
 			cdesc->control_data.options |= EIP197_OPTION_4_TOKEN_IV_CMD;
 			break;
 		}
-
-		if (ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_CTR_LOAD) {
-			/* 32 bit nonce */
-			cdesc->control_data.token[0] = ctx->nonce;
-			/* 64 bit IV part */
-			memcpy(&cdesc->control_data.token[1], iv, 8);
-			/* 32 bit counter, start at 1 (big endian!) */
-			cdesc->control_data.token[3] = cpu_to_be32(1);
-		} else {
-			memcpy(cdesc->control_data.token, iv, block_sz);
-		}
+		memcpy(cdesc->control_data.token, iv, block_sz);
 	}
 }
 
-- 
1.8.3.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085A821F74
	for <lists+linux-crypto@lfdr.de>; Fri, 17 May 2019 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEQVQC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 May 2019 17:16:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53846 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEQVQB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 May 2019 17:16:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so8124674wme.3
        for <linux-crypto@vger.kernel.org>; Fri, 17 May 2019 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmI1crTCuQke733ZI5hEHjLhSTAYDc+7zfcaIv/jgP4=;
        b=B4u2+YL0YWO1taeH4tpE2TMORwAJdVm593tcxXlowNyPHFG9kPXgr+7ZSv3qA+z4XO
         FTgL0PFh+bofxgZmnZDrNtoKzJCovhL6YjQ8ZECqXyafqvyKtQV/uIJjphZmdSaLxeW3
         afdaMA7CB3F2POPFqidGqbAd5SO5C0Uic+taI5ZfKUw1iPIIyJ00R0e7ECByNRgD3edJ
         LTcUSfi99V59ryE48eRoCma5tEwH36yhw55tMZVWfYaEIh9O1nlkBTa9cjSIuawwP6Sa
         ijHxLZ2makMgpd2YK7AjwaIAog+zuu4KFp14Nlolnk4B5QWOWYjxVPS7NU/DPPLuipe+
         mnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fmI1crTCuQke733ZI5hEHjLhSTAYDc+7zfcaIv/jgP4=;
        b=iHElv0ywvwRvSS9eP6qNo9eqcCVtdbM/ygqABPVoX+m8kzxzPTRYkIgA8Dy2St3Cy0
         6ODDqLHzQlchxoYkbcUs8UfMEW31mst8KeGnuWwd+e89C32ZMkznCGpsFnkVK9ZF8RdN
         XxEC6VnBRy6HwJ7MK8XGW8nu76KEx6z4OIj2QA1gH3sQeXpZTtNHsVb4s5gqCy1759As
         wUhrBtcFrytTUPwjlYp8vR6lviZYkd+zUKXS7glTQ2FQbH8L+JguGpkjAkZcY4Utubve
         WH6ryYl8hZw/C+5WMPqDLCR5ltXRBgYy9sKmkzTDUHbuWkpS+nsZRIXXYT08gL8JrorA
         INqg==
X-Gm-Message-State: APjAAAWbV8riPGweHwSFItcV4HOCnjVUZhUFn0PIG0mTTinLCpsN70ld
        8UDlbHDRki49t+3LEOrcl6NfZd0T
X-Google-Smtp-Source: APXvYqwUKisBdMWFnDFWk3kgAPAb0iOu29c4UkBSWk6BkqfTSvwsHHL9wDflcdixriOo/zE56axNpQ==
X-Received: by 2002:a05:600c:254e:: with SMTP id e14mr22042577wma.70.1558127759301;
        Fri, 17 May 2019 14:15:59 -0700 (PDT)
Received: from debian64.daheim (p4FD09697.dip0.t-ipconnect.de. [79.208.150.151])
        by smtp.gmail.com with ESMTPSA id n2sm14292933wra.89.2019.05.17.14.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 14:15:58 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hRkCr-0006j7-PQ; Fri, 17 May 2019 23:15:57 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: crypto4xx - fix AES CTR blocksize value
Date:   Fri, 17 May 2019 23:15:57 +0200
Message-Id: <20190517211557.25815-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a issue with crypto4xx's ctr(aes) that was
discovered by libcapi's kcapi-enc-test.sh test.

The some of the ctr(aes) encryptions test were failing on the
non-power-of-two test:

kcapi-enc - Error: encryption failed with error 0
kcapi-enc - Error: decryption failed with error 0
[FAILED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (128 bits):
original file (1d100e..cc96184c) and generated file (e3b0c442..1b7852b855)
[FAILED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (128 bits)
(openssl generated CT): original file (e3b0..5) and generated file (3..8e)
[PASSED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (128 bits)
(openssl generated PT)
[FAILED: 32-bit - 5.1.0-rc1+] 15 bytes: STDIN / STDOUT enc test (password):
original file (1d1..84c) and generated file (e3b..852b855)

But the 16, 32, 512, 65536 tests always worked.

Thankfully, this isn't a hidden hardware problem like previously,
instead this turned out to be a copy and paste issue.

With this patch, all the tests are passing with and
kcapi-enc-test.sh gives crypto4xx's a clean bill of health:
 "Number of failures: 0" :).

Cc: stable@vger.kernel.org
Fixes: 98e87e3d933b ("crypto: crypto4xx - add aes-ctr support")
Fixes: f2a13e7cba9e ("crypto: crypto4xx - enable AES RFC3686, ECB, CFB and OFB offloads")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/crypto/amcc/crypto4xx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 3934c2523762..0322ae8ac466 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1252,7 +1252,7 @@ static struct crypto4xx_alg_common crypto4xx_alg[] = {
 			.cra_flags = CRYPTO_ALG_NEED_FALLBACK |
 				CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_KERN_DRIVER_ONLY,
-			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct crypto4xx_ctx),
 			.cra_module = THIS_MODULE,
 		},
@@ -1272,7 +1272,7 @@ static struct crypto4xx_alg_common crypto4xx_alg[] = {
 			.cra_priority = CRYPTO4XX_CRYPTO_PRIORITY,
 			.cra_flags = CRYPTO_ALG_ASYNC |
 				CRYPTO_ALG_KERN_DRIVER_ONLY,
-			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_blocksize = 1,
 			.cra_ctxsize = sizeof(struct crypto4xx_ctx),
 			.cra_module = THIS_MODULE,
 		},
-- 
2.20.1


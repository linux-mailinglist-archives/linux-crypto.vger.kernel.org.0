Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38210C8F4
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Nov 2019 13:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfK1MzY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 Nov 2019 07:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfK1MzY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 Nov 2019 07:55:24 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1714B2176D;
        Thu, 28 Nov 2019 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574945723;
        bh=8bxLnSoz8rBfOPLDuSDuh1pX0IuRo0h0J6S+OsbXTls=;
        h=From:To:Cc:Subject:Date:From;
        b=WHN6gSqz6zJuaqYeR2otaVjeZ3BNzzSBiiwxt6NmKAYBa7n3WXbhMqNVHoKGWysyz
         wPwPa6XNmm2651cTEuMK3HfsDTcmfeiKdOcp7GnB+nxIKUdFaREArS1nA4Xim3vVP1
         H0M5Wt/dcpEWtIBHwW7QtXcfjcM0lT1aNbmhJ29g=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: arm64/ghash-neon - bump priority to 150
Date:   Thu, 28 Nov 2019 13:55:31 +0100
Message-Id: <20191128125531.5165-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The SIMD based GHASH implementation for arm64 is typically much faster
than the generic one, and doesn't use any lookup tables, so it is
clearly preferred when available. So bump the priority to reflect that.

Fixes: 5a22b198cd527447 ("crypto: arm64/ghash - register PMULL variants ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/ghash-ce-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/ghash-ce-glue.c b/arch/arm64/crypto/ghash-ce-glue.c
index 522cf004ce65..196aedd0c20c 100644
--- a/arch/arm64/crypto/ghash-ce-glue.c
+++ b/arch/arm64/crypto/ghash-ce-glue.c
@@ -259,7 +259,7 @@ static int ghash_setkey(struct crypto_shash *tfm,
 static struct shash_alg ghash_alg[] = {{
 	.base.cra_name		= "ghash",
 	.base.cra_driver_name	= "ghash-neon",
-	.base.cra_priority	= 100,
+	.base.cra_priority	= 150,
 	.base.cra_blocksize	= GHASH_BLOCK_SIZE,
 	.base.cra_ctxsize	= sizeof(struct ghash_key),
 	.base.cra_module	= THIS_MODULE,
-- 
2.17.1


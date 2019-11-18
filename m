Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94AFFF75
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Nov 2019 08:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfKRHWN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Nov 2019 02:22:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfKRHWM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Nov 2019 02:22:12 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B58420722;
        Mon, 18 Nov 2019 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574061732;
        bh=IbEqxaiyzZJOVLb4UmWwycgAJjMGUjhfaoZembpMM8o=;
        h=From:To:Cc:Subject:Date:From;
        b=2kNVxWmE6FXWcHRvSIMXR/7SlUfchlPuACRvFYw3oflu98cTHu/RWbYK2To0rtYXw
         obgcQ9FUTi9fmeaUIrEC/f3f3sfCNf/g1324SNmwNdgT+yNajAxDRXGkm6P+UnbFVG
         xxJ8s8QXbpsZl33qlCNnK2rLXpzUR8427BA1seEc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: x86/chacha - only unregister algorithms if registered
Date:   Sun, 17 Nov 2019 23:21:58 -0800
Message-Id: <20191118072158.467616-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It's not valid to call crypto_unregister_skciphers() without a prior
call to crypto_register_skciphers().

Fixes: 84e03fa39fbe ("crypto: x86/chacha - expose SIMD ChaCha routine as library function")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/chacha_glue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index b391e13a9e41..a94e30b6f941 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -304,7 +304,8 @@ static int __init chacha_simd_mod_init(void)
 
 static void __exit chacha_simd_mod_fini(void)
 {
-	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
+	if (boot_cpu_has(X86_FEATURE_SSSE3))
+		crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
 }
 
 module_init(chacha_simd_mod_init);
-- 
2.24.0


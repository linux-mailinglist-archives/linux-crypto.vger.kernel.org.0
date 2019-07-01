Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3596323DD1
	for <lists+linux-crypto@lfdr.de>; Mon, 20 May 2019 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbfETQtX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 May 2019 12:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390047AbfETQtX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 May 2019 12:49:23 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8720F214DA;
        Mon, 20 May 2019 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558370962;
        bh=sbBvPwQrTC5x5PztZUie3inpeJhVaH4xSOzv5uVo8Lc=;
        h=From:To:Subject:Date:From;
        b=X/h/1uWBwPQrMYIo5CG/yBlZpBt70HBry+3FpFCR7WwfXjsVmHxEKPRXHPqzNrJVA
         px1/wybarVyGDTdwZgsNKB+8L3Aj2URTKA4V1wkxG11+QlsXt8Q23KpjqlxwaSxndR
         IlUlachohS6p3VeRXJOD1fhn1dk/qa7u3L11uGF0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: testmgr - make extra tests depend on cryptomgr
Date:   Mon, 20 May 2019 09:48:29 -0700
Message-Id: <20190520164829.167433-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The crypto self-tests are part of the "cryptomgr" module, which can
technically be disabled (though it rarely is).  If you do so, currently
you can still enable CRYPTO_MANAGER_EXTRA_TESTS, which doesn't make
sense since in that case testmgr.c isn't compiled at all.  Fix it by
making it CRYPTO_MANAGER_EXTRA_TESTS depend on CRYPTO_MANAGER2, like
CRYPTO_MANAGER_DISABLE_TESTS already does.

Fixes: 5b2706a4d459 ("crypto: testmgr - introduce CONFIG_CRYPTO_MANAGER_EXTRA_TESTS")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3d056e7da65f6..7009aff745cb7 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -137,10 +137,11 @@ config CRYPTO_USER
 	  Userspace configuration for cryptographic instantiations such as
 	  cbc(aes).
 
+if CRYPTO_MANAGER2
+
 config CRYPTO_MANAGER_DISABLE_TESTS
 	bool "Disable run-time self tests"
 	default y
-	depends on CRYPTO_MANAGER2
 	help
 	  Disable run-time self tests that normally take place at
 	  algorithm registration.
@@ -155,6 +156,8 @@ config CRYPTO_MANAGER_EXTRA_TESTS
 	  This is intended for developer use only, as these tests take much
 	  longer to run than the normal self tests.
 
+endif	# if CRYPTO_MANAGER2
+
 config CRYPTO_GF128MUL
 	tristate "GF(2^128) multiplication functions"
 	help
-- 
2.21.0.1020.gf2820cf01a-goog


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611165367FA
	for <lists+linux-crypto@lfdr.de>; Fri, 27 May 2022 22:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350871AbiE0UTt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 May 2022 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiE0UTt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 May 2022 16:19:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3182131938
        for <linux-crypto@vger.kernel.org>; Fri, 27 May 2022 13:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB07EB82402
        for <linux-crypto@vger.kernel.org>; Fri, 27 May 2022 20:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD936C385B8;
        Fri, 27 May 2022 20:19:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RSlwJwzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653682782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxnmVUnFJbwhjkp5oOLKRrdc02B8mWHaayarGv+2kt8=;
        b=RSlwJwzY93BYe6jh3koNqZ8NY2AvKIH65tBwHsIYoD7Zvk85Z5YQ/IGVOclar6UG1HnSer
        MLOwk/q0CL439IzdqKMZM6faqvAq2r50KjvqVp1yaak8xOxScXWekDs1I7WE+ID9TIQRwC
        pq6h37UiTfzLJVHY61UO588HcF1+Gp4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81e4257d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 27 May 2022 20:19:41 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH crypto v2] crypto: poly1305 - cleanup stray CRYPTO_LIB_POLY1305_RSIZE
Date:   Fri, 27 May 2022 22:19:31 +0200
Message-Id: <20220527201931.63955-1-Jason@zx2c4.com>
In-Reply-To: <202205271557.oReeyAVT-lkp@intel.com>
References: <202205271557.oReeyAVT-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When CRYPTO_LIB_POLY1305 is unset, CRYPTO_LIB_POLY1305_RSIZE is still
set in the Kconfig, cluttering things. Fix this by making
CRYPTO_LIB_POLY1305_RSIZE depend on CRYPTO_LIB_POLY1305 and other
various related config options.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Also depend on CRYPTO_ARCH_HAVE_LIB_POLY1305 and
  CRYPTO_LIB_POLY1305_GENERIC, after kbuild bot warning. Hopefully this
  handles all the weird edge cases in this unfortunate maze.

 lib/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 379a66d7f504..7ee13c08c970 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -85,6 +85,7 @@ config CRYPTO_LIB_POLY1305_RSIZE
 	default 11 if X86_64
 	default 9 if ARM || ARM64
 	default 1
+	depends on CRYPTO_LIB_POLY1305 || CRYPTO_ARCH_HAVE_LIB_POLY1305 || CRYPTO_LIB_POLY1305_GENERIC
 
 config CRYPTO_ARCH_HAVE_LIB_POLY1305
 	tristate
-- 
2.35.1


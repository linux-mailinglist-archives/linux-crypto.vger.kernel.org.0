Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E12AB26D
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Nov 2020 09:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgKIIdA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Nov 2020 03:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIIdA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Nov 2020 03:33:00 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46A920702;
        Mon,  9 Nov 2020 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604910780;
        bh=zszShy06+zN4PJDfPJHQspJ0fbmNAx5/Pfj9Sy7XWvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nasZEq/PWQ9Omy8JBLU6zElwM1epDdGEoqeIqDonTVTLGTXcvylMRAh1WzKuoxdin
         SKhenRpYHhc5VdYSUJne+EFignGesqBBaSI293jVCLoPm5LuauuukX+GSOamggbEwm
         XPQgLCim7Ja85kDwpzPCuaQZMiWU9rz/C+ksnZGw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/3] crypto: tcrypt - don't initialize at subsys_initcall time
Date:   Mon,  9 Nov 2020 09:31:41 +0100
Message-Id: <20201109083143.2884-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109083143.2884-1-ardb@kernel.org>
References: <20201109083143.2884-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Commit c4741b2305979 ("crypto: run initcalls for generic implementations
earlier") converted tcrypt.ko's module_init() to subsys_initcall(), but
this was unintentional: tcrypt.ko currently cannot be built into the core
kernel, and so the subsys_initcall() gets converted into module_init()
under the hood. Given that tcrypt.ko does not implement a generic version
of a crypto algorithm that has to be available early during boot, there
is no point in running the tcrypt init code earlier than implied by
module_init().

However, for crypto development purposes, we will lift the restriction
that tcrypt.ko must be built as a module, and when builtin, it makes sense
for tcrypt.ko (which does its work inside the module init function) to run
as late as possible. So let's switch to late_initcall() instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/tcrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index eea0f453cfb6..fc1f3e516694 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -3066,7 +3066,7 @@ static int __init tcrypt_mod_init(void)
  */
 static void __exit tcrypt_mod_fini(void) { }
 
-subsys_initcall(tcrypt_mod_init);
+late_initcall(tcrypt_mod_init);
 module_exit(tcrypt_mod_fini);
 
 module_param(alg, charp, 0);
-- 
2.17.1


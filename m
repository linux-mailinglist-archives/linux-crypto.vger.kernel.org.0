Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87722F8586
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Jan 2021 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbhAOTbK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Jan 2021 14:31:10 -0500
Received: from mail.zx2c4.com ([167.71.246.149]:36304 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbhAOTbK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 Jan 2021 14:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1610739026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BaNXWOkaA65p8n11dAlACCraC+MzlfwCOIG3MhWrHk=;
        b=Mg1YiCm4JcgjRFChNaaTX1xOutjzCMiMfe6UdC1ymN0INqS2gdRXk3i562QDly4ePWcGq6
        zr5iDy/4l/lPVOP4IvB2mpCW5T0dC+C8MfRlO06SxKxshGM+oG6AnPOA7kIcQkQXR3qHbt
        uGD8OMPsRFOwHWhW71Ps14jr54Dn2JY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9d76af42 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 15 Jan 2021 19:30:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, ardb@kernel.org,
        herbert@gondor.apana.org.au
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        John Donnelly <john.p.donnelly@oracle.com>
Subject: [PATCH v2] crypto: lib/chacha20poly1305 - define empty module exit function
Date:   Fri, 15 Jan 2021 20:30:12 +0100
Message-Id: <20210115193012.3059929-1-Jason@zx2c4.com>
In-Reply-To: <20210115171743.1559595-1-Jason@zx2c4.com>
References: <20210115171743.1559595-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

With no mod_exit function, users are unable to unload the module after
use. I'm not aware of any reason why module unloading should be
prohibited for this one, so this commit simply adds an empty exit
function.

Reported-and-tested-by: John Donnelly <john.p.donnelly@oracle.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v1->v2:
- Fix typo in commit message.

 lib/crypto/chacha20poly1305.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
index 5850f3b87359..c2fcdb98cc02 100644
--- a/lib/crypto/chacha20poly1305.c
+++ b/lib/crypto/chacha20poly1305.c
@@ -362,7 +362,12 @@ static int __init mod_init(void)
 	return 0;
 }
 
+static void __exit mod_exit(void)
+{
+}
+
 module_init(mod_init);
+module_exit(mod_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ChaCha20Poly1305 AEAD construction");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.30.0


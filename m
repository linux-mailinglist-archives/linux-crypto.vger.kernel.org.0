Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CEC327238
	for <lists+linux-crypto@lfdr.de>; Sun, 28 Feb 2021 13:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhB1M3O (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 28 Feb 2021 07:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhB1M3O (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 28 Feb 2021 07:29:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDB0A64E56;
        Sun, 28 Feb 2021 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614515313;
        bh=01W+dreAZY78xHV76wyDXov0ZLJ+CfiKyMbxabOuw7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=eu1tAUHYLImR8Q5VIVcDnNdu2zbkq3ektii8VUhUd3iXL9df7gyRYpzqnu3YU1rQU
         GJX7izxhgefHnsvfJxktDCKNbX8gRYtnP2UdCLty3PicM/HB9XZSPMK/f6kbVnEtyI
         90ktAYpl/A1TyX3kdsWwEwIprGKmb9obXcMBko8rGmZcL1uug9ut7m3ppGjtEKRuwL
         q24XtuGRDx5u2EvbA7KkI564oXh+07AbpiYWRDnfwQd7xteJ2C1oz3Cw2egipX6Nt2
         0tqpNBVqsExC6KoN5gpKIf03yE3dgW/eaXbmPaLDwFcD1Tpb+W2U5SiKNlG8ztp0OK
         pLmNB282im0KA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>,
        syzbot+12cf5fbfdeba210a89dd@syzkaller.appspotmail.com
Subject: [PATCH] crypto: api - check for ERR pointers in crypto_destroy_tfm()
Date:   Sun, 28 Feb 2021 13:28:24 +0100
Message-Id: <20210228122824.5441-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Given that crypto_alloc_tfm() may return ERR pointers, and to avoid
crashes on obscure error paths where such pointers are presented to
crypto_destroy_tfm() (such as [0]), add an ERR_PTR check there
before dereferencing the second argument as a struct crypto_tfm
pointer.

[0] https://lore.kernel.org/linux-crypto/000000000000de949705bc59e0f6@google.com/

Reported-by: syzbot+12cf5fbfdeba210a89dd@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/api.c b/crypto/api.c
index ed08cbd5b9d3..c4eda56cff89 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -562,7 +562,7 @@ void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
 {
 	struct crypto_alg *alg;
 
-	if (unlikely(!mem))
+	if (IS_ERR_OR_NULL(mem))
 		return;
 
 	alg = tfm->__crt_alg;
-- 
2.30.1


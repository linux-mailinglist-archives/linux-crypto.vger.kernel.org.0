Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63B7D6D49
	for <lists+linux-crypto@lfdr.de>; Tue, 15 Oct 2019 04:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfJOCpn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 22:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfJOCpm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 22:45:42 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02830217F9;
        Tue, 15 Oct 2019 02:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571107542;
        bh=rEgridOr8x0Q5MuTsLI43vItUDgIo4mn9nzaQ9Vl67w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F96iiTbN+pwBwSuudvaRKiotVJp0wfe0Jic4ohAgo+DLyt2dJ/uAeAqplBMMVpIv+
         Hqe4aGidB8cMgFC2IZiaPU5f6NwBkfQ6kwOpN/sCjr7TZ/KYVbNh6t5fEougninXcY
         8UOSBpMpVUx2Iwdr9/deFzDazTEqvVXCLyZrubWU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markus Stockhausen <stockhausen@collogia.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] crypto: powerpc - don't unnecessarily use atomic scatterwalk
Date:   Mon, 14 Oct 2019 19:45:15 -0700
Message-Id: <20191015024517.52790-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015024517.52790-1-ebiggers@kernel.org>
References: <20191015024517.52790-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The PowerPC SPE implementations of AES modes only disable preemption
during the actual encryption/decryption, not during the scatterwalk
functions.  It's therefore unnecessary to request an atomic scatterwalk.
So don't do so.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/powerpc/crypto/aes-spe-glue.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/crypto/aes-spe-glue.c b/arch/powerpc/crypto/aes-spe-glue.c
index 3a4ca7d32477..319f1dbb3a70 100644
--- a/arch/powerpc/crypto/aes-spe-glue.c
+++ b/arch/powerpc/crypto/aes-spe-glue.c
@@ -186,7 +186,6 @@ static int ppc_ecb_encrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	unsigned int ubytes;
 	int err;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
 
@@ -214,7 +213,6 @@ static int ppc_ecb_decrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	unsigned int ubytes;
 	int err;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
 
@@ -242,7 +240,6 @@ static int ppc_cbc_encrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	unsigned int ubytes;
 	int err;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
 
@@ -270,7 +267,6 @@ static int ppc_cbc_decrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	unsigned int ubytes;
 	int err;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
 
@@ -298,7 +294,6 @@ static int ppc_ctr_crypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	unsigned int pbytes, ubytes;
 	int err;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt_block(desc, &walk, AES_BLOCK_SIZE);
 
@@ -329,7 +324,6 @@ static int ppc_xts_encrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	int err;
 	u32 *twk;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
 	twk = ctx->key_twk;
@@ -360,7 +354,6 @@ static int ppc_xts_decrypt(struct blkcipher_desc *desc, struct scatterlist *dst,
 	int err;
 	u32 *twk;
 
-	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
 	twk = ctx->key_twk;
-- 
2.23.0


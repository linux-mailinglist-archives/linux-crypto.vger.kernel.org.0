Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2970A217D20
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2020 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgGHClQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 7 Jul 2020 22:41:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59598 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgGHClQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 7 Jul 2020 22:41:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jt01J-00040t-P1; Wed, 08 Jul 2020 12:41:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Jul 2020 12:41:13 +1000
Date:   Wed, 8 Jul 2020 12:41:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: lib/chacha20poly1305 - Add missing function
 declaration
Message-ID: <20200708024113.GA10596@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds a declaration for chacha20poly1305_selftest to
silence a sparse warning.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/crypto/chacha20poly1305.h b/include/crypto/chacha20poly1305.h
index 234ee28078efd..d2ac3ff7dc1ec 100644
--- a/include/crypto/chacha20poly1305.h
+++ b/include/crypto/chacha20poly1305.h
@@ -45,4 +45,6 @@ bool chacha20poly1305_decrypt_sg_inplace(struct scatterlist *src, size_t src_len
 					 const u64 nonce,
 					 const u8 key[CHACHA20POLY1305_KEY_SIZE]);
 
+bool chacha20poly1305_selftest(void);
+
 #endif /* __CHACHA20POLY1305_H */
diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
index c6baa946ccb1a..9d46b4999857b 100644
--- a/lib/crypto/chacha20poly1305.c
+++ b/lib/crypto/chacha20poly1305.c
@@ -21,8 +21,6 @@
 
 #define CHACHA_KEY_WORDS	(CHACHA_KEY_SIZE / sizeof(u32))
 
-bool __init chacha20poly1305_selftest(void);
-
 static void chacha_load_key(u32 *k, const u8 *in)
 {
 	k[0] = get_unaligned_le32(in);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4EDB6F1
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Oct 2019 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503353AbfJQTKU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Oct 2019 15:10:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503389AbfJQTKT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Oct 2019 15:10:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so3669463wmj.5
        for <linux-crypto@vger.kernel.org>; Thu, 17 Oct 2019 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zon5LWc38AUMGyVXuSJTgSrpKN4xPBBsq5DbIiKEaQs=;
        b=dafF+sOJYHTr3TX83dicwLwOIVBjSfi7gl8jlanQuj71XOF7joYXRWS3wgsEaWy6j6
         TQKdgc+7tfhleAVJJfGbFqh3RJqcfuVluLV96B/5Z5kMzTFisisiO1sYZJMtl6HASkW9
         6jAx47jJX9s63SQ94i7CK+lOhY92IFaOxGCXqXdqli/7Z6iuS4e7uBYmlWDZO9pF5cqs
         KnrPotQqyjzsECnoffrniMjD1MB96SJp8oXCFU6mZdo8V+uo3eEMTS32SPvkM7oFvDxp
         6W/7zP5f0Dbxih+dzAM3m/h30lbVBZKnW4jPyP1wP4NKr4NER4p9i6l5ffbh5CFFNAxo
         8fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zon5LWc38AUMGyVXuSJTgSrpKN4xPBBsq5DbIiKEaQs=;
        b=qfB/foVlbZ/h5vKngjAo7bZruWpNULFyCmB3A1acsVOPuqo5y4qRmsbVGQLM1fTYlO
         rd2ZZO2PTJHcsE1891PdDnQtv9lWLqReO5LmokIMOZ+J5MsFIfKnmxQJLDLAlwyCWVyI
         eEDTnva8oknQ3sCE/xkp7H/QCC4JElsNtuUAIF0mheELPHf9LE0uWKyYuFywXU8Y/Os2
         deBS6hzms6ktWHEg4DcnLToxR186Ck799RqO6pi9+yaJXvbk1/Osa4+fq9n881yFTDDH
         w/Sd9OSAxpgM3X6SEirwZnbC6psztOD0tliHtlBfn2VDSjykbU34p+sNRHTbRG818fpS
         l8Ng==
X-Gm-Message-State: APjAAAWzsAtUrpOx6CeNNPgW54rPciEFFt2S7yk84uu4nELcs5Spq/7B
        ylktLfYhzNztiKR0z+xXU+OUqY2bMAbNAFNC
X-Google-Smtp-Source: APXvYqx4p6AADnHnhSw+eAg1jVyYmW/mjMARsYmyqyXLCH+boLSf+y8WWxdZqWXvBcmhB5aCXvLPJw==
X-Received: by 2002:a1c:1f8d:: with SMTP id f135mr4121931wmf.156.1571339416111;
        Thu, 17 Oct 2019 12:10:16 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:ccb6:e9d4:c1bc:d107])
        by smtp.gmail.com with ESMTPSA id y3sm5124528wro.36.2019.10.17.12.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 12:10:15 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v4 15/35] crypto: poly1305 - expose init/update/final library interface
Date:   Thu, 17 Oct 2019 21:09:12 +0200
Message-Id: <20191017190932.1947-16-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017190932.1947-1-ard.biesheuvel@linaro.org>
References: <20191017190932.1947-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Expose the existing generic Poly1305 code via a init/update/final
library interface so that callers are not required to go through
the crypto API's shash abstraction to access it. At the same time,
make some preparations so that the library implementation can be
superseded by an accelerated arch-specific version in the future.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/poly1305_generic.c | 22 +-----
 include/crypto/poly1305.h | 38 +++++++++-
 lib/crypto/Kconfig        | 26 +++++++
 lib/crypto/poly1305.c     | 74 ++++++++++++++++++++
 4 files changed, 138 insertions(+), 22 deletions(-)

diff --git a/crypto/poly1305_generic.c b/crypto/poly1305_generic.c
index f3fcd9578a47..afe9a9e576dd 100644
--- a/crypto/poly1305_generic.c
+++ b/crypto/poly1305_generic.c
@@ -85,31 +85,11 @@ EXPORT_SYMBOL_GPL(crypto_poly1305_update);
 int crypto_poly1305_final(struct shash_desc *desc, u8 *dst)
 {
 	struct poly1305_desc_ctx *dctx = shash_desc_ctx(desc);
-	__le32 digest[4];
-	u64 f = 0;
 
 	if (unlikely(!dctx->sset))
 		return -ENOKEY;
 
-	if (unlikely(dctx->buflen)) {
-		dctx->buf[dctx->buflen++] = 1;
-		memset(dctx->buf + dctx->buflen, 0,
-		       POLY1305_BLOCK_SIZE - dctx->buflen);
-		poly1305_core_blocks(&dctx->h, dctx->r, dctx->buf, 1, 0);
-	}
-
-	poly1305_core_emit(&dctx->h, digest);
-
-	/* mac = (h + s) % (2^128) */
-	f = (f >> 32) + le32_to_cpu(digest[0]) + dctx->s[0];
-	put_unaligned_le32(f, dst + 0);
-	f = (f >> 32) + le32_to_cpu(digest[1]) + dctx->s[1];
-	put_unaligned_le32(f, dst + 4);
-	f = (f >> 32) + le32_to_cpu(digest[2]) + dctx->s[2];
-	put_unaligned_le32(f, dst + 8);
-	f = (f >> 32) + le32_to_cpu(digest[3]) + dctx->s[3];
-	put_unaligned_le32(f, dst + 12);
-
+	poly1305_final_generic(dctx, dst);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_poly1305_final);
diff --git a/include/crypto/poly1305.h b/include/crypto/poly1305.h
index 36b5886cb50c..74c6e1cd73ee 100644
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -35,7 +35,43 @@ struct poly1305_desc_ctx {
 	/* accumulator */
 	struct poly1305_state h;
 	/* key */
-	struct poly1305_key r[1];
+	struct poly1305_key r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
 };
 
+void poly1305_init_arch(struct poly1305_desc_ctx *desc, const u8 *key);
+void poly1305_init_generic(struct poly1305_desc_ctx *desc, const u8 *key);
+
+static inline void poly1305_init(struct poly1305_desc_ctx *desc, const u8 *key)
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305))
+		poly1305_init_arch(desc, key);
+	else
+		poly1305_init_generic(desc, key);
+}
+
+void poly1305_update_arch(struct poly1305_desc_ctx *desc, const u8 *src,
+			  unsigned int nbytes);
+void poly1305_update_generic(struct poly1305_desc_ctx *desc, const u8 *src,
+			     unsigned int nbytes);
+
+static inline void poly1305_update(struct poly1305_desc_ctx *desc,
+				   const u8 *src, unsigned int nbytes)
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305))
+		poly1305_update_arch(desc, src, nbytes);
+	else
+		poly1305_update_generic(desc, src, nbytes);
+}
+
+void poly1305_final_arch(struct poly1305_desc_ctx *desc, u8 *digest);
+void poly1305_final_generic(struct poly1305_desc_ctx *desc, u8 *digest);
+
+static inline void poly1305_final(struct poly1305_desc_ctx *desc, u8 *digest)
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305))
+		poly1305_final_arch(desc, digest);
+	else
+		poly1305_final_generic(desc, digest);
+}
+
 #endif
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index c4882d29879e..a731ea36bd5c 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -37,8 +37,34 @@ config CRYPTO_LIB_CHACHA
 config CRYPTO_LIB_DES
 	tristate
 
+config CRYPTO_LIB_POLY1305_RSIZE
+	int
+	default 1
+
+config CRYPTO_ARCH_HAVE_LIB_POLY1305
+	tristate
+	help
+	  Declares whether the architecture provides an arch-specific
+	  accelerated implementation of the Poly1305 library interface,
+	  either builtin or as a module.
+
 config CRYPTO_LIB_POLY1305_GENERIC
 	tristate
+	help
+	  This symbol can be depended upon by arch implementations of the
+	  Poly1305 library interface that require the generic code as a
+	  fallback, e.g., for SIMD implementations. If no arch specific
+	  implementation is enabled, this implementation serves the users
+	  of CRYPTO_LIB_POLY1305.
+
+config CRYPTO_LIB_POLY1305
+	tristate "Poly1305 library interface"
+	depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305
+	select CRYPTO_LIB_POLY1305_GENERIC if CRYPTO_ARCH_HAVE_LIB_POLY1305=n
+	help
+	  Enable the Poly1305 library interface. This interface may be fulfilled
+	  by either the generic implementation or an arch-specific one, if one
+	  is available and enabled.
 
 config CRYPTO_LIB_SHA256
 	tristate
diff --git a/lib/crypto/poly1305.c b/lib/crypto/poly1305.c
index f019a57dbc1b..32ec293c65ae 100644
--- a/lib/crypto/poly1305.c
+++ b/lib/crypto/poly1305.c
@@ -154,5 +154,79 @@ void poly1305_core_emit(const struct poly1305_state *state, void *dst)
 }
 EXPORT_SYMBOL_GPL(poly1305_core_emit);
 
+void poly1305_init_generic(struct poly1305_desc_ctx *desc, const u8 *key)
+{
+	poly1305_core_setkey(desc->r, key);
+	desc->s[0] = get_unaligned_le32(key + 16);
+	desc->s[1] = get_unaligned_le32(key + 20);
+	desc->s[2] = get_unaligned_le32(key + 24);
+	desc->s[3] = get_unaligned_le32(key + 28);
+	poly1305_core_init(&desc->h);
+	desc->buflen = 0;
+	desc->sset = true;
+	desc->rset = 1;
+}
+EXPORT_SYMBOL_GPL(poly1305_init_generic);
+
+void poly1305_update_generic(struct poly1305_desc_ctx *desc, const u8 *src,
+			     unsigned int nbytes)
+{
+	unsigned int bytes;
+
+	if (unlikely(desc->buflen)) {
+		bytes = min(nbytes, POLY1305_BLOCK_SIZE - desc->buflen);
+		memcpy(desc->buf + desc->buflen, src, bytes);
+		src += bytes;
+		nbytes -= bytes;
+		desc->buflen += bytes;
+
+		if (desc->buflen == POLY1305_BLOCK_SIZE) {
+			poly1305_core_blocks(&desc->h, desc->r, desc->buf, 1, 1);
+			desc->buflen = 0;
+		}
+	}
+
+	if (likely(nbytes >= POLY1305_BLOCK_SIZE)) {
+		poly1305_core_blocks(&desc->h, desc->r, src,
+				     nbytes / POLY1305_BLOCK_SIZE, 1);
+		src += nbytes - (nbytes % POLY1305_BLOCK_SIZE);
+		nbytes %= POLY1305_BLOCK_SIZE;
+	}
+
+	if (unlikely(nbytes)) {
+		desc->buflen = nbytes;
+		memcpy(desc->buf, src, nbytes);
+	}
+}
+EXPORT_SYMBOL_GPL(poly1305_update_generic);
+
+void poly1305_final_generic(struct poly1305_desc_ctx *desc, u8 *dst)
+{
+	__le32 digest[4];
+	u64 f = 0;
+
+	if (unlikely(desc->buflen)) {
+		desc->buf[desc->buflen++] = 1;
+		memset(desc->buf + desc->buflen, 0,
+		       POLY1305_BLOCK_SIZE - desc->buflen);
+		poly1305_core_blocks(&desc->h, desc->r, desc->buf, 1, 0);
+	}
+
+	poly1305_core_emit(&desc->h, digest);
+
+	/* mac = (h + s) % (2^128) */
+	f = (f >> 32) + le32_to_cpu(digest[0]) + desc->s[0];
+	put_unaligned_le32(f, dst + 0);
+	f = (f >> 32) + le32_to_cpu(digest[1]) + desc->s[1];
+	put_unaligned_le32(f, dst + 4);
+	f = (f >> 32) + le32_to_cpu(digest[2]) + desc->s[2];
+	put_unaligned_le32(f, dst + 8);
+	f = (f >> 32) + le32_to_cpu(digest[3]) + desc->s[3];
+	put_unaligned_le32(f, dst + 12);
+
+	*desc = (struct poly1305_desc_ctx){};
+}
+EXPORT_SYMBOL_GPL(poly1305_final_generic);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Martin Willi <martin@strongswan.org>");
-- 
2.20.1


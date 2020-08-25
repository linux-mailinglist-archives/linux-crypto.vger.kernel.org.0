Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1521250E53
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Aug 2020 03:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgHYBlj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Aug 2020 21:41:39 -0400
Received: from [216.24.177.18] ([216.24.177.18]:58840 "EHLO fornost.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHYBli (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Aug 2020 21:41:38 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kANr2-0005BT-QY; Tue, 25 Aug 2020 11:34:29 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 25 Aug 2020 11:34:28 +1000
Date:   Tue, 25 Aug 2020 11:34:28 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] crypto: arm64/sha - Add declarations for assembly variables
Message-ID: <20200825013428.GA14497@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds declarations for variables only used by assembly
code to silence compiler warnings:

  CC [M]  arch/arm64/crypto/sha1-ce-glue.o
  AS [M]  arch/arm64/crypto/sha1-ce-core.o
  CC [M]  arch/arm64/crypto/sha2-ce-glue.o
  AS [M]  arch/arm64/crypto/sha2-ce-core.o
  CHECK   ../arch/arm64/crypto/sha1-ce-glue.c
  CHECK   ../arch/arm64/crypto/sha2-ce-glue.c
../arch/arm64/crypto/sha1-ce-glue.c:38:11: warning: symbol 'sha1_ce_offsetof_count' was not declared. Should it be static?
../arch/arm64/crypto/sha1-ce-glue.c:39:11: warning: symbol 'sha1_ce_offsetof_finalize' was not declared. Should it be static?
../arch/arm64/crypto/sha2-ce-glue.c:38:11: warning: symbol 'sha256_ce_offsetof_count' was not declared. Should it be static?
../arch/arm64/crypto/sha2-ce-glue.c:40:11: warning: symbol 'sha256_ce_offsetof_finalize' was not declared. Should it be static?

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
index 565ef604ca04..c63b99211db3 100644
--- a/arch/arm64/crypto/sha1-ce-glue.c
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -25,6 +25,9 @@ struct sha1_ce_state {
 	u32			finalize;
 };
 
+extern const u32 sha1_ce_offsetof_count;
+extern const u32 sha1_ce_offsetof_finalize;
+
 asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
 				  int blocks);
 
diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
index 9450d19b9e6e..5e956d7582a5 100644
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -25,6 +25,9 @@ struct sha256_ce_state {
 	u32			finalize;
 };
 
+extern const u32 sha256_ce_offsetof_count;
+extern const u32 sha256_ce_offsetof_finalize;
+
 asmlinkage void sha2_ce_transform(struct sha256_ce_state *sst, u8 const *src,
 				  int blocks);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

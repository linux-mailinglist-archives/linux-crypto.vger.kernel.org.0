Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF26A248083
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Aug 2020 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHRIZk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Aug 2020 04:25:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42320 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHRIZj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Aug 2020 04:25:39 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k7ww4-0000e4-CM; Tue, 18 Aug 2020 18:25:37 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 18 Aug 2020 18:25:36 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 18 Aug 2020 18:25:36 +1000
Subject: [PATCH 4/6] crypto: ahash - Add ahash_alg_instance
References: <20200818082410.GA24497@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, Ben Greear <greearb@candelatech.com>
Message-Id: <E1k7ww4-0000e4-CM@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds the helper ahash_alg_instance which is used to
convert a crypto_ahash object into its corresponding ahash_instance.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 include/crypto/internal/hash.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
index 12665b72672d3..a6fbc4363e5e1 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -178,6 +178,12 @@ static inline struct ahash_instance *ahash_instance(
 	return container_of(inst, struct ahash_instance, s.base);
 }
 
+static inline struct ahash_instance *ahash_alg_instance(
+	struct crypto_ahash *ahash)
+{
+	return ahash_instance(crypto_tfm_alg_instance(&ahash->base));
+}
+
 static inline void *ahash_instance_ctx(struct ahash_instance *inst)
 {
 	return crypto_instance_ctx(ahash_crypto_instance(inst));

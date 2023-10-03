Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFB7B5F72
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Oct 2023 05:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjJCDol (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Oct 2023 23:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJCDok (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Oct 2023 23:44:40 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985FDBF
        for <linux-crypto@vger.kernel.org>; Mon,  2 Oct 2023 20:44:37 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qnWKm-002wQW-Tr; Tue, 03 Oct 2023 11:44:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Oct 2023 11:44:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 02/16] crypto: skcipher - Add crypto_spawn_skcipher_alg_common
Date:   Tue,  3 Oct 2023 11:43:19 +0800
Message-Id: <20231003034333.1441826-3-herbert@gondor.apana.org.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003034333.1441826-1-herbert@gondor.apana.org.au>
References: <20231003034333.1441826-1-herbert@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As skcipher spawns can be of two different types (skcipher vs.
lskcipher), only the common fields can be accessed.  Add a helper
to return the common algorithm object.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/internal/skcipher.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index 4382fd707b8a..c767b5cfbd9c 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -160,6 +160,12 @@ static inline struct lskcipher_alg *crypto_lskcipher_spawn_alg(
 	return container_of(spawn->base.alg, struct lskcipher_alg, co.base);
 }
 
+static inline struct skcipher_alg_common *crypto_spawn_skcipher_alg_common(
+	struct crypto_skcipher_spawn *spawn)
+{
+	return container_of(spawn->base.alg, struct skcipher_alg_common, base);
+}
+
 static inline struct skcipher_alg *crypto_spawn_skcipher_alg(
 	struct crypto_skcipher_spawn *spawn)
 {
-- 
2.39.2


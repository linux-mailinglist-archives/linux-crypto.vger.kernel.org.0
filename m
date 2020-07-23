Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2E22A9F8
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGWHrP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:47:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34590 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgGWHrP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:47:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyVwK-0005i4-MH; Thu, 23 Jul 2020 17:46:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:46:52 +1000
Date:   Thu, 23 Jul 2020 17:46:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: testmgr - Fix zero initialiser warnings
Message-ID: <20200723074652.GA8595@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a bunch of zero initialiser warnings.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6863f911fcee..487ba5f369e4 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1649,7 +1649,7 @@ static int test_hash_vs_generic_impl(const char *driver,
 	struct crypto_shash *generic_tfm = NULL;
 	struct shash_desc *generic_desc = NULL;
 	unsigned int i;
-	struct hash_testvec vec = { 0 };
+	struct hash_testvec vec = {};
 	char vec_name[64];
 	struct testvec_config *cfg;
 	char cfgname[TESTVEC_CONFIG_NAMELEN];
@@ -2975,7 +2975,7 @@ static int test_skcipher_vs_generic_impl(const char *driver,
 	struct crypto_skcipher *generic_tfm = NULL;
 	struct skcipher_request *generic_req = NULL;
 	unsigned int i;
-	struct cipher_testvec vec = { 0 };
+	struct cipher_testvec vec = {};
 	char vec_name[64];
 	struct testvec_config *cfg;
 	char cfgname[TESTVEC_CONFIG_NAMELEN];
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

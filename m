Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5133168B50E
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Feb 2023 05:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBFEyK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 5 Feb 2023 23:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBFExr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 5 Feb 2023 23:53:47 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608942701
        for <linux-crypto@vger.kernel.org>; Sun,  5 Feb 2023 20:53:45 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pOtVa-007tPz-Lz; Mon, 06 Feb 2023 12:53:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Feb 2023 12:53:38 +0800
Date:   Mon, 6 Feb 2023 12:53:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] crypto: ecc - Silence sparse warning
Message-ID: <Y+CH0i0AHpXrw0KX@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Rewrite the bitwise operations to silence the sparse warnings:

  CHECK   ../crypto/ecc.c
../crypto/ecc.c:1387:39: warning: dubious: !x | y
../crypto/ecc.c:1397:47: warning: dubious: !x | y

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 7315217c8f73..f53fb4d6af99 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1384,7 +1384,8 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 
 	num_bits = max(vli_num_bits(u1, ndigits), vli_num_bits(u2, ndigits));
 	i = num_bits - 1;
-	idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
+	idx = !!vli_test_bit(u1, i);
+	idx |= (!!vli_test_bit(u2, i)) << 1;
 	point = points[idx];
 
 	vli_set(rx, point->x, ndigits);
@@ -1394,7 +1395,8 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 
 	for (--i; i >= 0; i--) {
 		ecc_point_double_jacobian(rx, ry, z, curve);
-		idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
+		idx = !!vli_test_bit(u1, i);
+		idx |= (!!vli_test_bit(u2, i)) << 1;
 		point = points[idx];
 		if (point) {
 			u64 tx[ECC_MAX_DIGITS];
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

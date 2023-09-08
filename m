Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C57984B8
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Sep 2023 11:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbjIHJVf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Sep 2023 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjIHJVe (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Sep 2023 05:21:34 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D21FC4
        for <linux-crypto@vger.kernel.org>; Fri,  8 Sep 2023 02:21:17 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qeXfr-00BxLc-Iz; Fri, 08 Sep 2023 17:21:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Sep 2023 17:21:13 +0800
Date:   Fri, 8 Sep 2023 17:21:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: octeon - Fix warnings on 32-bit platforms
Message-ID: <ZPrniQ4XYatlUqYE@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use unsigned long instead of u64 to silence compile warnings on
32-bit platforms.  Also remove the __force bit which seems no
longer needed with a current sparse.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/octeon-rng.c b/drivers/char/hw_random/octeon-rng.c
index 8561a09b4681..412f54405036 100644
--- a/drivers/char/hw_random/octeon-rng.c
+++ b/drivers/char/hw_random/octeon-rng.c
@@ -33,7 +33,7 @@ static int octeon_rng_init(struct hwrng *rng)
 	ctl.u64 = 0;
 	ctl.s.ent_en = 1; /* Enable the entropy source.  */
 	ctl.s.rng_en = 1; /* Enable the RNG hardware.  */
-	cvmx_write_csr((__force u64)p->control_status, ctl.u64);
+	cvmx_write_csr((unsigned long)p->control_status, ctl.u64);
 	return 0;
 }
 
@@ -44,14 +44,14 @@ static void octeon_rng_cleanup(struct hwrng *rng)
 
 	ctl.u64 = 0;
 	/* Disable everything.  */
-	cvmx_write_csr((__force u64)p->control_status, ctl.u64);
+	cvmx_write_csr((unsigned long)p->control_status, ctl.u64);
 }
 
 static int octeon_rng_data_read(struct hwrng *rng, u32 *data)
 {
 	struct octeon_rng *p = container_of(rng, struct octeon_rng, ops);
 
-	*data = cvmx_read64_uint32((__force u64)p->result);
+	*data = cvmx_read64_uint32((unsigned long)p->result);
 	return sizeof(u32);
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

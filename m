Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1962BA250
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 07:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgKTG2m (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:28:42 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33914 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgKTG2m (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:28:42 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kfzuQ-0006nZ-Ff; Fri, 20 Nov 2020 17:28:39 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:28:38 +1100
Date:   Fri, 20 Nov 2020 17:28:38 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Kim Phillips <kim.phillips@freescale.com>,
        Markus Stockhausen <stockhausen@collogia.de>
Subject: [PATCH] crypto: powerpc/sha256-spe - Fix sparse endianness warning
Message-ID: <20201120062838.GA18874@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a sparse endianness warning in sha256-spe.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/powerpc/crypto/sha256-spe-glue.c b/arch/powerpc/crypto/sha256-spe-glue.c
index 88530ae0791f..a6e650a97d8f 100644
--- a/arch/powerpc/crypto/sha256-spe-glue.c
+++ b/arch/powerpc/crypto/sha256-spe-glue.c
@@ -177,7 +177,7 @@ static int ppc_spe_sha256_final(struct shash_desc *desc, u8 *out)
 
 static int ppc_spe_sha224_final(struct shash_desc *desc, u8 *out)
 {
-	u32 D[SHA256_DIGEST_SIZE >> 2];
+	__be32 D[SHA256_DIGEST_SIZE >> 2];
 	__be32 *dst = (__be32 *)out;
 
 	ppc_spe_sha256_final(desc, (u8 *)D);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

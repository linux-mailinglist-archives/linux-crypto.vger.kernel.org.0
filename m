Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D659C250E5F
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Aug 2020 03:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgHYBwk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Aug 2020 21:52:40 -0400
Received: from [216.24.177.18] ([216.24.177.18]:58844 "EHLO fornost.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHYBwk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Aug 2020 21:52:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kAO83-0005Kl-0Z; Tue, 25 Aug 2020 11:52:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 25 Aug 2020 11:52:02 +1000
Date:   Tue, 25 Aug 2020 11:52:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH] crypto: powerpc/crc-vpmsum_test - Fix sparse endianness
 warning
Message-ID: <20200825015202.GA27732@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a sparse endianness warning by changing crc32 to
__le32 instead of u32:

  CHECK   ../arch/powerpc/crypto/crc-vpmsum_test.c
../arch/powerpc/crypto/crc-vpmsum_test.c:102:39: warning: cast from restricted __le32

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/powerpc/crypto/crc-vpmsum_test.c b/arch/powerpc/crypto/crc-vpmsum_test.c
index 8014cc48b62b..c1c1ef9457fb 100644
--- a/arch/powerpc/crypto/crc-vpmsum_test.c
+++ b/arch/powerpc/crypto/crc-vpmsum_test.c
@@ -23,10 +23,11 @@ static unsigned long iterations = 10000;
 static int __init crc_test_init(void)
 {
 	u16 crc16 = 0, verify16 = 0;
-	u32 crc32 = 0, verify32 = 0;
 	__le32 verify32le = 0;
 	unsigned char *data;
+	u32 verify32 = 0;
 	unsigned long i;
+	__le32 crc32;
 	int ret;
 
 	struct crypto_shash *crct10dif_tfm;
@@ -99,7 +100,7 @@ static int __init crc_test_init(void)
 			crypto_shash_final(crc32c_shash, (u8 *)(&crc32));
 			verify32 = le32_to_cpu(verify32le);
 		        verify32le = ~cpu_to_le32(__crc32c_le(~verify32, data+offset, len));
-			if (crc32 != (u32)verify32le) {
+			if (crc32 != verify32le) {
 				pr_err("FAILURE in CRC32: got 0x%08x expected 0x%08x (len %lu)\n",
 				       crc32, verify32, len);
 				break;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

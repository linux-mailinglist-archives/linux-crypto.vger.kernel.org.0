Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0E62B21E
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Nov 2022 05:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKPEOb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Nov 2022 23:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiKPEOV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:21 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA431EFA;
        Tue, 15 Nov 2022 20:14:18 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3RUTc013874;
        Wed, 16 Nov 2022 04:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=JLi1pqnZUODkLCm7SUQuuKGdHYscWYh21IabB9tftms=;
 b=WC70eAGL2IOGKa+Ve/ihe/kM+8DB57Q9/FathLVv3F6YM8DWhgqwyVeSoQS0obusd0Eb
 41dExgTVQMhUoKkfFmfu0HIimq8ksgjsUKAmI70jAq4VYBblR++N+cpDn+L+aYtp8h4R
 XjfTwqvrvLOOpVvf99J/d2i0tameakQt49XwqdwKTR3koB/YCy4BbYkaczPWU/X3e6nn
 q9RX4woHybqSf5cIg+ryzcLVKcJYs36b0cwca9RvLO02rxq5OpuB8WTk37V1xmcnA/Dq
 OuSN5C+ALAMgA/D3kJ5qMjR+hfRBQqqRnnuVJTsUz95jXaPpDQp7fyOEZazuoCxliK26 rg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqyfr9hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:13:59 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 385C34B5CE;
        Wed, 16 Nov 2022 04:13:58 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id BC9CD802DD6;
        Wed, 16 Nov 2022 04:13:57 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 04/24] crypto: x86/sha - limit FPU preemption
Date:   Tue, 15 Nov 2022 22:13:22 -0600
Message-Id: <20221116041342.3841-5-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C2NCv8BnIiHVn237aUl32a4qJjW2A1tT
X-Proofpoint-ORIG-GUID: C2NCv8BnIiHVn237aUl32a4qJjW2A1tT
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Limit the number of bytes processed between kernel_fpu_begin() and
kernel_fpu_end() calls.

Those functions call preempt_disable() and preempt_enable(), so
the CPU core is unavailable for scheduling while running.

This leads to "rcu_preempt detected expedited stalls" with stack dumps
pointing to the optimized hash function if the module is loaded and
used a lot:
    rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: ...

For example, that can occur during boot with the stack track pointing
to the sha512-x86 function if the system set to use SHA-512 for
module signing. The call trace includes:
    module_sig_check
    mod_verify_sig
    pkcs7_verify
    pkcs7_digest
    sha512_finup
    sha512_base_do_update

Fixes: 66be89515888 ("crypto: sha1 - SSSE3 based SHA1 implementation for x86-64")
Fixes: 8275d1aa6422 ("crypto: sha256 - Create module providing optimized SHA256 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: 87de4579f92d ("crypto: sha512 - Create module providing optimized SHA512 routines using SSSE3, AVX or AVX2 instructions.")
Fixes: aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 simplify to while loops rather than do..while loops, avoid
redundant checks for zero length, rename the limit macro and
change into a const, vary the limit for each algo
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 64 ++++++++++++++++++++++-------
 arch/x86/crypto/sha256_ssse3_glue.c | 64 ++++++++++++++++++++++-------
 arch/x86/crypto/sha512_ssse3_glue.c | 55 +++++++++++++++++++------
 3 files changed, 140 insertions(+), 43 deletions(-)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 44340a1139e0..4bc77c84b0fb 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -26,8 +26,17 @@
 #include <crypto/sha1_base.h>
 #include <asm/simd.h>
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+#ifdef CONFIG_AS_SHA1_NI
+static const unsigned int bytes_per_fpu_shani = 34 * 1024;
+#endif
+static const unsigned int bytes_per_fpu_avx2 = 34 * 1024;
+static const unsigned int bytes_per_fpu_avx = 30 * 1024;
+static const unsigned int bytes_per_fpu_ssse3 = 26 * 1024;
+
 static int sha1_update(struct shash_desc *desc, const u8 *data,
-			     unsigned int len, sha1_block_fn *sha1_xform)
+		       unsigned int len, unsigned int bytes_per_fpu,
+		       sha1_block_fn *sha1_xform)
 {
 	struct sha1_state *sctx = shash_desc_ctx(desc);
 
@@ -41,22 +50,39 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha1_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha1_base_do_update(desc, data, len, sha1_xform);
-	kernel_fpu_end();
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sha1_base_do_update(desc, data, chunk, sha1_xform);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
 
 	return 0;
 }
 
 static int sha1_finup(struct shash_desc *desc, const u8 *data,
-		      unsigned int len, u8 *out, sha1_block_fn *sha1_xform)
+		      unsigned int len, unsigned int bytes_per_fpu,
+		      u8 *out, sha1_block_fn *sha1_xform)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha1_finup(desc, data, len, out);
 
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sha1_base_do_update(desc, data, chunk, sha1_xform);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
+
 	kernel_fpu_begin();
-	if (len)
-		sha1_base_do_update(desc, data, len, sha1_xform);
 	sha1_base_do_finalize(desc, sha1_xform);
 	kernel_fpu_end();
 
@@ -69,13 +95,15 @@ asmlinkage void sha1_transform_ssse3(struct sha1_state *state,
 static int sha1_ssse3_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_transform_ssse3);
+	return sha1_update(desc, data, len, bytes_per_fpu_ssse3,
+			   sha1_transform_ssse3);
 }
 
 static int sha1_ssse3_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_transform_ssse3);
+	return sha1_finup(desc, data, len, bytes_per_fpu_ssse3, out,
+			  sha1_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -119,13 +147,15 @@ asmlinkage void sha1_transform_avx(struct sha1_state *state,
 static int sha1_avx_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_transform_avx);
+	return sha1_update(desc, data, len, bytes_per_fpu_avx,
+			   sha1_transform_avx);
 }
 
 static int sha1_avx_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_transform_avx);
+	return sha1_finup(desc, data, len, bytes_per_fpu_avx, out,
+			  sha1_transform_avx);
 }
 
 static int sha1_avx_final(struct shash_desc *desc, u8 *out)
@@ -201,13 +231,15 @@ static void sha1_apply_transform_avx2(struct sha1_state *state,
 static int sha1_avx2_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_apply_transform_avx2);
+	return sha1_update(desc, data, len, bytes_per_fpu_avx2,
+			   sha1_apply_transform_avx2);
 }
 
 static int sha1_avx2_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_apply_transform_avx2);
+	return sha1_finup(desc, data, len, bytes_per_fpu_avx2, out,
+			  sha1_apply_transform_avx2);
 }
 
 static int sha1_avx2_final(struct shash_desc *desc, u8 *out)
@@ -251,13 +283,15 @@ asmlinkage void sha1_ni_transform(struct sha1_state *digest, const u8 *data,
 static int sha1_ni_update(struct shash_desc *desc, const u8 *data,
 			     unsigned int len)
 {
-	return sha1_update(desc, data, len, sha1_ni_transform);
+	return sha1_update(desc, data, len, bytes_per_fpu_shani,
+			   sha1_ni_transform);
 }
 
 static int sha1_ni_finup(struct shash_desc *desc, const u8 *data,
 			      unsigned int len, u8 *out)
 {
-	return sha1_finup(desc, data, len, out, sha1_ni_transform);
+	return sha1_finup(desc, data, len, bytes_per_fpu_shani, out,
+			  sha1_ni_transform);
 }
 
 static int sha1_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 3a5f6be7dbba..cdcdf5a80ffe 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -40,11 +40,20 @@
 #include <linux/string.h>
 #include <asm/simd.h>
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+#ifdef CONFIG_AS_SHA256_NI
+static const unsigned int bytes_per_fpu_shani = 13 * 1024;
+#endif
+static const unsigned int bytes_per_fpu_avx2 = 13 * 1024;
+static const unsigned int bytes_per_fpu_avx = 11 * 1024;
+static const unsigned int bytes_per_fpu_ssse3 = 11 * 1024;
+
 asmlinkage void sha256_transform_ssse3(struct sha256_state *state,
 				       const u8 *data, int blocks);
 
 static int _sha256_update(struct shash_desc *desc, const u8 *data,
-			  unsigned int len, sha256_block_fn *sha256_xform)
+			  unsigned int len, unsigned int bytes_per_fpu,
+			  sha256_block_fn *sha256_xform)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
@@ -58,22 +67,39 @@ static int _sha256_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha256_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha256_base_do_update(desc, data, len, sha256_xform);
-	kernel_fpu_end();
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sha256_base_do_update(desc, data, chunk, sha256_xform);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
 
 	return 0;
 }
 
 static int sha256_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out, sha256_block_fn *sha256_xform)
+			unsigned int len, unsigned int bytes_per_fpu,
+			u8 *out, sha256_block_fn *sha256_xform)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha256_finup(desc, data, len, out);
 
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sha256_base_do_update(desc, data, chunk, sha256_xform);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
+
 	kernel_fpu_begin();
-	if (len)
-		sha256_base_do_update(desc, data, len, sha256_xform);
 	sha256_base_do_finalize(desc, sha256_xform);
 	kernel_fpu_end();
 
@@ -83,13 +109,15 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 static int sha256_ssse3_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_transform_ssse3);
+	return _sha256_update(desc, data, len, bytes_per_fpu_ssse3,
+			      sha256_transform_ssse3);
 }
 
 static int sha256_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_transform_ssse3);
+	return sha256_finup(desc, data, len, bytes_per_fpu_ssse3,
+			    out, sha256_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -149,13 +177,15 @@ asmlinkage void sha256_transform_avx(struct sha256_state *state,
 static int sha256_avx_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_transform_avx);
+	return _sha256_update(desc, data, len, bytes_per_fpu_avx,
+			      sha256_transform_avx);
 }
 
 static int sha256_avx_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_transform_avx);
+	return sha256_finup(desc, data, len, bytes_per_fpu_avx,
+			    out, sha256_transform_avx);
 }
 
 static int sha256_avx_final(struct shash_desc *desc, u8 *out)
@@ -225,13 +255,15 @@ asmlinkage void sha256_transform_rorx(struct sha256_state *state,
 static int sha256_avx2_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_transform_rorx);
+	return _sha256_update(desc, data, len, bytes_per_fpu_avx2,
+			      sha256_transform_rorx);
 }
 
 static int sha256_avx2_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_transform_rorx);
+	return sha256_finup(desc, data, len, bytes_per_fpu_avx2,
+			    out, sha256_transform_rorx);
 }
 
 static int sha256_avx2_final(struct shash_desc *desc, u8 *out)
@@ -300,13 +332,15 @@ asmlinkage void sha256_ni_transform(struct sha256_state *digest,
 static int sha256_ni_update(struct shash_desc *desc, const u8 *data,
 			 unsigned int len)
 {
-	return _sha256_update(desc, data, len, sha256_ni_transform);
+	return _sha256_update(desc, data, len, bytes_per_fpu_shani,
+			      sha256_ni_transform);
 }
 
 static int sha256_ni_finup(struct shash_desc *desc, const u8 *data,
 		      unsigned int len, u8 *out)
 {
-	return sha256_finup(desc, data, len, out, sha256_ni_transform);
+	return sha256_finup(desc, data, len, bytes_per_fpu_shani,
+			    out, sha256_ni_transform);
 }
 
 static int sha256_ni_final(struct shash_desc *desc, u8 *out)
diff --git a/arch/x86/crypto/sha512_ssse3_glue.c b/arch/x86/crypto/sha512_ssse3_glue.c
index 6d3b85e53d0e..c7036cfe2a7e 100644
--- a/arch/x86/crypto/sha512_ssse3_glue.c
+++ b/arch/x86/crypto/sha512_ssse3_glue.c
@@ -39,11 +39,17 @@
 #include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
+/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
+static const unsigned int bytes_per_fpu_avx2 = 20 * 1024;
+static const unsigned int bytes_per_fpu_avx = 17 * 1024;
+static const unsigned int bytes_per_fpu_ssse3 = 17 * 1024;
+
 asmlinkage void sha512_transform_ssse3(struct sha512_state *state,
 				       const u8 *data, int blocks);
 
 static int sha512_update(struct shash_desc *desc, const u8 *data,
-		       unsigned int len, sha512_block_fn *sha512_xform)
+			 unsigned int len, unsigned int bytes_per_fpu,
+			 sha512_block_fn *sha512_xform)
 {
 	struct sha512_state *sctx = shash_desc_ctx(desc);
 
@@ -57,22 +63,39 @@ static int sha512_update(struct shash_desc *desc, const u8 *data,
 	 */
 	BUILD_BUG_ON(offsetof(struct sha512_state, state) != 0);
 
-	kernel_fpu_begin();
-	sha512_base_do_update(desc, data, len, sha512_xform);
-	kernel_fpu_end();
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sha512_base_do_update(desc, data, chunk, sha512_xform);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
 
 	return 0;
 }
 
 static int sha512_finup(struct shash_desc *desc, const u8 *data,
-	      unsigned int len, u8 *out, sha512_block_fn *sha512_xform)
+			unsigned int len, unsigned int bytes_per_fpu,
+			u8 *out, sha512_block_fn *sha512_xform)
 {
 	if (!crypto_simd_usable())
 		return crypto_sha512_finup(desc, data, len, out);
 
+	while (len) {
+		unsigned int chunk = min(len, bytes_per_fpu);
+
+		kernel_fpu_begin();
+		sha512_base_do_update(desc, data, chunk, sha512_xform);
+		kernel_fpu_end();
+
+		len -= chunk;
+		data += chunk;
+	}
+
 	kernel_fpu_begin();
-	if (len)
-		sha512_base_do_update(desc, data, len, sha512_xform);
 	sha512_base_do_finalize(desc, sha512_xform);
 	kernel_fpu_end();
 
@@ -82,13 +105,15 @@ static int sha512_finup(struct shash_desc *desc, const u8 *data,
 static int sha512_ssse3_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
-	return sha512_update(desc, data, len, sha512_transform_ssse3);
+	return sha512_update(desc, data, len, bytes_per_fpu_ssse3,
+			     sha512_transform_ssse3);
 }
 
 static int sha512_ssse3_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha512_finup(desc, data, len, out, sha512_transform_ssse3);
+	return sha512_finup(desc, data, len, bytes_per_fpu_ssse3,
+			    out, sha512_transform_ssse3);
 }
 
 /* Add padding and return the message digest. */
@@ -158,13 +183,15 @@ static bool avx_usable(void)
 static int sha512_avx_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
-	return sha512_update(desc, data, len, sha512_transform_avx);
+	return sha512_update(desc, data, len, bytes_per_fpu_avx,
+			     sha512_transform_avx);
 }
 
 static int sha512_avx_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha512_finup(desc, data, len, out, sha512_transform_avx);
+	return sha512_finup(desc, data, len, bytes_per_fpu_avx,
+			    out, sha512_transform_avx);
 }
 
 /* Add padding and return the message digest. */
@@ -224,13 +251,15 @@ asmlinkage void sha512_transform_rorx(struct sha512_state *state,
 static int sha512_avx2_update(struct shash_desc *desc, const u8 *data,
 		       unsigned int len)
 {
-	return sha512_update(desc, data, len, sha512_transform_rorx);
+	return sha512_update(desc, data, len, bytes_per_fpu_avx2,
+			     sha512_transform_rorx);
 }
 
 static int sha512_avx2_finup(struct shash_desc *desc, const u8 *data,
 	      unsigned int len, u8 *out)
 {
-	return sha512_finup(desc, data, len, out, sha512_transform_rorx);
+	return sha512_finup(desc, data, len, bytes_per_fpu_avx2,
+			    out, sha512_transform_rorx);
 }
 
 /* Add padding and return the message digest. */
-- 
2.38.1


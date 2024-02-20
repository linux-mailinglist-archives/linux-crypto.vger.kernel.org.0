Return-Path: <linux-crypto+bounces-2201-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E497985BF88
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Feb 2024 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C17BB21358
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Feb 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C174E19;
	Tue, 20 Feb 2024 15:11:11 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01971B4A;
	Tue, 20 Feb 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441871; cv=none; b=TqcFrwCmqZYHUIGboCi6CG17mWMOJ2JkdKhhzs3LannEp7VIv0urcarv6r1wv3nAOJCvjDedTlY7IDRBWMoZdDK5BgjuWdaCnj7Cc05H3/zcJN8dYEfn2u4jqLQulvhzG2sxA/QjsB9mVs30ARrpwlfQAWEYiAulNh07bcx3gYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441871; c=relaxed/simple;
	bh=tgbkUpu6qTn2TmKhbD8vITvgwgVYXSpQdQG6ZCoKe1A=;
	h=Message-Id:From:Date:Subject:To:Cc; b=UrQyPJpnhC6U9VSeSmwf4hQR7OGdMtxU3sLqVYUSpzpN+tfM1USFsh8ydJSHWRohyXyHI/STCOtScNo/frol9FqI0NSI7mr4dZMAzVzzY+FnSglbsANxsf/8WEBWpNSaT8tQgVpZnCc4caAXRbAedtigiOyiIbdxPN4sr0mNIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id DEE25100D5877;
	Tue, 20 Feb 2024 16:10:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B126C4DD9F0; Tue, 20 Feb 2024 16:10:57 +0100 (CET)
Message-Id: <63cc7ab17a5064756e26e50bc605e3ff8914f05a.1708439875.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 20 Feb 2024 16:10:39 +0100
Subject: [PATCH v3] X.509: Introduce scope-based x509_certificate allocation
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Add a DEFINE_FREE() clause for x509_certificate structs and use it in
x509_cert_parse() and x509_key_preparse().  These are the only functions
where scope-based x509_certificate allocation currently makes sense.
A third user will be introduced with the forthcoming SPDM library
(Security Protocol and Data Model) for PCI device authentication.

Unlike most other DEFINE_FREE() clauses, this one checks for IS_ERR()
instead of NULL before calling x509_free_certificate() at end of scope.
That's because the "constructor" of x509_certificate structs,
x509_cert_parse(), returns a valid pointer or an ERR_PTR(), but never
NULL.

I've compared the Assembler output before/after and they are identical,
save for the fact that gcc-12 always generates two return paths when
__cleanup() is used, one for the success case and one for the error case.

In x509_cert_parse(), add a hint for the compiler that kzalloc() never
returns an ERR_PTR().  Otherwise the compiler adds a gratuitous IS_ERR()
check on return.  Introduce a handy assume() macro for this which can be
re-used elsewhere in the kernel to provide hints for the compiler.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: https://lore.kernel.org/all/20231003153937.000034ca@Huawei.com/
Link: https://lwn.net/Articles/934679/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v2 -> v3:
 * Add curly braces to "do { } while" loop in assume() macro (Andy).
 * Rephrase commit message: Drop first paragraph, use "Link:" tag for
   LWN article (Jarkko).

Link to v2:
 https://lore.kernel.org/all/4143b15418c4ecf87ddeceb36813943c3ede17aa.1707734526.git.lukas@wunner.de/

 crypto/asymmetric_keys/x509_cert_parser.c | 43 ++++++++++++-------------------
 crypto/asymmetric_keys/x509_parser.h      |  3 +++
 crypto/asymmetric_keys/x509_public_key.c  | 31 +++++++---------------
 include/linux/compiler.h                  |  2 ++
 4 files changed, 30 insertions(+), 49 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 487204d..aeffbf6 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -60,24 +60,24 @@ void x509_free_certificate(struct x509_certificate *cert)
  */
 struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 {
-	struct x509_certificate *cert;
-	struct x509_parse_context *ctx;
+	struct x509_certificate *cert __free(x509_free_certificate);
+	struct x509_parse_context *ctx __free(kfree) = NULL;
 	struct asymmetric_key_id *kid;
 	long ret;
 
-	ret = -ENOMEM;
 	cert = kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);
+	assume(!IS_ERR(cert)); /* Avoid gratuitous IS_ERR() check on return */
 	if (!cert)
-		goto error_no_cert;
+		return ERR_PTR(-ENOMEM);
 	cert->pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);
 	if (!cert->pub)
-		goto error_no_ctx;
+		return ERR_PTR(-ENOMEM);
 	cert->sig = kzalloc(sizeof(struct public_key_signature), GFP_KERNEL);
 	if (!cert->sig)
-		goto error_no_ctx;
+		return ERR_PTR(-ENOMEM);
 	ctx = kzalloc(sizeof(struct x509_parse_context), GFP_KERNEL);
 	if (!ctx)
-		goto error_no_ctx;
+		return ERR_PTR(-ENOMEM);
 
 	ctx->cert = cert;
 	ctx->data = (unsigned long)data;
@@ -85,7 +85,7 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 	/* Attempt to decode the certificate */
 	ret = asn1_ber_decoder(&x509_decoder, ctx, data, datalen);
 	if (ret < 0)
-		goto error_decode;
+		return ERR_PTR(ret);
 
 	/* Decode the AuthorityKeyIdentifier */
 	if (ctx->raw_akid) {
@@ -95,20 +95,19 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 				       ctx->raw_akid, ctx->raw_akid_size);
 		if (ret < 0) {
 			pr_warn("Couldn't decode AuthKeyIdentifier\n");
-			goto error_decode;
+			return ERR_PTR(ret);
 		}
 	}
 
-	ret = -ENOMEM;
 	cert->pub->key = kmemdup(ctx->key, ctx->key_size, GFP_KERNEL);
 	if (!cert->pub->key)
-		goto error_decode;
+		return ERR_PTR(-ENOMEM);
 
 	cert->pub->keylen = ctx->key_size;
 
 	cert->pub->params = kmemdup(ctx->params, ctx->params_size, GFP_KERNEL);
 	if (!cert->pub->params)
-		goto error_decode;
+		return ERR_PTR(-ENOMEM);
 
 	cert->pub->paramlen = ctx->params_size;
 	cert->pub->algo = ctx->key_algo;
@@ -116,33 +115,23 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 	/* Grab the signature bits */
 	ret = x509_get_sig_params(cert);
 	if (ret < 0)
-		goto error_decode;
+		return ERR_PTR(ret);
 
 	/* Generate cert issuer + serial number key ID */
 	kid = asymmetric_key_generate_id(cert->raw_serial,
 					 cert->raw_serial_size,
 					 cert->raw_issuer,
 					 cert->raw_issuer_size);
-	if (IS_ERR(kid)) {
-		ret = PTR_ERR(kid);
-		goto error_decode;
-	}
+	if (IS_ERR(kid))
+		return ERR_CAST(kid);
 	cert->id = kid;
 
 	/* Detect self-signed certificates */
 	ret = x509_check_for_self_signed(cert);
 	if (ret < 0)
-		goto error_decode;
-
-	kfree(ctx);
-	return cert;
+		return ERR_PTR(ret);
 
-error_decode:
-	kfree(ctx);
-error_no_ctx:
-	x509_free_certificate(cert);
-error_no_cert:
-	return ERR_PTR(ret);
+	return_ptr(cert);
 }
 EXPORT_SYMBOL_GPL(x509_cert_parse);
 
diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index 97a886c..0688c22 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -5,6 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+#include <linux/cleanup.h>
 #include <linux/time.h>
 #include <crypto/public_key.h>
 #include <keys/asymmetric-type.h>
@@ -44,6 +45,8 @@ struct x509_certificate {
  * x509_cert_parser.c
  */
 extern void x509_free_certificate(struct x509_certificate *cert);
+DEFINE_FREE(x509_free_certificate, struct x509_certificate *,
+	    if (!IS_ERR(_T)) x509_free_certificate(_T))
 extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 6a4f00b..00ac715 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -161,12 +161,11 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
  */
 static int x509_key_preparse(struct key_preparsed_payload *prep)
 {
-	struct asymmetric_key_ids *kids;
-	struct x509_certificate *cert;
+	struct x509_certificate *cert __free(x509_free_certificate);
+	struct asymmetric_key_ids *kids __free(kfree) = NULL;
+	char *p, *desc __free(kfree) = NULL;
 	const char *q;
 	size_t srlen, sulen;
-	char *desc = NULL, *p;
-	int ret;
 
 	cert = x509_cert_parse(prep->data, prep->datalen);
 	if (IS_ERR(cert))
@@ -188,9 +187,8 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	}
 
 	/* Don't permit addition of blacklisted keys */
-	ret = -EKEYREJECTED;
 	if (cert->blacklisted)
-		goto error_free_cert;
+		return -EKEYREJECTED;
 
 	/* Propose a description */
 	sulen = strlen(cert->subject);
@@ -202,10 +200,9 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 		q = cert->raw_serial;
 	}
 
-	ret = -ENOMEM;
 	desc = kmalloc(sulen + 2 + srlen * 2 + 1, GFP_KERNEL);
 	if (!desc)
-		goto error_free_cert;
+		return -ENOMEM;
 	p = memcpy(desc, cert->subject, sulen);
 	p += sulen;
 	*p++ = ':';
@@ -215,16 +212,14 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 
 	kids = kmalloc(sizeof(struct asymmetric_key_ids), GFP_KERNEL);
 	if (!kids)
-		goto error_free_desc;
+		return -ENOMEM;
 	kids->id[0] = cert->id;
 	kids->id[1] = cert->skid;
 	kids->id[2] = asymmetric_key_generate_id(cert->raw_subject,
 						 cert->raw_subject_size,
 						 "", 0);
-	if (IS_ERR(kids->id[2])) {
-		ret = PTR_ERR(kids->id[2]);
-		goto error_free_kids;
-	}
+	if (IS_ERR(kids->id[2]))
+		return PTR_ERR(kids->id[2]);
 
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
@@ -242,15 +237,7 @@ static int x509_key_preparse(struct key_preparsed_payload *prep)
 	cert->sig = NULL;
 	desc = NULL;
 	kids = NULL;
-	ret = 0;
-
-error_free_kids:
-	kfree(kids);
-error_free_desc:
-	kfree(desc);
-error_free_cert:
-	x509_free_certificate(cert);
-	return ret;
+	return 0;
 }
 
 static struct asymmetric_key_parser x509_key_parser = {
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index bb1339c..aee74ba 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -139,6 +139,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 } while (0)
 #endif
 
+#define assume(cond) do { if (!(cond)) __builtin_unreachable(); } while (0)
+
 /*
  * KENTRY - kernel entry point
  * This can be used to annotate symbols (functions or data) that are used
-- 
2.43.0



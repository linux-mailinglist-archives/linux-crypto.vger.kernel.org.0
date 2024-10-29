Return-Path: <linux-crypto+bounces-7720-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B49A9B4706
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Oct 2024 11:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFF81F23E92
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Oct 2024 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB1204924;
	Tue, 29 Oct 2024 10:38:54 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1292010F1;
	Tue, 29 Oct 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198334; cv=none; b=q4Sh1qiZ0aWSAqaRI+x7Iu3PNKzJOc6tCr8+Erqpam6XzH5NLco/GuW5wJ+OCxCbkIpCWukmbkE4Jc9+Og6tJD640NUt3vmHp5u6K0Ro622hK+MUVat12H09yzXbuWFOi7RsUmHMN2ByXmBxF/2KAOJ/UU/WjVzfJ8gVKdDLCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198334; c=relaxed/simple;
	bh=nFE+zwDAERHQMYo992A2UxvOwvN/rb+LhhgSUBLm5I8=;
	h=Message-Id:From:Date:Subject:To:Cc; b=Nm9NMIXqj4Y1ZHsBw8RiaxRCTmp08gg7Bwt0nsP18yKoIi9/9u8LGJJ5Rceh1K3gt0CInzVeekCi8cVA0gsRhd3wv+YD1TGacFB/fyKsQK17mNUmym9MTCqXc4peuRaCftQahfWhA6ojXS2yJDc1HcuijvmrglzIojZbVy1RiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2B85B100DA1CC;
	Tue, 29 Oct 2024 11:25:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EDC2F2FD485; Tue, 29 Oct 2024 11:25:18 +0100 (CET)
Message-Id: <6dc2b6afd9c4c5e9577acf2448cdcba41378e859.1730193800.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 29 Oct 2024 11:24:57 +0100
Subject: [PATCH cryptodev-2.6] crypto: rsassa-pkcs1 - Reinstate support for
 legacy protocols
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Klara Modin <klarasmodin@gmail.com>, klara@kasm.eu, Denis Kenzior <denkenz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: Zoltan Kelemen <zoltan@kelemen.se>, Kevin Jones <vcsjones@github.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, iwd@lists.linux.dev, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>, Tadeusz Struk <tstruk@gigaio.com>, David Howells <dhowells@redhat.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ignat Korchagin <ignat@cloudflare.com>, Stephan Mueller <smueller@chronox.de>, Varad Gautam <varadgautam@google.com>, Saulo Alessandre <saulo.alessandre@tse.jus.br>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Commit 1e562deacecc ("crypto: rsassa-pkcs1 - Migrate to sig_alg backend")
enforced that rsassa-pkcs1 sign/verify operations specify a hash
algorithm.  That is necessary because per RFC 8017 sec 8.2, a hash
algorithm identifier must be prepended to the hash before generating or
verifying the signature ("Full Hash Prefix").

However the commit went too far in that it changed user space behavior:
KEYCTL_PKEY_QUERY system calls now return -EINVAL unless they specify a
hash algorithm.  Intel Wireless Daemon (iwd) is one application issuing
such system calls (for EAP-TLS).

Closer analysis of the Embedded Linux Library (ell) used by iwd reveals
that the problem runs even deeper:  When iwd uses TLS 1.1 or earlier, it
not only queries for keys, but performs sign/verify operations without
specifying a hash algorithm.  These legacy TLS versions concatenate an
MD5 to a SHA-1 hash and omit the Full Hash Prefix:

https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/tls-suites.c#n97

TLS 1.1 was deprecated in 2021 by RFC 8996, but removal of support was
inadvertent in this case.  It probably should be coordinated with iwd
maintainers first.

So reinstate support for such legacy protocols by defaulting to hash
algorithm "none" which uses an empty Full Hash Prefix.

If it is later on decided to remove TLS 1.1 support but still allow
KEYCTL_PKEY_QUERY without a hash algorithm, that can be achieved by
reverting the present commit and replacing it with the following patch:

https://lore.kernel.org/r/ZxalYZwH5UiGX5uj@wunner.de/

It's worth noting that Python's cryptography library gained support for
such legacy use cases very recently, so they do seem to still be a thing.
The Python developers identified IKE version 1 as another protocol
omitting the Full Hash Prefix:

https://github.com/pyca/cryptography/issues/10226
https://github.com/pyca/cryptography/issues/5495

The author of those issues, Zoltan Kelemen, spent considerable effort
searching for test vectors but only found one in a 2019 blog post by
Kevin Jones.  Add it to testmgr.h to verify correctness of this feature.

Examination of wpa_supplicant as well as various IKE daemons (libreswan,
strongswan, isakmpd, raccoon) has determined that none of them seems to
use the kernel's Key Retention Service, so iwd is the only affected user
space application known so far.

Fixes: 1e562deacecc ("crypto: rsassa-pkcs1 - Migrate to sig_alg backend")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/r/2ed09a22-86c0-4cf0-8bda-ef804ccb3413@gmail.com/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/asymmetric_keys/public_key.c |  2 +-
 crypto/rsassa-pkcs1.c               | 20 +++++++++++---
 crypto/testmgr.c                    |  6 ++++
 crypto/testmgr.h                    | 55 +++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index c98c158..bbd07a9 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -93,7 +93,7 @@ static void public_key_destroy(void *payload0, void *payload3)
 					     pkey->pkey_algo);
 			} else {
 				if (!hash_algo)
-					return -EINVAL;
+					hash_algo = "none";
 				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
 					     "pkcs1(%s,%s)",
 					     pkey->pkey_algo, hash_algo);
diff --git a/crypto/rsassa-pkcs1.c b/crypto/rsassa-pkcs1.c
index 9c28f1c..4d077fc9 100644
--- a/crypto/rsassa-pkcs1.c
+++ b/crypto/rsassa-pkcs1.c
@@ -27,6 +27,8 @@
  * https://www.rfc-editor.org/rfc/rfc9580#table-24
  */
 
+static const u8 hash_prefix_none[] = { };
+
 static const u8 hash_prefix_md5[] = {
 	0x30, 0x20, 0x30, 0x0c, 0x06, 0x08,	  /* SEQUENCE (SEQUENCE (OID */
 	0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x02, 0x05,	/*	<algorithm>, */
@@ -93,6 +95,7 @@
 	size_t		size;
 } hash_prefixes[] = {
 #define _(X) { #X, hash_prefix_##X, sizeof(hash_prefix_##X) }
+	_(none),
 	_(md5),
 	_(sha1),
 	_(rmd160),
@@ -119,9 +122,18 @@ static const struct hash_prefix *rsassa_pkcs1_find_hash_prefix(const char *name)
 	return NULL;
 }
 
-static unsigned int rsassa_pkcs1_hash_len(const struct hash_prefix *p)
+static bool rsassa_pkcs1_invalid_hash_len(unsigned int len,
+					  const struct hash_prefix *p)
 {
 	/*
+	 * Legacy protocols such as TLS 1.1 or earlier and IKE version 1
+	 * do not prepend a Full Hash Prefix to the hash.  In that case,
+	 * the size of the Full Hash Prefix is zero.
+	 */
+	if (p->data == hash_prefix_none)
+		return false;
+
+	/*
 	 * The final byte of the Full Hash Prefix encodes the hash length.
 	 *
 	 * This needs to be revisited should hash algorithms with more than
@@ -130,7 +142,7 @@ static unsigned int rsassa_pkcs1_hash_len(const struct hash_prefix *p)
 	 */
 	static_assert(HASH_MAX_DIGESTSIZE <= 127);
 
-	return p->data[p->size - 1];
+	return len != p->data[p->size - 1];
 }
 
 struct rsassa_pkcs1_ctx {
@@ -167,7 +179,7 @@ static int rsassa_pkcs1_sign(struct crypto_sig *tfm,
 	if (dlen < ctx->key_size)
 		return -EOVERFLOW;
 
-	if (slen != rsassa_pkcs1_hash_len(hash_prefix))
+	if (rsassa_pkcs1_invalid_hash_len(slen, hash_prefix))
 		return -EINVAL;
 
 	if (slen + hash_prefix->size > ctx->key_size - 11)
@@ -237,7 +249,7 @@ static int rsassa_pkcs1_verify(struct crypto_sig *tfm,
 	/* RFC 8017 sec 8.2.2 step 1 - length checking */
 	if (!ctx->key_size ||
 	    slen != ctx->key_size ||
-	    dlen != rsassa_pkcs1_hash_len(hash_prefix))
+	    rsassa_pkcs1_invalid_hash_len(dlen, hash_prefix))
 		return -EINVAL;
 
 	/* RFC 8017 sec 8.2.2 step 2 - RSA verification */
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 7d768f0..86126be 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5540,6 +5540,12 @@ static int alg_test_null(const struct alg_test_desc *desc,
 			.cipher = __VECS(fcrypt_pcbc_tv_template)
 		}
 	}, {
+		.alg = "pkcs1(rsa,none)",
+		.test = alg_test_sig,
+		.suite = {
+			.sig = __VECS(pkcs1_rsa_none_tv_template)
+		}
+	}, {
 		.alg = "pkcs1(rsa,sha224)",
 		.test = alg_test_null,
 		.fips_allowed = 1,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 55aae18..430d33d 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1983,6 +1983,61 @@ struct kpp_testvec {
 };
 
 /*
+ * PKCS#1 RSA test vectors for hash algorithm "none"
+ * (i.e. the hash in "m" is not prepended by a Full Hash Prefix)
+ *
+ * Obtained from:
+ * https://vcsjones.dev/sometimes-valid-rsa-dotnet/
+ * https://gist.github.com/vcsjones/ab4c2327b53ed018eada76b75ef4fd99
+ */
+static const struct sig_testvec pkcs1_rsa_none_tv_template[] = {
+	{
+	.key =
+	"\x30\x82\x01\x0a\x02\x82\x01\x01\x00\xa2\x63\x0b\x39\x44\xb8\xbb"
+	"\x23\xa7\x44\x49\xbb\x0e\xff\xa1\xf0\x61\x0a\x53\x93\xb0\x98\xdb"
+	"\xad\x2c\x0f\x4a\xc5\x6e\xff\x86\x3c\x53\x55\x0f\x15\xce\x04\x3f"
+	"\x2b\xfd\xa9\x96\x96\xd9\xbe\x61\x79\x0b\x5b\xc9\x4c\x86\x76\xe5"
+	"\xe0\x43\x4b\x22\x95\xee\xc2\x2b\x43\xc1\x9f\xd8\x68\xb4\x8e\x40"
+	"\x4f\xee\x85\x38\xb9\x11\xc5\x23\xf2\x64\x58\xf0\x15\x32\x6f\x4e"
+	"\x57\xa1\xae\x88\xa4\x02\xd7\x2a\x1e\xcd\x4b\xe1\xdd\x63\xd5\x17"
+	"\x89\x32\x5b\xb0\x5e\x99\x5a\xa8\x9d\x28\x50\x0e\x17\xee\x96\xdb"
+	"\x61\x3b\x45\x51\x1d\xcf\x12\x56\x0b\x92\x47\xfc\xab\xae\xf6\x66"
+	"\x3d\x47\xac\x70\x72\xe7\x92\xe7\x5f\xcd\x10\xb9\xc4\x83\x64\x94"
+	"\x19\xbd\x25\x80\xe1\xe8\xd2\x22\xa5\xd0\xba\x02\x7a\xa1\x77\x93"
+	"\x5b\x65\xc3\xee\x17\x74\xbc\x41\x86\x2a\xdc\x08\x4c\x8c\x92\x8c"
+	"\x91\x2d\x9e\x77\x44\x1f\x68\xd6\xa8\x74\x77\xdb\x0e\x5b\x32\x8b"
+	"\x56\x8b\x33\xbd\xd9\x63\xc8\x49\x9d\x3a\xc5\xc5\xea\x33\x0b\xd2"
+	"\xf1\xa3\x1b\xf4\x8b\xbe\xd9\xb3\x57\x8b\x3b\xde\x04\xa7\x7a\x22"
+	"\xb2\x24\xae\x2e\xc7\x70\xc5\xbe\x4e\x83\x26\x08\xfb\x0b\xbd\xa9"
+	"\x4f\x99\x08\xe1\x10\x28\x72\xaa\xcd\x02\x03\x01\x00\x01",
+	.key_len = 270,
+	.m =
+	"\x68\xb4\xf9\x26\x34\x31\x25\xdd\x26\x50\x13\x68\xc1\x99\x26\x71"
+	"\x19\xa2\xde\x81",
+	.m_size = 20,
+	.c =
+	"\x6a\xdb\x39\xe5\x63\xb3\x25\xde\x58\xca\xc3\xf1\x36\x9c\x0b\x36"
+	"\xb7\xd6\x69\xf9\xba\xa6\x68\x14\x8c\x24\x52\xd3\x25\xa5\xf3\xad"
+	"\xc9\x47\x44\xde\x06\xd8\x0f\x56\xca\x2d\xfb\x0f\xe9\x99\xe2\x9d"
+	"\x8a\xe8\x7f\xfb\x9a\x99\x96\xf1\x2c\x4a\xe4\xc0\xae\x4d\x29\x47"
+	"\x38\x96\x51\x2f\x6d\x8e\xb8\x88\xbd\x1a\x0a\x70\xbc\x23\x38\x67"
+	"\x62\x22\x01\x23\x71\xe5\xbb\x95\xea\x6b\x8d\x31\x62\xbf\xf0\xc4"
+	"\xb9\x46\xd6\x67\xfc\x4c\xe6\x1f\xd6\x5d\xf7\xa9\xad\x3a\xf1\xbf"
+	"\xa2\xf9\x66\xde\xb6\x8e\xec\x8f\x81\x8d\x1e\x3a\x12\x27\x6a\xfc"
+	"\xae\x92\x9f\xc3\x87\xc3\xba\x8d\x04\xb8\x8f\x0f\x61\x68\x9a\x96"
+	"\x2c\x80\x2c\x32\x40\xde\x9d\xb9\x9b\xe2\xe4\x45\x2e\x91\x47\x5c"
+	"\x47\xa4\x9d\x02\x57\x59\xf7\x75\x5d\x5f\x32\x82\x75\x5d\xe5\x78"
+	"\xc9\x19\x61\x46\x06\x9d\xa5\x1d\xd6\x32\x48\x9a\xdb\x09\x29\x81"
+	"\x14\x2e\xf0\x27\xe9\x37\x13\x74\xec\xa5\xcd\x67\x6b\x19\xf6\x88"
+	"\xf0\xc2\x8b\xa8\x7f\x2f\x76\x5a\x3e\x0c\x47\x5d\xe8\x82\x50\x27"
+	"\x40\xce\x27\x41\x45\xa0\xcf\xaa\x2f\xd3\xad\x3c\xbf\x73\xff\x93"
+	"\xe3\x78\x49\xd9\xa9\x78\x22\x81\x9a\xe5\xe2\x94\xe9\x40\xab\xf1",
+	.c_size = 256,
+	.public_key_vec = true,
+	},
+};
+
+/*
  * PKCS#1 RSA test vectors. Obtained from CAVS testing.
  */
 static const struct sig_testvec pkcs1_rsa_tv_template[] = {
-- 
2.43.0



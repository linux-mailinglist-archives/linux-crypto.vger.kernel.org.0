Return-Path: <linux-crypto+bounces-25512-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oq9kJ8C6RGrHzgoAu9opvQ
	(envelope-from <linux-crypto+bounces-25512-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 08:59:12 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9F6EA63E
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 08:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=aJS8K1Y5;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25512-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25512-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404F230B8C9C
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2026 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDED3B2FCC;
	Wed,  1 Jul 2026 06:54:07 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9393B1EFC;
	Wed,  1 Jul 2026 06:54:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888847; cv=none; b=Tvy7IxStOX8tHU7gfSfC8dGVTJAwwvA5NAH03i10D3Ka1HNEx9q6vMveZZbdoK9EJYhgotst7iK3J67wmgPbUsJOpw5u8INgVDZeP53zZb1Pk+IcKpDDWQBmu4S62VtD9O2bJ6am3BTBuzuCcc/YEeut9vP0WBAF9AeUPb0q3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888847; c=relaxed/simple;
	bh=wNg8cg2qHdfGj5T0Y74ZjsGhaBXijUXnaHbfSt1bDFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiNxmDj+sxht6iWtUEvdt2C6xrx4FOmxVHuV7od7AHGKZJrQlDejjT12Be4XKfcyr4Z4XFEv7HpDBFPNUsWDC584LhI0HZ8/+kSwSCv4GYLz/AG3rS4lLMq2V79vPT8t4kmWadIDuwBNvB7zaxzOAhqo8UxUNQVB8wKToANKjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aJS8K1Y5; arc=none smtp.client-ip=52.42.203.116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782888845; x=1814424845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZtDzlUqcNbBUPrtGKQrPKoEzm0mzMrP9wv6Wa1gV0U=;
  b=aJS8K1Y5xdhpehEAj8gmbfuE0xRIICz55yqoLHRwy+hTZiX+U1jCb20/
   stXvORGFwOWBZKzLW6E41/ThT109GWlOvmfVyQ8qcc9gmZRKVAIuBX3Ew
   fiqzu1Vnk5B099jTHsv2NZNlSLNpijacvKO+4rOzrfyTb04WBxjRS6FDA
   vMFwzjXxyN/+1AfamUgpeS26wsEf3wxlgOFwz3Y+WJ+hym0jpdBxOXtZU
   iaYIKJViKuy1MAxUBYIRc3YjST2Af0dI1p0FshcTZJzuaOFA0kNo3AQ2h
   sgVYlIVv5ONPXpQTHip4dOSJQT9qv5yxAdgDL/u9scx+8a3VfQQV3WF0B
   Q==;
X-CSE-ConnectionGUID: 95UrIU7AQGKPBFe9v3jPcA==
X-CSE-MsgGUID: rgVJLOciTemm0B3Way3f6w==
X-IronPort-AV: E=Sophos;i="6.24,235,1774310400"; 
   d="scan'208";a="22848772"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 06:54:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:17636]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.142:2525] with esmtp (Farcaster)
 id 69589b78-9ba7-4d21-b27e-7e4675150263; Wed, 1 Jul 2026 06:54:01 +0000 (UTC)
X-Farcaster-Flow-ID: 69589b78-9ba7-4d21-b27e-7e4675150263
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 1 Jul 2026 06:54:01 +0000
Received: from dev-dsk-lravich-1b-7405803b.eu-west-1.amazon.com (10.13.225.95)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 1 Jul 2026 06:53:59 +0000
From: Leonid Ravich <lravich@amazon.com>
To: <linux-crypto@vger.kernel.org>, <dm-devel@lists.linux.dev>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ebiggers@kernel.org>,
	<snitzer@kernel.org>, <mpatocka@redhat.com>, <axboe@kernel.dk>
Subject: [PATCH v5 5/5] blk-crypto: fallback - batch a segment's data units via dun()
Date: Wed, 1 Jul 2026 06:53:54 +0000
Message-ID: <20260701065354.18928-1-lravich@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630083431.2772-1-lravich@amazon.com>
References: <20260630083431.2772-1-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lravich@amazon.com,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25512-lists,linux-crypto=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ebiggers@kernel.org,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[lravich@amazon.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0D9F6EA63E

blk-crypto-fallback open-codes a per-data-unit loop, issuing one
skcipher request per data unit with the IV walked as a DUN counter.
Allocate dun(<cipher>,le) instead of the bare cipher so a contiguous bio
segment is encrypted/decrypted as one multi-data-unit request, the
crypto layer walking the per-unit IV.  Every blk-crypto mode feeds the
DUN as a little-endian counter, and dun() handles any counter width up
to 32 bytes, so all modes -- including Adiantum (32-byte IV) -- are
wrapped and the open-coded inner per-unit loop is removed from both the
encrypt and decrypt paths.  This makes blk-crypto-fallback a second
consumer of the template (after dm-crypt) and lets a higher-priority
hardware dun(...) driver, if present, handle the request in one pass.

Output is unchanged: the template's little-endian per-unit counter is
exactly blk_crypto_dun_to_iv()/bio_crypt_dun_increment().

Signed-off-by: Leonid Ravich <lravich@amazon.com>
---
 block/Kconfig               |  1 +
 block/blk-crypto-fallback.c | 74 ++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d..0c9025f9b0f6 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -204,6 +204,7 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	depends on BLK_INLINE_ENCRYPTION
 	select CRYPTO
 	select CRYPTO_SKCIPHER
+	select CRYPTO_DUN # batches a segment's data units per crypto request
 	help
 	  Enabling this lets the block layer handle inline encryption
 	  by falling back to the kernel crypto API when inline
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 61f595410832..8337d56ba1dc 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -250,7 +250,6 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	unsigned int nr_enc_pages, enc_idx;
 	struct page **enc_pages;
 	struct bio *enc_bio;
-	unsigned int i;
 
 	skcipher_request_set_callback(ciph_req,
 			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
@@ -260,9 +259,6 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	sg_init_table(&src, 1);
 	sg_init_table(&dst, 1);
 
-	skcipher_request_set_crypt(ciph_req, &src, &dst, data_unit_size,
-				   iv.bytes);
-
 	/*
 	 * Encrypt each page in the source bio.  Because the source bio could
 	 * have bio_vecs that span more than a single page, but the encrypted
@@ -287,29 +283,26 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
 				src_bv.bv_offset);
 
-		sg_set_page(&src, src_bv.bv_page, data_unit_size,
-			    src_bv.bv_offset);
-		sg_set_page(&dst, enc_page, data_unit_size, src_bv.bv_offset);
-
 		/*
 		 * Increment the index now that the encrypted page is added to
 		 * the bio.  This is important for the error unwind path.
 		 */
 		enc_idx++;
 
-		/*
-		 * Encrypt each data unit in this page.
-		 */
-		for (i = 0; i < src_bv.bv_len; i += data_unit_size) {
-			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_skcipher_encrypt(ciph_req)) {
-				enc_bio->bi_status = BLK_STS_IOERR;
-				goto out_free_enc_bio;
-			}
-			bio_crypt_dun_increment(curr_dun, 1);
-			src.offset += data_unit_size;
-			dst.offset += data_unit_size;
+		/* Encrypt the whole segment as one multi-data-unit request. */
+		blk_crypto_dun_to_iv(curr_dun, &iv);
+		sg_set_page(&src, src_bv.bv_page, src_bv.bv_len,
+			    src_bv.bv_offset);
+		sg_set_page(&dst, enc_page, src_bv.bv_len, src_bv.bv_offset);
+		skcipher_request_set_crypt(ciph_req, &src, &dst, src_bv.bv_len,
+					   iv.bytes);
+		skcipher_request_set_data_unit_size(ciph_req, data_unit_size);
+		if (crypto_skcipher_encrypt(ciph_req)) {
+			enc_bio->bi_status = BLK_STS_IOERR;
+			goto out_free_enc_bio;
 		}
+		bio_crypt_dun_increment(curr_dun,
+					src_bv.bv_len / data_unit_size);
 
 		bio_advance_iter_single(src_bio, &src_bio->bi_iter,
 				src_bv.bv_len);
@@ -380,7 +373,6 @@ static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
 	struct scatterlist sg;
 	struct bio_vec bv;
 	const int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
-	unsigned int i;
 
 	skcipher_request_set_callback(ciph_req,
 			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
@@ -388,26 +380,20 @@ static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
 
 	memcpy(curr_dun, bc->bc_dun, sizeof(curr_dun));
 	sg_init_table(&sg, 1);
-	skcipher_request_set_crypt(ciph_req, &sg, &sg, data_unit_size,
-				   iv.bytes);
 
-	/* Decrypt each segment in the bio */
+	/* One dun() request per segment; the crypto layer walks the per-unit DUN. */
 	__bio_for_each_segment(bv, bio, iter, iter) {
-		struct page *page = bv.bv_page;
-
 		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
 			return BLK_STS_INVAL;
 
-		sg_set_page(&sg, page, data_unit_size, bv.bv_offset);
-
-		/* Decrypt each data unit in the segment */
-		for (i = 0; i < bv.bv_len; i += data_unit_size) {
-			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_skcipher_decrypt(ciph_req))
-				return BLK_STS_IOERR;
-			bio_crypt_dun_increment(curr_dun, 1);
-			sg.offset += data_unit_size;
-		}
+		blk_crypto_dun_to_iv(curr_dun, &iv);
+		sg_set_page(&sg, bv.bv_page, bv.bv_len, bv.bv_offset);
+		skcipher_request_set_crypt(ciph_req, &sg, &sg, bv.bv_len,
+					   iv.bytes);
+		skcipher_request_set_data_unit_size(ciph_req, data_unit_size);
+		if (crypto_skcipher_decrypt(ciph_req))
+			return BLK_STS_IOERR;
+		bio_crypt_dun_increment(curr_dun, bv.bv_len / data_unit_size);
 	}
 
 	return BLK_STS_OK;
@@ -621,6 +607,7 @@ static int blk_crypto_fallback_init(void)
 int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 {
 	const char *cipher_str = blk_crypto_modes[mode_num].cipher_str;
+	char dun_str[CRYPTO_MAX_ALG_NAME];
 	struct blk_crypto_fallback_keyslot *slotp;
 	unsigned int i;
 	int err = 0;
@@ -641,15 +628,24 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 	if (err)
 		goto out;
 
+	/*
+	 * Wrap in dun() to handle a whole segment per request (a higher-priority
+	 * hardware dun() wins if present).  The blk-crypto DUN is little-endian.
+	 */
+	if (snprintf(dun_str, sizeof(dun_str), "dun(%s,le)", cipher_str) >=
+	    (int)sizeof(dun_str)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0; i < blk_crypto_num_keyslots; i++) {
 		slotp = &blk_crypto_keyslots[i];
-		slotp->tfms[mode_num] = crypto_alloc_sync_skcipher(cipher_str,
-				0, 0);
+		slotp->tfms[mode_num] = crypto_alloc_sync_skcipher(dun_str, 0, 0);
 		if (IS_ERR(slotp->tfms[mode_num])) {
 			err = PTR_ERR(slotp->tfms[mode_num]);
 			if (err == -ENOENT) {
 				pr_warn_once("Missing crypto API support for \"%s\"\n",
-					     cipher_str);
+					     dun_str);
 				err = -ENOPKG;
 			}
 			slotp->tfms[mode_num] = NULL;
-- 
2.47.3



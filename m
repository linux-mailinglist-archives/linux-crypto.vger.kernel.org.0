Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5B5805A
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF0K2V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:28:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41693 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfF0K2S (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:28:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so1903412wrm.8
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q96/29TdV0TBH+QbXhY2WMZ256VAP+kFBl0pIhaOEg0=;
        b=fDpDUeThFvNCzFhp9NQqgylZHBb5OgbMoozEiZqrhAhU+yXb7B3lZOU7dXAv1SirsS
         X8Ln6R4nWEHMcGoIZMZs4Hij5BQK9BZdzEXPdAkJMzdnzHit/bK4O+dm74jFXxL500Lv
         VjEaUqwiSu+nLJFr4nyHgu6/8VaeYOtQqAigrJAB+WhwmjI84LilxAv0y8O0yIDRrdc4
         PZRbMACRDPOLHXT7hvzpXPBmjUaKAx1W/1D2n7kkwI4PPgUbBBnzvXDtm/NS++1gf8PS
         5a3WVBEkUHL/ACzZNQgbcYsyIGi86Qz3grASlgz+gd0Nl4ei5u05aa3zkJz2wqcnztrK
         5BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q96/29TdV0TBH+QbXhY2WMZ256VAP+kFBl0pIhaOEg0=;
        b=XL52EHYASNQ03gHO78TI8UYMb02zPMrGEgjbQRX+nJe791op4y8ZHXblUxXiaUrYmd
         odqeGHxgI6zUL9zDvUfbgZD/VxlHTN9a5piWCrVgcZ0BKCVSRPEesIB9kz0NugiPpp6J
         7XgCKH7qgIrCzIeVfWLCHXXAxgKKCwh4idkn+azj3sslQ8eQeV84fCUnHKsPk8aWNj9c
         QmVz2E/yxVQ92hrA4P5kCTa7UxGb0B+1WOn+BldKlFqjuyEvJxeFtcbOFTVd8S6PdluX
         OkdMA1RwfOGcZ7MtyRMPQZWaNBIJV9TdyXx9wtc+JQSplksrg6dVM63tkmVffjF+bujT
         fXvQ==
X-Gm-Message-State: APjAAAU1SOaFROjzC789J5IbzktYsJRWlXOgNsdWf1kPKmpLlgZljsJO
        ZhORCuAB83S4zkZ//T5nkEi8y3OWtog=
X-Google-Smtp-Source: APXvYqywSImpKQ/vfKD3wowAE4fGBLdaXf5bH+/d+xCzOLT4+Untk8eaYkCvpw7wNQiO4KzIgEkzyA==
X-Received: by 2002:adf:82e2:: with SMTP id 89mr2753495wrc.33.1561631295611;
        Thu, 27 Jun 2019 03:28:15 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.28.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:28:14 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 23/32] bluetooth: switch to AES library
Date:   Thu, 27 Jun 2019 12:26:38 +0200
Message-Id: <20190627102647.2992-24-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The bluetooth code uses a bare AES cipher for the encryption operations.
Given that it carries out a set_key() operation right before every
encryption operation, this is clearly not a hot path, and so the use of
the cipher interface (which provides the best implementation available
on the system) is not really required.

In fact, when using a cipher like AES-NI or AES-CE, both the set_key()
and the encrypt() operations involve en/disabling preemption as well as
stacking and unstacking the SIMD context, and this is most certainly
not worth it for encrypting 16 bytes of data.

So let's switch to the new lightweight library interface instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 net/bluetooth/Kconfig |   3 +-
 net/bluetooth/smp.c   | 103 ++++++--------------
 2 files changed, 33 insertions(+), 73 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index db82a40875e8..a9d83ec4ee33 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -9,7 +9,8 @@ menuconfig BT
 	select CRC16
 	select CRYPTO
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_AES
+	select CRYPTO_LIB_AES
+	imply CRYPTO_AES
 	select CRYPTO_CMAC
 	select CRYPTO_ECB
 	select CRYPTO_SHA256
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e68c715f8d37..b5045b57ead3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -23,6 +23,7 @@
 #include <linux/debugfs.h>
 #include <linux/scatterlist.h>
 #include <linux/crypto.h>
+#include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/b128ops.h>
 #include <crypto/hash.h>
@@ -88,7 +89,6 @@ struct smp_dev {
 	u8			local_rand[16];
 	bool			debug_key;
 
-	struct crypto_cipher	*tfm_aes;
 	struct crypto_shash	*tfm_cmac;
 	struct crypto_kpp	*tfm_ecdh;
 };
@@ -127,7 +127,6 @@ struct smp_chan {
 	u8			dhkey[32];
 	u8			mackey[16];
 
-	struct crypto_cipher	*tfm_aes;
 	struct crypto_shash	*tfm_cmac;
 	struct crypto_kpp	*tfm_ecdh;
 };
@@ -377,22 +376,18 @@ static int smp_h7(struct crypto_shash *tfm_cmac, const u8 w[16],
  * s1 and ah.
  */
 
-static int smp_e(struct crypto_cipher *tfm, const u8 *k, u8 *r)
+static int smp_e(const u8 *k, u8 *r)
 {
+	struct crypto_aes_ctx ctx;
 	uint8_t tmp[16], data[16];
 	int err;
 
 	SMP_DBG("k %16phN r %16phN", k, r);
 
-	if (!tfm) {
-		BT_ERR("tfm %p", tfm);
-		return -EINVAL;
-	}
-
 	/* The most significant octet of key corresponds to k[0] */
 	swap_buf(k, tmp, 16);
 
-	err = crypto_cipher_setkey(tfm, tmp, 16);
+	err = aes_expandkey(&ctx, tmp, 16);
 	if (err) {
 		BT_ERR("cipher setkey failed: %d", err);
 		return err;
@@ -401,17 +396,18 @@ static int smp_e(struct crypto_cipher *tfm, const u8 *k, u8 *r)
 	/* Most significant octet of plaintextData corresponds to data[0] */
 	swap_buf(r, data, 16);
 
-	crypto_cipher_encrypt_one(tfm, data, data);
+	aes_encrypt(&ctx, data, data);
 
 	/* Most significant octet of encryptedData corresponds to data[0] */
 	swap_buf(data, r, 16);
 
 	SMP_DBG("r %16phN", r);
 
+	memzero_explicit(&ctx, sizeof (ctx));
 	return err;
 }
 
-static int smp_c1(struct crypto_cipher *tfm_aes, const u8 k[16],
+static int smp_c1(const u8 k[16],
 		  const u8 r[16], const u8 preq[7], const u8 pres[7], u8 _iat,
 		  const bdaddr_t *ia, u8 _rat, const bdaddr_t *ra, u8 res[16])
 {
@@ -436,7 +432,7 @@ static int smp_c1(struct crypto_cipher *tfm_aes, const u8 k[16],
 	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
 
 	/* res = e(k, res) */
-	err = smp_e(tfm_aes, k, res);
+	err = smp_e(k, res);
 	if (err) {
 		BT_ERR("Encrypt data error");
 		return err;
@@ -453,14 +449,14 @@ static int smp_c1(struct crypto_cipher *tfm_aes, const u8 k[16],
 	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
 
 	/* res = e(k, res) */
-	err = smp_e(tfm_aes, k, res);
+	err = smp_e(k, res);
 	if (err)
 		BT_ERR("Encrypt data error");
 
 	return err;
 }
 
-static int smp_s1(struct crypto_cipher *tfm_aes, const u8 k[16],
+static int smp_s1(const u8 k[16],
 		  const u8 r1[16], const u8 r2[16], u8 _r[16])
 {
 	int err;
@@ -469,15 +465,14 @@ static int smp_s1(struct crypto_cipher *tfm_aes, const u8 k[16],
 	memcpy(_r, r2, 8);
 	memcpy(_r + 8, r1, 8);
 
-	err = smp_e(tfm_aes, k, _r);
+	err = smp_e(k, _r);
 	if (err)
 		BT_ERR("Encrypt data error");
 
 	return err;
 }
 
-static int smp_ah(struct crypto_cipher *tfm, const u8 irk[16],
-		  const u8 r[3], u8 res[3])
+static int smp_ah(const u8 irk[16], const u8 r[3], u8 res[3])
 {
 	u8 _res[16];
 	int err;
@@ -486,7 +481,7 @@ static int smp_ah(struct crypto_cipher *tfm, const u8 irk[16],
 	memcpy(_res, r, 3);
 	memset(_res + 3, 0, 13);
 
-	err = smp_e(tfm, irk, _res);
+	err = smp_e(irk, _res);
 	if (err) {
 		BT_ERR("Encrypt error");
 		return err;
@@ -518,7 +513,7 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 
 	BT_DBG("RPA %pMR IRK %*phN", bdaddr, 16, irk);
 
-	err = smp_ah(smp->tfm_aes, irk, &bdaddr->b[3], hash);
+	err = smp_ah(irk, &bdaddr->b[3], hash);
 	if (err)
 		return false;
 
@@ -541,7 +536,7 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 	rpa->b[5] &= 0x3f;	/* Clear two most significant bits */
 	rpa->b[5] |= 0x40;	/* Set second most significant bit */
 
-	err = smp_ah(smp->tfm_aes, irk, &rpa->b[3], rpa->b);
+	err = smp_ah(irk, &rpa->b[3], rpa->b);
 	if (err < 0)
 		return err;
 
@@ -768,7 +763,6 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	kzfree(smp->slave_csrk);
 	kzfree(smp->link_key);
 
-	crypto_free_cipher(smp->tfm_aes);
 	crypto_free_shash(smp->tfm_cmac);
 	crypto_free_kpp(smp->tfm_ecdh);
 
@@ -957,7 +951,7 @@ static u8 smp_confirm(struct smp_chan *smp)
 
 	BT_DBG("conn %p", conn);
 
-	ret = smp_c1(smp->tfm_aes, smp->tk, smp->prnd, smp->preq, smp->prsp,
+	ret = smp_c1(smp->tk, smp->prnd, smp->preq, smp->prsp,
 		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
 		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr,
 		     cp.confirm_val);
@@ -983,12 +977,9 @@ static u8 smp_random(struct smp_chan *smp)
 	u8 confirm[16];
 	int ret;
 
-	if (IS_ERR_OR_NULL(smp->tfm_aes))
-		return SMP_UNSPECIFIED;
-
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
-	ret = smp_c1(smp->tfm_aes, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+	ret = smp_c1(smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
 		     hcon->resp_addr_type, &hcon->resp_addr, confirm);
 	if (ret)
@@ -1005,7 +996,7 @@ static u8 smp_random(struct smp_chan *smp)
 		__le64 rand = 0;
 		__le16 ediv = 0;
 
-		smp_s1(smp->tfm_aes, smp->tk, smp->rrnd, smp->prnd, stk);
+		smp_s1(smp->tk, smp->rrnd, smp->prnd, stk);
 
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
 			return SMP_UNSPECIFIED;
@@ -1021,7 +1012,7 @@ static u8 smp_random(struct smp_chan *smp)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 
-		smp_s1(smp->tfm_aes, smp->tk, smp->prnd, smp->rrnd, stk);
+		smp_s1(smp->tk, smp->prnd, smp->rrnd, stk);
 
 		if (hcon->pending_sec_level == BT_SECURITY_HIGH)
 			auth = 1;
@@ -1389,16 +1380,10 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	if (!smp)
 		return NULL;
 
-	smp->tfm_aes = crypto_alloc_cipher("aes", 0, 0);
-	if (IS_ERR(smp->tfm_aes)) {
-		BT_ERR("Unable to create AES crypto context");
-		goto zfree_smp;
-	}
-
 	smp->tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(smp->tfm_cmac)) {
 		BT_ERR("Unable to create CMAC crypto context");
-		goto free_cipher;
+		goto zfree_smp;
 	}
 
 	smp->tfm_ecdh = crypto_alloc_kpp("ecdh", CRYPTO_ALG_INTERNAL, 0);
@@ -1420,8 +1405,6 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 free_shash:
 	crypto_free_shash(smp->tfm_cmac);
-free_cipher:
-	crypto_free_cipher(smp->tfm_aes);
 zfree_smp:
 	kzfree(smp);
 	return NULL;
@@ -3219,7 +3202,6 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 {
 	struct l2cap_chan *chan;
 	struct smp_dev *smp;
-	struct crypto_cipher *tfm_aes;
 	struct crypto_shash *tfm_cmac;
 	struct crypto_kpp *tfm_ecdh;
 
@@ -3232,17 +3214,9 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 	if (!smp)
 		return ERR_PTR(-ENOMEM);
 
-	tfm_aes = crypto_alloc_cipher("aes", 0, 0);
-	if (IS_ERR(tfm_aes)) {
-		BT_ERR("Unable to create AES crypto context");
-		kzfree(smp);
-		return ERR_CAST(tfm_aes);
-	}
-
 	tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(tfm_cmac)) {
 		BT_ERR("Unable to create CMAC crypto context");
-		crypto_free_cipher(tfm_aes);
 		kzfree(smp);
 		return ERR_CAST(tfm_cmac);
 	}
@@ -3251,13 +3225,11 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 	if (IS_ERR(tfm_ecdh)) {
 		BT_ERR("Unable to create ECDH crypto context");
 		crypto_free_shash(tfm_cmac);
-		crypto_free_cipher(tfm_aes);
 		kzfree(smp);
 		return ERR_CAST(tfm_ecdh);
 	}
 
 	smp->local_oob = false;
-	smp->tfm_aes = tfm_aes;
 	smp->tfm_cmac = tfm_cmac;
 	smp->tfm_ecdh = tfm_ecdh;
 
@@ -3265,7 +3237,6 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 	chan = l2cap_chan_create();
 	if (!chan) {
 		if (smp) {
-			crypto_free_cipher(smp->tfm_aes);
 			crypto_free_shash(smp->tfm_cmac);
 			crypto_free_kpp(smp->tfm_ecdh);
 			kzfree(smp);
@@ -3313,7 +3284,6 @@ static void smp_del_chan(struct l2cap_chan *chan)
 	smp = chan->data;
 	if (smp) {
 		chan->data = NULL;
-		crypto_free_cipher(smp->tfm_aes);
 		crypto_free_shash(smp->tfm_cmac);
 		crypto_free_kpp(smp->tfm_ecdh);
 		kzfree(smp);
@@ -3569,7 +3539,7 @@ static int __init test_debug_key(struct crypto_kpp *tfm_ecdh)
 	return 0;
 }
 
-static int __init test_ah(struct crypto_cipher *tfm_aes)
+static int __init test_ah(void)
 {
 	const u8 irk[16] = {
 			0x9b, 0x7d, 0x39, 0x0a, 0xa6, 0x10, 0x10, 0x34,
@@ -3579,7 +3549,7 @@ static int __init test_ah(struct crypto_cipher *tfm_aes)
 	u8 res[3];
 	int err;
 
-	err = smp_ah(tfm_aes, irk, r, res);
+	err = smp_ah(irk, r, res);
 	if (err)
 		return err;
 
@@ -3589,7 +3559,7 @@ static int __init test_ah(struct crypto_cipher *tfm_aes)
 	return 0;
 }
 
-static int __init test_c1(struct crypto_cipher *tfm_aes)
+static int __init test_c1(void)
 {
 	const u8 k[16] = {
 			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -3609,7 +3579,7 @@ static int __init test_c1(struct crypto_cipher *tfm_aes)
 	u8 res[16];
 	int err;
 
-	err = smp_c1(tfm_aes, k, r, preq, pres, _iat, &ia, _rat, &ra, res);
+	err = smp_c1(k, r, preq, pres, _iat, &ia, _rat, &ra, res);
 	if (err)
 		return err;
 
@@ -3619,7 +3589,7 @@ static int __init test_c1(struct crypto_cipher *tfm_aes)
 	return 0;
 }
 
-static int __init test_s1(struct crypto_cipher *tfm_aes)
+static int __init test_s1(void)
 {
 	const u8 k[16] = {
 			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -3634,7 +3604,7 @@ static int __init test_s1(struct crypto_cipher *tfm_aes)
 	u8 res[16];
 	int err;
 
-	err = smp_s1(tfm_aes, k, r1, r2, res);
+	err = smp_s1(k, r1, r2, res);
 	if (err)
 		return err;
 
@@ -3815,8 +3785,7 @@ static const struct file_operations test_smp_fops = {
 	.llseek		= default_llseek,
 };
 
-static int __init run_selftests(struct crypto_cipher *tfm_aes,
-				struct crypto_shash *tfm_cmac,
+static int __init run_selftests(struct crypto_shash *tfm_cmac,
 				struct crypto_kpp *tfm_ecdh)
 {
 	ktime_t calltime, delta, rettime;
@@ -3831,19 +3800,19 @@ static int __init run_selftests(struct crypto_cipher *tfm_aes,
 		goto done;
 	}
 
-	err = test_ah(tfm_aes);
+	err = test_ah();
 	if (err) {
 		BT_ERR("smp_ah test failed");
 		goto done;
 	}
 
-	err = test_c1(tfm_aes);
+	err = test_c1();
 	if (err) {
 		BT_ERR("smp_c1 test failed");
 		goto done;
 	}
 
-	err = test_s1(tfm_aes);
+	err = test_s1();
 	if (err) {
 		BT_ERR("smp_s1 test failed");
 		goto done;
@@ -3900,21 +3869,13 @@ static int __init run_selftests(struct crypto_cipher *tfm_aes,
 
 int __init bt_selftest_smp(void)
 {
-	struct crypto_cipher *tfm_aes;
 	struct crypto_shash *tfm_cmac;
 	struct crypto_kpp *tfm_ecdh;
 	int err;
 
-	tfm_aes = crypto_alloc_cipher("aes", 0, 0);
-	if (IS_ERR(tfm_aes)) {
-		BT_ERR("Unable to create AES crypto context");
-		return PTR_ERR(tfm_aes);
-	}
-
 	tfm_cmac = crypto_alloc_shash("cmac(aes)", 0, 0);
 	if (IS_ERR(tfm_cmac)) {
 		BT_ERR("Unable to create CMAC crypto context");
-		crypto_free_cipher(tfm_aes);
 		return PTR_ERR(tfm_cmac);
 	}
 
@@ -3922,14 +3883,12 @@ int __init bt_selftest_smp(void)
 	if (IS_ERR(tfm_ecdh)) {
 		BT_ERR("Unable to create ECDH crypto context");
 		crypto_free_shash(tfm_cmac);
-		crypto_free_cipher(tfm_aes);
 		return PTR_ERR(tfm_ecdh);
 	}
 
-	err = run_selftests(tfm_aes, tfm_cmac, tfm_ecdh);
+	err = run_selftests(tfm_cmac, tfm_ecdh);
 
 	crypto_free_shash(tfm_cmac);
-	crypto_free_cipher(tfm_aes);
 	crypto_free_kpp(tfm_ecdh);
 
 	return err;
-- 
2.20.1


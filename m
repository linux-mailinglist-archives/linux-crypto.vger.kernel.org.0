Return-Path: <linux-crypto+bounces-658-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B87480B29F
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Dec 2023 08:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99A31F21344
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Dec 2023 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5D1FBE;
	Sat,  9 Dec 2023 07:05:41 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D810E7;
	Fri,  8 Dec 2023 23:05:36 -0800 (PST)
Received: from dggpemd200003.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SnJtG2T2Sz14LyK;
	Sat,  9 Dec 2023 15:05:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 9 Dec 2023 15:05:13 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<shenyang39@huawei.com>, <liulongfang@huawei.com>, <qianweili@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/sec2 - optimize the error return process
Date: Sat, 9 Dec 2023 15:01:35 +0800
Message-ID: <20231209070135.555110-3-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231209070135.555110-1-huangchenghai2@huawei.com>
References: <20231209070135.555110-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd200003.china.huawei.com (7.185.36.122)
X-CFilter-Loop: Reflected

Add the printf of an error message and optimized the handling
process of ret.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index c760f3a8af4d..f028dcfd0ead 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -850,6 +850,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		ret = sec_skcipher_aes_sm4_setkey(c_ctx, keylen, c_mode);
 		break;
 	default:
+		dev_err(dev, "sec c_alg err!\n");
 		return -EINVAL;
 	}
 
@@ -1172,7 +1173,8 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		return 0;
 	}
 
-	if (crypto_authenc_extractkeys(&keys, key, keylen))
+	ret = crypto_authenc_extractkeys(&keys, key, keylen);
+	if (ret)
 		goto bad_key;
 
 	ret = sec_aead_aes_set_key(c_ctx, &keys);
@@ -1189,6 +1191,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 	if ((ctx->a_ctx.mac_len & SEC_SQE_LEN_RATE_MASK)  ||
 	    (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK)) {
+		ret = -EINVAL;
 		dev_err(dev, "MAC or AUTH key length error!\n");
 		goto bad_key;
 	}
@@ -1197,7 +1200,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 bad_key:
 	memzero_explicit(&keys, sizeof(struct crypto_authenc_keys));
-	return -EINVAL;
+	return ret;
 }
 
 
-- 
2.30.0



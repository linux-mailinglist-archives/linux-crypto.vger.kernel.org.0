Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13301181190
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Mar 2020 08:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCKHPM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Mar 2020 03:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHPM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Mar 2020 03:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33988AC51;
        Wed, 11 Mar 2020 07:15:09 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: bcm: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:15:06 +0100
Message-Id: <20200311071506.4417-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/crypto/bcm/util.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/bcm/util.c b/drivers/crypto/bcm/util.c
index cd7504101acd..2b304fc78059 100644
--- a/drivers/crypto/bcm/util.c
+++ b/drivers/crypto/bcm/util.c
@@ -366,88 +366,88 @@ static ssize_t spu_debugfs_read(struct file *filp, char __user *ubuf,
 
 	ipriv = filp->private_data;
 	out_offset = 0;
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Number of SPUs.........%u\n",
 			       ipriv->spu.num_spu);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Current sessions.......%u\n",
 			       atomic_read(&ipriv->session_count));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Session count..........%u\n",
 			       atomic_read(&ipriv->stream_count));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Cipher setkey..........%u\n",
 			       atomic_read(&ipriv->setkey_cnt[SPU_OP_CIPHER]));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Cipher Ops.............%u\n",
 			       atomic_read(&ipriv->op_counts[SPU_OP_CIPHER]));
 	for (alg = 0; alg < CIPHER_ALG_LAST; alg++) {
 		for (mode = 0; mode < CIPHER_MODE_LAST; mode++) {
 			op_cnt = atomic_read(&ipriv->cipher_cnt[alg][mode]);
 			if (op_cnt) {
-				out_offset += snprintf(buf + out_offset,
+				out_offset += scnprintf(buf + out_offset,
 						       out_count - out_offset,
 			       "  %-13s%11u\n",
 			       spu_alg_name(alg, mode), op_cnt);
 			}
 		}
 	}
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Hash Ops...............%u\n",
 			       atomic_read(&ipriv->op_counts[SPU_OP_HASH]));
 	for (alg = 0; alg < HASH_ALG_LAST; alg++) {
 		op_cnt = atomic_read(&ipriv->hash_cnt[alg]);
 		if (op_cnt) {
-			out_offset += snprintf(buf + out_offset,
+			out_offset += scnprintf(buf + out_offset,
 					       out_count - out_offset,
 		       "  %-13s%11u\n",
 		       hash_alg_name[alg], op_cnt);
 		}
 	}
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "HMAC setkey............%u\n",
 			       atomic_read(&ipriv->setkey_cnt[SPU_OP_HMAC]));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "HMAC Ops...............%u\n",
 			       atomic_read(&ipriv->op_counts[SPU_OP_HMAC]));
 	for (alg = 0; alg < HASH_ALG_LAST; alg++) {
 		op_cnt = atomic_read(&ipriv->hmac_cnt[alg]);
 		if (op_cnt) {
-			out_offset += snprintf(buf + out_offset,
+			out_offset += scnprintf(buf + out_offset,
 					       out_count - out_offset,
 		       "  %-13s%11u\n",
 		       hash_alg_name[alg], op_cnt);
 		}
 	}
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "AEAD setkey............%u\n",
 			       atomic_read(&ipriv->setkey_cnt[SPU_OP_AEAD]));
 
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "AEAD Ops...............%u\n",
 			       atomic_read(&ipriv->op_counts[SPU_OP_AEAD]));
 	for (alg = 0; alg < AEAD_TYPE_LAST; alg++) {
 		op_cnt = atomic_read(&ipriv->aead_cnt[alg]);
 		if (op_cnt) {
-			out_offset += snprintf(buf + out_offset,
+			out_offset += scnprintf(buf + out_offset,
 					       out_count - out_offset,
 		       "  %-13s%11u\n",
 		       aead_alg_name[alg], op_cnt);
 		}
 	}
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Bytes of req data......%llu\n",
 			       (u64)atomic64_read(&ipriv->bytes_out));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Bytes of resp data.....%llu\n",
 			       (u64)atomic64_read(&ipriv->bytes_in));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Mailbox full...........%u\n",
 			       atomic_read(&ipriv->mb_no_spc));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Mailbox send failures..%u\n",
 			       atomic_read(&ipriv->mb_send_fail));
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Check ICV errors.......%u\n",
 			       atomic_read(&ipriv->bad_icv));
 	if (ipriv->spu.spu_type == SPU_TYPE_SPUM)
@@ -455,7 +455,7 @@ static ssize_t spu_debugfs_read(struct file *filp, char __user *ubuf,
 			spu_ofifo_ctrl = ioread32(ipriv->spu.reg_vbase[i] +
 						  SPU_OFIFO_CTRL);
 			fifo_len = spu_ofifo_ctrl & SPU_FIFO_WATERMARK;
-			out_offset += snprintf(buf + out_offset,
+			out_offset += scnprintf(buf + out_offset,
 					       out_count - out_offset,
 				       "SPU %d output FIFO high water.....%u\n",
 				       i, fifo_len);
-- 
2.16.4


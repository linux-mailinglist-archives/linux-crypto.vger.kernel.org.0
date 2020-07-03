Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36553213312
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2020 06:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgGCEq4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Jul 2020 00:46:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40186 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCEqz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Jul 2020 00:46:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jrDbA-0007zr-9s; Fri, 03 Jul 2020 14:46:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2020 14:46:52 +1000
Date:   Fri, 3 Jul 2020 14:46:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: ccp - Fix sparse warnings
Message-ID: <20200703044652.GA23139@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a number of endianness marking issues in the ccp
driver.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/ccp/ccp-dev-v5.c b/drivers/crypto/ccp/ccp-dev-v5.c
index 82ac4c14c04c..7838f63bab32 100644
--- a/drivers/crypto/ccp/ccp-dev-v5.c
+++ b/drivers/crypto/ccp/ccp-dev-v5.c
@@ -221,8 +221,8 @@ static unsigned int ccp5_get_free_slots(struct ccp_cmd_queue *cmd_q)
 static int ccp5_do_cmd(struct ccp5_desc *desc,
 		       struct ccp_cmd_queue *cmd_q)
 {
-	u32 *mP;
-	__le32 *dP;
+	__le32 *mP;
+	u32 *dP;
 	u32 tail;
 	int	i;
 	int ret = 0;
@@ -235,8 +235,8 @@ static int ccp5_do_cmd(struct ccp5_desc *desc,
 	}
 	mutex_lock(&cmd_q->q_mutex);
 
-	mP = (u32 *) &cmd_q->qbase[cmd_q->qidx];
-	dP = (__le32 *) desc;
+	mP = (__le32 *)&cmd_q->qbase[cmd_q->qidx];
+	dP = (u32 *)desc;
 	for (i = 0; i < 8; i++)
 		mP[i] = cpu_to_le32(dP[i]); /* handle endianness */
 
diff --git a/drivers/crypto/ccp/ccp-dev.h b/drivers/crypto/ccp/ccp-dev.h
index 87a34d91fdf7..a5d9123a22ea 100644
--- a/drivers/crypto/ccp/ccp-dev.h
+++ b/drivers/crypto/ccp/ccp-dev.h
@@ -597,8 +597,8 @@ struct dword3 {
 };
 
 union dword4 {
-	__le32 dst_lo;		/* NON-SHA	*/
-	__le32 sha_len_lo;	/* SHA		*/
+	u32 dst_lo;		/* NON-SHA	*/
+	u32 sha_len_lo;		/* SHA		*/
 };
 
 union dword5 {
@@ -608,7 +608,7 @@ union dword5 {
 		unsigned int  rsvd1:13;
 		unsigned int  fixed:1;
 	} fields;
-	__le32 sha_len_hi;
+	u32 sha_len_hi;
 };
 
 struct dword7 {
@@ -619,12 +619,12 @@ struct dword7 {
 
 struct ccp5_desc {
 	struct dword0 dw0;
-	__le32 length;
-	__le32 src_lo;
+	u32 length;
+	u32 src_lo;
 	struct dword3 dw3;
 	union dword4 dw4;
 	union dword5 dw5;
-	__le32 key_lo;
+	u32 key_lo;
 	struct dword7 dw7;
 };
 
diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index a06d20263efa..bd270e66185e 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -632,13 +632,12 @@ ccp_run_aes_gcm_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	struct ccp_data src, dst;
 	struct ccp_data aad;
 	struct ccp_op op;
-
-	unsigned long long *final;
 	unsigned int dm_offset;
 	unsigned int authsize;
 	unsigned int jobid;
 	unsigned int ilen;
 	bool in_place = true; /* Default value */
+	__be64 *final;
 	int ret;
 
 	struct scatterlist *p_inp, sg_inp[2];
@@ -840,7 +839,7 @@ ccp_run_aes_gcm_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 				   DMA_BIDIRECTIONAL);
 	if (ret)
 		goto e_dst;
-	final = (unsigned long long *) final_wa.address;
+	final = (__be64 *)final_wa.address;
 	final[0] = cpu_to_be64(aes->aad_len * 8);
 	final[1] = cpu_to_be64(ilen * 8);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

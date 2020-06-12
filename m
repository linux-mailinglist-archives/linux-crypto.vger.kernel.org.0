Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F01F73F8
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 08:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFLGlb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 02:41:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38900 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgFLGlb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 02:41:31 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjdNV-0000kC-A5; Fri, 12 Jun 2020 16:41:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 16:41:25 +1000
Date:   Fri, 12 Jun 2020 16:41:25 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>
Subject: [PATCH] crypto: octeontx - Fix sparse warnings
Message-ID: <20200612064125.GA12572@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes all the sparse warnings in the octeontx driver.
Some of these are just trivial type changes.

However, some of the changes are non-trivial on little-endian hosts.
Obviously the driver appears to be broken on either LE or BE as it
was doing different things.  I've taken the BE behaviour as the
correct one.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 1e0a1d70ebd3..01bf4826c03e 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -239,7 +239,6 @@ static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
 	struct otx_cpt_fc_ctx *fctx = &rctx->fctx;
 	int ivsize = crypto_skcipher_ivsize(stfm);
 	u32 start = req->cryptlen - ivsize;
-	u64 *ctrl_flags = NULL;
 	gfp_t flags;
 
 	flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
@@ -280,8 +279,7 @@ static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
 
 	memcpy(fctx->enc.encr_iv, req->iv, crypto_skcipher_ivsize(stfm));
 
-	ctrl_flags = (u64 *)&fctx->enc.enc_ctrl.flags;
-	*ctrl_flags = cpu_to_be64(*ctrl_flags);
+	fctx->enc.enc_ctrl.flags = cpu_to_be64(fctx->enc.enc_ctrl.cflags);
 
 	/*
 	 * Storing  Packet Data Information in offset
@@ -692,20 +690,17 @@ static struct otx_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg)
 
 static inline void swap_data32(void *buf, u32 len)
 {
-	u32 *store = (u32 *) buf;
-	int i = 0;
-
-	for (i = 0 ; i < len/sizeof(u32); i++, store++)
-		*store = cpu_to_be32(*store);
+	cpu_to_be32_array(buf, buf, len / 4);
 }
 
 static inline void swap_data64(void *buf, u32 len)
 {
-	u64 *store = (u64 *) buf;
+	__be64 *dst = buf;
+	u64 *src = buf;
 	int i = 0;
 
-	for (i = 0 ; i < len/sizeof(u64); i++, store++)
-		*store = cpu_to_be64(*store);
+	for (i = 0 ; i < len / 8; i++, src++, dst++)
+		*dst = cpu_to_be64p(src);
 }
 
 static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
@@ -1012,7 +1007,7 @@ static inline u32 create_aead_ctx_hdr(struct aead_request *req, u32 enc,
 		/* Unknown cipher type */
 		return -EINVAL;
 	}
-	rctx->ctrl_word.flags = cpu_to_be64(rctx->ctrl_word.flags);
+	rctx->ctrl_word.flags = cpu_to_be64(rctx->ctrl_word.cflags);
 
 	req_info->ctrl.s.dma_mode = OTX_CPT_DMA_GATHER_SCATTER;
 	req_info->ctrl.s.se_req = OTX_CPT_SE_CORE_REQ;
@@ -1032,7 +1027,7 @@ static inline u32 create_aead_ctx_hdr(struct aead_request *req, u32 enc,
 	fctx->enc.enc_ctrl.e.aes_key = ctx->key_type;
 	fctx->enc.enc_ctrl.e.mac_type = ctx->mac_type;
 	fctx->enc.enc_ctrl.e.mac_len = mac_len;
-	fctx->enc.enc_ctrl.flags = cpu_to_be64(fctx->enc.enc_ctrl.flags);
+	fctx->enc.enc_ctrl.flags = cpu_to_be64(fctx->enc.enc_ctrl.cflags);
 
 	/*
 	 * Storing Packet Data Information in offset
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h
index 67cc0025f5d5..4181b5c5c356 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h
@@ -66,7 +66,8 @@ enum otx_cpt_aes_key_len {
 };
 
 union otx_cpt_encr_ctrl {
-	u64 flags;
+	__be64 flags;
+	u64 cflags;
 	struct {
 #if defined(__BIG_ENDIAN_BITFIELD)
 		u64 enc_cipher:4;
@@ -138,7 +139,8 @@ struct otx_cpt_des3_ctx {
 };
 
 union otx_cpt_offset_ctrl_word {
-	u64 flags;
+	__be64 flags;
+	u64 cflags;
 	struct {
 #if defined(__BIG_ENDIAN_BITFIELD)
 		u64 reserved:32;
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
index 239195cccf93..cbc3d7869ebe 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
@@ -202,11 +202,10 @@ static inline int setup_sgio_list(struct pci_dev *pdev,
 	info->dlen = dlen;
 	info->in_buffer = (u8 *)info + info_len;
 
-	((u16 *)info->in_buffer)[0] = req->outcnt;
-	((u16 *)info->in_buffer)[1] = req->incnt;
+	((__be16 *)info->in_buffer)[0] = cpu_to_be16(req->outcnt);
+	((__be16 *)info->in_buffer)[1] = cpu_to_be16(req->incnt);
 	((u16 *)info->in_buffer)[2] = 0;
 	((u16 *)info->in_buffer)[3] = 0;
-	*(u64 *)info->in_buffer = cpu_to_be64p((u64 *)info->in_buffer);
 
 	/* Setup gather (input) components */
 	if (setup_sgio_components(pdev, req->in, req->incnt,
@@ -367,8 +366,6 @@ static int process_request(struct pci_dev *pdev, struct otx_cpt_req_info *req,
 	iq_cmd.cmd.s.param2 = cpu_to_be16(cpt_req->param2);
 	iq_cmd.cmd.s.dlen   = cpu_to_be16(cpt_req->dlen);
 
-	/* 64-bit swap for microcode data reads, not needed for addresses*/
-	iq_cmd.cmd.u64 = cpu_to_be64(iq_cmd.cmd.u64);
 	iq_cmd.dptr = info->dptr_baddr;
 	iq_cmd.rptr = info->rptr_baddr;
 	iq_cmd.cptr.u64 = 0;
@@ -436,7 +433,7 @@ static int cpt_process_ccode(struct pci_dev *pdev,
 	u8 ccode = cpt_status->s.compcode;
 	union otx_cpt_error_code ecode;
 
-	ecode.u = be64_to_cpu(*((u64 *) cpt_info->out_buffer));
+	ecode.u = be64_to_cpup((__be64 *)cpt_info->out_buffer);
 	switch (ccode) {
 	case CPT_COMP_E_FAULT:
 		dev_err(&pdev->dev,
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h
index a4c9ff730b13..d912fe0c532d 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h
@@ -92,10 +92,10 @@ union otx_cpt_ctrl_info {
 union otx_cpt_iq_cmd_word0 {
 	u64 u64;
 	struct {
-		u16 opcode;
-		u16 param1;
-		u16 param2;
-		u16 dlen;
+		__be16 opcode;
+		__be16 param1;
+		__be16 param2;
+		__be16 dlen;
 	} s;
 };
 
@@ -123,16 +123,16 @@ struct otx_cpt_sglist_component {
 	union {
 		u64 len;
 		struct {
-			u16 len0;
-			u16 len1;
-			u16 len2;
-			u16 len3;
+			__be16 len0;
+			__be16 len1;
+			__be16 len2;
+			__be16 len3;
 		} s;
 	} u;
-	u64 ptr0;
-	u64 ptr1;
-	u64 ptr2;
-	u64 ptr3;
+	__be64 ptr0;
+	__be64 ptr1;
+	__be64 ptr2;
+	__be64 ptr3;
 };
 
 struct otx_cpt_pending_entry {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

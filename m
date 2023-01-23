Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04767795F
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Jan 2023 11:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAWKmu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Jan 2023 05:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjAWKmt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Jan 2023 05:42:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C8E3C29
        for <linux-crypto@vger.kernel.org>; Mon, 23 Jan 2023 02:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674470567; x=1706006567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8lJU0hCkk48fTfG/VEoD4Mn9h/k97y1cQVBvCm8HXQ=;
  b=mMZpBnS2WmjeIx+CJuSC9oG9RVggAiRdUX+TW7Xf2u9MXx3fKIY4mNyU
   E676nF36yunK3pWOyL7wzcfL8xwHUTGiGNCO6B3+5ZpqbBLn12hQfzYNm
   tV45yBh/PXPND55KfqP/eAhS98WI0QAH6ScXDFl1xmrWDMbVGCzU0zBSi
   aGg3zjc/6A/UavqLqNvjrCvxn9pwp/xonh5M3rPPCzGa+1GIvo0lQVg8h
   j6anDovCvEjp1ajnhIhEm3/iDMYZpvtJzCRwUIpFlAE7CDtYDNd0gBfZd
   nov9kCtjltwlLzuup+xVr0+6yIP77QvZKNwel5w2ZQKEARCQJ4fMhCFBc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="324695543"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="324695543"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 02:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="990361899"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="990361899"
Received: from sdpcloudhostegs034.jf.intel.com ([10.165.126.39])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jan 2023 02:42:47 -0800
From:   Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 2/2] crypto: qat - add qat_zlib_deflate
Date:   Mon, 23 Jan 2023 11:42:22 +0100
Message-Id: <20230123104222.131643-2-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230123104222.131643-1-lucas.segarra.fernandez@intel.com>
References: <20230123104222.131643-1-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The ZLIB format (RFC 1950) is made of deflate compressed data surrounded
by a header and a footer. The QAT accelerators support only the deflate
algorithm, therefore the header and the footer need to be inserted in
software.

This adds logic in the QAT driver to support the ZLIB format. In
particular:
  * Generalize the function qat_comp_alg_compress_decompress() to allow
    skipping an initial region (header) of the source and/or destination
    scatter lists.
  * Add logic to register the qat_zlib_deflate algorithm into the acomp
    framework.
  * For ZLIB compression, skip the initial portion of the destination
    buffer before sending the job to the QAT accelerator and insert the
    ZLIB header and footer in the callback, after the QAT request has
    been processed.
  * For ZLIB decompression, parse the header in the input buffer
    provided by the user and verify its validity before attempting the
    decompression of the buffer with QAT. Then submit the buffer to QAT
    for decompression. In the callback verify the correctness of the
    footer by comparing the value of the ADLER produced by QAT with the
    one in the destination buffer.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/qat_comp_algs.c | 166 ++++++++++++++++--
 1 file changed, 154 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_comp_algs.c b/drivers/crypto/qat/qat_common/qat_comp_algs.c
index 12d5e0fc3a95..8e54158c11f9 100644
--- a/drivers/crypto/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_comp_algs.c
@@ -13,6 +13,15 @@
 #include "qat_compression.h"
 #include "qat_algs_send.h"
 
+#define QAT_RFC_1950_HDR_SIZE 2
+#define QAT_RFC_1950_FOOTER_SIZE 4
+#define QAT_RFC_1950_CM_DEFLATE 8
+#define QAT_RFC_1950_CM_DEFLATE_CINFO_32K 7
+#define QAT_RFC_1950_CM_MASK 0x0f
+#define QAT_RFC_1950_CM_OFFSET 4
+#define QAT_RFC_1950_DICT_MASK 0x20
+#define QAT_RFC_1950_COMP_HDR 0x785e
+
 static DEFINE_MUTEX(algs_lock);
 static unsigned int active_devs;
 
@@ -21,9 +30,12 @@ enum direction {
 	COMPRESSION = 1,
 };
 
+struct qat_compression_req;
+
 struct qat_compression_ctx {
 	u8 comp_ctx[QAT_COMP_CTX_SIZE];
 	struct qat_compression_instance *inst;
+	int (*qat_comp_callback)(struct qat_compression_req *qat_req, void *resp);
 };
 
 struct qat_dst {
@@ -97,6 +109,69 @@ static void qat_comp_resubmit(struct work_struct *work)
 	areq->base.complete(&areq->base, ret);
 }
 
+static int parse_zlib_header(u16 zlib_h)
+{
+	int ret = -EINVAL;
+	__be16 header;
+	u8 *header_p;
+	u8 cmf, flg;
+
+	header = cpu_to_be16(zlib_h);
+	header_p = (u8 *)&header;
+
+	flg = header_p[0];
+	cmf = header_p[1];
+
+	if (cmf >> QAT_RFC_1950_CM_OFFSET > QAT_RFC_1950_CM_DEFLATE_CINFO_32K)
+		return ret;
+
+	if ((cmf & QAT_RFC_1950_CM_MASK) != QAT_RFC_1950_CM_DEFLATE)
+		return ret;
+
+	if (flg & QAT_RFC_1950_DICT_MASK)
+		return ret;
+
+	return 0;
+}
+
+static int qat_comp_rfc1950_callback(struct qat_compression_req *qat_req,
+				     void *resp)
+{
+	struct acomp_req *areq = qat_req->acompress_req;
+	enum direction dir = qat_req->dir;
+	__be32 qat_produced_adler;
+
+	qat_produced_adler = cpu_to_be32(qat_comp_get_produced_adler32(resp));
+
+	if (dir == COMPRESSION) {
+		__be16 zlib_header;
+
+		zlib_header = cpu_to_be16(QAT_RFC_1950_COMP_HDR);
+		scatterwalk_map_and_copy(&zlib_header, areq->dst, 0, QAT_RFC_1950_HDR_SIZE, 1);
+		areq->dlen += QAT_RFC_1950_HDR_SIZE;
+
+		scatterwalk_map_and_copy(&qat_produced_adler, areq->dst, areq->dlen,
+					 QAT_RFC_1950_FOOTER_SIZE, 1);
+		areq->dlen += QAT_RFC_1950_FOOTER_SIZE;
+	} else {
+		__be32 decomp_adler;
+		int footer_offset;
+		int consumed;
+
+		consumed = qat_comp_get_consumed_ctr(resp);
+		footer_offset = consumed + QAT_RFC_1950_HDR_SIZE;
+		if (footer_offset + QAT_RFC_1950_FOOTER_SIZE > areq->slen)
+			return -EBADMSG;
+
+		scatterwalk_map_and_copy(&decomp_adler, areq->src, footer_offset,
+					 QAT_RFC_1950_FOOTER_SIZE, 0);
+
+		if (qat_produced_adler != decomp_adler)
+			return -EBADMSG;
+	}
+	return 0;
+}
+
 static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 				      void *resp)
 {
@@ -167,6 +242,9 @@ static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 	res = 0;
 	areq->dlen = produced;
 
+	if (ctx->qat_comp_callback)
+		res = ctx->qat_comp_callback(qat_req, resp);
+
 end:
 	qat_bl_free_bufl(accel_dev, &qat_req->buf);
 	areq->base.complete(&areq->base, res);
@@ -215,26 +293,38 @@ static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
 	memset(ctx, 0, sizeof(*ctx));
 }
 
-static int qat_comp_alg_compress_decompress(struct acomp_req *areq,
-					    enum direction dir)
+static int qat_comp_alg_rfc1950_init_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret;
+
+	ret = qat_comp_alg_init_tfm(acomp_tfm);
+	ctx->qat_comp_callback = &qat_comp_rfc1950_callback;
+
+	return ret;
+}
+
+static int qat_comp_alg_compress_decompress(struct acomp_req *areq, enum direction dir,
+					    unsigned int shdr, unsigned int sftr,
+					    unsigned int dhdr, unsigned int dftr)
 {
 	struct qat_compression_req *qat_req = acomp_request_ctx(areq);
 	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(areq);
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
 	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
 	struct qat_compression_instance *inst = ctx->inst;
-	struct qat_sgl_to_bufl_params *p_params = NULL;
 	gfp_t f = qat_algs_alloc_flags(&areq->base);
-	struct qat_sgl_to_bufl_params params;
-	unsigned int slen = areq->slen;
-	unsigned int dlen = areq->dlen;
+	struct qat_sgl_to_bufl_params params = {0};
+	int slen = areq->slen - shdr - sftr;
+	int dlen = areq->dlen - dhdr - dftr;
 	dma_addr_t sfbuf, dfbuf;
 	u8 *req = qat_req->req;
 	size_t ovf_buff_sz;
 	int ret;
 
-	params.sskip = 0;
-	params.dskip = 0;
+	params.sskip = shdr;
+	params.dskip = dhdr;
 
 	if (!areq->src || !slen)
 		return -EINVAL;
@@ -257,6 +347,7 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq,
 		if (!areq->dst)
 			return -ENOMEM;
 
+		dlen -= dhdr + dftr;
 		areq->dlen = dlen;
 		qat_req->dst.resubmitted = false;
 	}
@@ -265,11 +356,10 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq,
 		params.extra_dst_buff = inst->dc_data->ovf_buff_p;
 		ovf_buff_sz = inst->dc_data->ovf_buff_sz;
 		params.sz_extra_dst_buff = ovf_buff_sz;
-		p_params = &params;
 	}
 
 	ret = qat_bl_sgl_to_bufl(ctx->inst->accel_dev, areq->src, areq->dst,
-				 &qat_req->buf, p_params, f);
+				 &qat_req->buf, &params, f);
 	if (unlikely(ret))
 		return ret;
 
@@ -302,12 +392,49 @@ static int qat_comp_alg_compress_decompress(struct acomp_req *areq,
 
 static int qat_comp_alg_compress(struct acomp_req *req)
 {
-	return qat_comp_alg_compress_decompress(req, COMPRESSION);
+	return qat_comp_alg_compress_decompress(req, COMPRESSION, 0, 0, 0, 0);
 }
 
 static int qat_comp_alg_decompress(struct acomp_req *req)
 {
-	return qat_comp_alg_compress_decompress(req, DECOMPRESSION);
+	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, 0, 0, 0, 0);
+}
+
+static int qat_comp_alg_rfc1950_compress(struct acomp_req *req)
+{
+	if (!req->dst && req->dlen != 0)
+		return -EINVAL;
+
+	if (req->dst && req->dlen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
+		return -EINVAL;
+
+	return qat_comp_alg_compress_decompress(req, COMPRESSION, 0, 0,
+						QAT_RFC_1950_HDR_SIZE,
+						QAT_RFC_1950_FOOTER_SIZE);
+}
+
+static int qat_comp_alg_rfc1950_decompress(struct acomp_req *req)
+{
+	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
+	u16 zlib_header;
+	int ret;
+
+	if (req->slen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
+		return -EBADMSG;
+
+	scatterwalk_map_and_copy(&zlib_header, req->src, 0, QAT_RFC_1950_HDR_SIZE, 0);
+
+	ret = parse_zlib_header(zlib_header);
+	if (ret) {
+		dev_dbg(&GET_DEV(accel_dev), "Error parsing zlib header\n");
+		return ret;
+	}
+
+	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, QAT_RFC_1950_HDR_SIZE,
+						QAT_RFC_1950_FOOTER_SIZE, 0, 0);
 }
 
 static struct acomp_alg qat_acomp[] = { {
@@ -325,6 +452,21 @@ static struct acomp_alg qat_acomp[] = { {
 	.decompress = qat_comp_alg_decompress,
 	.dst_free = sgl_free,
 	.reqsize = sizeof(struct qat_compression_req),
+}, {
+	.base = {
+		.cra_name = "zlib-deflate",
+		.cra_driver_name = "qat_zlib_deflate",
+		.cra_priority = 4001,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct qat_compression_ctx),
+		.cra_module = THIS_MODULE,
+	},
+	.init = qat_comp_alg_rfc1950_init_tfm,
+	.exit = qat_comp_alg_exit_tfm,
+	.compress = qat_comp_alg_rfc1950_compress,
+	.decompress = qat_comp_alg_rfc1950_decompress,
+	.dst_free = sgl_free,
+	.reqsize = sizeof(struct qat_compression_req),
 } };
 
 int qat_comp_algs_register(void)
-- 
2.37.1


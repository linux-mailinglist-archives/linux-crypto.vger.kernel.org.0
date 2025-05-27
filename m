Return-Path: <linux-crypto+bounces-13442-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA9AC4ECF
	for <lists+linux-crypto@lfdr.de>; Tue, 27 May 2025 14:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B03BEFB0
	for <lists+linux-crypto@lfdr.de>; Tue, 27 May 2025 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D726B0B6;
	Tue, 27 May 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msyy+vaB"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246042472AF
	for <linux-crypto@vger.kernel.org>; Tue, 27 May 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349790; cv=none; b=qAtV9vcSJxoQbTEyNiVL7MTuKnwiWiTSb1kDS4AxeWTOx35otUqJ46wLCFPf/6RdI1MYlF+vjbJAVunyXXJ7JrbRZp+7n/SgqkFjE7flu5B2axOPYZpf99KrwTsevFRWfMWEMmrJsDpUDPTcmUB+ZrRKs0+bqIM3ivANUH2FcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349790; c=relaxed/simple;
	bh=IQsh62JB+LiPXezxq9u136kZvZkLnyZzbnPMzcs4anc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gI7+cAnnqO+jnqLajrWi2IVv5dL5XRlX1ae7HT6l1soHh/plQl+GKwuqOCWu1H0aEji/c01rboUnQpzLmPi7EbIVLWjSkjYDnUYYD20gskRcherjBXfU4CYOpru1INyuh6wVecNdvCKd4ZyqzPuECDUDmxkiu/vOdQV0608MDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msyy+vaB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748349788; x=1779885788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IQsh62JB+LiPXezxq9u136kZvZkLnyZzbnPMzcs4anc=;
  b=msyy+vaBULfAFyAoRnGfqtOASYfIDHsFV66uRQIhNRgh2+dQPXBEa4XC
   29uOuzEjo1VIeDziUgBhVXDWreLsq04dFEg+J4PnLsfbRCvVm7MqABsmY
   GxXjeFvtfIlsedvnKbGfKI43/TQD6zBV/bxtLbubyCFp/orScYupWPmRZ
   +EiGxBbcMi83PnttApITq6L3DRB06rA/Lp7EGUjsb5dPwMoUVnDyt1a4v
   Pn8zuxEXtmuqTXHRkDfZ8Bg/k/6deumMr/3x3Wdq090IN3bcskZAho3Ih
   qdRkvUkG/oWpHIepjNuIXVTm+IsWNn/b/gFxm1lEvCTCHgrPkxNAHHZ56
   A==;
X-CSE-ConnectionGUID: EMowgPufR6Gt4ww2HUqmng==
X-CSE-MsgGUID: CxXMhca9SeuziHFJK1hDRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="54143291"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="54143291"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 05:43:07 -0700
X-CSE-ConnectionGUID: 2oMnAZJjRfKmKvzcT+MVLQ==
X-CSE-MsgGUID: BevNRONtQ4iQlB+SdGwSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="143771294"
Received: from t21-qat.iind.intel.com ([10.49.15.35])
  by fmviesa009.fm.intel.com with ESMTP; 27 May 2025 05:43:04 -0700
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	dsterba@suse.com,
	terrelln@fb.com,
	clabbe.montjoie@gmail.com
Subject: [v5] crypto: zstd - convert to acomp
Date: Tue, 27 May 2025 13:43:02 +0100
Message-Id: <20250527124302.533682-1-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the implementation to a native acomp interface using zstd
streaming APIs, eliminating the need for buffer linearization.

This includes:
   - Removal of the scomp interface in favor of acomp
   - Refactoring of stream allocation, initialization, and handling for
     both compression and decompression using Zstandard streaming APIs
   - Replacement of crypto_register_scomp() with crypto_register_acomp()
     for module registration

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
v4->v5
   - Swapping the order of acomp_walk_done_src/dst during
     decompression for a single flat buffer.

v3->v4:
   - Added acomp_walk_done_src/dst calls after completing
     compression/decompression for a single flat buffer
   
v2->v3:
   - Updated the logic to verify the existence of a single flat
     buffer using the acomp walk API.

v1->v2:
   - Made the wksp address to be 8 byte aligned.
   - Added logic to use Zstd non streaming APIs for single flat buffer.

 crypto/zstd.c | 389 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 252 insertions(+), 137 deletions(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index 7570e11b4ee6..f84f3aae7428 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -12,188 +12,303 @@
 #include <linux/net.h>
 #include <linux/vmalloc.h>
 #include <linux/zstd.h>
-#include <crypto/internal/scompress.h>
+#include <crypto/internal/acompress.h>
+#include <crypto/scatterwalk.h>
 
 
-#define ZSTD_DEF_LEVEL	3
+#define ZSTD_DEF_LEVEL		3
+#define ZSTD_MAX_WINDOWLOG	18
+#define ZSTD_MAX_SIZE		BIT(ZSTD_MAX_WINDOWLOG)
 
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
-	void *cwksp;
-	void *dwksp;
+	size_t wksp_size;
+	zstd_parameters params;
+	union {
+		u8 wksp[0];
+		/* forces alignment */
+		u64 _align;
+	};
 };
 
-static zstd_parameters zstd_params(void)
+static DEFINE_MUTEX(zstd_stream_lock);
+
+static void *zstd_alloc_stream(void)
 {
-	return zstd_get_params(ZSTD_DEF_LEVEL, 0);
-}
-
-static int zstd_comp_init(struct zstd_ctx *ctx)
-{
-	int ret = 0;
-	const zstd_parameters params = zstd_params();
-	const size_t wksp_size = zstd_cctx_workspace_bound(&params.cParams);
-
-	ctx->cwksp = vzalloc(wksp_size);
-	if (!ctx->cwksp) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ctx->cctx = zstd_init_cctx(ctx->cwksp, wksp_size);
-	if (!ctx->cctx) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-out:
-	return ret;
-out_free:
-	vfree(ctx->cwksp);
-	goto out;
-}
-
-static int zstd_decomp_init(struct zstd_ctx *ctx)
-{
-	int ret = 0;
-	const size_t wksp_size = zstd_dctx_workspace_bound();
-
-	ctx->dwksp = vzalloc(wksp_size);
-	if (!ctx->dwksp) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ctx->dctx = zstd_init_dctx(ctx->dwksp, wksp_size);
-	if (!ctx->dctx) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-out:
-	return ret;
-out_free:
-	vfree(ctx->dwksp);
-	goto out;
-}
-
-static void zstd_comp_exit(struct zstd_ctx *ctx)
-{
-	vfree(ctx->cwksp);
-	ctx->cwksp = NULL;
-	ctx->cctx = NULL;
-}
-
-static void zstd_decomp_exit(struct zstd_ctx *ctx)
-{
-	vfree(ctx->dwksp);
-	ctx->dwksp = NULL;
-	ctx->dctx = NULL;
-}
-
-static int __zstd_init(void *ctx)
-{
-	int ret;
-
-	ret = zstd_comp_init(ctx);
-	if (ret)
-		return ret;
-	ret = zstd_decomp_init(ctx);
-	if (ret)
-		zstd_comp_exit(ctx);
-	return ret;
-}
-
-static void *zstd_alloc_ctx(void)
-{
-	int ret;
+	zstd_parameters params;
 	struct zstd_ctx *ctx;
+	size_t wksp_size;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	params = zstd_get_params(ZSTD_DEF_LEVEL, ZSTD_MAX_SIZE);
+
+	wksp_size = max_t(size_t,
+			  zstd_cstream_workspace_bound(&params.cParams),
+			  zstd_dstream_workspace_bound(ZSTD_MAX_SIZE));
+	if (!wksp_size)
+		return ERR_PTR(-EINVAL);
+
+	ctx = kvmalloc(sizeof(*ctx) + wksp_size, GFP_KERNEL);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
-	ret = __zstd_init(ctx);
-	if (ret) {
-		kfree(ctx);
-		return ERR_PTR(ret);
-	}
+	ctx->params = params;
+	ctx->wksp_size = wksp_size;
 
 	return ctx;
 }
 
-static void __zstd_exit(void *ctx)
+static struct crypto_acomp_streams zstd_streams = {
+	.alloc_ctx = zstd_alloc_stream,
+	.cfree_ctx = kvfree,
+};
+
+static int zstd_init(struct crypto_acomp *acomp_tfm)
 {
-	zstd_comp_exit(ctx);
-	zstd_decomp_exit(ctx);
+	int ret = 0;
+
+	mutex_lock(&zstd_stream_lock);
+	ret = crypto_acomp_alloc_streams(&zstd_streams);
+	mutex_unlock(&zstd_stream_lock);
+
+	return ret;
 }
 
-static void zstd_free_ctx(void *ctx)
+static void zstd_exit(struct crypto_acomp *acomp_tfm)
 {
-	__zstd_exit(ctx);
-	kfree_sensitive(ctx);
+	crypto_acomp_free_streams(&zstd_streams);
 }
 
-static int __zstd_compress(const u8 *src, unsigned int slen,
-			   u8 *dst, unsigned int *dlen, void *ctx)
+static int zstd_compress_one(struct acomp_req *req, struct zstd_ctx *ctx, unsigned int *dlen)
 {
-	size_t out_len;
-	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_params();
+	unsigned int out_len;
 
-	out_len = zstd_compress_cctx(zctx->cctx, dst, *dlen, src, slen, &params);
+	ctx->cctx = zstd_init_cctx(ctx->wksp, ctx->wksp_size);
+	if (!ctx->cctx)
+		return -EINVAL;
+
+	out_len = zstd_compress_cctx(ctx->cctx, sg_virt(req->dst),
+				     req->dlen, sg_virt(req->src),
+				     req->slen, &ctx->params);
 	if (zstd_is_error(out_len))
 		return -EINVAL;
+
 	*dlen = out_len;
+
 	return 0;
 }
 
-static int zstd_scompress(struct crypto_scomp *tfm, const u8 *src,
-			  unsigned int slen, u8 *dst, unsigned int *dlen,
-			  void *ctx)
+static int zstd_compress(struct acomp_req *req)
 {
-	return __zstd_compress(src, slen, dst, dlen, ctx);
-}
+	struct crypto_acomp_stream *s;
+	unsigned int pos, scur, dcur;
+	unsigned int total_out = 0;
+	bool data_available = true;
+	zstd_out_buffer outbuf;
+	struct acomp_walk walk;
+	zstd_in_buffer inbuf;
+	struct zstd_ctx *ctx;
+	size_t pending_bytes;
+	size_t num_bytes;
+	int ret;
 
-static int __zstd_decompress(const u8 *src, unsigned int slen,
-			     u8 *dst, unsigned int *dlen, void *ctx)
-{
-	size_t out_len;
-	struct zstd_ctx *zctx = ctx;
+	s = crypto_acomp_lock_stream_bh(&zstd_streams);
+	ctx = s->ctx;
 
-	out_len = zstd_decompress_dctx(zctx->dctx, dst, *dlen, src, slen);
-	if (zstd_is_error(out_len))
-		return -EINVAL;
-	*dlen = out_len;
-	return 0;
-}
+	ret = acomp_walk_virt(&walk, req, true);
+	if (ret)
+		goto out;
 
-static int zstd_sdecompress(struct crypto_scomp *tfm, const u8 *src,
-			    unsigned int slen, u8 *dst, unsigned int *dlen,
-			    void *ctx)
-{
-	return __zstd_decompress(src, slen, dst, dlen, ctx);
-}
-
-static struct scomp_alg scomp = {
-	.alloc_ctx		= zstd_alloc_ctx,
-	.free_ctx		= zstd_free_ctx,
-	.compress		= zstd_scompress,
-	.decompress		= zstd_sdecompress,
-	.base			= {
-		.cra_name	= "zstd",
-		.cra_driver_name = "zstd-scomp",
-		.cra_module	 = THIS_MODULE,
+	ctx->cctx = zstd_init_cstream(&ctx->params, 0, ctx->wksp, ctx->wksp_size);
+	if (!ctx->cctx) {
+		ret = -EINVAL;
+		goto out;
 	}
+
+	do {
+		dcur = acomp_walk_next_dst(&walk);
+		if (!dcur) {
+			ret = -ENOSPC;
+			goto out;
+		}
+
+		outbuf.pos = 0;
+		outbuf.dst = (u8 *)walk.dst.virt.addr;
+		outbuf.size = dcur;
+
+		do {
+			scur = acomp_walk_next_src(&walk);
+			if (dcur == req->dlen && scur == req->slen) {
+				ret = zstd_compress_one(req, ctx, &total_out);
+				acomp_walk_done_src(&walk, scur);
+				acomp_walk_done_dst(&walk, dcur);
+				goto out;
+			}
+
+			if (scur) {
+				inbuf.pos = 0;
+				inbuf.src = walk.src.virt.addr;
+				inbuf.size = scur;
+			} else {
+				data_available = false;
+				break;
+			}
+
+			num_bytes = zstd_compress_stream(ctx->cctx, &outbuf, &inbuf);
+			if (ZSTD_isError(num_bytes)) {
+				ret = -EIO;
+				goto out;
+			}
+
+			pending_bytes = zstd_flush_stream(ctx->cctx, &outbuf);
+			if (ZSTD_isError(pending_bytes)) {
+				ret = -EIO;
+				goto out;
+			}
+			acomp_walk_done_src(&walk, inbuf.pos);
+		} while (dcur != outbuf.pos);
+
+		total_out += outbuf.pos;
+		acomp_walk_done_dst(&walk, dcur);
+	} while (data_available);
+
+	pos = outbuf.pos;
+	num_bytes = zstd_end_stream(ctx->cctx, &outbuf);
+	if (ZSTD_isError(num_bytes))
+		ret = -EIO;
+	else
+		total_out += (outbuf.pos - pos);
+
+out:
+	if (ret)
+		req->dlen = 0;
+	else
+		req->dlen = total_out;
+
+	crypto_acomp_unlock_stream_bh(s);
+
+	return ret;
+}
+
+static int zstd_decompress_one(struct acomp_req *req, struct zstd_ctx *ctx, unsigned int *dlen)
+{
+	size_t out_len;
+
+	ctx->dctx = zstd_init_dctx(ctx->wksp, ctx->wksp_size);
+	if (!ctx->dctx)
+		return -EINVAL;
+
+	out_len = zstd_decompress_dctx(ctx->dctx, sg_virt(req->dst),
+				       req->dlen, sg_virt(req->src),
+				       req->slen);
+	if (zstd_is_error(out_len))
+		return -EINVAL;
+
+	*dlen = out_len;
+
+	return 0;
+}
+
+static int zstd_decompress(struct acomp_req *req)
+{
+	struct crypto_acomp_stream *s;
+	unsigned int total_out = 0;
+	unsigned int scur, dcur;
+	zstd_out_buffer outbuf;
+	struct acomp_walk walk;
+	zstd_in_buffer inbuf;
+	struct zstd_ctx *ctx;
+	size_t pending_bytes;
+	int ret;
+
+	s = crypto_acomp_lock_stream_bh(&zstd_streams);
+	ctx = s->ctx;
+
+	ret = acomp_walk_virt(&walk, req, true);
+	if (ret)
+		goto out;
+
+	ctx->dctx = zstd_init_dstream(ZSTD_MAX_SIZE, ctx->wksp, ctx->wksp_size);
+	if (!ctx->dctx) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	do {
+		scur = acomp_walk_next_src(&walk);
+		if (scur) {
+			inbuf.pos = 0;
+			inbuf.size = scur;
+			inbuf.src = walk.src.virt.addr;
+		} else {
+			break;
+		}
+
+		do {
+			dcur = acomp_walk_next_dst(&walk);
+			if (dcur == req->dlen && scur == req->slen) {
+				ret = zstd_decompress_one(req, ctx, &total_out);
+				acomp_walk_done_dst(&walk, dcur);
+				acomp_walk_done_src(&walk, scur);
+				goto out;
+			}
+
+			if (!dcur) {
+				ret = -ENOSPC;
+				goto out;
+			}
+
+			outbuf.pos = 0;
+			outbuf.dst = (u8 *)walk.dst.virt.addr;
+			outbuf.size = dcur;
+
+			pending_bytes = zstd_decompress_stream(ctx->dctx, &outbuf, &inbuf);
+			if (ZSTD_isError(pending_bytes)) {
+				ret = -EIO;
+				goto out;
+			}
+
+			total_out += outbuf.pos;
+
+			acomp_walk_done_dst(&walk, outbuf.pos);
+		} while (scur != inbuf.pos);
+
+		if (scur)
+			acomp_walk_done_src(&walk, scur);
+	} while (ret == 0);
+
+out:
+	if (ret)
+		req->dlen = 0;
+	else
+		req->dlen = total_out;
+
+	crypto_acomp_unlock_stream_bh(s);
+
+	return ret;
+}
+
+static struct acomp_alg zstd_acomp = {
+	.base = {
+		.cra_name = "zstd",
+		.cra_driver_name = "zstd-generic",
+		.cra_flags = CRYPTO_ALG_REQ_VIRT,
+		.cra_module = THIS_MODULE,
+	},
+	.init = zstd_init,
+	.exit = zstd_exit,
+	.compress = zstd_compress,
+	.decompress = zstd_decompress,
 };
 
 static int __init zstd_mod_init(void)
 {
-	return crypto_register_scomp(&scomp);
+	return crypto_register_acomp(&zstd_acomp);
 }
 
 static void __exit zstd_mod_fini(void)
 {
-	crypto_unregister_scomp(&scomp);
+	crypto_unregister_acomp(&zstd_acomp);
 }
 
 module_init(zstd_mod_init);

base-commit: b939a747dcec83d77fb23660204b82cf64f0b944
-- 
2.40.1



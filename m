Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900435FE25F
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Oct 2022 21:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJMTFd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Oct 2022 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJMTFc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Oct 2022 15:05:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5305E84E71
        for <linux-crypto@vger.kernel.org>; Thu, 13 Oct 2022 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665687927;
        bh=JkkGbOrcjjRuW4KeCwf2Ign9inZRbe+hMZq8NVTB7kg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Qm9aFpFYgy7p197Q+UrN/TU754jinUunD+ZFGBe0nC4skVB9955Xz9p7usCxixXAi
         x4NS7nyfhyDuC/pOG8Uc+NxaAq20FYaab3fmXs7MQe/at7LaZ+iupzxnyrtZrZiS7O
         hnaucdOrxnyjQGWDDx6NBg+AZY83I/2U/KSbKxy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fedora.willemsstb.de ([94.31.86.22]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC30P-1or3Ls3Bjp-00CNGS; Thu, 13
 Oct 2022 20:40:29 +0200
From:   Markus Stockhausen <markus.stockhausen@gmx.de>
To:     linux-crypto@vger.kernel.org
Cc:     Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 3/6] crypto/realtek: hash algorithms
Date:   Thu, 13 Oct 2022 20:40:23 +0200
Message-Id: <20221013184026.63826-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013184026.63826-1-markus.stockhausen@gmx.de>
References: <20221013184026.63826-1-markus.stockhausen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vqqXUhAwW8s6PJVujFOZYQlQtOlxCvHlT+I7IFCRMozC5IdEmEg
 yKJ4gATiAl35HUd+xWsv2fkoobtRZXkGqnK3FLr96R/dOxCVEz7v5EW7lNE21Bl0i03NBf3
 ZreSM51/biDU+tL6PXY9FW1TS0CF3P0b6atdWb7FTV3l62y33+0q3P9xp55258Qe1FN93Bc
 WBf/r++tEmhfrfsV+ylXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+AaJdy7nwQ=:SNxAxgkrcafBHLOwqMqTVW
 QHRUSr+zaR5rx9ycZC2NDzz0Ah1P9zNRA2Y3uDm5ZWZ7ZaRjBdC/JeQ2FXSFhnJbi/OcuThNb
 7h5RAAMKrXxD56nsyJxLAuRDGXVVywEFfO1O1NtedU9YeYwkMB+wVXBRzMSQxdV/msL9GmYzK
 nUuQgnObDVY6oWaff8k1nHN+kSgO6c6l74WRm5TKmvrtWd3USelJGM8e/D1VQMNA4mEys5zi6
 iizoo3+QfiJNt6j/2gpe/XQkKe0oxjJyEIzsS/4AsdiAlwIV9gd9MMe6kaZPEm96e6tHiqrVV
 meeuOFkWHPfhGw4lRyix5KjKKw3p9Ry/txLf8MnnfrCtTvMnt4PWOPfTY9hWL1Iht/pw7grjy
 PaKAoXA7BGNY98a58X+O+8f2AVDNk3nrrsuiOngBrUHSQwRSk4NtSuKRIzvh8biIefVqDzvS5
 ttfHTUTVLcoRDeLqsbEbOfGfEL7BmTiXM14syltVsnGprIEG+zU+UoNkTohubilJI+Py3giIm
 WPn6J2DjwUL8GXeqWp5E8GffK3BTm/PMufU+saCAZwlX4aih5uqV5+vCowFO4dwBringbd0Vn
 lFnLuGLz0Km+U49x6W6b9AnXUuyumqeE5JmktY0e+i65r3UaUZ9chcrzZDxhNO4hBNx10rM0f
 BywsEHJE9FrAf/v5tYmhuXXUZ/u3rJLWPrjSWhd0y8oS3ImfWY4LibvugYITaBMAfz4sNQxPB
 JD0pwa+eaC4LKFcTeGm/h/eh1xRYUKrlfFpAB2y0qAOH6zPNShKkBMw56TmWP8a8gzwPXx6bD
 FAGl1jATRPMoAac2b6lyTN801+3OlZq6S4V/AwbDHu1GrPwq/nYJTDHIq/vOY/NNAUSLhqVbb
 2pCE/cL8RNoVPcYvjmvSLTHMsJAROtITe5+O+fListpUhBagDbLQFSZmdPy5c5Sf591hk3xYJ
 eK+HDs7EYzhxh7N73lZuRzMGA8ptjkdORa06qsIXo26YYXHfjIkNq3OZ6ZFnMn8EiTPXVZ0Sr
 +d1YSKieEwRApAL1jj7k2EictY2hwfn35PiXXtTTHdYpFmni5fJBJ51W3uVpzdmCC8JchpZZV
 Xz1o3YZKhFS62wYTVvSCUwh6alK5KjSc0We9r08Hz4j4Ghs7MQDg5yNf+oBmS203edpA3sEfA
 GRreTtriqqTxDNic6UaE90ZQcJZ1gxy1YF3voLkWJXQ5W0ccc2LpGQnMvKNV+w5L0kVWcV+S9
 FCl3Ct9XAA7Qp+vC7EzE3KTP8lgSQvwuCMmig4ubqwsCOR7aIxScCcup6TEeMWGRL9luhYX7b
 TdG2xb6IQAYGOTkU6JIh1xrwf+G+WU8rUeeHUzarmbr9tjWCv3dzZ3jxhJG1Gz2XsT6QgONAs
 tAUJLA8PECTl/8HbE/CLljMzf3IpgrNxuNza+oxI3bqNfmisKJE7HgyqLkMQ7s9QCHWf8c9zJ
 n+zaHLgCCKbwNagmBLulNBasfEzVEKyWel/22vZH8x6qot7fShlAgs2gagGPb8zcgDzvd9YZ6
 qThdbE3C1SkVqX34eeFN1hnOBcF922rzGq5ODdQuNbOE3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add md5/sha1 hash algorithms for new Realtek crypto device.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/crypto/realtek/realtek_crypto_ahash.c | 406 ++++++++++++++++++
 1 file changed, 406 insertions(+)
 create mode 100644 drivers/crypto/realtek/realtek_crypto_ahash.c

diff --git a/drivers/crypto/realtek/realtek_crypto_ahash.c b/drivers/crypt=
o/realtek/realtek_crypto_ahash.c
new file mode 100644
index 000000000000..eba83451fac1
=2D-- /dev/null
+++ b/drivers/crypto/realtek/realtek_crypto_ahash.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Crypto acceleration support for Realtek crypto engine. Based on ideas =
from
+ * Rockchip & SafeXcel driver plus Realtek OpenWrt RTK.
+ *
+ * Copyright (c) 2022, Markus Stockhausen <markus.stockhausen@gmx.de>
+ */
+
+#include <crypto/internal/hash.h>
+#include <linux/dma-mapping.h>
+
+#include "realtek_crypto.h"
+
+static inline struct ahash_request *fallback_request_ctx(struct ahash_req=
uest *areq)
+{
+	char *p =3D (char *)ahash_request_ctx(areq);
+
+	return (struct ahash_request *)(p + offsetof(struct rtcr_ahash_req, vect=
or));
+}
+
+static inline void *fallback_export_state(void *export)
+{
+	char *p =3D (char *)export;
+
+	return (void *)(p + offsetof(struct rtcr_ahash_req, vector));
+}
+
+static int rtcr_process_hash(struct ahash_request *areq, int opmode)
+{
+	unsigned int len, nextbuflen, datalen, padlen, reqlen;
+	struct rtcr_ahash_req *hreq =3D ahash_request_ctx(areq);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(areq);
+	struct rtcr_ahash_ctx *hctx =3D crypto_ahash_ctx(tfm);
+	int sgcnt =3D hreq->state & RTCR_REQ_SG_MASK;
+	struct rtcr_crypto_dev *cdev =3D hctx->cdev;
+	struct scatterlist *sg =3D areq->src;
+	int idx, srcidx, dstidx, ret;
+	u64 pad[RTCR_HASH_PAD_SIZE];
+	char *ppad;
+
+	/* Quick checks if processing is really needed */
+	if (unlikely(!areq->nbytes) && !(opmode & RTCR_HASH_FINAL))
+		return 0;
+
+	if (hreq->buflen + areq->nbytes < 64 && !(opmode & RTCR_HASH_FINAL)) {
+		hreq->buflen +=3D sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
+						   hreq->buf + hreq->buflen,
+						   areq->nbytes, 0);
+		return 0;
+	}
+
+	/* calculate required parts of the request */
+	datalen =3D (opmode & RTCR_HASH_UPDATE) ? areq->nbytes : 0;
+	if (opmode & RTCR_HASH_FINAL) {
+		nextbuflen =3D 0;
+		padlen =3D 64 - ((hreq->buflen + datalen) & 63);
+		if (padlen < 9)
+			padlen +=3D 64;
+		hreq->totallen +=3D hreq->buflen + datalen;
+
+		memset(pad, 0, sizeof(pad) - sizeof(u64));
+		ppad =3D (char *)&pad[RTCR_HASH_PAD_SIZE] - padlen;
+		*ppad =3D 0x80;
+		pad[RTCR_HASH_PAD_SIZE - 1] =3D hreq->state & RTCR_REQ_MD5 ?
+					      cpu_to_le64(hreq->totallen << 3) :
+					      cpu_to_be64(hreq->totallen << 3);
+	} else {
+		nextbuflen =3D (hreq->buflen + datalen) & 63;
+		padlen =3D 0;
+		datalen -=3D nextbuflen;
+		hreq->totallen +=3D hreq->buflen + datalen;
+	}
+	reqlen =3D hreq->buflen + datalen + padlen;
+
+	/* Write back any uncommitted data to memory. */
+	if (hreq->buflen)
+		dma_sync_single_for_device(cdev->dev, virt_to_phys(hreq->buf),
+					   hreq->buflen, DMA_TO_DEVICE);
+	if (padlen)
+		dma_sync_single_for_device(cdev->dev, virt_to_phys(ppad),
+					   padlen, DMA_TO_DEVICE);
+	if (datalen)
+		dma_map_sg(cdev->dev, sg, sgcnt, DMA_TO_DEVICE);
+
+	/* Get free space in the ring */
+	sgcnt =3D 1 + (hreq->buflen ? 1 : 0) + (datalen ? sgcnt : 0) + (padlen ?=
 1 : 0);
+
+	ret =3D rtcr_alloc_ring(cdev, sgcnt, &srcidx, &dstidx, RTCR_WB_LEN_HASH,=
 NULL);
+	if (ret)
+		return ret;
+	/*
+	 * Feed input data into the rings. Start with destination ring and fill
+	 * source ring afterwards. Ensure that the owner flag of the first sourc=
e
+	 * ring is the last that becomes visible to the engine.
+	 */
+	rtcr_add_dst_to_ring(cdev, dstidx, NULL, 0, hreq->vector, 0);
+
+	idx =3D srcidx;
+	if (hreq->buflen) {
+		idx =3D rtcr_inc_src_idx(idx, 1);
+		rtcr_add_src_to_ring(cdev, idx, hreq->buf, hreq->buflen, reqlen);
+	}
+
+	while (datalen) {
+		len =3D min(sg_dma_len(sg), datalen);
+
+		idx =3D rtcr_inc_src_idx(idx, 1);
+		rtcr_add_src_to_ring(cdev, idx, sg_virt(sg), len, reqlen);
+
+		datalen -=3D len;
+		if (datalen)
+			sg =3D sg_next(sg);
+	}
+
+	if (padlen) {
+		idx =3D rtcr_inc_src_idx(idx, 1);
+		rtcr_add_src_to_ring(cdev, idx, ppad, padlen, reqlen);
+	}
+
+	rtcr_add_src_pad_to_ring(cdev, idx, reqlen);
+	rtcr_add_src_ahash_to_ring(cdev, srcidx, hctx->opmode, reqlen);
+
+	/* Off we go */
+	rtcr_kick_engine(cdev);
+	if (rtcr_wait_for_request(cdev, dstidx))
+		return -EINVAL;
+
+	hreq->state |=3D RTCR_REQ_FB_ACT;
+	hreq->buflen =3D nextbuflen;
+
+	if (nextbuflen)
+		sg_pcopy_to_buffer(sg, sg_nents(sg), hreq->buf, nextbuflen, len);
+	if (padlen)
+		memcpy(areq->result, hreq->vector, crypto_ahash_digestsize(tfm));
+
+	return 0;
+}
+
+static void rtcr_check_request(struct ahash_request *areq, int opmode)
+{
+	struct rtcr_ahash_req *hreq =3D ahash_request_ctx(areq);
+	struct scatterlist *sg =3D areq->src;
+	int reqlen, sgcnt, sgmax;
+
+	if (hreq->state & RTCR_REQ_FB_ACT)
+		return;
+
+	if (reqlen > RTCR_MAX_REQ_SIZE) {
+		hreq->state |=3D RTCR_REQ_FB_ACT;
+		return;
+	}
+
+	sgcnt =3D 0;
+	sgmax =3D RTCR_MAX_SG_AHASH - (hreq->buflen ? 1 : 0);
+	reqlen =3D areq->nbytes;
+	if (!(opmode & RTCR_HASH_FINAL)) {
+		reqlen -=3D (hreq->buflen + reqlen) & 63;
+		sgmax--;
+	}
+
+	while (reqlen > 0) {
+		reqlen -=3D sg_dma_len(sg);
+		sgcnt++;
+		sg =3D sg_next(sg);
+	}
+
+	if (sgcnt > sgmax)
+		hreq->state |=3D RTCR_REQ_FB_ACT;
+	else
+		hreq->state =3D (hreq->state & ~RTCR_REQ_SG_MASK) | sgcnt;
+}
+
+static bool rtcr_check_fallback(struct ahash_request *areq)
+{
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+	struct rtcr_ahash_req *hreq =3D ahash_request_ctx(areq);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(areq);
+	struct rtcr_ahash_ctx *hctx =3D crypto_ahash_ctx(tfm);
+	union rtcr_fallback_state state;
+
+	if (!(hreq->state & RTCR_REQ_FB_ACT))
+		return false;
+
+	if (!(hreq->state & RTCR_REQ_FB_RDY)) {
+		/* Convert state to generic fallback state */
+		if (hreq->state & RTCR_REQ_MD5) {
+			memcpy(state.md5.hash, hreq->vector, MD5_DIGEST_SIZE);
+			if (hreq->totallen)
+				cpu_to_le32_array(state.md5.hash, 4);
+			memcpy(state.md5.block, hreq->buf, SHA1_BLOCK_SIZE);
+			state.md5.byte_count =3D hreq->totallen + (u64)hreq->buflen;
+		} else {
+			memcpy(state.sha1.state, hreq->vector, SHA1_DIGEST_SIZE);
+			memcpy(state.sha1.buffer, &hreq->buf, SHA1_BLOCK_SIZE);
+			state.sha1.count =3D hreq->totallen + (u64)hreq->buflen;
+		}
+	}
+
+	ahash_request_set_tfm(freq, hctx->fback);
+	ahash_request_set_crypt(freq, areq->src, areq->result, areq->nbytes);
+
+	if (!(hreq->state & RTCR_REQ_FB_RDY)) {
+		crypto_ahash_import(freq, &state);
+		hreq->state |=3D RTCR_REQ_FB_RDY;
+	}
+
+	return true;
+}
+
+static int rtcr_ahash_init(struct ahash_request *areq)
+{
+	struct rtcr_ahash_req *hreq =3D ahash_request_ctx(areq);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(areq);
+	int ds =3D crypto_ahash_digestsize(tfm);
+
+	memset(hreq, 0, sizeof(*hreq));
+
+	hreq->vector[0] =3D SHA1_H0;
+	hreq->vector[1] =3D SHA1_H1;
+	hreq->vector[2] =3D SHA1_H2;
+	hreq->vector[3] =3D SHA1_H3;
+	hreq->vector[4] =3D SHA1_H4;
+
+	hreq->state |=3D (ds =3D=3D MD5_DIGEST_SIZE) ? RTCR_REQ_MD5 : RTCR_REQ_S=
HA1;
+
+	return 0;
+}
+
+static int rtcr_ahash_update(struct ahash_request *areq)
+{
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+
+	rtcr_check_request(areq, RTCR_HASH_UPDATE);
+	if (rtcr_check_fallback(areq))
+		return crypto_ahash_update(freq);
+	return rtcr_process_hash(areq, RTCR_HASH_UPDATE);
+}
+
+static int rtcr_ahash_final(struct ahash_request *areq)
+{
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+
+	if (rtcr_check_fallback(areq))
+		return crypto_ahash_final(freq);
+
+	return rtcr_process_hash(areq, RTCR_HASH_FINAL);
+}
+
+static int rtcr_ahash_finup(struct ahash_request *areq)
+{
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+
+	rtcr_check_request(areq, RTCR_HASH_FINAL | RTCR_HASH_UPDATE);
+	if (rtcr_check_fallback(areq))
+		return crypto_ahash_finup(freq);
+
+	return rtcr_process_hash(areq, RTCR_HASH_FINAL | RTCR_HASH_UPDATE);
+}
+
+static int rtcr_ahash_digest(struct ahash_request *areq)
+{
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+	int ret;
+
+	ret =3D rtcr_ahash_init(areq);
+	if (ret)
+		return ret;
+
+	rtcr_check_request(areq, RTCR_HASH_FINAL | RTCR_HASH_UPDATE);
+	if (rtcr_check_fallback(areq))
+		return crypto_ahash_digest(freq);
+
+	return rtcr_process_hash(areq, RTCR_HASH_FINAL | RTCR_HASH_UPDATE);
+}
+
+static int rtcr_ahash_import(struct ahash_request *areq, const void *in)
+{
+	const void *fexp =3D (const void *)fallback_export_state((void *)in);
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+	struct rtcr_ahash_req *hreq =3D ahash_request_ctx(areq);
+	const struct rtcr_ahash_req *hexp =3D in;
+
+	hreq->state =3D hexp->state;
+	if (hreq->state & RTCR_REQ_FB_ACT)
+		hreq->state |=3D RTCR_REQ_FB_RDY;
+
+	if (rtcr_check_fallback(areq))
+		return crypto_ahash_import(freq, fexp);
+
+	memcpy(hreq, hexp, sizeof(struct rtcr_ahash_req));
+
+	return 0;
+}
+
+static int rtcr_ahash_export(struct ahash_request *areq, void *out)
+{
+	struct ahash_request *freq =3D fallback_request_ctx(areq);
+	struct rtcr_ahash_req *hreq =3D ahash_request_ctx(areq);
+	void *fexp =3D fallback_export_state(out);
+	struct rtcr_ahash_req *hexp =3D out;
+
+	if (rtcr_check_fallback(areq)) {
+		hexp->state =3D hreq->state;
+		return crypto_ahash_export(freq, fexp);
+	}
+
+	memcpy(hexp, hreq, sizeof(struct rtcr_ahash_req));
+
+	return 0;
+}
+
+static int rtcr_ahash_cra_init(struct crypto_tfm *tfm)
+{
+	struct crypto_ahash *ahash =3D __crypto_ahash_cast(tfm);
+	struct rtcr_ahash_ctx *hctx =3D crypto_tfm_ctx(tfm);
+	struct rtcr_crypto_dev *cdev =3D hctx->cdev;
+	struct rtcr_alg_template *tmpl;
+
+	tmpl =3D container_of(__crypto_ahash_alg(tfm->__crt_alg),
+			     struct rtcr_alg_template, alg.ahash);
+
+	hctx->cdev =3D tmpl->cdev;
+	hctx->opmode =3D tmpl->opmode;
+	hctx->fback =3D crypto_alloc_ahash(crypto_tfm_alg_name(tfm), 0,
+					 CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+
+	if (IS_ERR(hctx->fback)) {
+		dev_err(cdev->dev, "could not allocate fallback for %s\n",
+			crypto_tfm_alg_name(tfm));
+		return PTR_ERR(hctx->fback);
+	}
+
+	crypto_ahash_set_reqsize(ahash, max(sizeof(struct rtcr_ahash_req),
+					    offsetof(struct rtcr_ahash_req, vector) +
+					    sizeof(struct ahash_request) +
+					    crypto_ahash_reqsize(hctx->fback)));
+
+	return 0;
+}
+
+static void rtcr_ahash_cra_exit(struct crypto_tfm *tfm)
+{
+	struct rtcr_ahash_ctx *hctx =3D crypto_tfm_ctx(tfm);
+
+	crypto_free_ahash(hctx->fback);
+}
+
+struct rtcr_alg_template rtcr_ahash_md5 =3D {
+	.type =3D RTCR_ALG_AHASH,
+	.opmode =3D RTCR_SRC_OP_MS_HASH | RTCR_SRC_OP_HASH_MD5,
+	.alg.ahash =3D {
+		.init =3D rtcr_ahash_init,
+		.update =3D rtcr_ahash_update,
+		.final =3D rtcr_ahash_final,
+		.finup =3D rtcr_ahash_finup,
+		.export =3D rtcr_ahash_export,
+		.import =3D rtcr_ahash_import,
+		.digest =3D rtcr_ahash_digest,
+		.halg =3D {
+			.digestsize =3D MD5_DIGEST_SIZE,
+			/* statesize calculated during initialization */
+			.base =3D {
+				.cra_name =3D "md5",
+				.cra_driver_name =3D "realtek-md5",
+				.cra_priority =3D 300,
+				.cra_flags =3D CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize =3D SHA1_BLOCK_SIZE,
+				.cra_ctxsize =3D sizeof(struct rtcr_ahash_ctx),
+				.cra_alignmask =3D 0,
+				.cra_init =3D rtcr_ahash_cra_init,
+				.cra_exit =3D rtcr_ahash_cra_exit,
+				.cra_module =3D THIS_MODULE,
+			}
+		}
+	}
+};
+
+struct rtcr_alg_template rtcr_ahash_sha1 =3D {
+	.type =3D RTCR_ALG_AHASH,
+	.opmode =3D RTCR_SRC_OP_MS_HASH | RTCR_SRC_OP_HASH_SHA1,
+	.alg.ahash =3D {
+		.init =3D rtcr_ahash_init,
+		.update =3D rtcr_ahash_update,
+		.final =3D rtcr_ahash_final,
+		.finup =3D rtcr_ahash_finup,
+		.export =3D rtcr_ahash_export,
+		.import =3D rtcr_ahash_import,
+		.digest =3D rtcr_ahash_digest,
+		.halg =3D {
+			.digestsize =3D SHA1_DIGEST_SIZE,
+			/* statesize calculated during initialization */
+			.base =3D {
+				.cra_name =3D "sha1",
+				.cra_driver_name =3D "realtek-sha1",
+				.cra_priority =3D 300,
+				.cra_flags =3D CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK,
+				.cra_blocksize =3D SHA1_BLOCK_SIZE,
+				.cra_ctxsize =3D sizeof(struct rtcr_ahash_ctx),
+				.cra_alignmask =3D 0,
+				.cra_init =3D rtcr_ahash_cra_init,
+				.cra_exit =3D rtcr_ahash_cra_exit,
+				.cra_module =3D THIS_MODULE,
+			}
+		}
+	}
+};
=2D-
2.37.3


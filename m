Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5465A5AF
	for <lists+linux-crypto@lfdr.de>; Sat, 31 Dec 2022 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLaQZe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 31 Dec 2022 11:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLaQZd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 31 Dec 2022 11:25:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78501632D
        for <linux-crypto@vger.kernel.org>; Sat, 31 Dec 2022 08:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672503929; bh=tHQfak81RAlM2QkP3GPAxRW7Cuw/1rL+is4QiM1CnGM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=paIaEtHKSwTG9ycdxUrX/8busRUd0O4ziSXCYmR96hh19HMVoU8x70N1b6cx5en/C
         R4mOj8Ncf7ohItmGl0BqjhPk2sgmTRPDjidMS4shaqxAUScK+TeJ9EXFOj/f5y6qAy
         EYHPnTnOpECBcTQiHAJ4sd1CLnLKYD/pW2ku244lNEtMgI40masI9OR/qbfQFd55mE
         FCXBrEzsK77+vOaMdwSsG6AYijlcovo+NX/vncu+iGKPGk/JJFq5d8tm76a2HtHssI
         CH2DWs2xYnZKWmMpiRiDBMDpnTrtWHJ14kzJe6h0ll6HfTXlY+G/xZFEJI/bT7drHi
         sq0YeMYBoezhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fedora.willemsstb.de ([94.31.82.22]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1pWm1c2kZh-00LE2s; Sat, 31
 Dec 2022 17:25:29 +0100
From:   Markus Stockhausen <markus.stockhausen@gmx.de>
To:     linux-crypto@vger.kernel.org
Cc:     Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH v3 2/6] crypto/realtek: core functions
Date:   Sat, 31 Dec 2022 17:25:21 +0100
Message-Id: <20221231162525.416709-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231162525.416709-1-markus.stockhausen@gmx.de>
References: <20221231162525.416709-1-markus.stockhausen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aQAlsil/M4++Pju+JibY5pz6MlTHGDVsI4+PM2vqvsy5KZYTf8v
 6lCcsbtKxcuCyz3VLS9uPndvfZ3ICxMSzUGJMtyva78k41pVOngl7KpMs5Jj4ad5Sd0l9bS
 2nwZZLN4aIYqRFGdnSbLMA6wh7DexCRaQgwWsbQHcQ5eCIGVpRBph+M7tt/w/Tko+QF4taX
 k986UJObfuiEHxeOFh90g==
UI-OutboundReport: notjunk:1;M01:P0:O4lByrZq6ZY=;F7oZsbuCTS2I6AsOU1JsEyFpKon
 wUy20DnQXpvbEm1GFF3XyP76Ww8dEwwKRb+HVEES8AvQaWLbkUJltbH2b/2YBMo9TYa8JfyQa
 N+Il9SZ9XtdpsvmMf5D3V0VO+JmybwuVORTO+d2rdOQDrkKRJnqTDwRxF2IDeIHL1hTKu21sK
 2jvrLeEfaD4KAQAGbvefUSBTUNvch3enJYNWaEDdP+3zlRjMtD+Edvp3bRAxyE1RV/DkhtW6f
 itWb1524uVlltLgIAaOoCQSYEFrUv8G5HI6ir4hBMY2hx+UbpsV+v2fkWsjSqLG5aESog9z/J
 211E6bhpgZqQdECqT8MVjUDxNnv3JYcKcJQZ5uoNzMQjegQTGhKtaOkEm/RmkLgXsISRG9qAW
 S4ahuUSmW+Upuqzx2RLV9iIZ4V711iF+iXAfJB7nL1AJe9KoAmuPov49wPmJPToYrRGo4ZzKY
 q+5JC/bDPTAkfdnKMe+tIeTYZxdyBISxBjw0aYL8gDNuewxJrd0PwX80FouehR73JTdbPtPgU
 WXS8FQyDQyo9mWU6blHPkNHdVDDX3UFAPGq9BUuGST5ZurSUqFtO3y1miRXHi27X6yeSndFJZ
 f/EpF7mxN21c0wVMiKpzRUdqXkaUFvCzAjVDDak4Q35o36DVJFe1Zlh3Hzjdn/EPbIp2FD6Ap
 0n5jN5FYGPVxao2+r1wcsd/0SbZPFsILizp43DSNqPCbkJJF0lTyA98H5HXlx5B/8EzcWzrdf
 oIbTTTq047SIi4chCp0jbdCtZFSOlLAV0fEvkioWnepihb7k3GAyq5ovA44EZHKN+IEuFCJDn
 +nMV16/cyT6aoE9WEQ4XFwXu6kbUF/2m222TAf++YzdQ/Eys7kIuK5xak4tGFMSsS8DWFW6AC
 kT4v5VuXdPB5d9KetsY29PSFAghqs6j9c7bco88F3Aip6A/vWjabk0/z6UQwWcd/Y/uI0MHzg
 Opm6jKRqhoz3p1h3CnOWhPXyTAY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add core functions for new Realtek crypto device.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/crypto/realtek/realtek_crypto.c | 475 ++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 drivers/crypto/realtek/realtek_crypto.c

diff --git a/drivers/crypto/realtek/realtek_crypto.c b/drivers/crypto/real=
tek/realtek_crypto.c
new file mode 100644
index 000000000000..c325625d8e11
=2D-- /dev/null
+++ b/drivers/crypto/realtek/realtek_crypto.c
@@ -0,0 +1,475 @@
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
+#include <crypto/internal/skcipher.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+#include "realtek_crypto.h"
+
+inline int rtcr_inc_src_idx(int idx, int cnt)
+{
+	return (idx + cnt) & (RTCR_SRC_RING_SIZE - 1);
+}
+
+inline int rtcr_inc_dst_idx(int idx, int cnt)
+{
+	return (idx + cnt) & (RTCR_DST_RING_SIZE - 1);
+}
+
+inline int rtcr_inc_buf_idx(int idx, int cnt)
+{
+	return (idx + cnt) & (RTCR_BUF_RING_SIZE - 1);
+}
+
+inline int rtcr_space_plus_pad(int len)
+{
+	return (len + 31) & ~31;
+}
+
+int rtcr_alloc_ring(struct rtcr_crypto_dev *cdev, int srclen, int *srcidx=
,
+		    int *dstidx, int buflen, char **buf)
+{
+	int srcfree, dstfree, buffree, bufidx;
+	int srcalloc =3D (srclen + 1) & ~1, bufalloc =3D 0;
+	int ret =3D -ENOSPC;
+
+	spin_lock(&cdev->ringlock);
+
+	bufidx =3D cdev->cpu_buf_idx;
+	if (buflen > 0) {
+		bufalloc =3D rtcr_space_plus_pad(buflen);
+		if (bufidx + bufalloc > RTCR_BUF_RING_SIZE) {
+			if (unlikely(cdev->cpu_buf_idx > bufidx)) {
+				dev_err(cdev->dev, "buffer ring full\n");
+				goto err_nospace;
+			}
+			/* end of buffer is free but too small, skip it */
+			bufidx =3D 0;
+		}
+	}
+
+	srcfree =3D rtcr_inc_src_idx(cdev->pp_src_idx - cdev->cpu_src_idx, -1);
+	dstfree =3D rtcr_inc_dst_idx(cdev->pp_dst_idx - cdev->cpu_dst_idx, -1);
+	buffree =3D rtcr_inc_buf_idx(cdev->pp_buf_idx - bufidx, -1);
+
+	if (unlikely(srcfree < srcalloc)) {
+		dev_err(cdev->dev, "source ring full\n");
+		goto err_nospace;
+	}
+	if (unlikely(dstfree < 1)) {
+		dev_err(cdev->dev, "destination ring full\n");
+		goto err_nospace;
+	}
+	if (unlikely(buffree < bufalloc)) {
+		dev_err(cdev->dev, "buffer ring full\n");
+		goto err_nospace;
+	}
+
+	*srcidx =3D cdev->cpu_src_idx;
+	cdev->cpu_src_idx =3D rtcr_inc_src_idx(cdev->cpu_src_idx, srcalloc);
+
+	*dstidx =3D cdev->cpu_dst_idx;
+	cdev->cpu_dst_idx =3D rtcr_inc_dst_idx(cdev->cpu_dst_idx, 1);
+
+	ret =3D 0;
+	cdev->wbk_ring[*dstidx].len =3D buflen;
+	if (buflen > 0) {
+		*buf =3D &cdev->buf_ring[bufidx];
+		cdev->wbk_ring[*dstidx].src =3D *buf;
+		cdev->cpu_buf_idx =3D rtcr_inc_buf_idx(bufidx, bufalloc);
+	}
+
+err_nospace:
+	spin_unlock(&cdev->ringlock);
+
+	return ret;
+}
+
+static inline void rtcr_ack_irq(struct rtcr_crypto_dev *cdev)
+{
+	int v =3D ioread32(cdev->base + RTCR_REG_CMD);
+
+	if (unlikely((v !=3D RTCR_CMD_DDOKIP) && v))
+		dev_err(cdev->dev, "unexpected IRQ result 0x%08x\n", v);
+	v =3D RTCR_CMD_SDUEIP | RTCR_CMD_SDLEIP | RTCR_CMD_DDUEIP |
+	     RTCR_CMD_DDOKIP | RTCR_CMD_DABFIP;
+
+	iowrite32(v, cdev->base + RTCR_REG_CMD);
+}
+
+static void rtcr_done_task(unsigned long data)
+{
+	struct rtcr_crypto_dev *cdev =3D (struct rtcr_crypto_dev *)data;
+	int stop_src_idx, stop_dst_idx, idx, len;
+	struct scatterlist *sg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cdev->asiclock, flags);
+	stop_src_idx =3D cdev->asic_src_idx;
+	stop_dst_idx =3D cdev->asic_dst_idx;
+	spin_unlock_irqrestore(&cdev->asiclock, flags);
+
+	idx =3D cdev->pp_dst_idx;
+
+	while (idx !=3D stop_dst_idx) {
+		len =3D cdev->wbk_ring[idx].len;
+		switch (len) {
+		case RTCR_WB_LEN_SG_DIRECT:
+			/* already written to the destination by the engine */
+			break;
+		case RTCR_WB_LEN_HASH:
+			/* write back hash from destination ring */
+			memcpy(cdev->wbk_ring[idx].dst,
+			       cdev->dst_ring[idx].vector,
+			       RTCR_HASH_VECTOR_SIZE);
+			break;
+		default:
+			/* write back data from buffer */
+			sg =3D (struct scatterlist *)cdev->wbk_ring[idx].dst;
+			sg_pcopy_from_buffer(sg, sg_nents(sg),
+					     cdev->wbk_ring[idx].src,
+					     len, cdev->wbk_ring[idx].off);
+			len =3D rtcr_space_plus_pad(len);
+			cdev->pp_buf_idx =3D ((char *)cdev->wbk_ring[idx].src - cdev->buf_ring=
) + len;
+		}
+
+		cdev->wbk_ring[idx].len =3D RTCR_WB_LEN_DONE;
+		idx =3D rtcr_inc_dst_idx(idx, 1);
+	}
+
+	wake_up_all(&cdev->done_queue);
+	cdev->pp_src_idx =3D stop_src_idx;
+	cdev->pp_dst_idx =3D stop_dst_idx;
+}
+
+static irqreturn_t rtcr_handle_irq(int irq, void *dev_id)
+{
+	struct rtcr_crypto_dev *cdev =3D dev_id;
+	u32 p;
+
+	spin_lock(&cdev->asiclock);
+
+	rtcr_ack_irq(cdev);
+	cdev->busy =3D false;
+
+	p =3D (u32)phys_to_virt((u32)ioread32(cdev->base + RTCR_REG_SRC));
+	cdev->asic_src_idx =3D (p - (u32)cdev->src_ring) / RTCR_SRC_DESC_SIZE;
+
+	p =3D (u32)phys_to_virt((u32)ioread32(cdev->base + RTCR_REG_DST));
+	cdev->asic_dst_idx =3D (p - (u32)cdev->dst_ring) / RTCR_DST_DESC_SIZE;
+
+	tasklet_schedule(&cdev->done_task);
+	spin_unlock(&cdev->asiclock);
+
+	return IRQ_HANDLED;
+}
+
+void rtcr_add_src_ahash_to_ring(struct rtcr_crypto_dev *cdev, int idx,
+				int opmode, int totallen)
+{
+	dma_addr_t dma =3D cdev->src_dma + idx * RTCR_SRC_DESC_SIZE;
+	struct rtcr_src_desc *src =3D &cdev->src_ring[idx];
+
+	src->len =3D totallen;
+	src->opmode =3D opmode | RTCR_SRC_OP_FS |
+		      RTCR_SRC_OP_DUMMY_LEN | RTCR_SRC_OP_OWN_ASIC |
+		      RTCR_SRC_OP_CALC_EOR(idx);
+
+	dma_sync_single_for_device(cdev->dev, dma, RTCR_SRC_DESC_SIZE, DMA_TO_DE=
VICE);
+}
+
+void rtcr_add_src_skcipher_to_ring(struct rtcr_crypto_dev *cdev, int idx,
+				   int opmode, int totallen,
+				   struct rtcr_skcipher_ctx *sctx)
+{
+	dma_addr_t dma =3D cdev->src_dma + idx * RTCR_SRC_DESC_SIZE;
+	struct rtcr_src_desc *src =3D &cdev->src_ring[idx];
+
+	src->len =3D totallen;
+	if (opmode & RTCR_SRC_OP_KAM_ENC)
+		src->paddr =3D sctx->keydma;
+	else
+		src->paddr =3D sctx->keydma + AES_KEYSIZE_256;
+
+	src->opmode =3D RTCR_SRC_OP_FS | RTCR_SRC_OP_OWN_ASIC |
+		      RTCR_SRC_OP_MS_CRYPTO | RTCR_SRC_OP_CRYPT_ECB |
+		      RTCR_SRC_OP_CALC_EOR(idx) | opmode | sctx->keylen;
+
+	dma_sync_single_for_device(cdev->dev, dma, RTCR_SRC_DESC_SIZE, DMA_TO_DE=
VICE);
+}
+
+void rtcr_add_src_to_ring(struct rtcr_crypto_dev *cdev, int idx, void *va=
ddr,
+			  int blocklen, int totallen)
+{
+	dma_addr_t dma =3D cdev->src_dma + idx * RTCR_SRC_DESC_SIZE;
+	struct rtcr_src_desc *src =3D &cdev->src_ring[idx];
+
+	src->len =3D totallen;
+	src->paddr =3D virt_to_phys(vaddr);
+	src->opmode =3D RTCR_SRC_OP_OWN_ASIC | RTCR_SRC_OP_CALC_EOR(idx) | block=
len;
+
+	dma_sync_single_for_device(cdev->dev, dma, RTCR_SRC_DESC_SIZE, DMA_BIDIR=
ECTIONAL);
+}
+
+inline void rtcr_add_src_pad_to_ring(struct rtcr_crypto_dev *cdev, int id=
x, int len)
+{
+	/* align 16 byte source descriptors with 32 byte cache lines */
+	if (!(idx & 1))
+		rtcr_add_src_to_ring(cdev, idx + 1, NULL, 0, len);
+}
+
+void rtcr_add_dst_to_ring(struct rtcr_crypto_dev *cdev, int idx, void *re=
qdst,
+			  int reqlen, void *wbkdst, int wbkoff)
+{
+	dma_addr_t dma =3D cdev->dst_dma + idx * RTCR_DST_DESC_SIZE;
+	struct rtcr_dst_desc *dst =3D &cdev->dst_ring[idx];
+	struct rtcr_wbk_desc *wbk =3D &cdev->wbk_ring[idx];
+
+	dst->paddr =3D virt_to_phys(reqdst);
+	dst->opmode =3D RTCR_DST_OP_OWN_ASIC | RTCR_DST_OP_CALC_EOR(idx) | reqle=
n;
+
+	wbk->dst =3D wbkdst;
+	wbk->off =3D wbkoff;
+
+	dma_sync_single_for_device(cdev->dev, dma, RTCR_DST_DESC_SIZE, DMA_BIDIR=
ECTIONAL);
+}
+
+inline int rtcr_wait_for_request(struct rtcr_crypto_dev *cdev, int idx)
+{
+	int *len =3D &cdev->wbk_ring[idx].len;
+
+	wait_event(cdev->done_queue, *len =3D=3D RTCR_WB_LEN_DONE);
+	return 0;
+}
+
+void rtcr_kick_engine(struct rtcr_crypto_dev *cdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cdev->asiclock, flags);
+
+	if (!cdev->busy) {
+		cdev->busy =3D true;
+		/* engine needs up to 5us to reset poll bit */
+		iowrite32(RTCR_CMD_POLL, cdev->base + RTCR_REG_CMD);
+	}
+
+	spin_unlock_irqrestore(&cdev->asiclock, flags);
+}
+
+static struct rtcr_alg_template *rtcr_algs[] =3D {
+	&rtcr_ahash_md5,
+	&rtcr_ahash_sha1,
+	&rtcr_skcipher_ecb_aes,
+	&rtcr_skcipher_cbc_aes,
+	&rtcr_skcipher_ctr_aes,
+};
+
+static void rtcr_unregister_algorithms(int end)
+{
+	int i;
+
+	for (i =3D 0; i < end; i++) {
+		if (rtcr_algs[i]->type =3D=3D RTCR_ALG_SKCIPHER)
+			crypto_unregister_skcipher(&rtcr_algs[i]->alg.skcipher);
+		else
+			crypto_unregister_ahash(&rtcr_algs[i]->alg.ahash);
+	}
+}
+
+static int rtcr_register_algorithms(struct rtcr_crypto_dev *cdev)
+{
+	int i, ret =3D 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(rtcr_algs); i++) {
+		rtcr_algs[i]->cdev =3D cdev;
+		if (rtcr_algs[i]->type =3D=3D RTCR_ALG_SKCIPHER)
+			ret =3D crypto_register_skcipher(&rtcr_algs[i]->alg.skcipher);
+		else {
+			rtcr_algs[i]->alg.ahash.halg.statesize =3D
+				max(sizeof(struct rtcr_ahash_req),
+				offsetof(struct rtcr_ahash_req, vector) +
+				sizeof(union rtcr_fallback_state));
+			ret =3D crypto_register_ahash(&rtcr_algs[i]->alg.ahash);
+		}
+		if (ret)
+			goto err_cipher_algs;
+	}
+
+	return 0;
+
+err_cipher_algs:
+	rtcr_unregister_algorithms(i);
+
+	return ret;
+}
+
+static void rtcr_init_engine(struct rtcr_crypto_dev *cdev)
+{
+	int v;
+
+	v =3D ioread32(cdev->base + RTCR_REG_CMD);
+	v |=3D RTCR_CMD_SRST;
+	iowrite32(v, cdev->base + RTCR_REG_CMD);
+
+	usleep_range(10000, 20000);
+
+	iowrite32(RTCR_CTR_CKE | RTCR_CTR_SDM16 | RTCR_CTR_DDM16 |
+		  RTCR_CTR_SDUEIE | RTCR_CTR_SDLEIE | RTCR_CTR_DDUEIE |
+		  RTCR_CTR_DDOKIE | RTCR_CTR_DABFIE, cdev->base + RTCR_REG_CTR);
+
+	rtcr_ack_irq(cdev);
+	usleep_range(10000, 20000);
+}
+
+static void rtcr_exit_engine(struct rtcr_crypto_dev *cdev)
+{
+	iowrite32(0, cdev->base + RTCR_REG_CTR);
+}
+
+static void rtcr_init_rings(struct rtcr_crypto_dev *cdev)
+{
+	iowrite32(cdev->src_dma, cdev->base + RTCR_REG_SRC);
+	iowrite32(cdev->dst_dma, cdev->base + RTCR_REG_DST);
+
+	cdev->asic_dst_idx =3D cdev->asic_src_idx =3D 0;
+	cdev->cpu_src_idx =3D cdev->cpu_dst_idx =3D cdev->cpu_buf_idx =3D 0;
+	cdev->pp_src_idx =3D cdev->pp_dst_idx =3D cdev->pp_buf_idx =3D 0;
+}
+
+static int rtcr_crypto_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct rtcr_crypto_dev *cdev;
+	unsigned long flags =3D 0;
+	struct resource *res;
+	void __iomem *base;
+	int irq, ret;
+
+#ifdef CONFIG_MIPS
+	if ((cpu_dcache_line_size() !=3D 16) && (cpu_dcache_line_size() !=3D 32)=
) {
+		dev_err(dev, "cache line size not 16 or 32 bytes\n");
+		ret =3D -EINVAL;
+		goto err_map;
+	}
+#endif
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no IO address given\n");
+		ret =3D -ENODEV;
+		goto err_map;
+	}
+
+	base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR_OR_NULL(base)) {
+		dev_err(dev, "failed to map IO address\n");
+		ret =3D -EINVAL;
+		goto err_map;
+	}
+
+	cdev =3D devm_kzalloc(dev, sizeof(*cdev), GFP_KERNEL);
+	if (!cdev) {
+		dev_err(dev, "failed to allocate device memory\n");
+		ret =3D -ENOMEM;
+		goto err_mem;
+	}
+
+	irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (!irq) {
+		dev_err(dev, "failed to determine device interrupt\n");
+		ret =3D -EINVAL;
+		goto err_of_irq;
+	}
+
+	if (devm_request_irq(dev, irq, rtcr_handle_irq, flags, "realtek-crypto",=
 cdev)) {
+		dev_err(dev, "failed to request device interrupt\n");
+		ret =3D -ENXIO;
+		goto err_request_irq;
+	}
+
+	platform_set_drvdata(pdev, cdev);
+	cdev->base =3D base;
+	cdev->dev =3D dev;
+	cdev->irq =3D irq;
+	cdev->pdev =3D pdev;
+
+	cdev->src_dma =3D dma_map_single(cdev->dev, cdev->src_ring,
+				       RTCR_SRC_DESC_SIZE * RTCR_SRC_RING_SIZE, DMA_BIDIRECTIONAL);
+	cdev->dst_dma =3D dma_map_single(cdev->dev, cdev->dst_ring,
+				       RTCR_DST_DESC_SIZE * RTCR_DST_RING_SIZE, DMA_BIDIRECTIONAL);
+
+	dma_map_single(dev, (void *)empty_zero_page, PAGE_SIZE, DMA_TO_DEVICE);
+
+	init_waitqueue_head(&cdev->done_queue);
+	tasklet_init(&cdev->done_task, rtcr_done_task, (unsigned long)cdev);
+	spin_lock_init(&cdev->ringlock);
+	spin_lock_init(&cdev->asiclock);
+
+	/* Init engine first as it resets the ring pointers */
+	rtcr_init_engine(cdev);
+	rtcr_init_rings(cdev);
+	rtcr_register_algorithms(cdev);
+
+	dev_info(dev, "%d KB buffer, max %d requests of up to %d bytes\n",
+		 RTCR_BUF_RING_SIZE / 1024, RTCR_DST_RING_SIZE,
+		 RTCR_MAX_REQ_SIZE);
+	dev_info(dev, "ready for AES/SHA1/MD5 crypto acceleration\n");
+
+	return 0;
+
+err_request_irq:
+	irq_dispose_mapping(irq);
+err_of_irq:
+	kfree(cdev);
+err_mem:
+	iounmap(base);
+err_map:
+	return ret;
+}
+
+static int rtcr_crypto_remove(struct platform_device *pdev)
+{
+	struct rtcr_crypto_dev *cdev =3D platform_get_drvdata(pdev);
+
+	dma_unmap_single(cdev->dev, cdev->src_dma,
+			 RTCR_SRC_DESC_SIZE * RTCR_SRC_RING_SIZE, DMA_BIDIRECTIONAL);
+	dma_unmap_single(cdev->dev, cdev->dst_dma,
+			 RTCR_DST_DESC_SIZE * RTCR_DST_RING_SIZE, DMA_BIDIRECTIONAL);
+
+	rtcr_exit_engine(cdev);
+	rtcr_unregister_algorithms(ARRAY_SIZE(rtcr_algs));
+	tasklet_kill(&cdev->done_task);
+	return 0;
+}
+
+static const struct of_device_id rtcr_id_table[] =3D {
+	{ .compatible =3D "realtek,realtek-crypto" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtcr_id_table);
+
+static struct platform_driver rtcr_driver =3D {
+	.probe		=3D rtcr_crypto_probe,
+	.remove		=3D rtcr_crypto_remove,
+	.driver		=3D {
+		.name	=3D "realtek-crypto",
+		.of_match_table	=3D rtcr_id_table,
+	},
+};
+
+module_platform_driver(rtcr_driver);
+
+MODULE_AUTHOR("Markus Stockhausen <markus.stockhausen@gmx.de>");
+MODULE_DESCRIPTION("Support for Realtek's cryptographic engine");
+MODULE_LICENSE("GPL");
=2D-
2.38.1


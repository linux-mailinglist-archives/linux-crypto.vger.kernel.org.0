Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624875B3590
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Sep 2022 12:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIIKt4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Sep 2022 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIIKtd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Sep 2022 06:49:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273A7675
        for <linux-crypto@vger.kernel.org>; Fri,  9 Sep 2022 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662720571; x=1694256571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+32mjfsMXo8UfF9y7W2gO6DevL3N6uggAvy63V0WX1I=;
  b=VFAt2omwwSJzP0r0WFqHcGe2+6LmhcKgxVhoAR7q1pGHYa/Ylc40YNcj
   K8QcDWYWaX1wayBfnbdMIzMwDykKm2/YkWmS1HzAVGnSNse5LGwbXliap
   At6WJvqEtpgJvvE3GzpSrQhsqwNwBqUAV4/t2CT8/m/KEqbVG9q2ym/tl
   Z7Sg2LyELmkRdsFx1jSS0fl8qT9stbzKQncg7fqIpZYETbuKstVd2zcxL
   owmZGv9F2EUBFvCAJJl7fvmjKURKlPFWlzW8bMTooygftyLYG0Ym9Ra3q
   yRSvlyNG83+mZMDVgG30+htE60hySifSAWbgkFsumakdjvf2iUbemLYZv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="295031003"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="295031003"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="677115243"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 03:49:26 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 1/3] crypto: qat - fix DMA transfer direction
Date:   Fri,  9 Sep 2022 11:49:12 +0100
Message-Id: <20220909104914.3351-2-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909104914.3351-1-giovanni.cabiddu@intel.com>
References: <20220909104914.3351-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Damian Muszynski <damian.muszynski@intel.com>

When CONFIG_DMA_API_DEBUG is selected, while running the crypto self
test on the QAT crypto algorithms, the function add_dma_entry() reports
a warning similar to the one below, saying that overlapping mappings
are not supported. This occurs in tests where the input and the output
scatter list point to the same buffers (i.e. two different scatter lists
which point to the same chunks of memory).

The logic that implements the mapping uses the flag DMA_BIDIRECTIONAL
for both the input and the output scatter lists which leads to
overlapped write mappings. These are not supported by the DMA layer.

Fix by specifying the correct DMA transfer directions when mapping
buffers. For in-place operations where the input scatter list
matches the output scatter list, buffers are mapped once with
DMA_BIDIRECTIONAL, otherwise input buffers are mapped using the flag
DMA_TO_DEVICE and output buffers are mapped with DMA_FROM_DEVICE.
Overlapping a read mapping with a write mapping is a valid case in
dma-coherent devices like QAT.
The function that frees and unmaps the buffers, qat_alg_free_bufl()
has been changed accordingly to the changes to the mapping function.

   DMA-API: 4xxx 0000:06:00.0: cacheline tracking EEXIST, overlapping mappings aren't supported
   WARNING: CPU: 53 PID: 4362 at kernel/dma/debug.c:570 add_dma_entry+0x1e9/0x270
   ...
   Call Trace:
   dma_map_page_attrs+0x82/0x2d0
   ? preempt_count_add+0x6a/0xa0
   qat_alg_sgl_to_bufl+0x45b/0x990 [intel_qat]
   qat_alg_aead_dec+0x71/0x250 [intel_qat]
   crypto_aead_decrypt+0x3d/0x70
   test_aead_vec_cfg+0x649/0x810
   ? number+0x310/0x3a0
   ? vsnprintf+0x2a3/0x550
   ? scnprintf+0x42/0x70
   ? valid_sg_divisions.constprop.0+0x86/0xa0
   ? test_aead_vec+0xdf/0x120
   test_aead_vec+0xdf/0x120
   alg_test_aead+0x185/0x400
   alg_test+0x3d8/0x500
   ? crypto_acomp_scomp_free_ctx+0x30/0x30
   ? __schedule+0x32a/0x12a0
   ? ttwu_queue_wakelist+0xbf/0x110
   ? _raw_spin_unlock_irqrestore+0x23/0x40
   ? try_to_wake_up+0x83/0x570
   ? _raw_spin_unlock_irqrestore+0x23/0x40
   ? __set_cpus_allowed_ptr_locked+0xea/0x1b0
   ? crypto_acomp_scomp_free_ctx+0x30/0x30
   cryptomgr_test+0x27/0x50
   kthread+0xe6/0x110
   ? kthread_complete_and_exit+0x20/0x20
   ret_from_fork+0x1f/0x30

Fixes: d370cec ("crypto: qat - Intel(R) QAT crypto interface")
Link: https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@benyossef.com/
Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index fb45fa83841c..cad9c58caab1 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -673,11 +673,14 @@ static void qat_alg_free_bufl(struct qat_crypto_instance *inst,
 	dma_addr_t blpout = qat_req->buf.bloutp;
 	size_t sz = qat_req->buf.sz;
 	size_t sz_out = qat_req->buf.sz_out;
+	int bl_dma_dir;
 	int i;
 
+	bl_dma_dir = blp != blpout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
 	for (i = 0; i < bl->num_bufs; i++)
 		dma_unmap_single(dev, bl->bufers[i].addr,
-				 bl->bufers[i].len, DMA_BIDIRECTIONAL);
+				 bl->bufers[i].len, bl_dma_dir);
 
 	dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
 
@@ -691,7 +694,7 @@ static void qat_alg_free_bufl(struct qat_crypto_instance *inst,
 		for (i = bufless; i < blout->num_bufs; i++) {
 			dma_unmap_single(dev, blout->bufers[i].addr,
 					 blout->bufers[i].len,
-					 DMA_BIDIRECTIONAL);
+					 DMA_FROM_DEVICE);
 		}
 		dma_unmap_single(dev, blpout, sz_out, DMA_TO_DEVICE);
 
@@ -716,6 +719,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	struct scatterlist *sg;
 	size_t sz_out, sz = struct_size(bufl, bufers, n);
 	int node = dev_to_node(&GET_DEV(inst->accel_dev));
+	int bufl_dma_dir;
 
 	if (unlikely(!n))
 		return -EINVAL;
@@ -733,6 +737,8 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		qat_req->buf.sgl_src_valid = true;
 	}
 
+	bufl_dma_dir = sgl != sglout ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
 	for_each_sg(sgl, sg, n, i)
 		bufl->bufers[i].addr = DMA_MAPPING_ERROR;
 
@@ -744,7 +750,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 
 		bufl->bufers[y].addr = dma_map_single(dev, sg_virt(sg),
 						      sg->length,
-						      DMA_BIDIRECTIONAL);
+						      bufl_dma_dir);
 		bufl->bufers[y].len = sg->length;
 		if (unlikely(dma_mapping_error(dev, bufl->bufers[y].addr)))
 			goto err_in;
@@ -787,7 +793,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 
 			bufers[y].addr = dma_map_single(dev, sg_virt(sg),
 							sg->length,
-							DMA_BIDIRECTIONAL);
+							DMA_FROM_DEVICE);
 			if (unlikely(dma_mapping_error(dev, bufers[y].addr)))
 				goto err_out;
 			bufers[y].len = sg->length;
@@ -817,7 +823,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		if (!dma_mapping_error(dev, buflout->bufers[i].addr))
 			dma_unmap_single(dev, buflout->bufers[i].addr,
 					 buflout->bufers[i].len,
-					 DMA_BIDIRECTIONAL);
+					 DMA_FROM_DEVICE);
 
 	if (!qat_req->buf.sgl_dst_valid)
 		kfree(buflout);
@@ -831,7 +837,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		if (!dma_mapping_error(dev, bufl->bufers[i].addr))
 			dma_unmap_single(dev, bufl->bufers[i].addr,
 					 bufl->bufers[i].len,
-					 DMA_BIDIRECTIONAL);
+					 bufl_dma_dir);
 
 	if (!qat_req->buf.sgl_src_valid)
 		kfree(bufl);
-- 
2.37.1


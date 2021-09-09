Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AFF4056C4
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Sep 2021 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356977AbhIINXM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Sep 2021 09:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358468AbhIINLR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Sep 2021 09:11:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD946614C8;
        Thu,  9 Sep 2021 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188878;
        bh=iGPyawP9lKM8+1uNBuwR8xBjNPGLc8IRR3+Jrsahchk=;
        h=From:To:Cc:Subject:Date:From;
        b=ntDZiGqEu3F7pXULQuJUKATxydAc4KYHoneRvX2qbAX8acBk79S1dwbwSD0MY8At3
         P0ZS0XYS7OohGPts78+yCbxmpx6UaEDTVMdwpks5m6Prv3Ek2bF9S3aJZg93w187Yg
         PdvEIK6Tb8RdVP9fmWLlZ3njrbpCPw9AjdFAugIB0hT3zR1vBebCpF/E3SWs8Wmmg1
         Hd58jRUYFg4m0I9FoJu31xGp8uZVvuv6PtyWDlPwQ7k8vjbE4x7eExH0SgztTdpGvg
         xFyfhGoEBzfo24zLjsML2GBm6T5stl/kMmrrKPCR09ei+7afeARvinrjBtf2w7pvFi
         CuLK5dT+7GbBw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 01/35] crypto: mxs-dcp - Use sg_mapping_iter to copy data
Date:   Thu,  9 Sep 2021 08:00:42 -0400
Message-Id: <20210909120116.150912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

[ Upstream commit 2e6d793e1bf07fe5e20cfbbdcec9e1af7e5097eb ]

This uses the sg_pcopy_from_buffer to copy data, instead of doing it
ourselves.

In addition to reducing code size, this fixes the following oops
resulting from failing to kmap the page:

[   68.896381] Unable to handle kernel NULL pointer dereference at virtual address 00000ab8
[   68.904539] pgd = 3561adb3
[   68.907475] [00000ab8] *pgd=00000000
[   68.911153] Internal error: Oops: 805 [#1] ARM
[   68.915618] Modules linked in: cfg80211 rfkill des_generic libdes arc4 libarc4 cbc ecb algif_skcipher sha256_generic libsha256 sha1_generic hmac aes_generic libaes cmac sha512_generic md5 md4 algif_hash af_alg i2c_imx i2c_core ci_hdrc_imx ci_hdrc mxs_dcp ulpi roles udc_core imx_sdma usbmisc_imx usb_common firmware_class virt_dma phy_mxs_usb nf_tables nfnetlink ip_tables x_tables ipv6 autofs4
[   68.950741] CPU: 0 PID: 139 Comm: mxs_dcp_chan/ae Not tainted 5.10.34 #296
[   68.958501] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   68.964710] PC is at memcpy+0xa8/0x330
[   68.968479] LR is at 0xd7b2bc9d
[   68.971638] pc : [<c053e7c8>]    lr : [<d7b2bc9d>]    psr: 000f0013
[   68.977920] sp : c2cbbee4  ip : 00000010  fp : 00000010
[   68.983159] r10: 00000000  r9 : c3283a40  r8 : 1a5a6f08
[   68.988402] r7 : 4bfe0ecc  r6 : 76d8a220  r5 : c32f9050  r4 : 00000001
[   68.994945] r3 : 00000ab8  r2 : fffffff0  r1 : c32f9050  r0 : 00000ab8
[   69.001492] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   69.008646] Control: 10c53c7d  Table: 83664059  DAC: 00000051
[   69.014414] Process mxs_dcp_chan/ae (pid: 139, stack limit = 0x667b57ab)
[   69.021133] Stack: (0xc2cbbee4 to 0xc2cbc000)
[   69.025519] bee0:          c32f9050 c3235408 00000010 00000010 00000ab8 00000001 bf10406c
[   69.033720] bf00: 00000000 00000000 00000010 00000000 c32355d0 832fb080 00000000 c13de2fc
[   69.041921] bf20: c3628010 00000010 c33d5780 00000ab8 bf1067e8 00000002 c21e5010 c2cba000
[   69.050125] bf40: c32f8040 00000000 bf106a40 c32f9040 c3283a80 00000001 bf105240 c3234040
[   69.058327] bf60: ffffe000 c3204100 c2c69800 c2cba000 00000000 bf103b84 00000000 c2eddc54
[   69.066530] bf80: c3204144 c0140d1c c2cba000 c2c69800 c0140be8 00000000 00000000 00000000
[   69.074730] bfa0: 00000000 00000000 00000000 c0100114 00000000 00000000 00000000 00000000
[   69.082932] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   69.091131] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   69.099364] [<c053e7c8>] (memcpy) from [<bf10406c>] (dcp_chan_thread_aes+0x4e8/0x840 [mxs_dcp])
[   69.108117] [<bf10406c>] (dcp_chan_thread_aes [mxs_dcp]) from [<c0140d1c>] (kthread+0x134/0x160)
[   69.116941] [<c0140d1c>] (kthread) from [<c0100114>] (ret_from_fork+0x14/0x20)
[   69.124178] Exception stack(0xc2cbbfb0 to 0xc2cbbff8)
[   69.129250] bfa0:                                     00000000 00000000 00000000 00000000
[   69.137450] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   69.145648] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   69.152289] Code: e320f000 e4803004 e4804004 e4805004 (e4806004)

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/mxs-dcp.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 1a8dc76e117e..f42d8c852314 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -280,21 +280,20 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 
 	struct scatterlist *dst = req->dst;
 	struct scatterlist *src = req->src;
-	const int nents = sg_nents(req->src);
+	int dst_nents = sg_nents(dst);
 
 	const int out_off = DCP_BUF_SZ;
 	uint8_t *in_buf = sdcp->coh->aes_in_buf;
 	uint8_t *out_buf = sdcp->coh->aes_out_buf;
 
-	uint8_t *out_tmp, *src_buf, *dst_buf = NULL;
 	uint32_t dst_off = 0;
+	uint8_t *src_buf = NULL;
 	uint32_t last_out_len = 0;
 
 	uint8_t *key = sdcp->coh->aes_key;
 
 	int ret = 0;
-	int split = 0;
-	unsigned int i, len, clen, rem = 0, tlen = 0;
+	unsigned int i, len, clen, tlen = 0;
 	int init = 0;
 	bool limit_hit = false;
 
@@ -312,7 +311,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 		memset(key + AES_KEYSIZE_128, 0, AES_KEYSIZE_128);
 	}
 
-	for_each_sg(req->src, src, nents, i) {
+	for_each_sg(req->src, src, sg_nents(src), i) {
 		src_buf = sg_virt(src);
 		len = sg_dma_len(src);
 		tlen += len;
@@ -337,34 +336,17 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 			 * submit the buffer.
 			 */
 			if (actx->fill == out_off || sg_is_last(src) ||
-				limit_hit) {
+			    limit_hit) {
 				ret = mxs_dcp_run_aes(actx, req, init);
 				if (ret)
 					return ret;
 				init = 0;
 
-				out_tmp = out_buf;
+				sg_pcopy_from_buffer(dst, dst_nents, out_buf,
+						     actx->fill, dst_off);
+				dst_off += actx->fill;
 				last_out_len = actx->fill;
-				while (dst && actx->fill) {
-					if (!split) {
-						dst_buf = sg_virt(dst);
-						dst_off = 0;
-					}
-					rem = min(sg_dma_len(dst) - dst_off,
-						  actx->fill);
-
-					memcpy(dst_buf + dst_off, out_tmp, rem);
-					out_tmp += rem;
-					dst_off += rem;
-					actx->fill -= rem;
-
-					if (dst_off == sg_dma_len(dst)) {
-						dst = sg_next(dst);
-						split = 0;
-					} else {
-						split = 1;
-					}
-				}
+				actx->fill = 0;
 			}
 		} while (len);
 
-- 
2.30.2


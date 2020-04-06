Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D21A013D
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Apr 2020 00:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgDFWro (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Apr 2020 18:47:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32828 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFWrn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Apr 2020 18:47:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 89E06200EBE;
        Tue,  7 Apr 2020 00:47:41 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D524200220;
        Tue,  7 Apr 2020 00:47:41 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 170C4205A5;
        Tue,  7 Apr 2020 00:47:41 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v2 1/4] crypto: caam - fix use-after-free KASAN issue for SKCIPHER algorithms
Date:   Tue,  7 Apr 2020 01:47:25 +0300
Message-Id: <1586213248-4230-2-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
References: <1586213248-4230-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Here's the KASAN report:
BUG: KASAN: use-after-free in skcipher_crypt_done+0xe8/0x1a8
Read of size 1 at addr ffff00002304001c by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc1-00162-gfcb90d5 #57
Hardware name: LS1046A RDB Board (DT)
Call trace:
 dump_backtrace+0x0/0x260
 show_stack+0x14/0x20
 dump_stack+0xe8/0x144
 print_address_description.isra.11+0x64/0x348
 __kasan_report+0x11c/0x230
 kasan_report+0xc/0x18
 __asan_load1+0x5c/0x68
 skcipher_crypt_done+0xe8/0x1a8
 caam_jr_dequeue+0x390/0x608
 tasklet_action_common.isra.13+0x1ec/0x230
 tasklet_action+0x24/0x30
 efi_header_end+0x1a4/0x370
 irq_exit+0x114/0x128
 __handle_domain_irq+0x80/0xe0
 gic_handle_irq+0x50/0xa0
 el1_irq+0xb8/0x180
 _raw_spin_unlock_irq+0x2c/0x78
 finish_task_switch+0xa4/0x2f8
 __schedule+0x3a4/0x890
 schedule_idle+0x28/0x50
 do_idle+0x22c/0x338
 cpu_startup_entry+0x24/0x40
 rest_init+0xf8/0x10c
 arch_call_rest_init+0xc/0x14
 start_kernel+0x774/0x7b4

Allocated by task 263:
 save_stack+0x24/0xb0
 __kasan_kmalloc.isra.10+0xc4/0xe0
 kasan_kmalloc+0xc/0x18
 __kmalloc+0x178/0x2b8
 skcipher_edesc_alloc+0x21c/0x1018
 skcipher_encrypt+0x84/0x150
 crypto_skcipher_encrypt+0x50/0x68
 test_skcipher_vec_cfg+0x4d4/0xc10
 test_skcipher_vec+0xf8/0x1d8
 alg_test_skcipher+0xec/0x230
 alg_test.part.44+0x114/0x4a0
 alg_test+0x1c/0x60
 cryptomgr_test+0x34/0x58
 kthread+0x1b8/0x1c0
 ret_from_fork+0x10/0x18

Freed by task 0:
 save_stack+0x24/0xb0
 __kasan_slab_free+0x10c/0x188
 kasan_slab_free+0x10/0x18
 kfree+0x7c/0x298
 skcipher_crypt_done+0xe0/0x1a8
 caam_jr_dequeue+0x390/0x608
 tasklet_action_common.isra.13+0x1ec/0x230
 tasklet_action+0x24/0x30
 efi_header_end+0x1a4/0x370

The buggy address belongs to the object at ffff000023040000
 which belongs to the cache dma-kmalloc-512 of size 512
The buggy address is located 28 bytes inside of
 512-byte region [ffff000023040000, ffff000023040200)
The buggy address belongs to the page:
page:fffffe00006c1000 refcount:1 mapcount:0 mapping:ffff00093200c400 index:0x0 compound_mapcount: 0
flags: 0xffff00000010200(slab|head)
raw: 0ffff00000010200 dead000000000100 dead000000000122 ffff00093200c400
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00002303ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff00002303ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff000023040000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff000023040080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff000023040100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: ee38767f152a ("crypto: caam - support crypto_engine framework for SKCIPHER algorithms")
Cc: <stable@vger.kernel.org> # v5.6
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index b7bb7c3..86be876 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -995,10 +995,12 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(jrdev);
 	int ivsize = crypto_skcipher_ivsize(skcipher);
 	int ecode = 0;
+	bool has_bklog;
 
 	dev_dbg(jrdev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
 
 	edesc = rctx->edesc;
+	has_bklog = edesc->bklog;
 	if (err)
 		ecode = caam_jr_strstatus(jrdev, err);
 
@@ -1028,7 +1030,7 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 	 * If no backlog flag, the completion of the request is done
 	 * by CAAM, not crypto engine.
 	 */
-	if (!edesc->bklog)
+	if (!has_bklog)
 		skcipher_request_complete(req, ecode);
 	else
 		crypto_finalize_skcipher_request(jrp->engine, req, ecode);
-- 
2.1.0


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0368B525
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Feb 2023 06:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBFFTF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Feb 2023 00:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBFFTF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Feb 2023 00:19:05 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89619196B0
        for <linux-crypto@vger.kernel.org>; Sun,  5 Feb 2023 21:19:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pOtty-007tft-95; Mon, 06 Feb 2023 13:18:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Feb 2023 13:18:50 +0800
Date:   Mon, 6 Feb 2023 13:18:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Derek Chickles <dchickles@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>
Subject: [PATCH] crypto: octeontx2 - Fix objects shared between several
 modules
Message-ID: <Y+CNuieL3rqgrfip@gondor.apana.org.au>
References: <20221119225650.1044591-1-alobakin@pm.me>
 <20221119225650.1044591-14-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119225650.1044591-14-alobakin@pm.me>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>

cn10k_cpt.o, otx2_cptlf.o and otx2_cpt_mbox_common.o are linked
into both rvu_cptpf and rvu_cptvf modules:

> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile:
> cn10k_cpt.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile:
> otx2_cptlf.o is added to multiple modules: rvu_cptpf rvu_cptvf
> scripts/Makefile.build:252: ./drivers/crypto/marvell/octeontx2/Makefile:
> otx2_cpt_mbox_common.o is added to multiple modules: rvu_cptpf rvu_cptvf

Despite they're build under the same Kconfig option
(CONFIG_CRYPTO_DEV_OCTEONTX2_CPT), it's better do link the common
code into a standalone module and export the shared functions. Under
certain circumstances, this can lead to the same situation as fixed
by commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects").
Plus, those three common object files are relatively big to duplicate
them several times.

Introduce the new module, rvu_cptcommon, to provide the common
functions to both modules.

Fixes: 19d8e8c7be15 ("crypto: octeontx2 - add virtual function driver support")
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/marvell/octeontx2/Makefile          | 11 +++++------
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c       |  9 +++++++--
 drivers/crypto/marvell/octeontx2/cn10k_cpt.h       |  2 --
 drivers/crypto/marvell/octeontx2/otx2_cpt_common.h |  2 --
 .../marvell/octeontx2/otx2_cpt_mbox_common.c       | 14 ++++++++++++--
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      | 11 +++++++++++
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |  2 ++
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |  2 ++
 8 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/Makefile b/drivers/crypto/marvell/octeontx2/Makefile
index 965297e96954..f0f2942c1d27 100644
--- a/drivers/crypto/marvell/octeontx2/Makefile
+++ b/drivers/crypto/marvell/octeontx2/Makefile
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_CRYPTO_DEV_OCTEONTX2_CPT) += rvu_cptpf.o rvu_cptvf.o
+obj-$(CONFIG_CRYPTO_DEV_OCTEONTX2_CPT) += rvu_cptcommon.o rvu_cptpf.o rvu_cptvf.o

+rvu_cptcommon-objs := cn10k_cpt.o otx2_cptlf.o otx2_cpt_mbox_common.o
 rvu_cptpf-objs := otx2_cptpf_main.o otx2_cptpf_mbox.o \
-		  otx2_cpt_mbox_common.o otx2_cptpf_ucode.o otx2_cptlf.o \
-		  cn10k_cpt.o otx2_cpt_devlink.o
-rvu_cptvf-objs := otx2_cptvf_main.o otx2_cptvf_mbox.o otx2_cptlf.o \
-		  otx2_cpt_mbox_common.o otx2_cptvf_reqmgr.o \
-		  otx2_cptvf_algs.o cn10k_cpt.o
+		  otx2_cptpf_ucode.o otx2_cpt_devlink.o
+rvu_cptvf-objs := otx2_cptvf_main.o otx2_cptvf_mbox.o \
+		  otx2_cptvf_reqmgr.o otx2_cptvf_algs.o

 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
index 1499ef75b5c2..93d22b328991 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
@@ -7,6 +7,9 @@
 #include "otx2_cptlf.h"
 #include "cn10k_cpt.h"

+static void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
+			       struct otx2_cptlf_info *lf);
+
 static struct cpt_hw_ops otx2_hw_ops = {
 	.send_cmd = otx2_cpt_send_cmd,
 	.cpt_get_compcode = otx2_cpt_get_compcode,
@@ -19,8 +22,8 @@ static struct cpt_hw_ops cn10k_hw_ops = {
 	.cpt_get_uc_compcode = cn10k_cpt_get_uc_compcode,
 };

-void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
-			struct otx2_cptlf_info *lf)
+static void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
+			       struct otx2_cptlf_info *lf)
 {
 	void __iomem *lmtline = lf->lmtline;
 	u64 val = (lf->slot & 0x7FF);
@@ -68,6 +71,7 @@ int cn10k_cptpf_lmtst_init(struct otx2_cptpf_dev *cptpf)

 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cn10k_cptpf_lmtst_init, CRYPTO_DEV_OCTEONTX2_CPT);

 int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf)
 {
@@ -91,3 +95,4 @@ int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf)

 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cn10k_cptvf_lmtst_init, CRYPTO_DEV_OCTEONTX2_CPT);
diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.h b/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
index c091392b47e0..aaefc7e38e06 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
@@ -28,8 +28,6 @@ static inline u8 otx2_cpt_get_uc_compcode(union otx2_cpt_res_s *result)
 	return ((struct cn9k_cpt_res_s *)result)->uc_compcode;
 }

-void cn10k_cpt_send_cmd(union otx2_cpt_inst_s *cptinst, u32 insts_num,
-			struct otx2_cptlf_info *lf);
 int cn10k_cptpf_lmtst_init(struct otx2_cptpf_dev *cptpf);
 int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf);

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index 5012b7e669f0..6019066a6451 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -145,8 +145,6 @@ int otx2_cpt_send_mbox_msg(struct otx2_mbox *mbox, struct pci_dev *pdev);

 int otx2_cpt_send_af_reg_requests(struct otx2_mbox *mbox,
 				  struct pci_dev *pdev);
-int otx2_cpt_add_read_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,
-			     u64 reg, u64 *val, int blkaddr);
 int otx2_cpt_add_write_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,
 			      u64 reg, u64 val, int blkaddr);
 int otx2_cpt_read_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
index a317319696ef..115997475beb 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
@@ -19,6 +19,7 @@ int otx2_cpt_send_mbox_msg(struct otx2_mbox *mbox, struct pci_dev *pdev)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_send_mbox_msg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_send_ready_msg(struct otx2_mbox *mbox, struct pci_dev *pdev)
 {
@@ -36,14 +37,17 @@ int otx2_cpt_send_ready_msg(struct otx2_mbox *mbox, struct pci_dev *pdev)

 	return otx2_cpt_send_mbox_msg(mbox, pdev);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_send_ready_msg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_send_af_reg_requests(struct otx2_mbox *mbox, struct pci_dev *pdev)
 {
 	return otx2_cpt_send_mbox_msg(mbox, pdev);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_send_af_reg_requests, CRYPTO_DEV_OCTEONTX2_CPT);

-int otx2_cpt_add_read_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,
-			     u64 reg, u64 *val, int blkaddr)
+static int otx2_cpt_add_read_af_reg(struct otx2_mbox *mbox,
+				    struct pci_dev *pdev, u64 reg,
+				    u64 *val, int blkaddr)
 {
 	struct cpt_rd_wr_reg_msg *reg_msg;

@@ -91,6 +95,7 @@ int otx2_cpt_add_write_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,

 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_add_write_af_reg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_read_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,
 			 u64 reg, u64 *val, int blkaddr)
@@ -103,6 +108,7 @@ int otx2_cpt_read_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,

 	return otx2_cpt_send_mbox_msg(mbox, pdev);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_read_af_reg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_write_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,
 			  u64 reg, u64 val, int blkaddr)
@@ -115,6 +121,7 @@ int otx2_cpt_write_af_reg(struct otx2_mbox *mbox, struct pci_dev *pdev,

 	return otx2_cpt_send_mbox_msg(mbox, pdev);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_write_af_reg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_attach_rscrs_msg(struct otx2_cptlfs_info *lfs)
 {
@@ -170,6 +177,7 @@ int otx2_cpt_detach_rsrcs_msg(struct otx2_cptlfs_info *lfs)

 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_detach_rsrcs_msg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_msix_offset_msg(struct otx2_cptlfs_info *lfs)
 {
@@ -202,6 +210,7 @@ int otx2_cpt_msix_offset_msg(struct otx2_cptlfs_info *lfs)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_msix_offset_msg, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cpt_sync_mbox_msg(struct otx2_mbox *mbox)
 {
@@ -216,3 +225,4 @@ int otx2_cpt_sync_mbox_msg(struct otx2_mbox *mbox)

 	return otx2_mbox_check_rsp_msgs(mbox, 0);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_sync_mbox_msg, CRYPTO_DEV_OCTEONTX2_CPT);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index c8350fcd60fa..fc484cb05c0f 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -274,6 +274,8 @@ void otx2_cptlf_unregister_interrupts(struct otx2_cptlfs_info *lfs)
 	}
 	cptlf_disable_intrs(lfs);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cptlf_unregister_interrupts,
+		     CRYPTO_DEV_OCTEONTX2_CPT);

 static int cptlf_do_register_interrrupts(struct otx2_cptlfs_info *lfs,
 					 int lf_num, int irq_offset,
@@ -321,6 +323,7 @@ int otx2_cptlf_register_interrupts(struct otx2_cptlfs_info *lfs)
 	otx2_cptlf_unregister_interrupts(lfs);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cptlf_register_interrupts, CRYPTO_DEV_OCTEONTX2_CPT);

 void otx2_cptlf_free_irqs_affinity(struct otx2_cptlfs_info *lfs)
 {
@@ -334,6 +337,7 @@ void otx2_cptlf_free_irqs_affinity(struct otx2_cptlfs_info *lfs)
 		free_cpumask_var(lfs->lf[slot].affinity_mask);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cptlf_free_irqs_affinity, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cptlf_set_irqs_affinity(struct otx2_cptlfs_info *lfs)
 {
@@ -366,6 +370,7 @@ int otx2_cptlf_set_irqs_affinity(struct otx2_cptlfs_info *lfs)
 	otx2_cptlf_free_irqs_affinity(lfs);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cptlf_set_irqs_affinity, CRYPTO_DEV_OCTEONTX2_CPT);

 int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 		    int lfs_num)
@@ -422,6 +427,7 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 	lfs->lfs_num = 0;
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cptlf_init, CRYPTO_DEV_OCTEONTX2_CPT);

 void otx2_cptlf_shutdown(struct otx2_cptlfs_info *lfs)
 {
@@ -431,3 +437,8 @@ void otx2_cptlf_shutdown(struct otx2_cptlfs_info *lfs)
 	/* Send request to detach LFs */
 	otx2_cpt_detach_rsrcs_msg(lfs);
 }
+EXPORT_SYMBOL_NS_GPL(otx2_cptlf_shutdown, CRYPTO_DEV_OCTEONTX2_CPT);
+
+MODULE_AUTHOR("Marvell");
+MODULE_DESCRIPTION("Marvell RVU CPT Common module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index a402ccfac557..ddf6e913c1c4 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -831,6 +831,8 @@ static struct pci_driver otx2_cpt_pci_driver = {

 module_pci_driver(otx2_cpt_pci_driver);

+MODULE_IMPORT_NS(CRYPTO_DEV_OCTEONTX2_CPT);
+
 MODULE_AUTHOR("Marvell");
 MODULE_DESCRIPTION(OTX2_CPT_DRV_STRING);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 3411e664cf50..392e9fee05e8 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -429,6 +429,8 @@ static struct pci_driver otx2_cptvf_pci_driver = {

 module_pci_driver(otx2_cptvf_pci_driver);

+MODULE_IMPORT_NS(CRYPTO_DEV_OCTEONTX2_CPT);
+
 MODULE_AUTHOR("Marvell");
 MODULE_DESCRIPTION("Marvell RVU CPT Virtual Function Driver");
 MODULE_LICENSE("GPL v2");
--
2.38.1
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

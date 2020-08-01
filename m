Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4AA235269
	for <lists+linux-crypto@lfdr.de>; Sat,  1 Aug 2020 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgHAMmy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 1 Aug 2020 08:42:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:44000 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgHAMmy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 1 Aug 2020 08:42:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1qqf-0000de-R0; Sat, 01 Aug 2020 22:42:50 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 01 Aug 2020 22:42:49 +1000
Date:   Sat, 1 Aug 2020 22:42:49 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Aymen Sghaier <aymen.sghaier@nxp.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [v2 PATCH] crypto: caam - Move debugfs fops into standalone file
Message-ID: <20200801124249.GA18580@gondor.apana.org.au>
References: <20200730135426.GA13682@gondor.apana.org.au>
 <c7fa483a-8f57-ee12-3c72-68c770ba4e00@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7fa483a-8f57-ee12-3c72-68c770ba4e00@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 31, 2020 at 07:46:07PM +0300, Horia Geantă wrote:
>
> Below hunk is needed for fixing the compilation when CONFIG_DEBUG_FS=y:

Thanks for catching this.  The NULL pointer assignments are also
a bit iffy.  So here is an updated version:

---8<---
Currently the debugfs fops are defined in caam/intern.h.  This causes
problems because it creates identical static functions and variables
in multiple files.  It also creates warnings when those files don't
use the fops.

This patch moves them into a standalone file, debugfs.c.

It also removes unnecessary uses of ifdefs on CONFIG_DEBUG_FS.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/caam/Makefile b/drivers/crypto/caam/Makefile
index 68d5cc0f28e2..3570286eb9ce 100644
--- a/drivers/crypto/caam/Makefile
+++ b/drivers/crypto/caam/Makefile
@@ -27,6 +27,8 @@ ifneq ($(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI),)
 	ccflags-y += -DCONFIG_CAAM_QI
 endif
 
+caam-$(CONFIG_DEBUG_FS) += debugfs.o
+
 obj-$(CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM) += dpaa2_caam.o
 
 dpaa2_caam-y    := caamalg_qi2.o dpseci.o
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 94502f1d4b48..44c69b6fb8c4 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -13,6 +13,7 @@
 #include <linux/fsl/mc.h>
 
 #include "compat.h"
+#include "debugfs.h"
 #include "regs.h"
 #include "intern.h"
 #include "jr.h"
@@ -582,12 +583,10 @@ static int init_clocks(struct device *dev, const struct caam_imx_data *data)
 	return devm_add_action_or_reset(dev, disable_clocks, ctrlpriv);
 }
 
-#ifdef CONFIG_DEBUG_FS
 static void caam_remove_debugfs(void *root)
 {
 	debugfs_remove_recursive(root);
 }
-#endif
 
 #ifdef CONFIG_FSL_MC_BUS
 static bool check_version(struct fsl_mc_version *mc_version, u32 major,
@@ -613,21 +612,22 @@ static bool check_version(struct fsl_mc_version *mc_version, u32 major,
 static int caam_probe(struct platform_device *pdev)
 {
 	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	struct debugfs_blob_wrapper blob0 __maybe_unused;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
 	struct device_node *nprop, *np;
 	struct caam_ctrl __iomem *ctrl;
 	struct caam_drv_private *ctrlpriv;
-#ifdef CONFIG_DEBUG_FS
+	struct debugfs_blob_wrapper *blob;
 	struct caam_perfmon *perfmon;
 	struct dentry *dfs_root;
-#endif
 	u32 scfgr, comp_params;
 	u8 rng_vid;
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool pr_support = false;
+	struct dentry *ctl;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -777,7 +777,6 @@ static int caam_probe(struct platform_device *pdev)
 	ctrlpriv->era = caam_get_era(ctrl);
 	ctrlpriv->domain = iommu_get_domain_for_dev(dev);
 
-#ifdef CONFIG_DEBUG_FS
 	/*
 	 * FIXME: needs better naming distinction, as some amalgamation of
 	 * "caam" and nprop->full_name. The OF name isn't distinctive,
@@ -786,11 +785,16 @@ static int caam_probe(struct platform_device *pdev)
 	perfmon = (struct caam_perfmon __force *)&ctrl->perfmon;
 
 	dfs_root = debugfs_create_dir(dev_name(dev), NULL);
-	ret = devm_add_action_or_reset(dev, caam_remove_debugfs, dfs_root);
-	if (ret)
-		return ret;
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		ret = devm_add_action_or_reset(dev, caam_remove_debugfs,
+					       dfs_root);
+		if (ret)
+			return ret;
+	}
 
-	ctrlpriv->ctl = debugfs_create_dir("ctl", dfs_root);
+	ctl = debugfs_create_dir("ctl", dfs_root);
+#ifdef CONFIG_DEBUG_FS
+	ctrlpriv->ctl = ctl;
 #endif
 
 	/* Check to see if (DPAA 1.x) QI present. If so, enable */
@@ -912,56 +916,54 @@ static int caam_probe(struct platform_device *pdev)
 	dev_info(dev, "job rings = %d, qi = %d\n",
 		 ctrlpriv->total_jobrs, ctrlpriv->qi_present);
 
-#ifdef CONFIG_DEBUG_FS
-	debugfs_create_file("rq_dequeued", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->req_dequeued,
-			    &caam_fops_u64_ro);
-	debugfs_create_file("ob_rq_encrypted", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->ob_enc_req,
-			    &caam_fops_u64_ro);
-	debugfs_create_file("ib_rq_decrypted", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->ib_dec_req,
-			    &caam_fops_u64_ro);
-	debugfs_create_file("ob_bytes_encrypted", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->ob_enc_bytes,
-			    &caam_fops_u64_ro);
-	debugfs_create_file("ob_bytes_protected", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->ob_prot_bytes,
-			    &caam_fops_u64_ro);
-	debugfs_create_file("ib_bytes_decrypted", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->ib_dec_bytes,
-			    &caam_fops_u64_ro);
-	debugfs_create_file("ib_bytes_validated", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->ib_valid_bytes,
-			    &caam_fops_u64_ro);
+	caam_debugfs_create_file_u64("rq_dequeued",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->req_dequeued);
+	caam_debugfs_create_file_u64("ob_rq_encrypted",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->ob_enc_req);
+	caam_debugfs_create_file_u64("ib_rq_decrypted",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->ib_dec_req);
+	caam_debugfs_create_file_u64("ob_bytes_encrypted",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->ob_enc_bytes);
+	caam_debugfs_create_file_u64("ob_bytes_protected",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->ob_prot_bytes);
+	caam_debugfs_create_file_u64("ib_bytes_decrypted",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->ib_dec_bytes);
+	caam_debugfs_create_file_u64("ib_bytes_validated",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->ib_valid_bytes);
 
 	/* Controller level - global status values */
-	debugfs_create_file("fault_addr", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->faultaddr,
-			    &caam_fops_u32_ro);
-	debugfs_create_file("fault_detail", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->faultdetail,
-			    &caam_fops_u32_ro);
-	debugfs_create_file("fault_status", S_IRUSR | S_IRGRP | S_IROTH,
-			    ctrlpriv->ctl, &perfmon->status,
-			    &caam_fops_u32_ro);
+	caam_debugfs_create_file_u32("fault_addr",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->faultaddr);
+	caam_debugfs_create_file_u32("fault_detail",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->faultdetail);
+	caam_debugfs_create_file_u32("fault_status",
+				     S_IRUSR | S_IRGRP | S_IROTH,
+				     ctl, &perfmon->status);
 
 	/* Internal covering keys (useful in non-secure mode only) */
-	ctrlpriv->ctl_kek_wrap.data = (__force void *)&ctrlpriv->ctrl->kek[0];
-	ctrlpriv->ctl_kek_wrap.size = KEK_KEY_SIZE * sizeof(u32);
-	debugfs_create_blob("kek", S_IRUSR | S_IRGRP | S_IROTH, ctrlpriv->ctl,
-			    &ctrlpriv->ctl_kek_wrap);
-
-	ctrlpriv->ctl_tkek_wrap.data = (__force void *)&ctrlpriv->ctrl->tkek[0];
-	ctrlpriv->ctl_tkek_wrap.size = KEK_KEY_SIZE * sizeof(u32);
-	debugfs_create_blob("tkek", S_IRUSR | S_IRGRP | S_IROTH, ctrlpriv->ctl,
-			    &ctrlpriv->ctl_tkek_wrap);
-
-	ctrlpriv->ctl_tdsk_wrap.data = (__force void *)&ctrlpriv->ctrl->tdsk[0];
-	ctrlpriv->ctl_tdsk_wrap.size = KEK_KEY_SIZE * sizeof(u32);
-	debugfs_create_blob("tdsk", S_IRUSR | S_IRGRP | S_IROTH, ctrlpriv->ctl,
-			    &ctrlpriv->ctl_tdsk_wrap);
-#endif
+	blob = caam_debugfs_ptr(&ctrlpriv->ctl_kek_wrap, &blob0);
+	blob->data = (__force void *)&ctrlpriv->ctrl->kek[0];
+	blob->size = KEK_KEY_SIZE * sizeof(u32);
+	debugfs_create_blob("kek", S_IRUSR | S_IRGRP | S_IROTH, ctl, blob);
+
+	blob = caam_debugfs_ptr(&ctrlpriv->ctl_tkek_wrap, &blob0);
+	blob->data = (__force void *)&ctrlpriv->ctrl->tkek[0];
+	blob->size = KEK_KEY_SIZE * sizeof(u32);
+	debugfs_create_blob("tkek", S_IRUSR | S_IRGRP | S_IROTH, ctl, blob);
+
+	blob = caam_debugfs_ptr(&ctrlpriv->ctl_tdsk_wrap, &blob0);
+	blob->data = (__force void *)&ctrlpriv->ctrl->tdsk[0];
+	blob->size = KEK_KEY_SIZE * sizeof(u32);
+	debugfs_create_blob("tdsk", S_IRUSR | S_IRGRP | S_IROTH, ctl, blob);
 
 	ret = devm_of_platform_populate(dev);
 	if (ret)
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
new file mode 100644
index 000000000000..f300feecf40b
--- /dev/null
+++ b/drivers/crypto/caam/debugfs.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2019 NXP */
+
+#include <linux/debugfs.h>
+#include "debugfs.h"
+#include "regs.h"
+
+static int caam_debugfs_u64_get(void *data, u64 *val)
+{
+	*val = caam64_to_cpu(*(u64 *)data);
+	return 0;
+}
+
+static int caam_debugfs_u32_get(void *data, u64 *val)
+{
+	*val = caam32_to_cpu(*(u32 *)data);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u32_ro, caam_debugfs_u32_get, NULL, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u64_ro, caam_debugfs_u64_get, NULL, "%llu\n");
+
+struct dentry *caam_debugfs_create_file_u32(const char *name, umode_t mode,
+					    struct dentry *parent, void *data)
+{
+	return debugfs_create_file(name, mode, parent, data,
+				   &caam_fops_u32_ro);
+}
+
+struct dentry *caam_debugfs_create_file_u64(const char *name, umode_t mode,
+					    struct dentry *parent, void *data)
+{
+	return debugfs_create_file(name, mode, parent, data,
+				   &caam_fops_u64_ro);
+}
diff --git a/drivers/crypto/caam/debugfs.h b/drivers/crypto/caam/debugfs.h
new file mode 100644
index 000000000000..0e9001538108
--- /dev/null
+++ b/drivers/crypto/caam/debugfs.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2019 NXP */
+
+#ifndef CAAM_DEBUGFS_H
+#define CAAM_DEBUGFS_H
+
+#include <linux/err.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+struct dentry;
+
+#ifdef CONFIG_DEBUG_FS
+#define caam_debugfs_ptr(X, Y) X
+
+struct dentry *caam_debugfs_create_file_u32(const char *name, umode_t mode,
+					    struct dentry *parent, void *data);
+struct dentry *caam_debugfs_create_file_u64(const char *name, umode_t mode,
+					    struct dentry *parent, void *data);
+#else
+#define caam_debugfs_ptr(X, Y) Y
+
+static inline struct dentry *caam_debugfs_create_file_u32(
+	const char *name, umode_t mode, struct dentry *parent, void *data)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct dentry *caam_debugfs_create_file_u64(
+	const char *name, umode_t mode, struct dentry *parent, void *data)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* CAAM_DEBUGFS_H */
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 402d6a362e8c..9112279a4de0 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -195,23 +195,6 @@ static inline void caam_qi_algapi_exit(void)
 
 #endif /* CONFIG_CAAM_QI */
 
-#ifdef CONFIG_DEBUG_FS
-static int caam_debugfs_u64_get(void *data, u64 *val)
-{
-	*val = caam64_to_cpu(*(u64 *)data);
-	return 0;
-}
-
-static int caam_debugfs_u32_get(void *data, u64 *val)
-{
-	*val = caam32_to_cpu(*(u32 *)data);
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u32_ro, caam_debugfs_u32_get, NULL, "%llu\n");
-DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u64_ro, caam_debugfs_u64_get, NULL, "%llu\n");
-#endif
-
 static inline u64 caam_get_dma_mask(struct device *dev)
 {
 	struct device_node *nprop = dev->of_node;
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index b390b935db6d..aa61205e9477 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -11,6 +11,7 @@
 #include <linux/kthread.h>
 #include <soc/fsl/qman.h>
 
+#include "debugfs.h"
 #include "regs.h"
 #include "qi.h"
 #include "desc.h"
@@ -776,8 +777,8 @@ int caam_qi_init(struct platform_device *caam_pdev)
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	debugfs_create_file("qi_congested", 0444, ctrlpriv->ctl,
-			    &times_congested, &caam_fops_u64_ro);
+	caam_debugfs_create_file_u64("qi_congested", 0444, ctrlpriv->ctl,
+				     &times_congested);
 #endif
 
 	err = devm_add_action_or_reset(qidev, caam_qi_shutdown, ctrlpriv);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

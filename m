Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE88535D9DE
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Apr 2021 10:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbhDMIU1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 13 Apr 2021 04:20:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229585AbhDMIU1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 13 Apr 2021 04:20:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D83HIK158211;
        Tue, 13 Apr 2021 04:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yn+F7kfFvpNI5ZpGauX/Xr3LQHJBS9TkgyZRmOQBWsQ=;
 b=pCjFMw6UgZjEljqejgBLjpJ/PRX3sMYWzEEfGRCioinK1LiGldxAsELeJLrxF5zxWaTA
 v+vUJxA5BzcH1QVcO2Qr4s7xpS2OEPkKCnYFo30HIwmCgvOwVP3/bm+382uKJm+NOnvO
 1d09vqnb3MhWiqdTtrM2GKSA6aMhi5mhjI1lCLXtrOcgw8CkNt+HqZe6OZDb+ZLPwZnP
 1CrJVzYEkNecUbPlL2M2SYp8nfgYO0I/pREOoU1zJ2HDb1q4wLRmIbezkBhb+Povrz16
 Y5PoPIPZsGga9bN0NhS/lcmCT2lcKKvID8DiAMxoN3bUIzo4I4RdGbg7CJnp6Ap0ne82 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnt0c6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 04:20:00 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13D83PoP158827;
        Tue, 13 Apr 2021 04:19:59 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnt0c6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 04:19:59 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13D7w19t015385;
        Tue, 13 Apr 2021 08:19:59 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 37u3n9y2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 08:19:59 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13D8JxWl35717384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 08:19:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFC2AB2065;
        Tue, 13 Apr 2021 08:19:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1491B2064;
        Tue, 13 Apr 2021 08:19:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.232.48])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 08:19:57 +0000 (GMT)
Message-ID: <c4178e5927c264fb51ab80994fe8c7cbff3e144f.camel@linux.ibm.com>
Subject: [V2 PATCH 02/16] powerpc/vas: Make VAS API powerpc platform
 independent
From:   Haren Myneni <haren@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        mpe@ellerman.id.au, herbert@gondor.apana.org.au, npiggin@gmail.com
Cc:     hbabu@us.ibm.com, haren@linux.ibm.com
Date:   Tue, 13 Apr 2021 01:19:55 -0700
In-Reply-To: <68aa9f2860f9acffa41469d3858883c938634722.camel@linux.ibm.com>
References: <68aa9f2860f9acffa41469d3858883c938634722.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DOSa89CHl_4Yy3rQfjtB-mRTe0Y0mrnW
X-Proofpoint-ORIG-GUID: knRRfLOkEADCJmXDV1rvPeQF-4iBHvll
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_03:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130055
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Using the same /dev/crypto/nx-gzip interface for both powerNV and
pseries. So this patch moves VAS API to powerpc platform indepedent
directory. The actual functionality is not changed in this patch.

Common interface functions such as open, window open ioctl, mmap
and close are moved to arch/powerpc/kernel/vas-api.c. Added
hooks to call platform specific code, but the underline powerNV
code in these functions is not changed.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/include/asm/vas.h                | 22 ++++++-
 arch/powerpc/kernel/Makefile                  |  1 +
 .../{platforms/powernv => kernel}/vas-api.c   | 64 ++++++++++--------
 arch/powerpc/platforms/Kconfig                | 15 +++++
 arch/powerpc/platforms/powernv/Kconfig        | 14 ----
 arch/powerpc/platforms/powernv/Makefile       |  2 +-
 arch/powerpc/platforms/powernv/vas-window.c   | 66 +++++++++++++++++++
 7 files changed, 140 insertions(+), 44 deletions(-)
 rename arch/powerpc/{platforms/powernv => kernel}/vas-api.c (83%)

diff --git a/arch/powerpc/include/asm/vas.h
b/arch/powerpc/include/asm/vas.h
index 41f73fae7ab8..6bbade60d8f4 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -5,6 +5,8 @@
 
 #ifndef _ASM_POWERPC_VAS_H
 #define _ASM_POWERPC_VAS_H
+#include <uapi/asm/vas-api.h>
+
 
 struct vas_window;
 
@@ -48,6 +50,16 @@ enum vas_cop_type {
 	VAS_COP_TYPE_MAX,
 };
 
+/*
+ * User space window operations used for powernv and powerVM
+ */
+struct vas_user_win_ops {
+	struct vas_window * (*open_win)(struct vas_tx_win_open_attr *,
+				enum vas_cop_type);
+	u64 (*paste_addr)(void *);
+	int (*close_win)(void *);
+};
+
 /*
  * Receive window attributes specified by the (in-kernel) owner of
window.
  */
@@ -161,6 +173,9 @@ int vas_copy_crb(void *crb, int offset);
  * assumed to be true for NX windows.
  */
 int vas_paste_crb(struct vas_window *win, int offset, bool re);
+int vas_register_api_powernv(struct module *mod, enum vas_cop_type
cop_type,
+			     const char *name);
+void vas_unregister_api_powernv(void);
 
 /*
  * Register / unregister coprocessor type to VAS API which will be
exported
@@ -170,8 +185,9 @@ int vas_paste_crb(struct vas_window *win, int
offset, bool re);
  * Only NX GZIP coprocessor type is supported now, but this API can be
  * used for others in future.
  */
-int vas_register_api_powernv(struct module *mod, enum vas_cop_type
cop_type,
-			     const char *name);
-void vas_unregister_api_powernv(void);
+int vas_register_coproc_api(struct module *mod, enum vas_cop_type
cop_type,
+			    const char *name,
+			    struct vas_user_win_ops *vops);
+void vas_unregister_coproc_api(void);
 
 #endif /* __ASM_POWERPC_VAS_H */
diff --git a/arch/powerpc/kernel/Makefile
b/arch/powerpc/kernel/Makefile
index f66b63e81c3b..e4a9ff11b23d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_PPC_UDBG_16550)	+=
legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
 obj-$(CONFIG_ARCH_HAS_DMA_SET_MASK) += dma-mask.o
+obj-$(CONFIG_PPC_VAS)		+= vas-api.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o pci-hotplug.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
diff --git a/arch/powerpc/platforms/powernv/vas-api.c
b/arch/powerpc/kernel/vas-api.c
similarity index 83%
rename from arch/powerpc/platforms/powernv/vas-api.c
rename to arch/powerpc/kernel/vas-api.c
index 72d8ce39e56c..05d7b99acf41 100644
--- a/arch/powerpc/platforms/powernv/vas-api.c
+++ b/arch/powerpc/kernel/vas-api.c
@@ -4,15 +4,20 @@
  * Copyright (C) 2019 Haren Myneni, IBM Corp
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/kthread.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/mm.h>
+#include <linux/mmu_context.h>
 #include <asm/vas.h>
+#include <asm/icswx.h>
 #include <uapi/asm/vas-api.h>
-#include "vas.h"
 
 /*
  * The driver creates the device node that can be used as follows:
@@ -42,6 +47,7 @@ static struct coproc_dev {
 	dev_t devt;
 	struct class *class;
 	enum vas_cop_type cop_type;
+	struct vas_user_win_ops *vops;
 } coproc_device;
 
 struct coproc_instance {
@@ -72,11 +78,10 @@ static int coproc_open(struct inode *inode, struct
file *fp)
 static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
 {
 	void __user *uptr = (void __user *)arg;
-	struct vas_tx_win_attr txattr = {};
 	struct vas_tx_win_open_attr uattr;
 	struct coproc_instance *cp_inst;
 	struct vas_window *txwin;
-	int rc, vasid;
+	int rc;
 
 	cp_inst = fp->private_data;
 
@@ -93,27 +98,20 @@ static int coproc_ioc_tx_win_open(struct file *fp,
unsigned long arg)
 	}
 
 	if (uattr.version != 1) {
-		pr_err("Invalid version\n");
+		pr_err("Invalid window open API version\n");
 		return -EINVAL;
 	}
 
-	vasid = uattr.vas_id;
-
-	vas_init_tx_win_attr(&txattr, cp_inst->coproc->cop_type);
-
-	txattr.lpid = mfspr(SPRN_LPID);
-	txattr.pidr = mfspr(SPRN_PID);
-	txattr.user_win = true;
-	txattr.rsvd_txbuf_count = false;
-	txattr.pswid = false;
-
-	pr_devel("Pid %d: Opening txwin, PIDR %ld\n", txattr.pidr,
-				mfspr(SPRN_PID));
+	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->open_win) 
{
+		pr_err("VAS API is not registered\n");
+		return -EACCES;
+	}
 
-	txwin = vas_tx_win_open(vasid, cp_inst->coproc->cop_type,
&txattr);
+	txwin = cp_inst->coproc->vops->open_win(&uattr,
+					cp_inst->coproc->cop_type);
 	if (IS_ERR(txwin)) {
-		pr_err("%s() vas_tx_win_open() failed, %ld\n",
__func__,
-					PTR_ERR(txwin));
+		pr_err("%s() VAS window open failed, %ld\n", __func__,
+				PTR_ERR(txwin));
 		return PTR_ERR(txwin);
 	}
 
@@ -125,9 +123,14 @@ static int coproc_ioc_tx_win_open(struct file *fp,
unsigned long arg)
 static int coproc_release(struct inode *inode, struct file *fp)
 {
 	struct coproc_instance *cp_inst = fp->private_data;
+	int rc = 0;
 
 	if (cp_inst->txwin) {
-		vas_win_close(cp_inst->txwin);
+		if (cp_inst->coproc->vops && cp_inst->coproc->vops-
>close_win) {
+			rc = cp_inst->coproc->vops->close_win(cp_inst-
>txwin);
+			if (rc)
+				return rc;
+		}
 		cp_inst->txwin = NULL;
 	}
 
@@ -168,7 +171,17 @@ static int coproc_mmap(struct file *fp, struct
vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	vas_win_paste_addr(txwin, &paste_addr, NULL);
+	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops-
>paste_addr) {
+		pr_err("%s(): VAS API is not registered\n", __func__);
+		return -EACCES;
+	}
+
+	paste_addr = cp_inst->coproc->vops->paste_addr(txwin);
+	if (!paste_addr) {
+		pr_err("%s(): Window paste address failed\n",
__func__);
+		return -EINVAL;
+	}
+
 	pfn = paste_addr >> PAGE_SHIFT;
 
 	/* flags, page_prot from cxl_mmap(), except we want cachable */
@@ -207,8 +220,8 @@ static struct file_operations coproc_fops = {
  * Supporting only nx-gzip coprocessor type now, but this API code
  * extended to other coprocessor types later.
  */
-int vas_register_api_powernv(struct module *mod, enum vas_cop_type
cop_type,
-			     const char *name)
+int vas_register_coproc_api(struct module *mod, enum vas_cop_type
cop_type,
+			const char *name, struct vas_user_win_ops
*vops)
 {
 	int rc = -EINVAL;
 	dev_t devno;
@@ -230,6 +243,7 @@ int vas_register_api_powernv(struct module *mod,
enum vas_cop_type cop_type,
 	}
 	coproc_device.class->devnode = coproc_devnode;
 	coproc_device.cop_type = cop_type;
+	coproc_device.vops = vops;
 
 	coproc_fops.owner = mod;
 	cdev_init(&coproc_device.cdev, &coproc_fops);
@@ -262,9 +276,8 @@ int vas_register_api_powernv(struct module *mod,
enum vas_cop_type cop_type,
 	unregister_chrdev_region(coproc_device.devt, 1);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(vas_register_api_powernv);
 
-void vas_unregister_api_powernv(void)
+void vas_unregister_coproc_api(void)
 {
 	dev_t devno;
 
@@ -275,4 +288,3 @@ void vas_unregister_api_powernv(void)
 	class_destroy(coproc_device.class);
 	unregister_chrdev_region(coproc_device.devt, 1);
 }
-EXPORT_SYMBOL_GPL(vas_unregister_api_powernv);
diff --git a/arch/powerpc/platforms/Kconfig
b/arch/powerpc/platforms/Kconfig
index 7a5e8f4541e3..1b14dc7343f3 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -69,6 +69,21 @@ config PPC_DT_CPU_FTRS
 	  firmware provides this binding.
 	  If you're not sure say Y.
 
+config PPC_VAS
+	bool "IBM Virtual Accelerator Switchboard (VAS)"
+	depends on PPC_POWERNV && PPC_64K_PAGES
+	default y
+	help
+	  This enables support for IBM Virtual Accelerator Switchboard
(VAS).
+
+	  VAS allows accelerators in co-processors like NX-GZIP and NX-
842
+	  to be accessible to kernel subsystems and user processes.
+	  VAS adapters are found in POWER9 and later based systems.
+	  The user mode NX-GZIP support is added on P9 for powerNV and
on
+	  P10 for powerVM.
+
+	  If unsure, say "N".
+
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
 	depends on PPC_RTAS
diff --git a/arch/powerpc/platforms/powernv/Kconfig
b/arch/powerpc/platforms/powernv/Kconfig
index 619b093a0657..043eefbbdd28 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -33,20 +33,6 @@ config PPC_MEMTRACE
 	  Enabling this option allows for runtime allocation of memory
(RAM)
 	  for hardware tracing.
 
-config PPC_VAS
-	bool "IBM Virtual Accelerator Switchboard (VAS)"
-	depends on PPC_POWERNV && PPC_64K_PAGES
-	default y
-	help
-	  This enables support for IBM Virtual Accelerator Switchboard
(VAS).
-
-	  VAS allows accelerators in co-processors like NX-GZIP and NX-
842
-	  to be accessible to kernel subsystems and user processes.
-
-	  VAS adapters are found in POWER9 based systems.
-
-	  If unsure, say N.
-
 config SCOM_DEBUGFS
 	bool "Expose SCOM controllers via debugfs"
 	depends on DEBUG_FS
diff --git a/arch/powerpc/platforms/powernv/Makefile
b/arch/powerpc/platforms/powernv/Makefile
index 2eb6ae150d1f..c747a1f1d25b 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
 obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
-obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o vas-fault.o
vas-api.o
+obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o vas-fault.o
 obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
 obj-$(CONFIG_SCOM_DEBUGFS) += opal-xscom.o
 obj-$(CONFIG_PPC_SECURE_BOOT) += opal-secvar.o
diff --git a/arch/powerpc/platforms/powernv/vas-window.c
b/arch/powerpc/platforms/powernv/vas-window.c
index 5f5fe63a3d1c..b973dd574b47 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -16,6 +16,8 @@
 #include <linux/mmu_context.h>
 #include <asm/switch_to.h>
 #include <asm/ppc-opcode.h>
+#include <asm/vas.h>
+#include <uapi/asm/vas-api.h>
 #include "vas.h"
 #include "copy-paste.h"
 
@@ -1441,3 +1443,67 @@ struct vas_window *vas_pswid_to_window(struct
vas_instance *vinst,
 
 	return window;
 }
+
+static struct vas_window *vas_user_win_open(struct
vas_tx_win_open_attr *uattr,
+				enum vas_cop_type cop_type)
+{
+	struct vas_tx_win_attr txattr = {};
+
+	vas_init_tx_win_attr(&txattr, cop_type);
+
+	txattr.lpid = mfspr(SPRN_LPID);
+	txattr.pidr = mfspr(SPRN_PID);
+	txattr.user_win = true;
+	txattr.rsvd_txbuf_count = false;
+	txattr.pswid = false;
+
+	pr_devel("Pid %d: Opening txwin, PIDR %ld\n", txattr.pidr,
+				mfspr(SPRN_PID));
+
+	return vas_tx_win_open(uattr->vas_id, cop_type, &txattr);
+}
+
+static u64 vas_user_win_paste_addr(void *addr)
+{
+	u64 paste_addr;
+
+	vas_win_paste_addr((struct vas_window *)addr, &paste_addr,
NULL);
+
+	return paste_addr;
+}
+
+static int vas_user_win_close(void *addr)
+{
+	struct vas_window *txwin = addr;
+
+	vas_win_close(txwin);
+
+	return 0;
+}
+
+static struct vas_user_win_ops vops =  {
+	.open_win	=	vas_user_win_open,
+	.paste_addr	=	vas_user_win_paste_addr,
+	.close_win	=	vas_user_win_close,
+};
+
+/*
+ * Supporting only nx-gzip coprocessor type now, but this API code
+ * extended to other coprocessor types later.
+ */
+int vas_register_api_powernv(struct module *mod, enum vas_cop_type
cop_type,
+				const char *name)
+{
+	int rc;
+
+	rc = vas_register_coproc_api(mod, cop_type, name, &vops);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vas_register_api_powernv);
+
+void vas_unregister_api_powernv(void)
+{
+	vas_unregister_coproc_api();
+}
+EXPORT_SYMBOL_GPL(vas_unregister_api_powernv);
-- 
2.18.2



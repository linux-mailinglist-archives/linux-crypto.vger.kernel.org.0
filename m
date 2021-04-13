Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80235D9EF
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Apr 2021 10:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhDMIXl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 13 Apr 2021 04:23:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229446AbhDMIXk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 13 Apr 2021 04:23:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D83GO0158185;
        Tue, 13 Apr 2021 04:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mw6EMzbdpMpg25BHJTf5cjqRD7VjavNBwfG7Zi21oiQ=;
 b=eh85GiiQ4SL+15bDknHMDy4e2W3gro5gDQ6UMlKQ6O9nkhhmJN0JRcu5NCd3DDQrZ8LN
 ytJQ/8CinBJD4ulE0hcOgBbpy0v6g8tgRSKJ1qyaKcdUJc3ynpOnQHs9l1GlyVA/LSlo
 B9XAPJ31c/vm19Becxm9/JL+KPbAzR+WWAoT8MXw7cf/kgWDMWfb8voMDGxmS8QmFVF6
 ZQ01J2jUbjBrx/UeqSl6QLTmB5Fmu0FXo786omSeiAU+YOTyupkD0m2QyOLtb5lPoVS/
 TcaRw0IjM1qlA0DpJGLxYc3dG4aeav9NnAwT4XbyUcxYoHY40oCLqM77tn+bUaqQc7Sz Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnt0f8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 04:23:13 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13D84QGh165293;
        Tue, 13 Apr 2021 04:23:13 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37vtnt0f8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 04:23:13 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13D8LxrV009864;
        Tue, 13 Apr 2021 08:23:12 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 37uhcmkc8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 08:23:12 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13D8NB8B25624980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 08:23:11 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D042D136053;
        Tue, 13 Apr 2021 08:23:11 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B6B713604F;
        Tue, 13 Apr 2021 08:23:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.232.48])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 13 Apr 2021 08:23:10 +0000 (GMT)
Message-ID: <5407f08a02231fd7f4b879c33ee508d3bcd44588.camel@linux.ibm.com>
Subject: [V2 PATCH 05/16] powerpc/vas:  Define and use common vas_window
 struct
From:   Haren Myneni <haren@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        mpe@ellerman.id.au, herbert@gondor.apana.org.au, npiggin@gmail.com
Cc:     hbabu@us.ibm.com
Date:   Tue, 13 Apr 2021 01:23:08 -0700
In-Reply-To: <68aa9f2860f9acffa41469d3858883c938634722.camel@linux.ibm.com>
References: <68aa9f2860f9acffa41469d3858883c938634722.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jvJLYsnuuKnZ0RlodPeu1qwEEdXBiC25
X-Proofpoint-ORIG-GUID: _6Me2CsxFmfa0UOnR7wqV_snQrp0NrVO
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


Same vas_window struct is used on powerNV and pseries. So this patch
changes in struct vas_window to support both platforms and also the
corresponding modifications in powerNV vas code.

On powerNV vas_window is used for both TX and RX windows, whereas
only for TX windows on powerVM. So some elements are specific to
these platforms.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/include/asm/vas.h              |  48 ++++++++
 arch/powerpc/platforms/powernv/vas-debug.c  |  12 +-
 arch/powerpc/platforms/powernv/vas-fault.c  |   4 +-
 arch/powerpc/platforms/powernv/vas-trace.h  |   6 +-
 arch/powerpc/platforms/powernv/vas-window.c | 129 +++++++++++---------
 arch/powerpc/platforms/powernv/vas.h        |  38 +-----
 6 files changed, 135 insertions(+), 102 deletions(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 66bf8fb1a1be..f928bf4c7e98 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -69,6 +69,54 @@ struct vas_win_task {
 	struct mm_struct *mm;	/* Linux process mm_struct */
 };
 
+/*
+ * In-kernel state a VAS window. One per window.
+ * powerVM: Used only for Tx windows.
+ * powerNV: Used for both Tx and Rx windows.
+ */
+struct vas_window {
+	u32 winid;
+	u32 wcreds_max;	/* Window credits */
+	enum vas_cop_type cop;
+	struct vas_win_task task;
+	char *dbgname;
+	struct dentry *dbgdir;
+	union {
+		/* powerNV specific data */
+		struct {
+			void *vinst;	/* points to VAS instance */
+			bool tx_win;	/* True if send window */
+			bool nx_win;	/* True if NX window */
+			bool user_win;	/* True if user space window */
+			void *hvwc_map;	/* HV window context */
+			void *uwc_map;	/* OS/User window context */
+
+			/* Fields applicable only to send windows */
+			void *paste_kaddr;
+			char *paste_addr_name;
+			struct vas_window *rxwin;
+
+			atomic_t num_txwins;	/* Only for receive windows */
+		} pnv;
+		struct {
+			u64 win_addr;	/* Physical paste address */
+			u8 win_type;	/* QoS or Default window */
+			u8 status;
+			u32 complete_irq;	/* Completion interrupt */
+			u32 fault_irq;	/* Fault interrupt */
+			u64 domain[6];	/* Associativity domain Ids */
+					/* this window is allocated */
+			u64 util;
+
+			/* List of windows opened which is used for LPM */
+			struct list_head win_list;
+			u64 flags;
+			char *name;
+			int fault_virq;
+		} lpar;
+	};
+};
+
 static inline void vas_drop_reference_task(struct vas_win_task *task)
 {
 	/* Drop references to pid and mm */
diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index 41fa90d2f4ab..80f735449ab8 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <asm/vas.h>
 #include "vas.h"
 
 static struct dentry *vas_debugfs;
@@ -33,11 +34,11 @@ static int info_show(struct seq_file *s, void *private)
 	mutex_lock(&vas_mutex);
 
 	/* ensure window is not unmapped */
-	if (!window->hvwc_map)
+	if (!window->pnv.hvwc_map)
 		goto unlock;
 
 	seq_printf(s, "Type: %s, %s\n", cop_to_str(window->cop),
-					window->tx_win ? "Send" : "Receive");
+				window->pnv.tx_win ? "Send" : "Receive");
 	seq_printf(s, "Pid : %d\n", vas_window_pid(window));
 
 unlock:
@@ -60,7 +61,7 @@ static int hvwc_show(struct seq_file *s, void *private)
 	mutex_lock(&vas_mutex);
 
 	/* ensure window is not unmapped */
-	if (!window->hvwc_map)
+	if (!window->pnv.hvwc_map)
 		goto unlock;
 
 	print_reg(s, window, VREG(LPID));
@@ -115,9 +116,10 @@ void vas_window_free_dbgdir(struct vas_window *window)
 
 void vas_window_init_dbgdir(struct vas_window *window)
 {
+	struct vas_instance *vinst = window->pnv.vinst;
 	struct dentry *d;
 
-	if (!window->vinst->dbgdir)
+	if (!vinst->dbgdir)
 		return;
 
 	window->dbgname = kzalloc(16, GFP_KERNEL);
@@ -126,7 +128,7 @@ void vas_window_init_dbgdir(struct vas_window *window)
 
 	snprintf(window->dbgname, 16, "w%d", window->winid);
 
-	d = debugfs_create_dir(window->dbgname, window->vinst->dbgdir);
+	d = debugfs_create_dir(window->dbgname, vinst->dbgdir);
 	window->dbgdir = d;
 
 	debugfs_create_file("info", 0444, d, window, &info_fops);
diff --git a/arch/powerpc/platforms/powernv/vas-fault.c b/arch/powerpc/platforms/powernv/vas-fault.c
index 2e898eac1bb2..82acede2d892 100644
--- a/arch/powerpc/platforms/powernv/vas-fault.c
+++ b/arch/powerpc/platforms/powernv/vas-fault.c
@@ -152,10 +152,10 @@ irqreturn_t vas_fault_thread_fn(int irq, void *data)
 			/*
 			 * NX sees faults only with user space windows.
 			 */
-			if (window->user_win)
+			if (window->pnv.user_win)
 				vas_update_csb(crb, &window->task);
 			else
-				WARN_ON_ONCE(!window->user_win);
+				WARN_ON_ONCE(!window->pnv.user_win);
 
 			/*
 			 * Return credit for send window after processing
diff --git a/arch/powerpc/platforms/powernv/vas-trace.h b/arch/powerpc/platforms/powernv/vas-trace.h
index a449b9f0c12e..843aae37c07a 100644
--- a/arch/powerpc/platforms/powernv/vas-trace.h
+++ b/arch/powerpc/platforms/powernv/vas-trace.h
@@ -95,9 +95,11 @@ TRACE_EVENT(	vas_paste_crb,
 
 		TP_fast_assign(
 			__entry->pid = tsk->pid;
-			__entry->vasid = win->vinst->vas_id;
+			__entry->vasid =
+				((struct vas_instance *)win->pnv.vinst)->vas_id;
 			__entry->winid = win->winid;
-			__entry->paste_kaddr = (unsigned long)win->paste_kaddr
+			__entry->paste_kaddr =
+				(unsigned long)win->pnv.paste_kaddr;
 		),
 
 		TP_printk("pid=%d, vasid=%d, winid=%d, paste_kaddr=0x%016lx\n",
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 58e3d16c316f..254be61c73ab 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -32,9 +32,10 @@ void vas_win_paste_addr(struct vas_window *window, u64 *addr, int *len)
 {
 	int winid;
 	u64 base, shift;
+	struct vas_instance *vinst = window->pnv.vinst;
 
-	base = window->vinst->paste_base_addr;
-	shift = window->vinst->paste_win_id_shift;
+	base = vinst->paste_base_addr;
+	shift = vinst->paste_win_id_shift;
 	winid = window->winid;
 
 	*addr  = base + (winid << shift);
@@ -47,9 +48,10 @@ void vas_win_paste_addr(struct vas_window *window, u64 *addr, int *len)
 static inline void get_hvwc_mmio_bar(struct vas_window *window,
 			u64 *start, int *len)
 {
+	struct vas_instance *vinst = window->pnv.vinst;
 	u64 pbaddr;
 
-	pbaddr = window->vinst->hvwc_bar_start;
+	pbaddr = vinst->hvwc_bar_start;
 	*start = pbaddr + window->winid * VAS_HVWC_SIZE;
 	*len = VAS_HVWC_SIZE;
 }
@@ -57,9 +59,10 @@ static inline void get_hvwc_mmio_bar(struct vas_window *window,
 static inline void get_uwc_mmio_bar(struct vas_window *window,
 			u64 *start, int *len)
 {
+	struct vas_instance *vinst = window->pnv.vinst;
 	u64 pbaddr;
 
-	pbaddr = window->vinst->uwc_bar_start;
+	pbaddr = vinst->uwc_bar_start;
 	*start = pbaddr + window->winid * VAS_UWC_SIZE;
 	*len = VAS_UWC_SIZE;
 }
@@ -75,13 +78,14 @@ static void *map_paste_region(struct vas_window *txwin)
 	void *map;
 	char *name;
 	u64 start;
+	struct vas_instance *vinst = txwin->pnv.vinst;
 
-	name = kasprintf(GFP_KERNEL, "window-v%d-w%d", txwin->vinst->vas_id,
+	name = kasprintf(GFP_KERNEL, "window-v%d-w%d", vinst->vas_id,
 				txwin->winid);
 	if (!name)
 		goto free_name;
 
-	txwin->paste_addr_name = name;
+	txwin->pnv.paste_addr_name = name;
 	vas_win_paste_addr(txwin, &start, &len);
 
 	if (!request_mem_region(start, len, name)) {
@@ -139,12 +143,12 @@ static void unmap_paste_region(struct vas_window *window)
 	int len;
 	u64 busaddr_start;
 
-	if (window->paste_kaddr) {
+	if (window->pnv.paste_kaddr) {
 		vas_win_paste_addr(window, &busaddr_start, &len);
-		unmap_region(window->paste_kaddr, busaddr_start, len);
-		window->paste_kaddr = NULL;
-		kfree(window->paste_addr_name);
-		window->paste_addr_name = NULL;
+		unmap_region(window->pnv.paste_kaddr, busaddr_start, len);
+		window->pnv.paste_kaddr = NULL;
+		kfree(window->pnv.paste_addr_name);
+		window->pnv.paste_addr_name = NULL;
 	}
 }
 
@@ -164,11 +168,11 @@ static void unmap_winctx_mmio_bars(struct vas_window *window)
 
 	mutex_lock(&vas_mutex);
 
-	hvwc_map = window->hvwc_map;
-	window->hvwc_map = NULL;
+	hvwc_map = window->pnv.hvwc_map;
+	window->pnv.hvwc_map = NULL;
 
-	uwc_map = window->uwc_map;
-	window->uwc_map = NULL;
+	uwc_map = window->pnv.uwc_map;
+	window->pnv.uwc_map = NULL;
 
 	mutex_unlock(&vas_mutex);
 
@@ -194,12 +198,12 @@ static int map_winctx_mmio_bars(struct vas_window *window)
 	u64 start;
 
 	get_hvwc_mmio_bar(window, &start, &len);
-	window->hvwc_map = map_mmio_region("HVWCM_Window", start, len);
+	window->pnv.hvwc_map = map_mmio_region("HVWCM_Window", start, len);
 
 	get_uwc_mmio_bar(window, &start, &len);
-	window->uwc_map = map_mmio_region("UWCM_Window", start, len);
+	window->pnv.uwc_map = map_mmio_region("UWCM_Window", start, len);
 
-	if (!window->hvwc_map || !window->uwc_map) {
+	if (!window->pnv.hvwc_map || !window->pnv.uwc_map) {
 		unmap_winctx_mmio_bars(window);
 		return -1;
 	}
@@ -524,7 +528,7 @@ static int vas_assign_window_id(struct ida *ida)
 static void vas_window_free(struct vas_window *window)
 {
 	int winid = window->winid;
-	struct vas_instance *vinst = window->vinst;
+	struct vas_instance *vinst = window->pnv.vinst;
 
 	unmap_winctx_mmio_bars(window);
 
@@ -548,7 +552,7 @@ static struct vas_window *vas_window_alloc(struct vas_instance *vinst)
 	if (!window)
 		goto out_free;
 
-	window->vinst = vinst;
+	window->pnv.vinst = vinst;
 	window->winid = winid;
 
 	if (map_winctx_mmio_bars(window))
@@ -567,9 +571,9 @@ static struct vas_window *vas_window_alloc(struct vas_instance *vinst)
 static void put_rx_win(struct vas_window *rxwin)
 {
 	/* Better not be a send window! */
-	WARN_ON_ONCE(rxwin->tx_win);
+	WARN_ON_ONCE(rxwin->pnv.tx_win);
 
-	atomic_dec(&rxwin->num_txwins);
+	atomic_dec(&rxwin->pnv.num_txwins);
 }
 
 /*
@@ -592,7 +596,7 @@ static struct vas_window *get_user_rxwin(struct vas_instance *vinst, u32 pswid)
 
 	rxwin = vinst->windows[winid];
 
-	if (!rxwin || rxwin->tx_win || rxwin->cop != VAS_COP_TYPE_FTW)
+	if (!rxwin || rxwin->pnv.tx_win || rxwin->cop != VAS_COP_TYPE_FTW)
 		return ERR_PTR(-EINVAL);
 
 	return rxwin;
@@ -617,7 +621,7 @@ static struct vas_window *get_vinst_rxwin(struct vas_instance *vinst,
 		rxwin = vinst->rxwin[cop] ?: ERR_PTR(-EINVAL);
 
 	if (!IS_ERR(rxwin))
-		atomic_inc(&rxwin->num_txwins);
+		atomic_inc(&rxwin->pnv.num_txwins);
 
 	mutex_unlock(&vinst->mutex);
 
@@ -650,7 +654,7 @@ static void set_vinst_win(struct vas_instance *vinst,
 	 * There should only be one receive window for a coprocessor type
 	 * unless its a user (FTW) window.
 	 */
-	if (!window->user_win && !window->tx_win) {
+	if (!window->pnv.user_win && !window->pnv.tx_win) {
 		WARN_ON_ONCE(vinst->rxwin[window->cop]);
 		vinst->rxwin[window->cop] = window;
 	}
@@ -668,11 +672,11 @@ static void set_vinst_win(struct vas_instance *vinst,
 static void clear_vinst_win(struct vas_window *window)
 {
 	int id = window->winid;
-	struct vas_instance *vinst = window->vinst;
+	struct vas_instance *vinst = window->pnv.vinst;
 
 	mutex_lock(&vinst->mutex);
 
-	if (!window->user_win && !window->tx_win) {
+	if (!window->pnv.user_win && !window->pnv.tx_win) {
 		WARN_ON_ONCE(!vinst->rxwin[window->cop]);
 		vinst->rxwin[window->cop] = NULL;
 	}
@@ -687,6 +691,8 @@ static void init_winctx_for_rxwin(struct vas_window *rxwin,
 			struct vas_rx_win_attr *rxattr,
 			struct vas_winctx *winctx)
 {
+	struct vas_instance *vinst;
+
 	/*
 	 * We first zero (memset()) all fields and only set non-zero fields.
 	 * Following fields are 0/false but maybe deserve a comment:
@@ -751,8 +757,9 @@ static void init_winctx_for_rxwin(struct vas_window *rxwin,
 
 	winctx->min_scope = VAS_SCOPE_LOCAL;
 	winctx->max_scope = VAS_SCOPE_VECTORED_GROUP;
-	if (rxwin->vinst->virq)
-		winctx->irq_port = rxwin->vinst->irq_port;
+	vinst = rxwin->pnv.vinst;
+	if (vinst->virq)
+		winctx->irq_port = vinst->irq_port;
 }
 
 static bool rx_win_args_valid(enum vas_cop_type cop,
@@ -875,9 +882,9 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 		return rxwin;
 	}
 
-	rxwin->tx_win = false;
-	rxwin->nx_win = rxattr->nx_win;
-	rxwin->user_win = rxattr->user_win;
+	rxwin->pnv.tx_win = false;
+	rxwin->pnv.nx_win = rxattr->nx_win;
+	rxwin->pnv.user_win = rxattr->user_win;
 	rxwin->cop = cop;
 	rxwin->wcreds_max = rxattr->wcreds_max;
 
@@ -911,6 +918,8 @@ static void init_winctx_for_txwin(struct vas_window *txwin,
 			struct vas_tx_win_attr *txattr,
 			struct vas_winctx *winctx)
 {
+	struct vas_instance *vinst = txwin->pnv.vinst;
+
 	/*
 	 * We first zero all fields and only set non-zero ones. Following
 	 * are some fields set to 0/false for the stated reason:
@@ -931,7 +940,7 @@ static void init_winctx_for_txwin(struct vas_window *txwin,
 	winctx->wcreds_max = txwin->wcreds_max;
 
 	winctx->user_win = txattr->user_win;
-	winctx->nx_win = txwin->rxwin->nx_win;
+	winctx->nx_win = txwin->pnv.rxwin->pnv.nx_win;
 	winctx->pin_win = txattr->pin_win;
 	winctx->rej_no_credit = txattr->rej_no_credit;
 	winctx->rsvd_txbuf_enable = txattr->rsvd_txbuf_enable;
@@ -948,23 +957,23 @@ static void init_winctx_for_txwin(struct vas_window *txwin,
 
 	winctx->lpid = txattr->lpid;
 	winctx->pidr = txattr->pidr;
-	winctx->rx_win_id = txwin->rxwin->winid;
+	winctx->rx_win_id = txwin->pnv.rxwin->winid;
 	/*
 	 * IRQ and fault window setup is successful. Set fault window
 	 * for the send window so that ready to handle faults.
 	 */
-	if (txwin->vinst->virq)
-		winctx->fault_win_id = txwin->vinst->fault_win->winid;
+	if (vinst->virq)
+		winctx->fault_win_id = vinst->fault_win->winid;
 
 	winctx->dma_type = VAS_DMA_TYPE_INJECT;
 	winctx->tc_mode = txattr->tc_mode;
 	winctx->min_scope = VAS_SCOPE_LOCAL;
 	winctx->max_scope = VAS_SCOPE_VECTORED_GROUP;
-	if (txwin->vinst->virq)
-		winctx->irq_port = txwin->vinst->irq_port;
+	if (vinst->virq)
+		winctx->irq_port = vinst->irq_port;
 
 	winctx->pswid = txattr->pswid ? txattr->pswid :
-			encode_pswid(txwin->vinst->vas_id, txwin->winid);
+			encode_pswid(vinst->vas_id, txwin->winid);
 }
 
 static bool tx_win_args_valid(enum vas_cop_type cop,
@@ -1032,10 +1041,10 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 	}
 
 	txwin->cop = cop;
-	txwin->tx_win = 1;
-	txwin->rxwin = rxwin;
-	txwin->nx_win = txwin->rxwin->nx_win;
-	txwin->user_win = attr->user_win;
+	txwin->pnv.tx_win = 1;
+	txwin->pnv.rxwin = rxwin;
+	txwin->pnv.nx_win = txwin->pnv.rxwin->pnv.nx_win;
+	txwin->pnv.user_win = attr->user_win;
 	txwin->wcreds_max = attr->wcreds_max ?: VAS_WCREDS_DEFAULT;
 
 	init_winctx_for_txwin(txwin, attr, &winctx);
@@ -1050,10 +1059,10 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 	 * NOTE: If kernel ever resubmits a user CRB after handling a page
 	 *	 fault, we will need to map this into kernel as well.
 	 */
-	if (!txwin->user_win) {
-		txwin->paste_kaddr = map_paste_region(txwin);
-		if (IS_ERR(txwin->paste_kaddr)) {
-			rc = PTR_ERR(txwin->paste_kaddr);
+	if (!txwin->pnv.user_win) {
+		txwin->pnv.paste_kaddr = map_paste_region(txwin);
+		if (IS_ERR(txwin->pnv.paste_kaddr)) {
+			rc = PTR_ERR(txwin->pnv.paste_kaddr);
 			goto free_window;
 		}
 	} else {
@@ -1105,9 +1114,9 @@ int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
 	 * report-enable flag is set for NX windows. Ensure software
 	 * complies too.
 	 */
-	WARN_ON_ONCE(txwin->nx_win && !re);
+	WARN_ON_ONCE(txwin->pnv.nx_win && !re);
 
-	addr = txwin->paste_kaddr;
+	addr = txwin->pnv.paste_kaddr;
 	if (re) {
 		/*
 		 * Set the REPORT_ENABLE bit (equivalent to writing
@@ -1154,7 +1163,7 @@ static void poll_window_credits(struct vas_window *window)
 	int count = 0;
 
 	val = read_hvwc_reg(window, VREG(WINCTL));
-	if (window->tx_win)
+	if (window->pnv.tx_win)
 		mode = GET_FIELD(VAS_WINCTL_TX_WCRED_MODE, val);
 	else
 		mode = GET_FIELD(VAS_WINCTL_RX_WCRED_MODE, val);
@@ -1162,7 +1171,7 @@ static void poll_window_credits(struct vas_window *window)
 	if (!mode)
 		return;
 retry:
-	if (window->tx_win) {
+	if (window->pnv.tx_win) {
 		val = read_hvwc_reg(window, VREG(TX_WCRED));
 		creds = GET_FIELD(VAS_TX_WCRED, val);
 	} else {
@@ -1278,7 +1287,7 @@ int vas_win_close(struct vas_window *window)
 	if (!window)
 		return 0;
 
-	if (!window->tx_win && atomic_read(&window->num_txwins) != 0) {
+	if (!window->pnv.tx_win && atomic_read(&window->pnv.num_txwins) != 0) {
 		pr_devel("Attempting to close an active Rx window!\n");
 		WARN_ON_ONCE(1);
 		return -EBUSY;
@@ -1297,11 +1306,11 @@ int vas_win_close(struct vas_window *window)
 	poll_window_castout(window);
 
 	/* if send window, drop reference to matching receive window */
-	if (window->tx_win) {
-		if (window->user_win)
+	if (window->pnv.tx_win) {
+		if (window->pnv.user_win)
 			vas_drop_reference_task(&window->task);
 
-		put_rx_win(window->rxwin);
+		put_rx_win(window->pnv.rxwin);
 	}
 
 	vas_window_free(window);
@@ -1385,12 +1394,12 @@ struct vas_window *vas_pswid_to_window(struct vas_instance *vinst,
 	 * since their CRBs are ignored (not queued on FIFO or processed
 	 * by NX).
 	 */
-	if (!window->tx_win || !window->user_win || !window->nx_win ||
-			window->cop == VAS_COP_TYPE_FAULT ||
-			window->cop == VAS_COP_TYPE_FTW) {
+	if (!window->pnv.tx_win || !window->pnv.user_win ||
+		!window->pnv.nx_win || window->cop == VAS_COP_TYPE_FAULT ||
+		window->cop == VAS_COP_TYPE_FTW) {
 		pr_err("PSWID decode: id %d, tx %d, user %d, nx %d, cop %d\n",
-			winid, window->tx_win, window->user_win,
-			window->nx_win, window->cop);
+			winid, window->pnv.tx_win, window->pnv.user_win,
+			window->pnv.nx_win, window->cop);
 		WARN_ON(1);
 	}
 
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index f7aa2d04cd16..72ccb2f692cc 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -345,34 +345,6 @@ struct vas_instance {
 	struct dentry *dbgdir;
 };
 
-/*
- * In-kernel state a VAS window. One per window.
- */
-struct vas_window {
-	/* Fields common to send and receive windows */
-	struct vas_instance *vinst;
-	int winid;
-	bool tx_win;		/* True if send window */
-	bool nx_win;		/* True if NX window */
-	bool user_win;		/* True if user space window */
-	void *hvwc_map;		/* HV window context */
-	void *uwc_map;		/* OS/User window context */
-	int wcreds_max;		/* Window credits */
-
-	struct vas_win_task task;
-	char *dbgname;
-	struct dentry *dbgdir;
-
-	/* Fields applicable only to send windows */
-	void *paste_kaddr;
-	char *paste_addr_name;
-	struct vas_window *rxwin;
-
-	/* Feilds applicable only to receive windows */
-	enum vas_cop_type cop;
-	atomic_t num_txwins;
-};
-
 /*
  * Container for the hardware state of a window. One per-window.
  *
@@ -449,8 +421,8 @@ static inline void vas_log_write(struct vas_window *win, char *name,
 {
 	if (val)
 		pr_debug("%swin #%d: %s reg %p, val 0x%016llx\n",
-				win->tx_win ? "Tx" : "Rx", win->winid, name,
-				regptr, val);
+				win->pnv.tx_win ? "Tx" : "Rx", win->winid,
+				name, regptr, val);
 }
 
 static inline void write_uwc_reg(struct vas_window *win, char *name,
@@ -458,7 +430,7 @@ static inline void write_uwc_reg(struct vas_window *win, char *name,
 {
 	void *regptr;
 
-	regptr = win->uwc_map + reg;
+	regptr = win->pnv.uwc_map + reg;
 	vas_log_write(win, name, regptr, val);
 
 	out_be64(regptr, val);
@@ -469,7 +441,7 @@ static inline void write_hvwc_reg(struct vas_window *win, char *name,
 {
 	void *regptr;
 
-	regptr = win->hvwc_map + reg;
+	regptr = win->pnv.hvwc_map + reg;
 	vas_log_write(win, name, regptr, val);
 
 	out_be64(regptr, val);
@@ -478,7 +450,7 @@ static inline void write_hvwc_reg(struct vas_window *win, char *name,
 static inline u64 read_hvwc_reg(struct vas_window *win,
 			char *name __maybe_unused, s32 reg)
 {
-	return in_be64(win->hvwc_map+reg);
+	return in_be64(win->pnv.hvwc_map + reg);
 }
 
 /*
-- 
2.18.2



Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7B179051
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Mar 2020 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgCDM0C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Mar 2020 07:26:02 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64650 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729232AbgCDM0B (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Mar 2020 07:26:01 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024CAkG0014133;
        Wed, 4 Mar 2020 04:25:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=nag0/EylGAXE+vm2nzWiOcgZkg0QtjskaXjwxlHVvLM=;
 b=g4RC1LYeDE4IO2cARHRbJVJOvG20+CSogZCxeJOxX+Mg23HdIHMAsdYvO9KJGuFYVL2W
 CthBKV9UD46gt6Oulpep7qi515x+8+Iz9Isc+1Uly3Ywx6vaYaPWSf1VN0M8u0gWSJDj
 Ao00g2RVQ/PcWi+CE4zAOpdCotk4xG/KP9eAKuJ0PkCJDPtItYmHI0Ga4U4LAjdnplYj
 OIVBT9tkXip8h/seqimetnzhR9eIEIq3daslDzicz3jVaGZY+c41wsvyAwC1dtbcd693
 YS1U6+Jth0+j/4eieXPdJD9BnWN2gCtgyzaH7BKUtzr4tDqhKWJf6MkYgYbcGkqT4/5L 1w== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yhxw4c3u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Mar 2020 04:25:38 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 4 Mar
 2020 04:25:36 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Mar 2020 04:25:36 -0800
Received: from hyd1schalla-dt.marvell.com (hyd1schalla-dt.marvell.com [10.29.8.39])
        by maili.marvell.com (Postfix) with ESMTP id 09D843F703F;
        Wed,  4 Mar 2020 04:25:34 -0800 (PST)
From:   Srujana Challa <schalla@marvell.com>
To:     <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <pathreya@marvell.com>, SrujanaChalla <schalla@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>
Subject: [PATCH 2/4] drivers: crypto: add support for OCTEON TX CPT engine
Date:   Wed, 4 Mar 2020 17:55:14 +0530
Message-ID: <1583324716-23633-3-git-send-email-schalla@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583324716-23633-1-git-send-email-schalla@marvell.com>
References: <1583324716-23633-1-git-send-email-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_03:2020-03-04,2020-03-04 signatures=0
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: SrujanaChalla <schalla@marvell.com>

Add support for the cryptographic acceleration unit (CPT) on
OcteonTX CN83XX SoC.

Co-developed-by: Lukasz Bartosik <lbartosik@marvell.com>
Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
Signed-off-by: SrujanaChalla <schalla@marvell.com>
---
 MAINTAINERS                                        |    2 +
 drivers/crypto/marvell/octeontx/Makefile           |    4 +
 drivers/crypto/marvell/octeontx/otx_cpt_common.h   |   51 +
 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h |  249 +++
 drivers/crypto/marvell/octeontx/otx_cptpf.h        |   34 +
 drivers/crypto/marvell/octeontx/otx_cptpf_main.c   |  307 ++++
 drivers/crypto/marvell/octeontx/otx_cptpf_mbox.c   |  253 +++
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  | 1686 ++++++++++++++++++++
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.h  |  180 +++
 9 files changed, 2766 insertions(+)
 create mode 100644 drivers/crypto/marvell/octeontx/Makefile
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cpt_common.h
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptpf.h
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptpf_main.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptpf_mbox.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a0c1618..1e32d3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9906,7 +9906,9 @@ F:	Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <bbrezillon@kernel.org>
 M:	Arnaud Ebalard <arno@natisbad.org>
+M:	Srujana Challa <schalla@marvell.com>
 F:	drivers/crypto/marvell/
+F:	drivers/crypto/marvell/octeontx/
 S:	Maintained
 L:	linux-crypto@vger.kernel.org
 
diff --git a/drivers/crypto/marvell/octeontx/Makefile b/drivers/crypto/marvell/octeontx/Makefile
new file mode 100644
index 0000000..627d00e
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_OCTEONTX_CPT) += octeontx-cpt.o
+
+octeontx-cpt-objs := otx_cptpf_main.o otx_cptpf_mbox.o otx_cptpf_ucode.o
diff --git a/drivers/crypto/marvell/octeontx/otx_cpt_common.h b/drivers/crypto/marvell/octeontx/otx_cpt_common.h
new file mode 100644
index 0000000..ca704a7
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cpt_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OTX_CPT_COMMON_H
+#define __OTX_CPT_COMMON_H
+
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+
+#define OTX_CPT_MAX_MBOX_DATA_STR_SIZE 64
+
+enum otx_cptpf_type {
+	OTX_CPT_AE = 2,
+	OTX_CPT_SE = 3,
+	BAD_OTX_CPTPF_TYPE,
+};
+
+enum otx_cptvf_type {
+	OTX_CPT_AE_TYPES = 1,
+	OTX_CPT_SE_TYPES = 2,
+	BAD_OTX_CPTVF_TYPE,
+};
+
+/* VF-PF message opcodes */
+enum otx_cpt_mbox_opcode {
+	OTX_CPT_MSG_VF_UP = 1,
+	OTX_CPT_MSG_VF_DOWN,
+	OTX_CPT_MSG_READY,
+	OTX_CPT_MSG_QLEN,
+	OTX_CPT_MSG_QBIND_GRP,
+	OTX_CPT_MSG_VQ_PRIORITY,
+	OTX_CPT_MSG_PF_TYPE,
+	OTX_CPT_MSG_ACK,
+	OTX_CPT_MSG_NACK
+};
+
+/* OcteonTX CPT mailbox structure */
+struct otx_cpt_mbox {
+	u64 msg; /* Message type MBOX[0] */
+	u64 data;/* Data         MBOX[1] */
+};
+
+#endif /* __OTX_CPT_COMMON_H */
diff --git a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
new file mode 100644
index 0000000..bec483f
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
@@ -0,0 +1,249 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OTX_CPT_HW_TYPES_H
+#define __OTX_CPT_HW_TYPES_H
+
+#include <linux/types.h>
+
+/* Device IDs */
+#define OTX_CPT_PCI_PF_DEVICE_ID 0xa040
+
+#define OTX_CPT_PCI_PF_SUBSYS_ID 0xa340
+
+/* Configuration and status registers are in BAR0 on OcteonTX platform */
+#define OTX_CPT_PF_PCI_CFG_BAR	0
+/* Mailbox interrupts offset */
+#define OTX_CPT_PF_MBOX_INT	3
+#define OTX_CPT_PF_INT_VEC_E_MBOXX(x, a) ((x) + (a))
+/* Number of MSIX supported in PF */
+#define OTX_CPT_PF_MSIX_VECTORS 4
+/* Maximum supported microcode groups */
+#define OTX_CPT_MAX_ENGINE_GROUPS 8
+
+/* OcteonTX CPT PF registers */
+#define OTX_CPT_PF_CONSTANTS		(0x0ll)
+#define OTX_CPT_PF_RESET		(0x100ll)
+#define OTX_CPT_PF_DIAG			(0x120ll)
+#define OTX_CPT_PF_BIST_STATUS		(0x160ll)
+#define OTX_CPT_PF_ECC0_CTL		(0x200ll)
+#define OTX_CPT_PF_ECC0_FLIP		(0x210ll)
+#define OTX_CPT_PF_ECC0_INT		(0x220ll)
+#define OTX_CPT_PF_ECC0_INT_W1S		(0x230ll)
+#define OTX_CPT_PF_ECC0_ENA_W1S		(0x240ll)
+#define OTX_CPT_PF_ECC0_ENA_W1C		(0x250ll)
+#define OTX_CPT_PF_MBOX_INTX(b)		(0x400ll | (u64)(b) << 3)
+#define OTX_CPT_PF_MBOX_INT_W1SX(b)	(0x420ll | (u64)(b) << 3)
+#define OTX_CPT_PF_MBOX_ENA_W1CX(b)	(0x440ll | (u64)(b) << 3)
+#define OTX_CPT_PF_MBOX_ENA_W1SX(b)	(0x460ll | (u64)(b) << 3)
+#define OTX_CPT_PF_EXEC_INT		(0x500ll)
+#define OTX_CPT_PF_EXEC_INT_W1S		(0x520ll)
+#define OTX_CPT_PF_EXEC_ENA_W1C		(0x540ll)
+#define OTX_CPT_PF_EXEC_ENA_W1S		(0x560ll)
+#define OTX_CPT_PF_GX_EN(b)		(0x600ll | (u64)(b) << 3)
+#define OTX_CPT_PF_EXEC_INFO		(0x700ll)
+#define OTX_CPT_PF_EXEC_BUSY		(0x800ll)
+#define OTX_CPT_PF_EXEC_INFO0		(0x900ll)
+#define OTX_CPT_PF_EXEC_INFO1		(0x910ll)
+#define OTX_CPT_PF_INST_REQ_PC		(0x10000ll)
+#define OTX_CPT_PF_INST_LATENCY_PC	(0x10020ll)
+#define OTX_CPT_PF_RD_REQ_PC		(0x10040ll)
+#define OTX_CPT_PF_RD_LATENCY_PC	(0x10060ll)
+#define OTX_CPT_PF_RD_UC_PC		(0x10080ll)
+#define OTX_CPT_PF_ACTIVE_CYCLES_PC	(0x10100ll)
+#define OTX_CPT_PF_EXE_CTL		(0x4000000ll)
+#define OTX_CPT_PF_EXE_STATUS		(0x4000008ll)
+#define OTX_CPT_PF_EXE_CLK		(0x4000010ll)
+#define OTX_CPT_PF_EXE_DBG_CTL		(0x4000018ll)
+#define OTX_CPT_PF_EXE_DBG_DATA		(0x4000020ll)
+#define OTX_CPT_PF_EXE_BIST_STATUS	(0x4000028ll)
+#define OTX_CPT_PF_EXE_REQ_TIMER	(0x4000030ll)
+#define OTX_CPT_PF_EXE_MEM_CTL		(0x4000038ll)
+#define OTX_CPT_PF_EXE_PERF_CTL		(0x4001000ll)
+#define OTX_CPT_PF_EXE_DBG_CNTX(b)	(0x4001100ll | (u64)(b) << 3)
+#define OTX_CPT_PF_EXE_PERF_EVENT_CNT	(0x4001180ll)
+#define OTX_CPT_PF_EXE_EPCI_INBX_CNT(b)	(0x4001200ll | (u64)(b) << 3)
+#define OTX_CPT_PF_EXE_EPCI_OUTBX_CNT(b) (0x4001240ll | (u64)(b) << 3)
+#define OTX_CPT_PF_ENGX_UCODE_BASE(b)	(0x4002000ll | (u64)(b) << 3)
+#define OTX_CPT_PF_QX_CTL(b)		(0x8000000ll | (u64)(b) << 20)
+#define OTX_CPT_PF_QX_GMCTL(b)		(0x8000020ll | (u64)(b) << 20)
+#define OTX_CPT_PF_QX_CTL2(b)		(0x8000100ll | (u64)(b) << 20)
+#define OTX_CPT_PF_VFX_MBOXX(b, c)	(0x8001000ll | (u64)(b) << 20 | \
+					 (u64)(c) << 8)
+
+/*
+ * Register (NCB) otx_cpt#_pf_bist_status
+ *
+ * CPT PF Control Bist Status Register
+ * This register has the BIST status of memories. Each bit is the BIST result
+ * of an individual memory (per bit, 0 = pass and 1 = fail).
+ * otx_cptx_pf_bist_status_s
+ * Word0
+ *  bstatus [29:0](RO/H) BIST status. One bit per memory, enumerated by
+ *	CPT_RAMS_E.
+ */
+union otx_cptx_pf_bist_status {
+	u64 u;
+	struct otx_cptx_pf_bist_status_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_30_63:34;
+		u64 bstatus:30;
+#else /* Word 0 - Little Endian */
+		u64 bstatus:30;
+		u64 reserved_30_63:34;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_pf_constants
+ *
+ * CPT PF Constants Register
+ * This register contains implementation-related parameters of CPT in CNXXXX.
+ * otx_cptx_pf_constants_s
+ * Word 0
+ *  reserved_40_63:24 [63:40] Reserved.
+ *  epcis:8 [39:32](RO) Number of EPCI busses.
+ *  grps:8 [31:24](RO) Number of engine groups implemented.
+ *  ae:8 [23:16](RO/H) Number of AEs. In CNXXXX, for CPT0 returns 0x0,
+ *	for CPT1 returns 0x18, or less if there are fuse-disables.
+ *  se:8 [15:8](RO/H) Number of SEs. In CNXXXX, for CPT0 returns 0x30,
+ *	or less if there are fuse-disables, for CPT1 returns 0x0.
+ *  vq:8 [7:0](RO) Number of VQs.
+ */
+union otx_cptx_pf_constants {
+	u64 u;
+	struct otx_cptx_pf_constants_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_40_63:24;
+		u64 epcis:8;
+		u64 grps:8;
+		u64 ae:8;
+		u64 se:8;
+		u64 vq:8;
+#else /* Word 0 - Little Endian */
+		u64 vq:8;
+		u64 se:8;
+		u64 ae:8;
+		u64 grps:8;
+		u64 epcis:8;
+		u64 reserved_40_63:24;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_pf_exe_bist_status
+ *
+ * CPT PF Engine Bist Status Register
+ * This register has the BIST status of each engine.  Each bit is the
+ * BIST result of an individual engine (per bit, 0 = pass and 1 = fail).
+ * otx_cptx_pf_exe_bist_status_s
+ * Word0
+ *  reserved_48_63:16 [63:48] reserved
+ *  bstatus:48 [47:0](RO/H) BIST status. One bit per engine.
+ *
+ */
+union otx_cptx_pf_exe_bist_status {
+	u64 u;
+	struct otx_cptx_pf_exe_bist_status_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_48_63:16;
+		u64 bstatus:48;
+#else /* Word 0 - Little Endian */
+		u64 bstatus:48;
+		u64 reserved_48_63:16;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_pf_q#_ctl
+ *
+ * CPT Queue Control Register
+ * This register configures queues. This register should be changed only
+ * when quiescent (see CPT()_VQ()_INPROG[INFLIGHT]).
+ * otx_cptx_pf_qx_ctl_s
+ * Word0
+ *  reserved_60_63:4 [63:60] reserved.
+ *  aura:12; [59:48](R/W) Guest-aura for returning this queue's
+ *	instruction-chunk buffers to FPA. Only used when [INST_FREE] is set.
+ *	For the FPA to not discard the request, FPA_PF_MAP() must map
+ *	[AURA] and CPT()_PF_Q()_GMCTL[GMID] as valid.
+ *  reserved_45_47:3 [47:45] reserved.
+ *  size:13 [44:32](R/W) Command-buffer size, in number of 64-bit words per
+ *	command buffer segment. Must be 8*n + 1, where n is the number of
+ *	instructions per buffer segment.
+ *  reserved_11_31:21 [31:11] Reserved.
+ *  cont_err:1 [10:10](R/W) Continue on error.
+ *	0 = When CPT()_VQ()_MISC_INT[NWRP], CPT()_VQ()_MISC_INT[IRDE] or
+ *	CPT()_VQ()_MISC_INT[DOVF] are set by hardware or software via
+ *	CPT()_VQ()_MISC_INT_W1S, then CPT()_VQ()_CTL[ENA] is cleared.  Due to
+ *	pipelining, additional instructions may have been processed between the
+ *	instruction causing the error and the next instruction in the disabled
+ *	queue (the instruction at CPT()_VQ()_SADDR).
+ *	1 = Ignore errors and continue processing instructions.
+ *	For diagnostic use only.
+ *  inst_free:1 [9:9](R/W) Instruction FPA free. When set, when CPT reaches the
+ *	end of an instruction chunk, that chunk will be freed to the FPA.
+ *  inst_be:1 [8:8](R/W) Instruction big-endian control. When set, instructions,
+ *	instruction next chunk pointers, and result structures are stored in
+ *	big-endian format in memory.
+ *  iqb_ldwb:1 [7:7](R/W) Instruction load don't write back.
+ *	0 = The hardware issues NCB transient load (LDT) towards the cache,
+ *	which if the line hits and is is dirty will cause the line to be
+ *	written back before being replaced.
+ *	1 = The hardware issues NCB LDWB read-and-invalidate command towards
+ *	the cache when fetching the last word of instructions; as a result the
+ *	line will not be written back when replaced.  This improves
+ *	performance, but software must not read the instructions after they are
+ *	posted to the hardware.	Reads that do not consume the last word of a
+ *	cache line always use LDI.
+ *  reserved_4_6:3 [6:4] Reserved.
+ *  grp:3; [3:1](R/W) Engine group.
+ *  pri:1; [0:0](R/W) Queue priority.
+ *	1 = This queue has higher priority. Round-robin between higher
+ *	priority queues.
+ *	0 = This queue has lower priority. Round-robin between lower
+ *	priority queues.
+ */
+union otx_cptx_pf_qx_ctl {
+	u64 u;
+	struct otx_cptx_pf_qx_ctl_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_60_63:4;
+		u64 aura:12;
+		u64 reserved_45_47:3;
+		u64 size:13;
+		u64 reserved_11_31:21;
+		u64 cont_err:1;
+		u64 inst_free:1;
+		u64 inst_be:1;
+		u64 iqb_ldwb:1;
+		u64 reserved_4_6:3;
+		u64 grp:3;
+		u64 pri:1;
+#else /* Word 0 - Little Endian */
+		u64 pri:1;
+		u64 grp:3;
+		u64 reserved_4_6:3;
+		u64 iqb_ldwb:1;
+		u64 inst_be:1;
+		u64 inst_free:1;
+		u64 cont_err:1;
+		u64 reserved_11_31:21;
+		u64 size:13;
+		u64 reserved_45_47:3;
+		u64 aura:12;
+		u64 reserved_60_63:4;
+#endif /* Word 0 - End */
+	} s;
+};
+#endif /* __OTX_CPT_HW_TYPES_H */
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf.h b/drivers/crypto/marvell/octeontx/otx_cptpf.h
new file mode 100644
index 0000000..73cd0a9
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OTX_CPTPF_H
+#define __OTX_CPTPF_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include "otx_cptpf_ucode.h"
+
+/*
+ * OcteonTX CPT device structure
+ */
+struct otx_cpt_device {
+	void __iomem *reg_base; /* Register start address */
+	struct pci_dev *pdev;	/* Pci device handle */
+	struct otx_cpt_eng_grps eng_grps;/* Engine groups information */
+	struct list_head list;
+	u8 pf_type;	/* PF type SE or AE */
+	u8 max_vfs;	/* Maximum number of VFs supported by the CPT */
+	u8 vfs_enabled;	/* Number of enabled VFs */
+};
+
+void otx_cpt_mbox_intr_handler(struct otx_cpt_device *cpt, int mbx);
+void otx_cpt_disable_all_cores(struct otx_cpt_device *cpt);
+
+#endif /* __OTX_CPTPF_H */
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_main.c b/drivers/crypto/marvell/octeontx/otx_cptpf_main.c
new file mode 100644
index 0000000..200fb33
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_main.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "otx_cpt_common.h"
+#include "otx_cptpf.h"
+
+#define DRV_NAME	"octeontx-cpt"
+#define DRV_VERSION	"1.0"
+
+static void otx_cpt_disable_mbox_interrupts(struct otx_cpt_device *cpt)
+{
+	/* Disable mbox(0) interrupts for all VFs */
+	writeq(~0ull, cpt->reg_base + OTX_CPT_PF_MBOX_ENA_W1CX(0));
+}
+
+static void otx_cpt_enable_mbox_interrupts(struct otx_cpt_device *cpt)
+{
+	/* Enable mbox(0) interrupts for all VFs */
+	writeq(~0ull, cpt->reg_base + OTX_CPT_PF_MBOX_ENA_W1SX(0));
+}
+
+static irqreturn_t otx_cpt_mbx0_intr_handler(int __always_unused irq,
+					     void *cpt)
+{
+	otx_cpt_mbox_intr_handler(cpt, 0);
+
+	return IRQ_HANDLED;
+}
+
+static void otx_cpt_reset(struct otx_cpt_device *cpt)
+{
+	writeq(1, cpt->reg_base + OTX_CPT_PF_RESET);
+}
+
+static void otx_cpt_find_max_enabled_cores(struct otx_cpt_device *cpt)
+{
+	union otx_cptx_pf_constants pf_cnsts = {0};
+
+	pf_cnsts.u = readq(cpt->reg_base + OTX_CPT_PF_CONSTANTS);
+	cpt->eng_grps.avail.max_se_cnt = pf_cnsts.s.se;
+	cpt->eng_grps.avail.max_ae_cnt = pf_cnsts.s.ae;
+}
+
+static u32 otx_cpt_check_bist_status(struct otx_cpt_device *cpt)
+{
+	union otx_cptx_pf_bist_status bist_sts = {0};
+
+	bist_sts.u = readq(cpt->reg_base + OTX_CPT_PF_BIST_STATUS);
+	return bist_sts.u;
+}
+
+static u64 otx_cpt_check_exe_bist_status(struct otx_cpt_device *cpt)
+{
+	union otx_cptx_pf_exe_bist_status bist_sts = {0};
+
+	bist_sts.u = readq(cpt->reg_base + OTX_CPT_PF_EXE_BIST_STATUS);
+	return bist_sts.u;
+}
+
+static int otx_cpt_device_init(struct otx_cpt_device *cpt)
+{
+	struct device *dev = &cpt->pdev->dev;
+	u16 sdevid;
+	u64 bist;
+
+	/* Reset the PF when probed first */
+	otx_cpt_reset(cpt);
+	mdelay(100);
+
+	pci_read_config_word(cpt->pdev, PCI_SUBSYSTEM_ID, &sdevid);
+
+	/* Check BIST status */
+	bist = (u64)otx_cpt_check_bist_status(cpt);
+	if (bist) {
+		dev_err(dev, "RAM BIST failed with code 0x%llx", bist);
+		return -ENODEV;
+	}
+
+	bist = otx_cpt_check_exe_bist_status(cpt);
+	if (bist) {
+		dev_err(dev, "Engine BIST failed with code 0x%llx", bist);
+		return -ENODEV;
+	}
+
+	/* Get max enabled cores */
+	otx_cpt_find_max_enabled_cores(cpt);
+
+	if ((sdevid == OTX_CPT_PCI_PF_SUBSYS_ID) &&
+	    (cpt->eng_grps.avail.max_se_cnt == 0)) {
+		cpt->pf_type = OTX_CPT_AE;
+	} else if ((sdevid == OTX_CPT_PCI_PF_SUBSYS_ID) &&
+		   (cpt->eng_grps.avail.max_ae_cnt == 0)) {
+		cpt->pf_type = OTX_CPT_SE;
+	}
+
+	/* Get max VQs/VFs supported by the device */
+	cpt->max_vfs = pci_sriov_get_totalvfs(cpt->pdev);
+
+	/* Disable all cores */
+	otx_cpt_disable_all_cores(cpt);
+
+	return 0;
+}
+
+static int otx_cpt_register_interrupts(struct otx_cpt_device *cpt)
+{
+	struct device *dev = &cpt->pdev->dev;
+	u32 mbox_int_idx = OTX_CPT_PF_MBOX_INT;
+	u32 num_vec = OTX_CPT_PF_MSIX_VECTORS;
+	int ret;
+
+	/* Enable MSI-X */
+	ret = pci_alloc_irq_vectors(cpt->pdev, num_vec, num_vec, PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dev_err(&cpt->pdev->dev,
+			"Request for #%d msix vectors failed\n",
+			num_vec);
+		return ret;
+	}
+
+	/* Register mailbox interrupt handlers */
+	ret = request_irq(pci_irq_vector(cpt->pdev,
+				OTX_CPT_PF_INT_VEC_E_MBOXX(mbox_int_idx, 0)),
+				otx_cpt_mbx0_intr_handler, 0, "CPT Mbox0", cpt);
+	if (ret) {
+		dev_err(dev, "Request irq failed\n");
+		pci_free_irq_vectors(cpt->pdev);
+		return ret;
+	}
+	/* Enable mailbox interrupt */
+	otx_cpt_enable_mbox_interrupts(cpt);
+	return 0;
+}
+
+static void otx_cpt_unregister_interrupts(struct otx_cpt_device *cpt)
+{
+	u32 mbox_int_idx = OTX_CPT_PF_MBOX_INT;
+
+	otx_cpt_disable_mbox_interrupts(cpt);
+	free_irq(pci_irq_vector(cpt->pdev,
+				OTX_CPT_PF_INT_VEC_E_MBOXX(mbox_int_idx, 0)),
+				cpt);
+	pci_free_irq_vectors(cpt->pdev);
+}
+
+
+static int otx_cpt_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	struct otx_cpt_device *cpt = pci_get_drvdata(pdev);
+	int ret = 0;
+
+	if (numvfs > cpt->max_vfs)
+		numvfs = cpt->max_vfs;
+
+	if (numvfs > 0) {
+		ret = otx_cpt_try_create_default_eng_grps(cpt->pdev,
+							  &cpt->eng_grps,
+							  cpt->pf_type);
+		if (ret)
+			return ret;
+
+		cpt->vfs_enabled = numvfs;
+		ret = pci_enable_sriov(pdev, numvfs);
+		if (ret) {
+			cpt->vfs_enabled = 0;
+			return ret;
+		}
+		otx_cpt_set_eng_grps_is_rdonly(&cpt->eng_grps, true);
+		try_module_get(THIS_MODULE);
+		ret = numvfs;
+	} else {
+		pci_disable_sriov(pdev);
+		otx_cpt_set_eng_grps_is_rdonly(&cpt->eng_grps, false);
+		module_put(THIS_MODULE);
+		cpt->vfs_enabled = 0;
+	}
+	dev_notice(&cpt->pdev->dev, "VFs enabled: %d\n", ret);
+
+	return ret;
+}
+
+static int otx_cpt_probe(struct pci_dev *pdev,
+			 const struct pci_device_id __always_unused *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct otx_cpt_device *cpt;
+	int err;
+
+	cpt = devm_kzalloc(dev, sizeof(*cpt), GFP_KERNEL);
+	if (!cpt)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, cpt);
+	cpt->pdev = pdev;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto err_clear_drvdata;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto err_disable_device;
+	}
+
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to get usable DMA configuration\n");
+		goto err_release_regions;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to get 48-bit DMA for consistent allocations\n");
+		goto err_release_regions;
+	}
+
+	/* MAP PF's configuration registers */
+	cpt->reg_base = pci_iomap(pdev, OTX_CPT_PF_PCI_CFG_BAR, 0);
+	if (!cpt->reg_base) {
+		dev_err(dev, "Cannot map config register space, aborting\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	/* CPT device HW initialization */
+	err = otx_cpt_device_init(cpt);
+	if (err)
+		goto err_unmap_region;
+
+	/* Register interrupts */
+	err = otx_cpt_register_interrupts(cpt);
+	if (err)
+		goto err_unmap_region;
+
+	/* Initialize engine groups */
+	err = otx_cpt_init_eng_grps(pdev, &cpt->eng_grps, cpt->pf_type);
+	if (err)
+		goto err_unregister_interrupts;
+
+	return 0;
+
+err_unregister_interrupts:
+	otx_cpt_unregister_interrupts(cpt);
+err_unmap_region:
+	pci_iounmap(pdev, cpt->reg_base);
+err_release_regions:
+	pci_release_regions(pdev);
+err_disable_device:
+	pci_disable_device(pdev);
+err_clear_drvdata:
+	pci_set_drvdata(pdev, NULL);
+
+	return err;
+}
+
+static void otx_cpt_remove(struct pci_dev *pdev)
+{
+	struct otx_cpt_device *cpt = pci_get_drvdata(pdev);
+
+	if (!cpt)
+		return;
+
+	/* Disable VFs */
+	pci_disable_sriov(pdev);
+	/* Cleanup engine groups */
+	otx_cpt_cleanup_eng_grps(pdev, &cpt->eng_grps);
+	/* Disable CPT PF interrupts */
+	otx_cpt_unregister_interrupts(cpt);
+	/* Disengage SE and AE cores from all groups */
+	otx_cpt_disable_all_cores(cpt);
+	pci_iounmap(pdev, cpt->reg_base);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+/* Supported devices */
+static const struct pci_device_id otx_cpt_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OTX_CPT_PCI_PF_DEVICE_ID) },
+	{ 0, }  /* end of table */
+};
+
+static struct pci_driver otx_cpt_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = otx_cpt_id_table,
+	.probe = otx_cpt_probe,
+	.remove = otx_cpt_remove,
+	.sriov_configure = otx_cpt_sriov_configure
+};
+
+module_pci_driver(otx_cpt_pci_driver);
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("Marvell OcteonTX CPT Physical Function Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, otx_cpt_id_table);
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_mbox.c b/drivers/crypto/marvell/octeontx/otx_cptpf_mbox.c
new file mode 100644
index 0000000..a677423
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_mbox.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "otx_cpt_common.h"
+#include "otx_cptpf.h"
+
+static char *get_mbox_opcode_str(int msg_opcode)
+{
+	char *str = "Unknown";
+
+	switch (msg_opcode) {
+	case OTX_CPT_MSG_VF_UP:
+		str = "UP";
+		break;
+
+	case OTX_CPT_MSG_VF_DOWN:
+		str = "DOWN";
+		break;
+
+	case OTX_CPT_MSG_READY:
+		str = "READY";
+		break;
+
+	case OTX_CPT_MSG_QLEN:
+		str = "QLEN";
+		break;
+
+	case OTX_CPT_MSG_QBIND_GRP:
+		str = "QBIND_GRP";
+		break;
+
+	case OTX_CPT_MSG_VQ_PRIORITY:
+		str = "VQ_PRIORITY";
+		break;
+
+	case OTX_CPT_MSG_PF_TYPE:
+		str = "PF_TYPE";
+		break;
+
+	case OTX_CPT_MSG_ACK:
+		str = "ACK";
+		break;
+
+	case OTX_CPT_MSG_NACK:
+		str = "NACK";
+		break;
+	}
+
+	return str;
+}
+
+static void dump_mbox_msg(struct otx_cpt_mbox *mbox_msg, int vf_id)
+{
+	char raw_data_str[OTX_CPT_MAX_MBOX_DATA_STR_SIZE];
+
+	hex_dump_to_buffer(mbox_msg, sizeof(struct otx_cpt_mbox), 16, 8,
+			   raw_data_str, OTX_CPT_MAX_MBOX_DATA_STR_SIZE, false);
+	if (vf_id >= 0)
+		pr_debug("MBOX opcode %s received from VF%d raw_data %s",
+			 get_mbox_opcode_str(mbox_msg->msg), vf_id,
+			 raw_data_str);
+	else
+		pr_debug("MBOX opcode %s received from PF raw_data %s",
+			 get_mbox_opcode_str(mbox_msg->msg), raw_data_str);
+}
+
+static void otx_cpt_send_msg_to_vf(struct otx_cpt_device *cpt, int vf,
+				   struct otx_cpt_mbox *mbx)
+{
+	/* Writing mbox(0) causes interrupt */
+	writeq(mbx->data, cpt->reg_base + OTX_CPT_PF_VFX_MBOXX(vf, 1));
+	writeq(mbx->msg, cpt->reg_base + OTX_CPT_PF_VFX_MBOXX(vf, 0));
+}
+
+/*
+ * ACKs VF's mailbox message
+ * @vf: VF to which ACK to be sent
+ */
+static void otx_cpt_mbox_send_ack(struct otx_cpt_device *cpt, int vf,
+			      struct otx_cpt_mbox *mbx)
+{
+	mbx->data = 0ull;
+	mbx->msg = OTX_CPT_MSG_ACK;
+	otx_cpt_send_msg_to_vf(cpt, vf, mbx);
+}
+
+/* NACKs VF's mailbox message that PF is not able to complete the action */
+static void otx_cptpf_mbox_send_nack(struct otx_cpt_device *cpt, int vf,
+				     struct otx_cpt_mbox *mbx)
+{
+	mbx->data = 0ull;
+	mbx->msg = OTX_CPT_MSG_NACK;
+	otx_cpt_send_msg_to_vf(cpt, vf, mbx);
+}
+
+static void otx_cpt_clear_mbox_intr(struct otx_cpt_device *cpt, u32 vf)
+{
+	/* W1C for the VF */
+	writeq(1ull << vf, cpt->reg_base + OTX_CPT_PF_MBOX_INTX(0));
+}
+
+/*
+ * Configure QLEN/Chunk sizes for VF
+ */
+static void otx_cpt_cfg_qlen_for_vf(struct otx_cpt_device *cpt, int vf,
+				    u32 size)
+{
+	union otx_cptx_pf_qx_ctl pf_qx_ctl;
+
+	pf_qx_ctl.u = readq(cpt->reg_base + OTX_CPT_PF_QX_CTL(vf));
+	pf_qx_ctl.s.size = size;
+	pf_qx_ctl.s.cont_err = true;
+	writeq(pf_qx_ctl.u, cpt->reg_base + OTX_CPT_PF_QX_CTL(vf));
+}
+
+/*
+ * Configure VQ priority
+ */
+static void otx_cpt_cfg_vq_priority(struct otx_cpt_device *cpt, int vf, u32 pri)
+{
+	union otx_cptx_pf_qx_ctl pf_qx_ctl;
+
+	pf_qx_ctl.u = readq(cpt->reg_base + OTX_CPT_PF_QX_CTL(vf));
+	pf_qx_ctl.s.pri = pri;
+	writeq(pf_qx_ctl.u, cpt->reg_base + OTX_CPT_PF_QX_CTL(vf));
+}
+
+static int otx_cpt_bind_vq_to_grp(struct otx_cpt_device *cpt, u8 q, u8 grp)
+{
+	struct device *dev = &cpt->pdev->dev;
+	struct otx_cpt_eng_grp_info *eng_grp;
+	union otx_cptx_pf_qx_ctl pf_qx_ctl;
+	struct otx_cpt_ucode *ucode;
+
+	if (q >= cpt->max_vfs) {
+		dev_err(dev, "Requested queue %d is > than maximum avail %d",
+			q, cpt->max_vfs);
+		return -EINVAL;
+	}
+
+	if (grp >= OTX_CPT_MAX_ENGINE_GROUPS) {
+		dev_err(dev, "Requested group %d is > than maximum avail %d",
+			grp, OTX_CPT_MAX_ENGINE_GROUPS);
+		return -EINVAL;
+	}
+
+	eng_grp = &cpt->eng_grps.grp[grp];
+	if (!eng_grp->is_enabled) {
+		dev_err(dev, "Requested engine group %d is disabled", grp);
+		return -EINVAL;
+	}
+
+	pf_qx_ctl.u = readq(cpt->reg_base + OTX_CPT_PF_QX_CTL(q));
+	pf_qx_ctl.s.grp = grp;
+	writeq(pf_qx_ctl.u, cpt->reg_base + OTX_CPT_PF_QX_CTL(q));
+
+	if (eng_grp->mirror.is_ena)
+		ucode = &eng_grp->g->grp[eng_grp->mirror.idx].ucode[0];
+	else
+		ucode = &eng_grp->ucode[0];
+
+	if (otx_cpt_uc_supports_eng_type(ucode, OTX_CPT_SE_TYPES))
+		return OTX_CPT_SE_TYPES;
+	else if (otx_cpt_uc_supports_eng_type(ucode, OTX_CPT_AE_TYPES))
+		return OTX_CPT_AE_TYPES;
+	else
+		return BAD_OTX_CPTVF_TYPE;
+}
+
+/* Interrupt handler to handle mailbox messages from VFs */
+static void otx_cpt_handle_mbox_intr(struct otx_cpt_device *cpt, int vf)
+{
+	int vftype = 0;
+	struct otx_cpt_mbox mbx = {};
+	struct device *dev = &cpt->pdev->dev;
+	/*
+	 * MBOX[0] contains msg
+	 * MBOX[1] contains data
+	 */
+	mbx.msg  = readq(cpt->reg_base + OTX_CPT_PF_VFX_MBOXX(vf, 0));
+	mbx.data = readq(cpt->reg_base + OTX_CPT_PF_VFX_MBOXX(vf, 1));
+
+	dump_mbox_msg(&mbx, vf);
+
+	switch (mbx.msg) {
+	case OTX_CPT_MSG_VF_UP:
+		mbx.msg  = OTX_CPT_MSG_VF_UP;
+		mbx.data = cpt->vfs_enabled;
+		otx_cpt_send_msg_to_vf(cpt, vf, &mbx);
+		break;
+	case OTX_CPT_MSG_READY:
+		mbx.msg  = OTX_CPT_MSG_READY;
+		mbx.data = vf;
+		otx_cpt_send_msg_to_vf(cpt, vf, &mbx);
+		break;
+	case OTX_CPT_MSG_VF_DOWN:
+		/* First msg in VF teardown sequence */
+		otx_cpt_mbox_send_ack(cpt, vf, &mbx);
+		break;
+	case OTX_CPT_MSG_QLEN:
+		otx_cpt_cfg_qlen_for_vf(cpt, vf, mbx.data);
+		otx_cpt_mbox_send_ack(cpt, vf, &mbx);
+		break;
+	case OTX_CPT_MSG_QBIND_GRP:
+		vftype = otx_cpt_bind_vq_to_grp(cpt, vf, (u8)mbx.data);
+		if ((vftype != OTX_CPT_AE_TYPES) &&
+		    (vftype != OTX_CPT_SE_TYPES)) {
+			dev_err(dev, "VF%d binding to eng group %llu failed",
+				vf, mbx.data);
+			otx_cptpf_mbox_send_nack(cpt, vf, &mbx);
+		} else {
+			mbx.msg = OTX_CPT_MSG_QBIND_GRP;
+			mbx.data = vftype;
+			otx_cpt_send_msg_to_vf(cpt, vf, &mbx);
+		}
+		break;
+	case OTX_CPT_MSG_PF_TYPE:
+		mbx.msg = OTX_CPT_MSG_PF_TYPE;
+		mbx.data = cpt->pf_type;
+		otx_cpt_send_msg_to_vf(cpt, vf, &mbx);
+		break;
+	case OTX_CPT_MSG_VQ_PRIORITY:
+		otx_cpt_cfg_vq_priority(cpt, vf, mbx.data);
+		otx_cpt_mbox_send_ack(cpt, vf, &mbx);
+		break;
+	default:
+		dev_err(&cpt->pdev->dev, "Invalid msg from VF%d, msg 0x%llx\n",
+			vf, mbx.msg);
+		break;
+	}
+}
+
+void otx_cpt_mbox_intr_handler (struct otx_cpt_device *cpt, int mbx)
+{
+	u64 intr;
+	u8  vf;
+
+	intr = readq(cpt->reg_base + OTX_CPT_PF_MBOX_INTX(0));
+	pr_debug("PF interrupt mbox%d mask 0x%llx\n", mbx, intr);
+	for (vf = 0; vf < cpt->max_vfs; vf++) {
+		if (intr & (1ULL << vf)) {
+			otx_cpt_handle_mbox_intr(cpt, vf);
+			otx_cpt_clear_mbox_intr(cpt, vf);
+		}
+	}
+}
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
new file mode 100644
index 0000000..d04baa3
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -0,0 +1,1686 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/ctype.h>
+#include <linux/firmware.h>
+#include "otx_cpt_common.h"
+#include "otx_cptpf_ucode.h"
+#include "otx_cptpf.h"
+
+#define CSR_DELAY 30
+/* Tar archive defines */
+#define TAR_MAGIC		"ustar"
+#define TAR_MAGIC_LEN		6
+#define TAR_BLOCK_LEN		512
+#define REGTYPE			'0'
+#define AREGTYPE		'\0'
+
+/* tar header as defined in POSIX 1003.1-1990. */
+struct tar_hdr_t {
+	char name[100];
+	char mode[8];
+	char uid[8];
+	char gid[8];
+	char size[12];
+	char mtime[12];
+	char chksum[8];
+	char typeflag;
+	char linkname[100];
+	char magic[6];
+	char version[2];
+	char uname[32];
+	char gname[32];
+	char devmajor[8];
+	char devminor[8];
+	char prefix[155];
+};
+
+struct tar_blk_t {
+	union {
+		struct tar_hdr_t hdr;
+		char block[TAR_BLOCK_LEN];
+	};
+};
+
+struct tar_arch_info_t {
+	struct list_head ucodes;
+	const struct firmware *fw;
+};
+
+static struct otx_cpt_bitmap get_cores_bmap(struct device *dev,
+					   struct otx_cpt_eng_grp_info *eng_grp)
+{
+	struct otx_cpt_bitmap bmap = { {0} };
+	bool found = false;
+	int i;
+
+	if (eng_grp->g->engs_num > OTX_CPT_MAX_ENGINES) {
+		dev_err(dev, "unsupported number of engines %d on octeontx",
+			eng_grp->g->engs_num);
+		return bmap;
+	}
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		if (eng_grp->engs[i].type) {
+			bitmap_or(bmap.bits, bmap.bits,
+				  eng_grp->engs[i].bmap,
+				  eng_grp->g->engs_num);
+			bmap.size = eng_grp->g->engs_num;
+			found = true;
+		}
+	}
+
+	if (!found)
+		dev_err(dev, "No engines reserved for engine group %d",
+			eng_grp->idx);
+	return bmap;
+}
+
+static int is_eng_type(int val, int eng_type)
+{
+	return val & (1 << eng_type);
+}
+
+static int dev_supports_eng_type(struct otx_cpt_eng_grps *eng_grps,
+				 int eng_type)
+{
+	return is_eng_type(eng_grps->eng_types_supported, eng_type);
+}
+
+static void set_ucode_filename(struct otx_cpt_ucode *ucode,
+			       const char *filename)
+{
+	strlcpy(ucode->filename, filename, OTX_CPT_UCODE_NAME_LENGTH);
+}
+
+static char *get_eng_type_str(int eng_type)
+{
+	char *str = "unknown";
+
+	switch (eng_type) {
+	case OTX_CPT_SE_TYPES:
+		str = "SE";
+		break;
+
+	case OTX_CPT_AE_TYPES:
+		str = "AE";
+		break;
+	}
+	return str;
+}
+
+static char *get_ucode_type_str(int ucode_type)
+{
+	char *str = "unknown";
+
+	switch (ucode_type) {
+	case (1 << OTX_CPT_SE_TYPES):
+		str = "SE";
+		break;
+
+	case (1 << OTX_CPT_AE_TYPES):
+		str = "AE";
+		break;
+	}
+	return str;
+}
+
+static int get_ucode_type(struct otx_cpt_ucode_hdr *ucode_hdr, int *ucode_type)
+{
+	char tmp_ver_str[OTX_CPT_UCODE_VER_STR_SZ];
+	u32 i, val = 0;
+	u8 nn;
+
+	strlcpy(tmp_ver_str, ucode_hdr->ver_str, OTX_CPT_UCODE_VER_STR_SZ);
+	for (i = 0; i < strlen(tmp_ver_str); i++)
+		tmp_ver_str[i] = tolower(tmp_ver_str[i]);
+
+	nn = ucode_hdr->ver_num.nn;
+	if (strnstr(tmp_ver_str, "se-", OTX_CPT_UCODE_VER_STR_SZ) &&
+	    (nn == OTX_CPT_SE_UC_TYPE1 || nn == OTX_CPT_SE_UC_TYPE2 ||
+	     nn == OTX_CPT_SE_UC_TYPE3))
+		val |= 1 << OTX_CPT_SE_TYPES;
+	if (strnstr(tmp_ver_str, "ae", OTX_CPT_UCODE_VER_STR_SZ) &&
+	    nn == OTX_CPT_AE_UC_TYPE)
+		val |= 1 << OTX_CPT_AE_TYPES;
+
+	*ucode_type = val;
+
+	if (!val)
+		return -EINVAL;
+	if (is_eng_type(val, OTX_CPT_AE_TYPES) &&
+	    is_eng_type(val, OTX_CPT_SE_TYPES))
+		return -EINVAL;
+	return 0;
+}
+
+static int is_mem_zero(const char *ptr, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (ptr[i])
+			return 0;
+	}
+	return 1;
+}
+
+static int cpt_set_ucode_base(struct otx_cpt_eng_grp_info *eng_grp, void *obj)
+{
+	struct otx_cpt_device *cpt = (struct otx_cpt_device *) obj;
+	dma_addr_t dma_addr;
+	struct otx_cpt_bitmap bmap;
+	int i;
+
+	bmap = get_cores_bmap(&cpt->pdev->dev, eng_grp);
+	if (!bmap.size)
+		return -EINVAL;
+
+	if (eng_grp->mirror.is_ena)
+		dma_addr =
+		       eng_grp->g->grp[eng_grp->mirror.idx].ucode[0].align_dma;
+	else
+		dma_addr = eng_grp->ucode[0].align_dma;
+
+	/*
+	 * Set UCODE_BASE only for the cores which are not used,
+	 * other cores should have already valid UCODE_BASE set
+	 */
+	for_each_set_bit(i, bmap.bits, bmap.size)
+		if (!eng_grp->g->eng_ref_cnt[i])
+			writeq((u64) dma_addr, cpt->reg_base +
+				OTX_CPT_PF_ENGX_UCODE_BASE(i));
+	return 0;
+}
+
+static int cpt_detach_and_disable_cores(struct otx_cpt_eng_grp_info *eng_grp,
+					void *obj)
+{
+	struct otx_cpt_device *cpt = (struct otx_cpt_device *) obj;
+	struct otx_cpt_bitmap bmap = { {0} };
+	int timeout = 10;
+	int i, busy;
+	u64 reg;
+
+	bmap = get_cores_bmap(&cpt->pdev->dev, eng_grp);
+	if (!bmap.size)
+		return -EINVAL;
+
+	/* Detach the cores from group */
+	reg = readq(cpt->reg_base + OTX_CPT_PF_GX_EN(eng_grp->idx));
+	for_each_set_bit(i, bmap.bits, bmap.size) {
+		if (reg & (1ull << i)) {
+			eng_grp->g->eng_ref_cnt[i]--;
+			reg &= ~(1ull << i);
+		}
+	}
+	writeq(reg, cpt->reg_base + OTX_CPT_PF_GX_EN(eng_grp->idx));
+
+	/* Wait for cores to become idle */
+	do {
+		busy = 0;
+		usleep_range(10000, 20000);
+		if (timeout-- < 0)
+			return -EBUSY;
+
+		reg = readq(cpt->reg_base + OTX_CPT_PF_EXEC_BUSY);
+		for_each_set_bit(i, bmap.bits, bmap.size)
+			if (reg & (1ull << i)) {
+				busy = 1;
+				break;
+			}
+	} while (busy);
+
+	/* Disable the cores only if they are not used anymore */
+	reg = readq(cpt->reg_base + OTX_CPT_PF_EXE_CTL);
+	for_each_set_bit(i, bmap.bits, bmap.size)
+		if (!eng_grp->g->eng_ref_cnt[i])
+			reg &= ~(1ull << i);
+	writeq(reg, cpt->reg_base + OTX_CPT_PF_EXE_CTL);
+
+	return 0;
+}
+
+static int cpt_attach_and_enable_cores(struct otx_cpt_eng_grp_info *eng_grp,
+				       void *obj)
+{
+	struct otx_cpt_device *cpt = (struct otx_cpt_device *) obj;
+	struct otx_cpt_bitmap bmap;
+	u64 reg;
+	int i;
+
+	bmap = get_cores_bmap(&cpt->pdev->dev, eng_grp);
+	if (!bmap.size)
+		return -EINVAL;
+
+	/* Attach the cores to the group */
+	reg = readq(cpt->reg_base + OTX_CPT_PF_GX_EN(eng_grp->idx));
+	for_each_set_bit(i, bmap.bits, bmap.size) {
+		if (!(reg & (1ull << i))) {
+			eng_grp->g->eng_ref_cnt[i]++;
+			reg |= 1ull << i;
+		}
+	}
+	writeq(reg, cpt->reg_base + OTX_CPT_PF_GX_EN(eng_grp->idx));
+
+	/* Enable the cores */
+	reg = readq(cpt->reg_base + OTX_CPT_PF_EXE_CTL);
+	for_each_set_bit(i, bmap.bits, bmap.size)
+		reg |= 1ull << i;
+	writeq(reg, cpt->reg_base + OTX_CPT_PF_EXE_CTL);
+
+	return 0;
+}
+
+static int process_tar_file(struct device *dev,
+			    struct tar_arch_info_t *tar_arch, char *filename,
+			    const u8 *data, u32 size)
+{
+	struct tar_ucode_info_t *tar_info;
+	struct otx_cpt_ucode_hdr *ucode_hdr;
+	int ucode_type, ucode_size;
+
+	/*
+	 * If size is less than microcode header size then don't report
+	 * an error because it might not be microcode file, just process
+	 * next file from archive
+	 */
+	if (size < sizeof(struct otx_cpt_ucode_hdr))
+		return 0;
+
+	ucode_hdr = (struct otx_cpt_ucode_hdr *) data;
+	/*
+	 * If microcode version can't be found don't report an error
+	 * because it might not be microcode file, just process next file
+	 */
+	if (get_ucode_type(ucode_hdr, &ucode_type))
+		return 0;
+
+	ucode_size = ntohl(ucode_hdr->code_length) * 2;
+	if (!ucode_size || (size < round_up(ucode_size, 16) +
+	    sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
+		dev_err(dev, "Ucode %s invalid size", filename);
+		return -EINVAL;
+	}
+
+	tar_info = kzalloc(sizeof(struct tar_ucode_info_t), GFP_KERNEL);
+	if (!tar_info)
+		return -ENOMEM;
+
+	tar_info->ucode_ptr = data;
+	set_ucode_filename(&tar_info->ucode, filename);
+	memcpy(tar_info->ucode.ver_str, ucode_hdr->ver_str,
+	       OTX_CPT_UCODE_VER_STR_SZ);
+	tar_info->ucode.ver_num = ucode_hdr->ver_num;
+	tar_info->ucode.type = ucode_type;
+	tar_info->ucode.size = ucode_size;
+	list_add_tail(&tar_info->list, &tar_arch->ucodes);
+
+	return 0;
+}
+
+static void release_tar_archive(struct tar_arch_info_t *tar_arch)
+{
+	struct tar_ucode_info_t *curr, *temp;
+
+	if (!tar_arch)
+		return;
+
+	list_for_each_entry_safe(curr, temp, &tar_arch->ucodes, list) {
+		list_del(&curr->list);
+		kfree(curr);
+	}
+
+	if (tar_arch->fw)
+		release_firmware(tar_arch->fw);
+	kfree(tar_arch);
+}
+
+static struct tar_ucode_info_t *get_uc_from_tar_archive(
+					struct tar_arch_info_t *tar_arch,
+					int ucode_type)
+{
+	struct tar_ucode_info_t *curr, *uc_found = NULL;
+
+	list_for_each_entry(curr, &tar_arch->ucodes, list) {
+		if (!is_eng_type(curr->ucode.type, ucode_type))
+			continue;
+
+		if (!uc_found) {
+			uc_found = curr;
+			continue;
+		}
+
+		switch (ucode_type) {
+		case OTX_CPT_AE_TYPES:
+			break;
+
+		case OTX_CPT_SE_TYPES:
+			if (uc_found->ucode.ver_num.nn == OTX_CPT_SE_UC_TYPE2 ||
+			    (uc_found->ucode.ver_num.nn == OTX_CPT_SE_UC_TYPE3
+			     && curr->ucode.ver_num.nn == OTX_CPT_SE_UC_TYPE1))
+				uc_found = curr;
+			break;
+		}
+	}
+
+	return uc_found;
+}
+
+static void print_tar_dbg_info(struct tar_arch_info_t *tar_arch,
+			       char *tar_filename)
+{
+	struct tar_ucode_info_t *curr;
+
+	pr_debug("Tar archive filename %s", tar_filename);
+	pr_debug("Tar archive pointer %p, size %ld", tar_arch->fw->data,
+		 tar_arch->fw->size);
+	list_for_each_entry(curr, &tar_arch->ucodes, list) {
+		pr_debug("Ucode filename %s", curr->ucode.filename);
+		pr_debug("Ucode version string %s", curr->ucode.ver_str);
+		pr_debug("Ucode version %d.%d.%d.%d",
+			 curr->ucode.ver_num.nn, curr->ucode.ver_num.xx,
+			 curr->ucode.ver_num.yy, curr->ucode.ver_num.zz);
+		pr_debug("Ucode type (%d) %s", curr->ucode.type,
+			 get_ucode_type_str(curr->ucode.type));
+		pr_debug("Ucode size %d", curr->ucode.size);
+		pr_debug("Ucode ptr %p\n", curr->ucode_ptr);
+	}
+}
+
+static struct tar_arch_info_t *load_tar_archive(struct device *dev,
+						char *tar_filename)
+{
+	struct tar_arch_info_t *tar_arch = NULL;
+	struct tar_blk_t *tar_blk;
+	unsigned int cur_size;
+	size_t tar_offs = 0;
+	size_t tar_size;
+	int ret;
+
+	tar_arch = kzalloc(sizeof(struct tar_arch_info_t), GFP_KERNEL);
+	if (!tar_arch)
+		return NULL;
+
+	INIT_LIST_HEAD(&tar_arch->ucodes);
+
+	/* Load tar archive */
+	ret = request_firmware(&tar_arch->fw, tar_filename, dev);
+	if (ret)
+		goto release_tar_arch;
+
+	if (tar_arch->fw->size < TAR_BLOCK_LEN) {
+		dev_err(dev, "Invalid tar archive %s ", tar_filename);
+		goto release_tar_arch;
+	}
+
+	tar_size = tar_arch->fw->size;
+	tar_blk = (struct tar_blk_t *) tar_arch->fw->data;
+	if (strncmp(tar_blk->hdr.magic, TAR_MAGIC, TAR_MAGIC_LEN - 1)) {
+		dev_err(dev, "Unsupported format of tar archive %s",
+			tar_filename);
+		goto release_tar_arch;
+	}
+
+	while (1) {
+		/* Read current file size */
+		ret = kstrtouint(tar_blk->hdr.size, 8, &cur_size);
+		if (ret)
+			goto release_tar_arch;
+
+		if (tar_offs + cur_size > tar_size ||
+		    tar_offs + 2*TAR_BLOCK_LEN > tar_size) {
+			dev_err(dev, "Invalid tar archive %s ", tar_filename);
+			goto release_tar_arch;
+		}
+
+		tar_offs += TAR_BLOCK_LEN;
+		if (tar_blk->hdr.typeflag == REGTYPE ||
+		    tar_blk->hdr.typeflag == AREGTYPE) {
+			ret = process_tar_file(dev, tar_arch,
+					       tar_blk->hdr.name,
+					       &tar_arch->fw->data[tar_offs],
+					       cur_size);
+			if (ret)
+				goto release_tar_arch;
+		}
+
+		tar_offs += (cur_size/TAR_BLOCK_LEN) * TAR_BLOCK_LEN;
+		if (cur_size % TAR_BLOCK_LEN)
+			tar_offs += TAR_BLOCK_LEN;
+
+		/* Check for the end of the archive */
+		if (tar_offs + 2*TAR_BLOCK_LEN > tar_size) {
+			dev_err(dev, "Invalid tar archive %s ", tar_filename);
+			goto release_tar_arch;
+		}
+
+		if (is_mem_zero(&tar_arch->fw->data[tar_offs],
+		    2*TAR_BLOCK_LEN))
+			break;
+
+		/* Read next block from tar archive */
+		tar_blk = (struct tar_blk_t *) &tar_arch->fw->data[tar_offs];
+	}
+
+	print_tar_dbg_info(tar_arch, tar_filename);
+	return tar_arch;
+release_tar_arch:
+	release_tar_archive(tar_arch);
+	return NULL;
+}
+
+static struct otx_cpt_engs_rsvd *find_engines_by_type(
+					struct otx_cpt_eng_grp_info *eng_grp,
+					int eng_type)
+{
+	int i;
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		if (!eng_grp->engs[i].type)
+			continue;
+
+		if (eng_grp->engs[i].type == eng_type)
+			return &eng_grp->engs[i];
+	}
+	return NULL;
+}
+
+int otx_cpt_uc_supports_eng_type(struct otx_cpt_ucode *ucode, int eng_type)
+{
+	return is_eng_type(ucode->type, eng_type);
+}
+EXPORT_SYMBOL_GPL(otx_cpt_uc_supports_eng_type);
+
+int otx_cpt_eng_grp_has_eng_type(struct otx_cpt_eng_grp_info *eng_grp,
+				 int eng_type)
+{
+	struct otx_cpt_engs_rsvd *engs;
+
+	engs = find_engines_by_type(eng_grp, eng_type);
+
+	return (engs != NULL ? 1 : 0);
+}
+EXPORT_SYMBOL_GPL(otx_cpt_eng_grp_has_eng_type);
+
+static void print_ucode_info(struct otx_cpt_eng_grp_info *eng_grp,
+			     char *buf, int size)
+{
+	if (eng_grp->mirror.is_ena) {
+		scnprintf(buf, size, "%s (shared with engine_group%d)",
+			  eng_grp->g->grp[eng_grp->mirror.idx].ucode[0].ver_str,
+			  eng_grp->mirror.idx);
+	} else {
+		scnprintf(buf, size, "%s", eng_grp->ucode[0].ver_str);
+	}
+}
+
+static void print_engs_info(struct otx_cpt_eng_grp_info *eng_grp,
+			    char *buf, int size, int idx)
+{
+	struct otx_cpt_engs_rsvd *mirrored_engs = NULL;
+	struct otx_cpt_engs_rsvd *engs;
+	int len, i;
+
+	buf[0] = '\0';
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		engs = &eng_grp->engs[i];
+		if (!engs->type)
+			continue;
+		if (idx != -1 && idx != i)
+			continue;
+
+		if (eng_grp->mirror.is_ena)
+			mirrored_engs = find_engines_by_type(
+					&eng_grp->g->grp[eng_grp->mirror.idx],
+					engs->type);
+		if (i > 0 && idx == -1) {
+			len = strlen(buf);
+			scnprintf(buf+len, size-len, ", ");
+		}
+
+		len = strlen(buf);
+		scnprintf(buf+len, size-len, "%d %s ", mirrored_engs ?
+			  engs->count + mirrored_engs->count : engs->count,
+			  get_eng_type_str(engs->type));
+		if (mirrored_engs) {
+			len = strlen(buf);
+			scnprintf(buf+len, size-len,
+				  "(%d shared with engine_group%d) ",
+				  engs->count <= 0 ? engs->count +
+				  mirrored_engs->count : mirrored_engs->count,
+				  eng_grp->mirror.idx);
+		}
+	}
+}
+
+static void print_ucode_dbg_info(struct otx_cpt_ucode *ucode)
+{
+	pr_debug("Ucode info");
+	pr_debug("Ucode version string %s", ucode->ver_str);
+	pr_debug("Ucode version %d.%d.%d.%d", ucode->ver_num.nn,
+		 ucode->ver_num.xx, ucode->ver_num.yy, ucode->ver_num.zz);
+	pr_debug("Ucode type %s", get_ucode_type_str(ucode->type));
+	pr_debug("Ucode size %d", ucode->size);
+	pr_debug("Ucode virt address %16.16llx", (u64)ucode->align_va);
+	pr_debug("Ucode phys address %16.16llx\n", ucode->align_dma);
+}
+
+static void cpt_print_engines_mask(struct otx_cpt_eng_grp_info *eng_grp,
+				   struct device *dev, char *buf, int size)
+{
+	struct otx_cpt_bitmap bmap;
+	u32 mask[2];
+
+	bmap = get_cores_bmap(dev, eng_grp);
+	if (!bmap.size) {
+		scnprintf(buf, size, "unknown");
+		return;
+	}
+	bitmap_to_arr32(mask, bmap.bits, bmap.size);
+	scnprintf(buf, size, "%8.8x %8.8x", mask[1], mask[0]);
+}
+
+
+static void print_dbg_info(struct device *dev,
+			   struct otx_cpt_eng_grps *eng_grps)
+{
+	char engs_info[2*OTX_CPT_UCODE_NAME_LENGTH];
+	struct otx_cpt_eng_grp_info *mirrored_grp;
+	char engs_mask[OTX_CPT_UCODE_NAME_LENGTH];
+	struct otx_cpt_eng_grp_info *grp;
+	struct otx_cpt_engs_rsvd *engs;
+	u32 mask[4];
+	int i, j;
+
+	pr_debug("Engine groups global info");
+	pr_debug("max SE %d, max AE %d",
+		 eng_grps->avail.max_se_cnt, eng_grps->avail.max_ae_cnt);
+	pr_debug("free SE %d", eng_grps->avail.se_cnt);
+	pr_debug("free AE %d", eng_grps->avail.ae_cnt);
+
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
+		grp = &eng_grps->grp[i];
+		pr_debug("engine_group%d, state %s", i, grp->is_enabled ?
+			 "enabled" : "disabled");
+		if (grp->is_enabled) {
+			mirrored_grp = &eng_grps->grp[grp->mirror.idx];
+			pr_debug("Ucode0 filename %s, version %s",
+				 grp->mirror.is_ena ?
+				 mirrored_grp->ucode[0].filename :
+				 grp->ucode[0].filename,
+				 grp->mirror.is_ena ?
+				 mirrored_grp->ucode[0].ver_str :
+				 grp->ucode[0].ver_str);
+		}
+
+		for (j = 0; j < OTX_CPT_MAX_ETYPES_PER_GRP; j++) {
+			engs = &grp->engs[j];
+			if (engs->type) {
+				print_engs_info(grp, engs_info,
+						2*OTX_CPT_UCODE_NAME_LENGTH, j);
+				pr_debug("Slot%d: %s", j, engs_info);
+				bitmap_to_arr32(mask, engs->bmap,
+						eng_grps->engs_num);
+				pr_debug("Mask:  %8.8x %8.8x %8.8x %8.8x",
+					 mask[3], mask[2], mask[1], mask[0]);
+			} else
+				pr_debug("Slot%d not used", j);
+		}
+		if (grp->is_enabled) {
+			cpt_print_engines_mask(grp, dev, engs_mask,
+					       OTX_CPT_UCODE_NAME_LENGTH);
+			pr_debug("Cmask: %s", engs_mask);
+		}
+	}
+}
+
+static int update_engines_avail_count(struct device *dev,
+				      struct otx_cpt_engs_available *avail,
+				      struct otx_cpt_engs_rsvd *engs, int val)
+{
+	switch (engs->type) {
+	case OTX_CPT_SE_TYPES:
+		avail->se_cnt += val;
+		break;
+
+	case OTX_CPT_AE_TYPES:
+		avail->ae_cnt += val;
+		break;
+
+	default:
+		dev_err(dev, "Invalid engine type %d\n", engs->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int update_engines_offset(struct device *dev,
+				 struct otx_cpt_engs_available *avail,
+				 struct otx_cpt_engs_rsvd *engs)
+{
+	switch (engs->type) {
+	case OTX_CPT_SE_TYPES:
+		engs->offset = 0;
+		break;
+
+	case OTX_CPT_AE_TYPES:
+		engs->offset = avail->max_se_cnt;
+		break;
+
+	default:
+		dev_err(dev, "Invalid engine type %d\n", engs->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int release_engines(struct device *dev, struct otx_cpt_eng_grp_info *grp)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		if (!grp->engs[i].type)
+			continue;
+
+		if (grp->engs[i].count > 0) {
+			ret = update_engines_avail_count(dev, &grp->g->avail,
+							 &grp->engs[i],
+							 grp->engs[i].count);
+			if (ret)
+				return ret;
+		}
+
+		grp->engs[i].type = 0;
+		grp->engs[i].count = 0;
+		grp->engs[i].offset = 0;
+		grp->engs[i].ucode = NULL;
+		bitmap_zero(grp->engs[i].bmap, grp->g->engs_num);
+	}
+
+	return 0;
+}
+
+static int do_reserve_engines(struct device *dev,
+			      struct otx_cpt_eng_grp_info *grp,
+			      struct otx_cpt_engines *req_engs)
+{
+	struct otx_cpt_engs_rsvd *engs = NULL;
+	int i, ret;
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		if (!grp->engs[i].type) {
+			engs = &grp->engs[i];
+			break;
+		}
+	}
+
+	if (!engs)
+		return -ENOMEM;
+
+	engs->type = req_engs->type;
+	engs->count = req_engs->count;
+
+	ret = update_engines_offset(dev, &grp->g->avail, engs);
+	if (ret)
+		return ret;
+
+	if (engs->count > 0) {
+		ret = update_engines_avail_count(dev, &grp->g->avail, engs,
+						 -engs->count);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int check_engines_availability(struct device *dev,
+				      struct otx_cpt_eng_grp_info *grp,
+				      struct otx_cpt_engines *req_eng)
+{
+	int avail_cnt = 0;
+
+	switch (req_eng->type) {
+	case OTX_CPT_SE_TYPES:
+		avail_cnt = grp->g->avail.se_cnt;
+		break;
+
+	case OTX_CPT_AE_TYPES:
+		avail_cnt = grp->g->avail.ae_cnt;
+		break;
+
+	default:
+		dev_err(dev, "Invalid engine type %d\n", req_eng->type);
+		return -EINVAL;
+	}
+
+	if (avail_cnt < req_eng->count) {
+		dev_err(dev,
+			"Error available %s engines %d < than requested %d",
+			get_eng_type_str(req_eng->type),
+			avail_cnt, req_eng->count);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int reserve_engines(struct device *dev, struct otx_cpt_eng_grp_info *grp,
+			   struct otx_cpt_engines *req_engs, int req_cnt)
+{
+	int i, ret;
+
+	/* Validate if a number of requested engines is available */
+	for (i = 0; i < req_cnt; i++) {
+		ret = check_engines_availability(dev, grp, &req_engs[i]);
+		if (ret)
+			return ret;
+	}
+
+	/* Reserve requested engines for this engine group */
+	for (i = 0; i < req_cnt; i++) {
+		ret = do_reserve_engines(dev, grp, &req_engs[i]);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static ssize_t eng_grp_info_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	char ucode_info[2*OTX_CPT_UCODE_NAME_LENGTH];
+	char engs_info[2*OTX_CPT_UCODE_NAME_LENGTH];
+	char engs_mask[OTX_CPT_UCODE_NAME_LENGTH];
+	struct otx_cpt_eng_grp_info *eng_grp;
+	int ret;
+
+	eng_grp = container_of(attr, struct otx_cpt_eng_grp_info, info_attr);
+	mutex_lock(&eng_grp->g->lock);
+
+	print_engs_info(eng_grp, engs_info, 2*OTX_CPT_UCODE_NAME_LENGTH, -1);
+	print_ucode_info(eng_grp, ucode_info, 2*OTX_CPT_UCODE_NAME_LENGTH);
+	cpt_print_engines_mask(eng_grp, dev, engs_mask,
+			       OTX_CPT_UCODE_NAME_LENGTH);
+	ret = scnprintf(buf, PAGE_SIZE,
+			"Microcode : %s\nEngines: %s\nEngines mask: %s\n",
+			ucode_info, engs_info, engs_mask);
+
+	mutex_unlock(&eng_grp->g->lock);
+	return ret;
+}
+
+static int create_sysfs_eng_grps_info(struct device *dev,
+				      struct otx_cpt_eng_grp_info *eng_grp)
+{
+	int ret;
+
+	eng_grp->info_attr.show = eng_grp_info_show;
+	eng_grp->info_attr.store = NULL;
+	eng_grp->info_attr.attr.name = eng_grp->sysfs_info_name;
+	eng_grp->info_attr.attr.mode = 0440;
+	sysfs_attr_init(&eng_grp->info_attr.attr);
+	ret = device_create_file(dev, &eng_grp->info_attr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void ucode_unload(struct device *dev, struct otx_cpt_ucode *ucode)
+{
+	if (ucode->va) {
+		dma_free_coherent(dev, ucode->size + OTX_CPT_UCODE_ALIGNMENT,
+				  ucode->va, ucode->dma);
+		ucode->va = NULL;
+		ucode->align_va = NULL;
+		ucode->dma = 0;
+		ucode->align_dma = 0;
+		ucode->size = 0;
+	}
+
+	memset(&ucode->ver_str, 0, OTX_CPT_UCODE_VER_STR_SZ);
+	memset(&ucode->ver_num, 0, sizeof(struct otx_cpt_ucode_ver_num));
+	set_ucode_filename(ucode, "");
+	ucode->type = 0;
+}
+
+static int copy_ucode_to_dma_mem(struct device *dev,
+				 struct otx_cpt_ucode *ucode,
+				 const u8 *ucode_data)
+{
+	u32 i;
+
+	/*  Allocate DMAable space */
+	ucode->va = dma_alloc_coherent(dev, ucode->size +
+				       OTX_CPT_UCODE_ALIGNMENT,
+				       &ucode->dma, GFP_KERNEL);
+	if (!ucode->va) {
+		dev_err(dev, "Unable to allocate space for microcode");
+		return -ENOMEM;
+	}
+	ucode->align_va = PTR_ALIGN(ucode->va, OTX_CPT_UCODE_ALIGNMENT);
+	ucode->align_dma = PTR_ALIGN(ucode->dma, OTX_CPT_UCODE_ALIGNMENT);
+
+	memcpy((void *) ucode->align_va, (void *) ucode_data +
+	       sizeof(struct otx_cpt_ucode_hdr), ucode->size);
+
+	/* Byte swap 64-bit */
+	for (i = 0; i < (ucode->size / 8); i++)
+		((u64 *)ucode->align_va)[i] =
+				cpu_to_be64(((u64 *)ucode->align_va)[i]);
+	/*  Ucode needs 16-bit swap */
+	for (i = 0; i < (ucode->size / 2); i++)
+		((u16 *)ucode->align_va)[i] =
+				cpu_to_be16(((u16 *)ucode->align_va)[i]);
+	return 0;
+}
+
+static int ucode_load(struct device *dev, struct otx_cpt_ucode *ucode,
+		      const char *ucode_filename)
+{
+	struct otx_cpt_ucode_hdr *ucode_hdr;
+	const struct firmware *fw;
+	int ret;
+
+	set_ucode_filename(ucode, ucode_filename);
+	ret = request_firmware(&fw, ucode->filename, dev);
+	if (ret)
+		return ret;
+
+	ucode_hdr = (struct otx_cpt_ucode_hdr *) fw->data;
+	memcpy(ucode->ver_str, ucode_hdr->ver_str, OTX_CPT_UCODE_VER_STR_SZ);
+	ucode->ver_num = ucode_hdr->ver_num;
+	ucode->size = ntohl(ucode_hdr->code_length) * 2;
+	if (!ucode->size || (fw->size < round_up(ucode->size, 16)
+	    + sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
+		dev_err(dev, "Ucode %s invalid size", ucode_filename);
+		ret = -EINVAL;
+		goto release_fw;
+	}
+
+	ret = get_ucode_type(ucode_hdr, &ucode->type);
+	if (ret) {
+		dev_err(dev, "Microcode %s unknown type 0x%x", ucode->filename,
+			ucode->type);
+		goto release_fw;
+	}
+
+	ret = copy_ucode_to_dma_mem(dev, ucode, fw->data);
+	if (ret)
+		goto release_fw;
+
+	print_ucode_dbg_info(ucode);
+release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
+static int enable_eng_grp(struct otx_cpt_eng_grp_info *eng_grp,
+			  void *obj)
+{
+	int ret;
+
+	ret = cpt_set_ucode_base(eng_grp, obj);
+	if (ret)
+		return ret;
+
+	ret = cpt_attach_and_enable_cores(eng_grp, obj);
+	return ret;
+}
+
+static int disable_eng_grp(struct device *dev,
+			   struct otx_cpt_eng_grp_info *eng_grp,
+			   void *obj)
+{
+	int i, ret;
+
+	ret = cpt_detach_and_disable_cores(eng_grp, obj);
+	if (ret)
+		return ret;
+
+	/* Unload ucode used by this engine group */
+	ucode_unload(dev, &eng_grp->ucode[0]);
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		if (!eng_grp->engs[i].type)
+			continue;
+
+		eng_grp->engs[i].ucode = &eng_grp->ucode[0];
+	}
+
+	ret = cpt_set_ucode_base(eng_grp, obj);
+
+	return ret;
+}
+
+static void setup_eng_grp_mirroring(struct otx_cpt_eng_grp_info *dst_grp,
+				    struct otx_cpt_eng_grp_info *src_grp)
+{
+	/* Setup fields for engine group which is mirrored */
+	src_grp->mirror.is_ena = false;
+	src_grp->mirror.idx = 0;
+	src_grp->mirror.ref_count++;
+
+	/* Setup fields for mirroring engine group */
+	dst_grp->mirror.is_ena = true;
+	dst_grp->mirror.idx = src_grp->idx;
+	dst_grp->mirror.ref_count = 0;
+}
+
+static void remove_eng_grp_mirroring(struct otx_cpt_eng_grp_info *dst_grp)
+{
+	struct otx_cpt_eng_grp_info *src_grp;
+
+	if (!dst_grp->mirror.is_ena)
+		return;
+
+	src_grp = &dst_grp->g->grp[dst_grp->mirror.idx];
+
+	src_grp->mirror.ref_count--;
+	dst_grp->mirror.is_ena = false;
+	dst_grp->mirror.idx = 0;
+	dst_grp->mirror.ref_count = 0;
+}
+
+static void update_requested_engs(struct otx_cpt_eng_grp_info *mirrored_eng_grp,
+				  struct otx_cpt_engines *engs, int engs_cnt)
+{
+	struct otx_cpt_engs_rsvd *mirrored_engs;
+	int i;
+
+	for (i = 0; i < engs_cnt; i++) {
+		mirrored_engs = find_engines_by_type(mirrored_eng_grp,
+						     engs[i].type);
+		if (!mirrored_engs)
+			continue;
+
+		/*
+		 * If mirrored group has this type of engines attached then
+		 * there are 3 scenarios possible:
+		 * 1) mirrored_engs.count == engs[i].count then all engines
+		 * from mirrored engine group will be shared with this engine
+		 * group
+		 * 2) mirrored_engs.count > engs[i].count then only a subset of
+		 * engines from mirrored engine group will be shared with this
+		 * engine group
+		 * 3) mirrored_engs.count < engs[i].count then all engines
+		 * from mirrored engine group will be shared with this group
+		 * and additional engines will be reserved for exclusively use
+		 * by this engine group
+		 */
+		engs[i].count -= mirrored_engs->count;
+	}
+}
+
+static struct otx_cpt_eng_grp_info *find_mirrored_eng_grp(
+					struct otx_cpt_eng_grp_info *grp)
+{
+	struct otx_cpt_eng_grps *eng_grps = grp->g;
+	int i;
+
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
+		if (!eng_grps->grp[i].is_enabled)
+			continue;
+		if (eng_grps->grp[i].ucode[0].type)
+			continue;
+		if (grp->idx == i)
+			continue;
+		if (!strncasecmp(eng_grps->grp[i].ucode[0].ver_str,
+				 grp->ucode[0].ver_str,
+				 OTX_CPT_UCODE_VER_STR_SZ))
+			return &eng_grps->grp[i];
+	}
+
+	return NULL;
+}
+
+static struct otx_cpt_eng_grp_info *find_unused_eng_grp(
+					struct otx_cpt_eng_grps *eng_grps)
+{
+	int i;
+
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
+		if (!eng_grps->grp[i].is_enabled)
+			return &eng_grps->grp[i];
+	}
+	return NULL;
+}
+
+static int eng_grp_update_masks(struct device *dev,
+				struct otx_cpt_eng_grp_info *eng_grp)
+{
+	struct otx_cpt_engs_rsvd *engs, *mirrored_engs;
+	struct otx_cpt_bitmap tmp_bmap = { {0} };
+	int i, j, cnt, max_cnt;
+	int bit;
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		engs = &eng_grp->engs[i];
+		if (!engs->type)
+			continue;
+		if (engs->count <= 0)
+			continue;
+
+		switch (engs->type) {
+		case OTX_CPT_SE_TYPES:
+			max_cnt = eng_grp->g->avail.max_se_cnt;
+			break;
+
+		case OTX_CPT_AE_TYPES:
+			max_cnt = eng_grp->g->avail.max_ae_cnt;
+			break;
+
+		default:
+			dev_err(dev, "Invalid engine type %d", engs->type);
+			return -EINVAL;
+		}
+
+		cnt = engs->count;
+		WARN_ON(engs->offset + max_cnt > OTX_CPT_MAX_ENGINES);
+		bitmap_zero(tmp_bmap.bits, eng_grp->g->engs_num);
+		for (j = engs->offset; j < engs->offset + max_cnt; j++) {
+			if (!eng_grp->g->eng_ref_cnt[j]) {
+				bitmap_set(tmp_bmap.bits, j, 1);
+				cnt--;
+				if (!cnt)
+					break;
+			}
+		}
+
+		if (cnt)
+			return -ENOSPC;
+
+		bitmap_copy(engs->bmap, tmp_bmap.bits, eng_grp->g->engs_num);
+	}
+
+	if (!eng_grp->mirror.is_ena)
+		return 0;
+
+	for (i = 0; i < OTX_CPT_MAX_ETYPES_PER_GRP; i++) {
+		engs = &eng_grp->engs[i];
+		if (!engs->type)
+			continue;
+
+		mirrored_engs = find_engines_by_type(
+					&eng_grp->g->grp[eng_grp->mirror.idx],
+					engs->type);
+		WARN_ON(!mirrored_engs && engs->count <= 0);
+		if (!mirrored_engs)
+			continue;
+
+		bitmap_copy(tmp_bmap.bits, mirrored_engs->bmap,
+			    eng_grp->g->engs_num);
+		if (engs->count < 0) {
+			bit = find_first_bit(mirrored_engs->bmap,
+					     eng_grp->g->engs_num);
+			bitmap_clear(tmp_bmap.bits, bit, -engs->count);
+		}
+		bitmap_or(engs->bmap, engs->bmap, tmp_bmap.bits,
+			  eng_grp->g->engs_num);
+	}
+	return 0;
+}
+
+static int delete_engine_group(struct device *dev,
+			       struct otx_cpt_eng_grp_info *eng_grp)
+{
+	int i, ret;
+
+	if (!eng_grp->is_enabled)
+		return -EINVAL;
+
+	if (eng_grp->mirror.ref_count) {
+		dev_err(dev, "Can't delete engine_group%d as it is used by:",
+			eng_grp->idx);
+		for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
+			if (eng_grp->g->grp[i].mirror.is_ena &&
+			    eng_grp->g->grp[i].mirror.idx == eng_grp->idx)
+				dev_err(dev, "engine_group%d", i);
+		}
+		return -EINVAL;
+	}
+
+	/* Removing engine group mirroring if enabled */
+	remove_eng_grp_mirroring(eng_grp);
+
+	/* Disable engine group */
+	ret = disable_eng_grp(dev, eng_grp, eng_grp->g->obj);
+	if (ret)
+		return ret;
+
+	/* Release all engines held by this engine group */
+	ret = release_engines(dev, eng_grp);
+	if (ret)
+		return ret;
+
+	device_remove_file(dev, &eng_grp->info_attr);
+	eng_grp->is_enabled = false;
+
+	return 0;
+}
+
+static int validate_1_ucode_scenario(struct device *dev,
+				     struct otx_cpt_eng_grp_info *eng_grp,
+				     struct otx_cpt_engines *engs, int engs_cnt)
+{
+	int i;
+
+	/* Verify that ucode loaded supports requested engine types */
+	for (i = 0; i < engs_cnt; i++) {
+		if (!otx_cpt_uc_supports_eng_type(&eng_grp->ucode[0],
+						  engs[i].type)) {
+			dev_err(dev,
+				"Microcode %s does not support %s engines",
+				eng_grp->ucode[0].filename,
+				get_eng_type_str(engs[i].type));
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static void update_ucode_ptrs(struct otx_cpt_eng_grp_info *eng_grp)
+{
+	struct otx_cpt_ucode *ucode;
+
+	if (eng_grp->mirror.is_ena)
+		ucode = &eng_grp->g->grp[eng_grp->mirror.idx].ucode[0];
+	else
+		ucode = &eng_grp->ucode[0];
+	WARN_ON(!eng_grp->engs[0].type);
+	eng_grp->engs[0].ucode = ucode;
+}
+
+static int create_engine_group(struct device *dev,
+			       struct otx_cpt_eng_grps *eng_grps,
+			       struct otx_cpt_engines *engs, int engs_cnt,
+			       void *ucode_data[], int ucodes_cnt,
+			       bool use_uc_from_tar_arch)
+{
+	struct otx_cpt_eng_grp_info *mirrored_eng_grp;
+	struct tar_ucode_info_t *tar_info;
+	struct otx_cpt_eng_grp_info *eng_grp;
+	int i, ret = 0;
+
+	if (ucodes_cnt > OTX_CPT_MAX_ETYPES_PER_GRP)
+		return -EINVAL;
+
+	/* Validate if requested engine types are supported by this device */
+	for (i = 0; i < engs_cnt; i++)
+		if (!dev_supports_eng_type(eng_grps, engs[i].type)) {
+			dev_err(dev, "Device does not support %s engines",
+				get_eng_type_str(engs[i].type));
+			return -EPERM;
+		}
+
+	/* Find engine group which is not used */
+	eng_grp = find_unused_eng_grp(eng_grps);
+	if (!eng_grp) {
+		dev_err(dev, "Error all engine groups are being used");
+		return -ENOSPC;
+	}
+
+	/* Load ucode */
+	for (i = 0; i < ucodes_cnt; i++) {
+		if (use_uc_from_tar_arch) {
+			tar_info = (struct tar_ucode_info_t *) ucode_data[i];
+			eng_grp->ucode[i] = tar_info->ucode;
+			ret = copy_ucode_to_dma_mem(dev, &eng_grp->ucode[i],
+						    tar_info->ucode_ptr);
+		} else
+			ret = ucode_load(dev, &eng_grp->ucode[i],
+					 (char *) ucode_data[i]);
+		if (ret)
+			goto err_ucode_unload;
+	}
+
+	/* Validate scenario where 1 ucode is used */
+	ret = validate_1_ucode_scenario(dev, eng_grp, engs, engs_cnt);
+	if (ret)
+		goto err_ucode_unload;
+
+	/* Check if this group mirrors another existing engine group */
+	mirrored_eng_grp = find_mirrored_eng_grp(eng_grp);
+	if (mirrored_eng_grp) {
+		/* Setup mirroring */
+		setup_eng_grp_mirroring(eng_grp, mirrored_eng_grp);
+
+		/*
+		 * Update count of requested engines because some
+		 * of them might be shared with mirrored group
+		 */
+		update_requested_engs(mirrored_eng_grp, engs, engs_cnt);
+	}
+
+	/* Reserve engines */
+	ret = reserve_engines(dev, eng_grp, engs, engs_cnt);
+	if (ret)
+		goto err_ucode_unload;
+
+	/* Update ucode pointers used by engines */
+	update_ucode_ptrs(eng_grp);
+
+	/* Update engine masks used by this group */
+	ret = eng_grp_update_masks(dev, eng_grp);
+	if (ret)
+		goto err_release_engs;
+
+	/* Create sysfs entry for engine group info */
+	ret = create_sysfs_eng_grps_info(dev, eng_grp);
+	if (ret)
+		goto err_release_engs;
+
+	/* Enable engine group */
+	ret = enable_eng_grp(eng_grp, eng_grps->obj);
+	if (ret)
+		goto err_release_engs;
+
+	/*
+	 * If this engine group mirrors another engine group
+	 * then we need to unload ucode as we will use ucode
+	 * from mirrored engine group
+	 */
+	if (eng_grp->mirror.is_ena)
+		ucode_unload(dev, &eng_grp->ucode[0]);
+
+	eng_grp->is_enabled = true;
+	if (eng_grp->mirror.is_ena)
+		dev_info(dev,
+			 "Engine_group%d: reuse microcode %s from group %d",
+			 eng_grp->idx, mirrored_eng_grp->ucode[0].ver_str,
+			 mirrored_eng_grp->idx);
+	else
+		dev_info(dev, "Engine_group%d: microcode loaded %s",
+			 eng_grp->idx, eng_grp->ucode[0].ver_str);
+
+	return 0;
+
+err_release_engs:
+	release_engines(dev, eng_grp);
+err_ucode_unload:
+	ucode_unload(dev, &eng_grp->ucode[0]);
+	return ret;
+}
+
+static ssize_t ucode_load_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct otx_cpt_engines engs[OTX_CPT_MAX_ETYPES_PER_GRP] = { {0} };
+	char *ucode_filename[OTX_CPT_MAX_ETYPES_PER_GRP];
+	char tmp_buf[OTX_CPT_UCODE_NAME_LENGTH] = { 0 };
+	char *start, *val, *err_msg, *tmp;
+	struct otx_cpt_eng_grps *eng_grps;
+	int grp_idx = 0, ret = -EINVAL;
+	bool has_se, has_ie, has_ae;
+	int del_grp_idx = -1;
+	int ucode_idx = 0;
+
+	if (strlen(buf) > OTX_CPT_UCODE_NAME_LENGTH)
+		return -EINVAL;
+
+	eng_grps = container_of(attr, struct otx_cpt_eng_grps, ucode_load_attr);
+	err_msg = "Invalid engine group format";
+	strlcpy(tmp_buf, buf, OTX_CPT_UCODE_NAME_LENGTH);
+	start = tmp_buf;
+
+	has_se = has_ie = has_ae = false;
+
+	for (;;) {
+		val = strsep(&start, ";");
+		if (!val)
+			break;
+		val = strim(val);
+		if (!*val)
+			continue;
+
+		if (!strncasecmp(val, "engine_group", 12)) {
+			if (del_grp_idx != -1)
+				goto err_print;
+			tmp = strim(strsep(&val, ":"));
+			if (!val)
+				goto err_print;
+			if (strlen(tmp) != 13)
+				goto err_print;
+			if (kstrtoint((tmp + 12), 10, &del_grp_idx))
+				goto err_print;
+			val = strim(val);
+			if (strncasecmp(val, "null", 4))
+				goto err_print;
+			if (strlen(val) != 4)
+				goto err_print;
+		} else if (!strncasecmp(val, "se", 2) && strchr(val, ':')) {
+			if (has_se || ucode_idx)
+				goto err_print;
+			tmp = strim(strsep(&val, ":"));
+			if (!val)
+				goto err_print;
+			if (strlen(tmp) != 2)
+				goto err_print;
+			if (kstrtoint(strim(val), 10, &engs[grp_idx].count))
+				goto err_print;
+			engs[grp_idx++].type = OTX_CPT_SE_TYPES;
+			has_se = true;
+		} else if (!strncasecmp(val, "ae", 2) && strchr(val, ':')) {
+			if (has_ae || ucode_idx)
+				goto err_print;
+			tmp = strim(strsep(&val, ":"));
+			if (!val)
+				goto err_print;
+			if (strlen(tmp) != 2)
+				goto err_print;
+			if (kstrtoint(strim(val), 10, &engs[grp_idx].count))
+				goto err_print;
+			engs[grp_idx++].type = OTX_CPT_AE_TYPES;
+			has_ae = true;
+		} else {
+			if (ucode_idx > 1)
+				goto err_print;
+			if (!strlen(val))
+				goto err_print;
+			if (strnstr(val, " ", strlen(val)))
+				goto err_print;
+			ucode_filename[ucode_idx++] = val;
+		}
+	}
+
+	/* Validate input parameters */
+	if (del_grp_idx == -1) {
+		if (!(grp_idx && ucode_idx))
+			goto err_print;
+
+		if (ucode_idx > 1 && grp_idx < 2)
+			goto err_print;
+
+		if (grp_idx > OTX_CPT_MAX_ETYPES_PER_GRP) {
+			err_msg = "Error max 2 engine types can be attached";
+			goto err_print;
+		}
+
+	} else {
+		if (del_grp_idx < 0 ||
+		    del_grp_idx >= OTX_CPT_MAX_ENGINE_GROUPS) {
+			dev_err(dev, "Invalid engine group index %d",
+				del_grp_idx);
+			ret = -EINVAL;
+			return ret;
+		}
+
+		if (!eng_grps->grp[del_grp_idx].is_enabled) {
+			dev_err(dev, "Error engine_group%d is not configured",
+				del_grp_idx);
+			ret = -EINVAL;
+			return ret;
+		}
+
+		if (grp_idx || ucode_idx)
+			goto err_print;
+	}
+
+	mutex_lock(&eng_grps->lock);
+
+	if (eng_grps->is_rdonly) {
+		dev_err(dev, "Disable VFs before modifying engine groups\n");
+		ret = -EACCES;
+		goto err_unlock;
+	}
+
+	if (del_grp_idx == -1)
+		/* create engine group */
+		ret = create_engine_group(dev, eng_grps, engs, grp_idx,
+					  (void **) ucode_filename,
+					  ucode_idx, false);
+	else
+		/* delete engine group */
+		ret = delete_engine_group(dev, &eng_grps->grp[del_grp_idx]);
+	if (ret)
+		goto err_unlock;
+
+	print_dbg_info(dev, eng_grps);
+err_unlock:
+	mutex_unlock(&eng_grps->lock);
+	return ret ? ret : count;
+err_print:
+	dev_err(dev, "%s\n", err_msg);
+
+	return ret;
+}
+
+int otx_cpt_try_create_default_eng_grps(struct pci_dev *pdev,
+					struct otx_cpt_eng_grps *eng_grps,
+					int pf_type)
+{
+	struct tar_ucode_info_t *tar_info[OTX_CPT_MAX_ETYPES_PER_GRP] = { 0 };
+	struct otx_cpt_engines engs[OTX_CPT_MAX_ETYPES_PER_GRP] = { {0} };
+	struct tar_arch_info_t *tar_arch = NULL;
+	char *tar_filename;
+	int i, ret = 0;
+
+	mutex_lock(&eng_grps->lock);
+
+	/*
+	 * We don't create engine group for kernel crypto if attempt to create
+	 * it was already made (when user enabled VFs for the first time)
+	 */
+	if (eng_grps->is_first_try)
+		goto unlock_mutex;
+	eng_grps->is_first_try = true;
+
+	/* We create group for kcrypto only if no groups are configured */
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++)
+		if (eng_grps->grp[i].is_enabled)
+			goto unlock_mutex;
+
+	switch (pf_type) {
+	case OTX_CPT_AE:
+	case OTX_CPT_SE:
+		tar_filename = OTX_CPT_UCODE_TAR_FILE_NAME;
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Unknown PF type %d\n", pf_type);
+		ret = -EINVAL;
+		goto unlock_mutex;
+	}
+
+	tar_arch = load_tar_archive(&pdev->dev, tar_filename);
+	if (!tar_arch)
+		goto unlock_mutex;
+
+	/*
+	 * If device supports SE engines and there is SE microcode in tar
+	 * archive try to create engine group with SE engines for kernel
+	 * crypto functionality (symmetric crypto)
+	 */
+	tar_info[0] = get_uc_from_tar_archive(tar_arch, OTX_CPT_SE_TYPES);
+	if (tar_info[0] &&
+	    dev_supports_eng_type(eng_grps, OTX_CPT_SE_TYPES)) {
+
+		engs[0].type = OTX_CPT_SE_TYPES;
+		engs[0].count = eng_grps->avail.max_se_cnt;
+
+		ret = create_engine_group(&pdev->dev, eng_grps, engs, 1,
+					  (void **) tar_info, 1, true);
+		if (ret)
+			goto release_tar_arch;
+	}
+	/*
+	 * If device supports AE engines and there is AE microcode in tar
+	 * archive try to create engine group with AE engines for asymmetric
+	 * crypto functionality.
+	 */
+	tar_info[0] = get_uc_from_tar_archive(tar_arch, OTX_CPT_AE_TYPES);
+	if (tar_info[0] &&
+	    dev_supports_eng_type(eng_grps, OTX_CPT_AE_TYPES)) {
+
+		engs[0].type = OTX_CPT_AE_TYPES;
+		engs[0].count = eng_grps->avail.max_ae_cnt;
+
+		ret = create_engine_group(&pdev->dev, eng_grps, engs, 1,
+					  (void **) tar_info, 1, true);
+		if (ret)
+			goto release_tar_arch;
+	}
+
+	print_dbg_info(&pdev->dev, eng_grps);
+release_tar_arch:
+	release_tar_archive(tar_arch);
+unlock_mutex:
+	mutex_unlock(&eng_grps->lock);
+	return ret;
+}
+
+void otx_cpt_set_eng_grps_is_rdonly(struct otx_cpt_eng_grps *eng_grps,
+				    bool is_rdonly)
+{
+	mutex_lock(&eng_grps->lock);
+
+	eng_grps->is_rdonly = is_rdonly;
+
+	mutex_unlock(&eng_grps->lock);
+}
+
+void otx_cpt_disable_all_cores(struct otx_cpt_device *cpt)
+{
+	int grp, timeout = 100;
+	u64 reg;
+
+	/* Disengage the cores from groups */
+	for (grp = 0; grp < OTX_CPT_MAX_ENGINE_GROUPS; grp++) {
+		writeq(0, cpt->reg_base + OTX_CPT_PF_GX_EN(grp));
+		udelay(CSR_DELAY);
+	}
+
+	reg = readq(cpt->reg_base + OTX_CPT_PF_EXEC_BUSY);
+	while (reg) {
+		udelay(CSR_DELAY);
+		reg = readq(cpt->reg_base + OTX_CPT_PF_EXEC_BUSY);
+		if (timeout--) {
+			dev_warn(&cpt->pdev->dev, "Cores still busy");
+			break;
+		}
+	}
+
+	/* Disable the cores */
+	writeq(0, cpt->reg_base + OTX_CPT_PF_EXE_CTL);
+}
+
+void otx_cpt_cleanup_eng_grps(struct pci_dev *pdev,
+			      struct otx_cpt_eng_grps *eng_grps)
+{
+	struct otx_cpt_eng_grp_info *grp;
+	int i, j;
+
+	mutex_lock(&eng_grps->lock);
+	if (eng_grps->is_ucode_load_created) {
+		device_remove_file(&pdev->dev,
+				   &eng_grps->ucode_load_attr);
+		eng_grps->is_ucode_load_created = false;
+	}
+
+	/* First delete all mirroring engine groups */
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++)
+		if (eng_grps->grp[i].mirror.is_ena)
+			delete_engine_group(&pdev->dev, &eng_grps->grp[i]);
+
+	/* Delete remaining engine groups */
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++)
+		delete_engine_group(&pdev->dev, &eng_grps->grp[i]);
+
+	/* Release memory */
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
+		grp = &eng_grps->grp[i];
+		for (j = 0; j < OTX_CPT_MAX_ETYPES_PER_GRP; j++) {
+			kfree(grp->engs[j].bmap);
+			grp->engs[j].bmap = NULL;
+		}
+	}
+
+	mutex_unlock(&eng_grps->lock);
+}
+
+int otx_cpt_init_eng_grps(struct pci_dev *pdev,
+			  struct otx_cpt_eng_grps *eng_grps, int pf_type)
+{
+	struct otx_cpt_eng_grp_info *grp;
+	int i, j, ret = 0;
+
+	mutex_init(&eng_grps->lock);
+	eng_grps->obj = pci_get_drvdata(pdev);
+	eng_grps->avail.se_cnt = eng_grps->avail.max_se_cnt;
+	eng_grps->avail.ae_cnt = eng_grps->avail.max_ae_cnt;
+
+	eng_grps->engs_num = eng_grps->avail.max_se_cnt +
+			     eng_grps->avail.max_ae_cnt;
+	if (eng_grps->engs_num > OTX_CPT_MAX_ENGINES) {
+		dev_err(&pdev->dev,
+			"Number of engines %d > than max supported %d",
+			eng_grps->engs_num, OTX_CPT_MAX_ENGINES);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
+		grp = &eng_grps->grp[i];
+		grp->g = eng_grps;
+		grp->idx = i;
+
+		snprintf(grp->sysfs_info_name, OTX_CPT_UCODE_NAME_LENGTH,
+			 "engine_group%d", i);
+		for (j = 0; j < OTX_CPT_MAX_ETYPES_PER_GRP; j++) {
+			grp->engs[j].bmap =
+				kcalloc(BITS_TO_LONGS(eng_grps->engs_num),
+					sizeof(long), GFP_KERNEL);
+			if (!grp->engs[j].bmap) {
+				ret = -ENOMEM;
+				goto err;
+			}
+		}
+	}
+
+	switch (pf_type) {
+	case OTX_CPT_SE:
+		/* OcteonTX 83XX SE CPT PF has only SE engines attached */
+		eng_grps->eng_types_supported = 1 << OTX_CPT_SE_TYPES;
+		break;
+
+	case OTX_CPT_AE:
+		/* OcteonTX 83XX AE CPT PF has only AE engines attached */
+		eng_grps->eng_types_supported = 1 << OTX_CPT_AE_TYPES;
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Unknown PF type %d\n", pf_type);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	eng_grps->ucode_load_attr.show = NULL;
+	eng_grps->ucode_load_attr.store = ucode_load_store;
+	eng_grps->ucode_load_attr.attr.name = "ucode_load";
+	eng_grps->ucode_load_attr.attr.mode = 0220;
+	sysfs_attr_init(&eng_grps->ucode_load_attr.attr);
+	ret = device_create_file(&pdev->dev,
+				 &eng_grps->ucode_load_attr);
+	if (ret)
+		goto err;
+	eng_grps->is_ucode_load_created = true;
+
+	print_dbg_info(&pdev->dev, eng_grps);
+	return ret;
+err:
+	otx_cpt_cleanup_eng_grps(pdev, eng_grps);
+	return ret;
+}
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.h b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.h
new file mode 100644
index 0000000..14f02b6
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTX CPT driver
+ *
+ * Copyright (C) 2019 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OTX_CPTPF_UCODE_H
+#define __OTX_CPTPF_UCODE_H
+
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include "otx_cpt_hw_types.h"
+
+/* CPT ucode name maximum length */
+#define OTX_CPT_UCODE_NAME_LENGTH	64
+/*
+ * On OcteonTX 83xx platform, only one type of engines is allowed to be
+ * attached to an engine group.
+ */
+#define OTX_CPT_MAX_ETYPES_PER_GRP	1
+
+/* Default tar archive file names */
+#define OTX_CPT_UCODE_TAR_FILE_NAME	"cpt8x-mc.tar"
+
+/* CPT ucode alignment */
+#define OTX_CPT_UCODE_ALIGNMENT		128
+
+/* CPT ucode signature size */
+#define OTX_CPT_UCODE_SIGN_LEN		256
+
+/* Microcode version string length */
+#define OTX_CPT_UCODE_VER_STR_SZ	44
+
+/* Maximum number of supported engines/cores on OcteonTX 83XX platform */
+#define OTX_CPT_MAX_ENGINES		64
+
+#define OTX_CPT_ENGS_BITMASK_LEN	(OTX_CPT_MAX_ENGINES/(BITS_PER_BYTE * \
+					 sizeof(unsigned long)))
+
+/* Microcode types */
+enum otx_cpt_ucode_type {
+	OTX_CPT_AE_UC_TYPE =	1,  /* AE-MAIN */
+	OTX_CPT_SE_UC_TYPE1 =	20, /* SE-MAIN - combination of 21 and 22 */
+	OTX_CPT_SE_UC_TYPE2 =	21, /* Fast Path IPSec + AirCrypto */
+	OTX_CPT_SE_UC_TYPE3 =	22, /*
+				     * Hash + HMAC + FlexiCrypto + RNG + Full
+				     * Feature IPSec + AirCrypto + Kasumi
+				     */
+};
+
+struct otx_cpt_bitmap {
+	unsigned long bits[OTX_CPT_ENGS_BITMASK_LEN];
+	int size;
+};
+
+struct otx_cpt_engines {
+	int type;
+	int count;
+};
+
+/* Microcode version number */
+struct otx_cpt_ucode_ver_num {
+	u8 nn;
+	u8 xx;
+	u8 yy;
+	u8 zz;
+};
+
+struct otx_cpt_ucode_hdr {
+	struct otx_cpt_ucode_ver_num ver_num;
+	u8 ver_str[OTX_CPT_UCODE_VER_STR_SZ];
+	u32 code_length;
+	u32 padding[3];
+};
+
+struct otx_cpt_ucode {
+	u8 ver_str[OTX_CPT_UCODE_VER_STR_SZ];/*
+					      * ucode version in readable format
+					      */
+	struct otx_cpt_ucode_ver_num ver_num;/* ucode version number */
+	char filename[OTX_CPT_UCODE_NAME_LENGTH];	 /* ucode filename */
+	dma_addr_t dma;		/* phys address of ucode image */
+	dma_addr_t align_dma;	/* aligned phys address of ucode image */
+	void *va;		/* virt address of ucode image */
+	void *align_va;		/* aligned virt address of ucode image */
+	u32 size;		/* ucode image size */
+	int type;		/* ucode image type SE or AE */
+};
+
+struct tar_ucode_info_t {
+	struct list_head list;
+	struct otx_cpt_ucode ucode;/* microcode information */
+	const u8 *ucode_ptr;	/* pointer to microcode in tar archive */
+};
+
+/* Maximum and current number of engines available for all engine groups */
+struct otx_cpt_engs_available {
+	int max_se_cnt;
+	int max_ae_cnt;
+	int se_cnt;
+	int ae_cnt;
+};
+
+/* Engines reserved to an engine group */
+struct otx_cpt_engs_rsvd {
+	int type;	/* engine type */
+	int count;	/* number of engines attached */
+	int offset;     /* constant offset of engine type in the bitmap */
+	unsigned long *bmap;		/* attached engines bitmap */
+	struct otx_cpt_ucode *ucode;	/* ucode used by these engines */
+};
+
+struct otx_cpt_mirror_info {
+	int is_ena;	/*
+			 * is mirroring enabled, it is set only for engine
+			 * group which mirrors another engine group
+			 */
+	int idx;	/*
+			 * index of engine group which is mirrored by this
+			 * group, set only for engine group which mirrors
+			 * another group
+			 */
+	int ref_count;	/*
+			 * number of times this engine group is mirrored by
+			 * other groups, this is set only for engine group
+			 * which is mirrored by other group(s)
+			 */
+};
+
+struct otx_cpt_eng_grp_info {
+	struct otx_cpt_eng_grps *g; /* pointer to engine_groups structure */
+	struct device_attribute info_attr; /* group info entry attr */
+	/* engines attached */
+	struct otx_cpt_engs_rsvd engs[OTX_CPT_MAX_ETYPES_PER_GRP];
+	/* Microcode information */
+	struct otx_cpt_ucode ucode[OTX_CPT_MAX_ETYPES_PER_GRP];
+	/* sysfs info entry name */
+	char sysfs_info_name[OTX_CPT_UCODE_NAME_LENGTH];
+	/* engine group mirroring information */
+	struct otx_cpt_mirror_info mirror;
+	int idx;	 /* engine group index */
+	bool is_enabled; /*
+			  * is engine group enabled, engine group is enabled
+			  * when it has engines attached and ucode loaded
+			  */
+};
+
+struct otx_cpt_eng_grps {
+	struct otx_cpt_eng_grp_info grp[OTX_CPT_MAX_ENGINE_GROUPS];
+	struct device_attribute ucode_load_attr;/* ucode load attr */
+	struct otx_cpt_engs_available avail;
+	struct mutex lock;
+	void *obj;
+	int engs_num;			/* total number of engines supported */
+	int eng_types_supported;	/* engine types supported SE, AE */
+	u8 eng_ref_cnt[OTX_CPT_MAX_ENGINES];/* engines reference count */
+	bool is_ucode_load_created;	/* is ucode_load sysfs entry created */
+	bool is_first_try; /* is this first try to create kcrypto engine grp */
+	bool is_rdonly;	/* do engine groups configuration can be modified */
+};
+
+int otx_cpt_init_eng_grps(struct pci_dev *pdev,
+			  struct otx_cpt_eng_grps *eng_grps, int pf_type);
+void otx_cpt_cleanup_eng_grps(struct pci_dev *pdev,
+			      struct otx_cpt_eng_grps *eng_grps);
+int otx_cpt_try_create_default_eng_grps(struct pci_dev *pdev,
+					struct otx_cpt_eng_grps *eng_grps,
+					int pf_type);
+void otx_cpt_set_eng_grps_is_rdonly(struct otx_cpt_eng_grps *eng_grps,
+				    bool is_rdonly);
+int otx_cpt_uc_supports_eng_type(struct otx_cpt_ucode *ucode, int eng_type);
+int otx_cpt_eng_grp_has_eng_type(struct otx_cpt_eng_grp_info *eng_grp,
+				 int eng_type);
+
+#endif /* __OTX_CPTPF_UCODE_H */
-- 
1.9.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB17A18462F
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2020 12:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCMLse (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Mar 2020 07:48:34 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16964 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgCMLsc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Mar 2020 07:48:32 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DBk77L020821;
        Fri, 13 Mar 2020 04:48:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=b2p5uqkgfqDBZSjnI5TYIzMCFihDs7WEDXaqk/CNXTQ=;
 b=ak0887sarXwWQmWJqE+l6oQUGKmhJBIjn1NrBRT1dm0TBpgdoeyYBs4jbW0teiYBgNbC
 iiGYwd30qs3i4WfeDvdqlN09P5bV/y9crzUBpolRr7eZ5FWFFRvJspMOq2o4LVNyuWZd
 9BuQWo1fr8XqNmGL3ACtvkdM3vrcMfWc3mifUi32WXbwRmkKPFBFoMrTmBuKvS8UFdlq
 +M5pGxHrdSHjHfyi6D2nARcBtvi41JfApO0jvw4iFgC05cTHQ0QMGUqGR/BFfhJyc6dc
 Ph5t2WFtg56ATw52npwtbtKc05/XhVZ7x+2nqNJcQcJ7IZfEC2Z6UgMI1Hsu9KAqmxrw Jw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yqt7f3n7r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 04:48:11 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Mar
 2020 04:48:09 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Mar 2020 04:48:08 -0700
Received: from hyd1schalla-dt.marvell.com (hyd1schalla-dt.marvell.com [10.29.8.39])
        by maili.marvell.com (Postfix) with ESMTP id 4F9BF3F704A;
        Fri, 13 Mar 2020 04:48:03 -0700 (PDT)
From:   Srujana Challa <schalla@marvell.com>
To:     <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <pathreya@marvell.com>, <schandran@marvell.com>,
        <arno@natisbad.org>, <bbrezillon@kernel.org>,
        SrujanaChalla <schalla@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>
Subject: [PATCH v2 3/4] drivers: crypto: add the Virtual Function driver for CPT
Date:   Fri, 13 Mar 2020 17:17:07 +0530
Message-ID: <1584100028-21279-4-git-send-email-schalla@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584100028-21279-1-git-send-email-schalla@marvell.com>
References: <1584100028-21279-1-git-send-email-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: SrujanaChalla <schalla@marvell.com>

Add support for the cryptographic accelerator unit virtual functions on
OcteonTX 83XX SoC.

Co-developed-by: Lukasz Bartosik <lbartosik@marvell.com>
Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
Signed-off-by: SrujanaChalla <schalla@marvell.com>
---
 drivers/crypto/marvell/octeontx/Makefile           |    4 +-
 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h |  577 ++++++-
 drivers/crypto/marvell/octeontx/otx_cptvf.h        |  104 ++
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c   | 1744 ++++++++++++++++++++
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.h   |  188 +++
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c   |  985 +++++++++++
 drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c   |  247 +++
 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c |  612 +++++++
 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h |  227 +++
 9 files changed, 4686 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf.h
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf_algs.h
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf_main.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
 create mode 100644 drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h

diff --git a/drivers/crypto/marvell/octeontx/Makefile b/drivers/crypto/marvell/octeontx/Makefile
index 627d00e..5e956fe 100644
--- a/drivers/crypto/marvell/octeontx/Makefile
+++ b/drivers/crypto/marvell/octeontx/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CRYPTO_DEV_OCTEONTX_CPT) += octeontx-cpt.o
+obj-$(CONFIG_CRYPTO_DEV_OCTEONTX_CPT) += octeontx-cpt.o octeontx-cptvf.o
 
 octeontx-cpt-objs := otx_cptpf_main.o otx_cptpf_mbox.o otx_cptpf_ucode.o
+octeontx-cptvf-objs := otx_cptvf_main.o otx_cptvf_mbox.o otx_cptvf_reqmgr.o \
+		       otx_cptvf_algs.o
diff --git a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
index bec483f..b8bdb9f 100644
--- a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
+++ b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
@@ -15,11 +15,19 @@
 
 /* Device IDs */
 #define OTX_CPT_PCI_PF_DEVICE_ID 0xa040
+#define OTX_CPT_PCI_VF_DEVICE_ID 0xa041
 
 #define OTX_CPT_PCI_PF_SUBSYS_ID 0xa340
+#define OTX_CPT_PCI_VF_SUBSYS_ID 0xa341
 
 /* Configuration and status registers are in BAR0 on OcteonTX platform */
 #define OTX_CPT_PF_PCI_CFG_BAR	0
+#define OTX_CPT_VF_PCI_CFG_BAR	0
+
+#define OTX_CPT_BAR_E_CPTX_VFX_BAR0_OFFSET(a, b) \
+	(0x000020000000ll + 0x1000000000ll * (a) + 0x100000ll * (b))
+#define OTX_CPT_BAR_E_CPTX_VFX_BAR0_SIZE	0x400000
+
 /* Mailbox interrupts offset */
 #define OTX_CPT_PF_MBOX_INT	3
 #define OTX_CPT_PF_INT_VEC_E_MBOXX(x, a) ((x) + (a))
@@ -28,6 +36,19 @@
 /* Maximum supported microcode groups */
 #define OTX_CPT_MAX_ENGINE_GROUPS 8
 
+/* CPT instruction size in bytes */
+#define OTX_CPT_INST_SIZE 64
+/* CPT queue next chunk pointer size in bytes */
+#define OTX_CPT_NEXT_CHUNK_PTR_SIZE 8
+
+/* OcteonTX CPT VF MSIX vectors and their offsets */
+#define OTX_CPT_VF_MSIX_VECTORS 2
+#define OTX_CPT_VF_INTR_MBOX_MASK BIT(0)
+#define OTX_CPT_VF_INTR_DOVF_MASK BIT(1)
+#define OTX_CPT_VF_INTR_IRDE_MASK BIT(2)
+#define OTX_CPT_VF_INTR_NWRP_MASK BIT(3)
+#define OTX_CPT_VF_INTR_SERR_MASK BIT(4)
+
 /* OcteonTX CPT PF registers */
 #define OTX_CPT_PF_CONSTANTS		(0x0ll)
 #define OTX_CPT_PF_RESET		(0x100ll)
@@ -78,6 +99,190 @@
 #define OTX_CPT_PF_VFX_MBOXX(b, c)	(0x8001000ll | (u64)(b) << 20 | \
 					 (u64)(c) << 8)
 
+/* OcteonTX CPT VF registers */
+#define OTX_CPT_VQX_CTL(b)		(0x100ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_SADDR(b)		(0x200ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE_WAIT(b)	(0x400ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_INPROG(b)		(0x410ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE(b)		(0x420ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE_ACK(b)		(0x440ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE_INT_W1S(b)	(0x460ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE_INT_W1C(b)	(0x468ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE_ENA_W1S(b)	(0x470ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DONE_ENA_W1C(b)	(0x478ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_MISC_INT(b)		(0x500ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_MISC_INT_W1S(b)	(0x508ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_MISC_ENA_W1S(b)	(0x510ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_MISC_ENA_W1C(b)	(0x518ll | (u64)(b) << 20)
+#define OTX_CPT_VQX_DOORBELL(b)		(0x600ll | (u64)(b) << 20)
+#define OTX_CPT_VFX_PF_MBOXX(b, c)	(0x1000ll | ((b) << 20) | ((c) << 3))
+
+/*
+ * Enumeration otx_cpt_ucode_error_code_e
+ *
+ * Enumerates ucode errors
+ */
+enum otx_cpt_ucode_error_code_e {
+	CPT_NO_UCODE_ERROR = 0x00,
+	ERR_OPCODE_UNSUPPORTED = 0x01,
+
+	/* Scatter gather */
+	ERR_SCATTER_GATHER_WRITE_LENGTH = 0x02,
+	ERR_SCATTER_GATHER_LIST = 0x03,
+	ERR_SCATTER_GATHER_NOT_SUPPORTED = 0x04,
+
+};
+
+/*
+ * Enumeration otx_cpt_comp_e
+ *
+ * CPT OcteonTX Completion Enumeration
+ * Enumerates the values of CPT_RES_S[COMPCODE].
+ */
+enum otx_cpt_comp_e {
+	CPT_COMP_E_NOTDONE = 0x00,
+	CPT_COMP_E_GOOD = 0x01,
+	CPT_COMP_E_FAULT = 0x02,
+	CPT_COMP_E_SWERR = 0x03,
+	CPT_COMP_E_HWERR = 0x04,
+	CPT_COMP_E_LAST_ENTRY = 0x05
+};
+
+/*
+ * Enumeration otx_cpt_vf_int_vec_e
+ *
+ * CPT OcteonTX VF MSI-X Vector Enumeration
+ * Enumerates the MSI-X interrupt vectors.
+ */
+enum otx_cpt_vf_int_vec_e {
+	CPT_VF_INT_VEC_E_MISC = 0x00,
+	CPT_VF_INT_VEC_E_DONE = 0x01
+};
+
+/*
+ * Structure cpt_inst_s
+ *
+ * CPT Instruction Structure
+ * This structure specifies the instruction layout. Instructions are
+ * stored in memory as little-endian unless CPT()_PF_Q()_CTL[INST_BE] is set.
+ * cpt_inst_s_s
+ * Word 0
+ * doneint:1 Done interrupt.
+ *	0 = No interrupts related to this instruction.
+ *	1 = When the instruction completes, CPT()_VQ()_DONE[DONE] will be
+ *	incremented,and based on the rules described there an interrupt may
+ *	occur.
+ * Word 1
+ * res_addr [127: 64] Result IOVA.
+ *	If nonzero, specifies where to write CPT_RES_S.
+ *	If zero, no result structure will be written.
+ *	Address must be 16-byte aligned.
+ *	Bits <63:49> are ignored by hardware; software should use a
+ *	sign-extended bit <48> for forward compatibility.
+ * Word 2
+ *  grp:10 [171:162] If [WQ_PTR] is nonzero, the SSO guest-group to use when
+ *	CPT submits work SSO.
+ *	For the SSO to not discard the add-work request, FPA_PF_MAP() must map
+ *	[GRP] and CPT()_PF_Q()_GMCTL[GMID] as valid.
+ *  tt:2 [161:160] If [WQ_PTR] is nonzero, the SSO tag type to use when CPT
+ *	submits work to SSO
+ *  tag:32 [159:128] If [WQ_PTR] is nonzero, the SSO tag to use when CPT
+ *	submits work to SSO.
+ * Word 3
+ *  wq_ptr [255:192] If [WQ_PTR] is nonzero, it is a pointer to a
+ *	work-queue entry that CPT submits work to SSO after all context,
+ *	output data, and result write operations are visible to other
+ *	CNXXXX units and the cores. Bits <2:0> must be zero.
+ *	Bits <63:49> are ignored by hardware; software should
+ *	use a sign-extended bit <48> for forward compatibility.
+ *	Internal:
+ *	Bits <63:49>, <2:0> are ignored by hardware, treated as always 0x0.
+ * Word 4
+ *  ei0; [319:256] Engine instruction word 0. Passed to the AE/SE.
+ * Word 5
+ *  ei1; [383:320] Engine instruction word 1. Passed to the AE/SE.
+ * Word 6
+ *  ei2; [447:384] Engine instruction word 1. Passed to the AE/SE.
+ * Word 7
+ *  ei3; [511:448] Engine instruction word 1. Passed to the AE/SE.
+ *
+ */
+union otx_cpt_inst_s {
+	u64 u[8];
+
+	struct {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_17_63:47;
+		u64 doneint:1;
+		u64 reserved_0_15:16;
+#else /* Word 0 - Little Endian */
+		u64 reserved_0_15:16;
+		u64 doneint:1;
+		u64 reserved_17_63:47;
+#endif /* Word 0 - End */
+		u64 res_addr;
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 2 - Big Endian */
+		u64 reserved_172_191:20;
+		u64 grp:10;
+		u64 tt:2;
+		u64 tag:32;
+#else /* Word 2 - Little Endian */
+		u64 tag:32;
+		u64 tt:2;
+		u64 grp:10;
+		u64 reserved_172_191:20;
+#endif /* Word 2 - End */
+		u64 wq_ptr;
+		u64 ei0;
+		u64 ei1;
+		u64 ei2;
+		u64 ei3;
+	} s;
+};
+
+/*
+ * Structure cpt_res_s
+ *
+ * CPT Result Structure
+ * The CPT coprocessor writes the result structure after it completes a
+ * CPT_INST_S instruction. The result structure is exactly 16 bytes, and
+ * each instruction completion produces exactly one result structure.
+ *
+ * This structure is stored in memory as little-endian unless
+ * CPT()_PF_Q()_CTL[INST_BE] is set.
+ * cpt_res_s_s
+ * Word 0
+ *  doneint:1 [16:16] Done interrupt. This bit is copied from the
+ *	corresponding instruction's CPT_INST_S[DONEINT].
+ *  compcode:8 [7:0] Indicates completion/error status of the CPT coprocessor
+ *	for the	associated instruction, as enumerated by CPT_COMP_E.
+ *	Core software may write the memory location containing [COMPCODE] to
+ *	0x0 before ringing the doorbell, and then poll for completion by
+ *	checking for a nonzero value.
+ *	Once the core observes a nonzero [COMPCODE] value in this case,the CPT
+ *	coprocessor will have also completed L2/DRAM write operations.
+ * Word 1
+ *  reserved
+ *
+ */
+union otx_cpt_res_s {
+	u64 u[2];
+	struct {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_17_63:47;
+		u64 doneint:1;
+		u64 reserved_8_15:8;
+		u64 compcode:8;
+#else /* Word 0 - Little Endian */
+		u64 compcode:8;
+		u64 reserved_8_15:8;
+		u64 doneint:1;
+		u64 reserved_17_63:47;
+#endif /* Word 0 - End */
+		u64 reserved_64_127;
+	} s;
+};
+
 /*
  * Register (NCB) otx_cpt#_pf_bist_status
  *
@@ -246,4 +451,374 @@
 #endif /* Word 0 - End */
 	} s;
 };
-#endif /* __OTX_CPT_HW_TYPES_H */
+
+/*
+ * Register (NCB) otx_cpt#_vq#_saddr
+ *
+ * CPT Queue Starting Buffer Address Registers
+ * These registers set the instruction buffer starting address.
+ * otx_cptx_vqx_saddr_s
+ * Word0
+ *  reserved_49_63:15 [63:49] Reserved.
+ *  ptr:43 [48:6](R/W/H) Instruction buffer IOVA <48:6> (64-byte aligned).
+ *	When written, it is the initial buffer starting address; when read,
+ *	it is the next read pointer to be requested from L2C. The PTR field
+ *	is overwritten with the next pointer each time that the command buffer
+ *	segment is exhausted. New commands will then be read from the newly
+ *	specified command buffer pointer.
+ *  reserved_0_5:6 [5:0] Reserved.
+ *
+ */
+union otx_cptx_vqx_saddr {
+	u64 u;
+	struct otx_cptx_vqx_saddr_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_49_63:15;
+		u64 ptr:43;
+		u64 reserved_0_5:6;
+#else /* Word 0 - Little Endian */
+		u64 reserved_0_5:6;
+		u64 ptr:43;
+		u64 reserved_49_63:15;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_misc_ena_w1s
+ *
+ * CPT Queue Misc Interrupt Enable Set Register
+ * This register sets interrupt enable bits.
+ * otx_cptx_vqx_misc_ena_w1s_s
+ * Word0
+ * reserved_5_63:59 [63:5] Reserved.
+ * swerr:1 [4:4](R/W1S/H) Reads or sets enable for
+ *	CPT(0..1)_VQ(0..63)_MISC_INT[SWERR].
+ * nwrp:1 [3:3](R/W1S/H) Reads or sets enable for
+ *	CPT(0..1)_VQ(0..63)_MISC_INT[NWRP].
+ * irde:1 [2:2](R/W1S/H) Reads or sets enable for
+ *	CPT(0..1)_VQ(0..63)_MISC_INT[IRDE].
+ * dovf:1 [1:1](R/W1S/H) Reads or sets enable for
+ *	CPT(0..1)_VQ(0..63)_MISC_INT[DOVF].
+ * mbox:1 [0:0](R/W1S/H) Reads or sets enable for
+ *	CPT(0..1)_VQ(0..63)_MISC_INT[MBOX].
+ *
+ */
+union otx_cptx_vqx_misc_ena_w1s {
+	u64 u;
+	struct otx_cptx_vqx_misc_ena_w1s_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_5_63:59;
+		u64 swerr:1;
+		u64 nwrp:1;
+		u64 irde:1;
+		u64 dovf:1;
+		u64 mbox:1;
+#else /* Word 0 - Little Endian */
+		u64 mbox:1;
+		u64 dovf:1;
+		u64 irde:1;
+		u64 nwrp:1;
+		u64 swerr:1;
+		u64 reserved_5_63:59;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_doorbell
+ *
+ * CPT Queue Doorbell Registers
+ * Doorbells for the CPT instruction queues.
+ * otx_cptx_vqx_doorbell_s
+ * Word0
+ *  reserved_20_63:44 [63:20] Reserved.
+ *  dbell_cnt:20 [19:0](R/W/H) Number of instruction queue 64-bit words to add
+ *	to the CPT instruction doorbell count. Readback value is the the
+ *	current number of pending doorbell requests. If counter overflows
+ *	CPT()_VQ()_MISC_INT[DBELL_DOVF] is set. To reset the count back to
+ *	zero, write one to clear CPT()_VQ()_MISC_INT_ENA_W1C[DBELL_DOVF],
+ *	then write a value of 2^20 minus the read [DBELL_CNT], then write one
+ *	to CPT()_VQ()_MISC_INT_W1C[DBELL_DOVF] and
+ *	CPT()_VQ()_MISC_INT_ENA_W1S[DBELL_DOVF]. Must be a multiple of 8.
+ *	All CPT instructions are 8 words and require a doorbell count of
+ *	multiple of 8.
+ */
+union otx_cptx_vqx_doorbell {
+	u64 u;
+	struct otx_cptx_vqx_doorbell_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_20_63:44;
+		u64 dbell_cnt:20;
+#else /* Word 0 - Little Endian */
+		u64 dbell_cnt:20;
+		u64 reserved_20_63:44;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_inprog
+ *
+ * CPT Queue In Progress Count Registers
+ * These registers contain the per-queue instruction in flight registers.
+ * otx_cptx_vqx_inprog_s
+ * Word0
+ *  reserved_8_63:56 [63:8] Reserved.
+ *  inflight:8 [7:0](RO/H) Inflight count. Counts the number of instructions
+ *	for the VF for which CPT is fetching, executing or responding to
+ *	instructions. However this does not include any interrupts that are
+ *	awaiting software handling (CPT()_VQ()_DONE[DONE] != 0x0).
+ *	A queue may not be reconfigured until:
+ *	1. CPT()_VQ()_CTL[ENA] is cleared by software.
+ *	2. [INFLIGHT] is polled until equals to zero.
+ */
+union otx_cptx_vqx_inprog {
+	u64 u;
+	struct otx_cptx_vqx_inprog_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_8_63:56;
+		u64 inflight:8;
+#else /* Word 0 - Little Endian */
+		u64 inflight:8;
+		u64 reserved_8_63:56;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_misc_int
+ *
+ * CPT Queue Misc Interrupt Register
+ * These registers contain the per-queue miscellaneous interrupts.
+ * otx_cptx_vqx_misc_int_s
+ * Word 0
+ *  reserved_5_63:59 [63:5] Reserved.
+ *  swerr:1 [4:4](R/W1C/H) Software error from engines.
+ *  nwrp:1  [3:3](R/W1C/H) NCB result write response error.
+ *  irde:1  [2:2](R/W1C/H) Instruction NCB read response error.
+ *  dovf:1 [1:1](R/W1C/H) Doorbell overflow.
+ *  mbox:1 [0:0](R/W1C/H) PF to VF mailbox interrupt. Set when
+ *	CPT()_VF()_PF_MBOX(0) is written.
+ *
+ */
+union otx_cptx_vqx_misc_int {
+	u64 u;
+	struct otx_cptx_vqx_misc_int_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_5_63:59;
+		u64 swerr:1;
+		u64 nwrp:1;
+		u64 irde:1;
+		u64 dovf:1;
+		u64 mbox:1;
+#else /* Word 0 - Little Endian */
+		u64 mbox:1;
+		u64 dovf:1;
+		u64 irde:1;
+		u64 nwrp:1;
+		u64 swerr:1;
+		u64 reserved_5_63:59;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_done_ack
+ *
+ * CPT Queue Done Count Ack Registers
+ * This register is written by software to acknowledge interrupts.
+ * otx_cptx_vqx_done_ack_s
+ * Word0
+ *  reserved_20_63:44 [63:20] Reserved.
+ *  done_ack:20 [19:0](R/W/H) Number of decrements to CPT()_VQ()_DONE[DONE].
+ *	Reads CPT()_VQ()_DONE[DONE]. Written by software to acknowledge
+ *	interrupts. If CPT()_VQ()_DONE[DONE] is still nonzero the interrupt
+ *	will be re-sent if the conditions described in CPT()_VQ()_DONE[DONE]
+ *	are satisfied.
+ *
+ */
+union otx_cptx_vqx_done_ack {
+	u64 u;
+	struct otx_cptx_vqx_done_ack_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_20_63:44;
+		u64 done_ack:20;
+#else /* Word 0 - Little Endian */
+		u64 done_ack:20;
+		u64 reserved_20_63:44;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_done
+ *
+ * CPT Queue Done Count Registers
+ * These registers contain the per-queue instruction done count.
+ * cptx_vqx_done_s
+ * Word0
+ *  reserved_20_63:44 [63:20] Reserved.
+ *  done:20 [19:0](R/W/H) Done count. When CPT_INST_S[DONEINT] set and that
+ *	instruction completes, CPT()_VQ()_DONE[DONE] is incremented when the
+ *	instruction finishes. Write to this field are for diagnostic use only;
+ *	instead software writes CPT()_VQ()_DONE_ACK with the number of
+ *	decrements for this field.
+ *	Interrupts are sent as follows:
+ *	* When CPT()_VQ()_DONE[DONE] = 0, then no results are pending, the
+ *	interrupt coalescing timer is held to zero, and an interrupt is not
+ *	sent.
+ *	* When CPT()_VQ()_DONE[DONE] != 0, then the interrupt coalescing timer
+ *	counts. If the counter is >= CPT()_VQ()_DONE_WAIT[TIME_WAIT]*1024, or
+ *	CPT()_VQ()_DONE[DONE] >= CPT()_VQ()_DONE_WAIT[NUM_WAIT], i.e. enough
+ *	time has passed or enough results have arrived, then the interrupt is
+ *	sent.
+ *	* When CPT()_VQ()_DONE_ACK is written (or CPT()_VQ()_DONE is written
+ *	but this is not typical), the interrupt coalescing timer restarts.
+ *	Note after decrementing this interrupt equation is recomputed,
+ *	for example if CPT()_VQ()_DONE[DONE] >= CPT()_VQ()_DONE_WAIT[NUM_WAIT]
+ *	and because the timer is zero, the interrupt will be resent immediately.
+ *	(This covers the race case between software acknowledging an interrupt
+ *	and a result returning.)
+ *	* When CPT()_VQ()_DONE_ENA_W1S[DONE] = 0, interrupts are not sent,
+ *	but the counting described above still occurs.
+ *	Since CPT instructions complete out-of-order, if software is using
+ *	completion interrupts the suggested scheme is to request a DONEINT on
+ *	each request, and when an interrupt arrives perform a "greedy" scan for
+ *	completions; even if a later command is acknowledged first this will
+ *	not result in missing a completion.
+ *	Software is responsible for making sure [DONE] does not overflow;
+ *	for example by insuring there are not more than 2^20-1 instructions in
+ *	flight that may request interrupts.
+ *
+ */
+union otx_cptx_vqx_done {
+	u64 u;
+	struct otx_cptx_vqx_done_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_20_63:44;
+		u64 done:20;
+#else /* Word 0 - Little Endian */
+		u64 done:20;
+		u64 reserved_20_63:44;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_done_wait
+ *
+ * CPT Queue Done Interrupt Coalescing Wait Registers
+ * Specifies the per queue interrupt coalescing settings.
+ * cptx_vqx_done_wait_s
+ * Word0
+ *  reserved_48_63:16 [63:48] Reserved.
+ *  time_wait:16; [47:32](R/W) Time hold-off. When CPT()_VQ()_DONE[DONE] = 0
+ *	or CPT()_VQ()_DONE_ACK is written a timer is cleared. When the timer
+ *	reaches [TIME_WAIT]*1024 then interrupt coalescing ends.
+ *	see CPT()_VQ()_DONE[DONE]. If 0x0, time coalescing is disabled.
+ *  reserved_20_31:12 [31:20] Reserved.
+ *  num_wait:20 [19:0](R/W) Number of messages hold-off.
+ *	When CPT()_VQ()_DONE[DONE] >= [NUM_WAIT] then interrupt coalescing ends
+ *	see CPT()_VQ()_DONE[DONE]. If 0x0, same behavior as 0x1.
+ *
+ */
+union otx_cptx_vqx_done_wait {
+	u64 u;
+	struct otx_cptx_vqx_done_wait_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_48_63:16;
+		u64 time_wait:16;
+		u64 reserved_20_31:12;
+		u64 num_wait:20;
+#else /* Word 0 - Little Endian */
+		u64 num_wait:20;
+		u64 reserved_20_31:12;
+		u64 time_wait:16;
+		u64 reserved_48_63:16;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_done_ena_w1s
+ *
+ * CPT Queue Done Interrupt Enable Set Registers
+ * Write 1 to these registers will enable the DONEINT interrupt for the queue.
+ * cptx_vqx_done_ena_w1s_s
+ * Word0
+ *  reserved_1_63:63 [63:1] Reserved.
+ *  done:1 [0:0](R/W1S/H) Write 1 will enable DONEINT for this queue.
+ *	Write 0 has no effect. Read will return the enable bit.
+ */
+union otx_cptx_vqx_done_ena_w1s {
+	u64 u;
+	struct otx_cptx_vqx_done_ena_w1s_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_1_63:63;
+		u64 done:1;
+#else /* Word 0 - Little Endian */
+		u64 done:1;
+		u64 reserved_1_63:63;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Register (NCB) otx_cpt#_vq#_ctl
+ *
+ * CPT VF Queue Control Registers
+ * This register configures queues. This register should be changed (other than
+ * clearing [ENA]) only when quiescent (see CPT()_VQ()_INPROG[INFLIGHT]).
+ * cptx_vqx_ctl_s
+ * Word0
+ *  reserved_1_63:63 [63:1] Reserved.
+ *  ena:1 [0:0](R/W/H) Enables the logical instruction queue.
+ *	See also CPT()_PF_Q()_CTL[CONT_ERR] and	CPT()_VQ()_INPROG[INFLIGHT].
+ *	1 = Queue is enabled.
+ *	0 = Queue is disabled.
+ */
+union otx_cptx_vqx_ctl {
+	u64 u;
+	struct otx_cptx_vqx_ctl_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		u64 reserved_1_63:63;
+		u64 ena:1;
+#else /* Word 0 - Little Endian */
+		u64 ena:1;
+		u64 reserved_1_63:63;
+#endif /* Word 0 - End */
+	} s;
+};
+
+/*
+ * Error Address/Error Codes
+ *
+ * In the event of a severe error, microcode writes an 8-byte Error Code
+ * value (ECODE) to host memory at the Rptr address specified by the host
+ * system (in the 64-byte request).
+ *
+ * Word0
+ *  [63:56](R) 8-bit completion code
+ *  [55:48](R) Number of the core that reported the severe error
+ *  [47:0] Lower 6 bytes of M-Inst word2. Used to assist in uniquely
+ *  identifying which specific instruction caused the error. This assumes
+ *  that each instruction has a unique result location (RPTR), at least
+ *  for a given period of time.
+ */
+union otx_cpt_error_code {
+	u64 u;
+	struct otx_cpt_error_code_s {
+#if defined(__BIG_ENDIAN_BITFIELD) /* Word 0 - Big Endian */
+		uint64_t ccode:8;
+		uint64_t coreid:8;
+		uint64_t rptr6:48;
+#else /* Word 0 - Little Endian */
+		uint64_t rptr6:48;
+		uint64_t coreid:8;
+		uint64_t ccode:8;
+#endif /* Word 0 - End */
+	} s;
+};
+
+#endif /*__OTX_CPT_HW_TYPES_H */
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf.h b/drivers/crypto/marvell/octeontx/otx_cptvf.h
new file mode 100644
index 0000000..dd02f21
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf.h
@@ -0,0 +1,104 @@
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
+#ifndef __OTX_CPTVF_H
+#define __OTX_CPTVF_H
+
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include "otx_cpt_common.h"
+#include "otx_cptvf_reqmgr.h"
+
+/* Flags to indicate the features supported */
+#define OTX_CPT_FLAG_DEVICE_READY  BIT(1)
+#define otx_cpt_device_ready(cpt)  ((cpt)->flags & OTX_CPT_FLAG_DEVICE_READY)
+/* Default command queue length */
+#define OTX_CPT_CMD_QLEN	(4*2046)
+#define OTX_CPT_CMD_QCHUNK_SIZE	1023
+#define OTX_CPT_NUM_QS_PER_VF	1
+
+struct otx_cpt_cmd_chunk {
+	u8 *head;
+	dma_addr_t dma_addr;
+	u32 size; /* Chunk size, max OTX_CPT_INST_CHUNK_MAX_SIZE */
+	struct list_head nextchunk;
+};
+
+struct otx_cpt_cmd_queue {
+	u32 idx;	/* Command queue host write idx */
+	u32 num_chunks;	/* Number of command chunks */
+	struct otx_cpt_cmd_chunk *qhead;/*
+					 * Command queue head, instructions
+					 * are inserted here
+					 */
+	struct otx_cpt_cmd_chunk *base;
+	struct list_head chead;
+};
+
+struct otx_cpt_cmd_qinfo {
+	u32 qchunksize; /* Command queue chunk size */
+	struct otx_cpt_cmd_queue queue[OTX_CPT_NUM_QS_PER_VF];
+};
+
+struct otx_cpt_pending_qinfo {
+	u32 num_queues;	/* Number of queues supported */
+	struct otx_cpt_pending_queue queue[OTX_CPT_NUM_QS_PER_VF];
+};
+
+#define for_each_pending_queue(qinfo, q, i)	\
+		for (i = 0, q = &qinfo->queue[i]; i < qinfo->num_queues; i++, \
+		     q = &qinfo->queue[i])
+
+struct otx_cptvf_wqe {
+	struct tasklet_struct twork;
+	struct otx_cptvf *cptvf;
+};
+
+struct otx_cptvf_wqe_info {
+	struct otx_cptvf_wqe vq_wqe[OTX_CPT_NUM_QS_PER_VF];
+};
+
+struct otx_cptvf {
+	u16 flags;	/* Flags to hold device status bits */
+	u8 vfid;	/* Device Index 0...OTX_CPT_MAX_VF_NUM */
+	u8 num_vfs;	/* Number of enabled VFs */
+	u8 vftype;	/* VF type of SE_TYPE(2) or AE_TYPE(1) */
+	u8 vfgrp;	/* VF group (0 - 8) */
+	u8 node;	/* Operating node: Bits (46:44) in BAR0 address */
+	u8 priority;	/*
+			 * VF priority ring: 1-High proirity round
+			 * robin ring;0-Low priority round robin ring;
+			 */
+	struct pci_dev *pdev;	/* Pci device handle */
+	void __iomem *reg_base;	/* Register start address */
+	void *wqe_info;		/* BH worker info */
+	/* MSI-X */
+	cpumask_var_t affinity_mask[OTX_CPT_VF_MSIX_VECTORS];
+	/* Command and Pending queues */
+	u32 qsize;
+	u32 num_queues;
+	struct otx_cpt_cmd_qinfo cqinfo; /* Command queue information */
+	struct otx_cpt_pending_qinfo pqinfo; /* Pending queue information */
+	/* VF-PF mailbox communication */
+	bool pf_acked;
+	bool pf_nacked;
+};
+
+int otx_cptvf_send_vf_up(struct otx_cptvf *cptvf);
+int otx_cptvf_send_vf_down(struct otx_cptvf *cptvf);
+int otx_cptvf_send_vf_to_grp_msg(struct otx_cptvf *cptvf, int group);
+int otx_cptvf_send_vf_priority_msg(struct otx_cptvf *cptvf);
+int otx_cptvf_send_vq_size_msg(struct otx_cptvf *cptvf);
+int otx_cptvf_check_pf_ready(struct otx_cptvf *cptvf);
+void otx_cptvf_handle_mbox_intr(struct otx_cptvf *cptvf);
+void otx_cptvf_write_vq_doorbell(struct otx_cptvf *cptvf, u32 val);
+
+#endif /* __OTX_CPTVF_H */
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
new file mode 100644
index 0000000..946fb62
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -0,0 +1,1744 @@
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
+#include <crypto/aes.h>
+#include <crypto/authenc.h>
+#include <crypto/cryptd.h>
+#include <crypto/des.h>
+#include <crypto/internal/aead.h>
+#include <crypto/sha.h>
+#include <crypto/xts.h>
+#include <crypto/scatterwalk.h>
+#include <linux/rtnetlink.h>
+#include <linux/sort.h>
+#include <linux/module.h>
+#include "otx_cptvf.h"
+#include "otx_cptvf_algs.h"
+#include "otx_cptvf_reqmgr.h"
+
+#define CPT_MAX_VF_NUM	64
+/* Size of salt in AES GCM mode */
+#define AES_GCM_SALT_SIZE	4
+/* Size of IV in AES GCM mode */
+#define AES_GCM_IV_SIZE		8
+/* Size of ICV (Integrity Check Value) in AES GCM mode */
+#define AES_GCM_ICV_SIZE	16
+/* Offset of IV in AES GCM mode */
+#define AES_GCM_IV_OFFSET	8
+#define CONTROL_WORD_LEN	8
+#define KEY2_OFFSET		48
+#define DMA_MODE_FLAG(dma_mode) \
+	(((dma_mode) == OTX_CPT_DMA_GATHER_SCATTER) ? (1 << 7) : 0)
+
+/* Truncated SHA digest size */
+#define SHA1_TRUNC_DIGEST_SIZE		12
+#define SHA256_TRUNC_DIGEST_SIZE	16
+#define SHA384_TRUNC_DIGEST_SIZE	24
+#define SHA512_TRUNC_DIGEST_SIZE	32
+
+static DEFINE_MUTEX(mutex);
+static int is_crypto_registered;
+
+struct cpt_device_desc {
+	enum otx_cptpf_type pf_type;
+	struct pci_dev *dev;
+	int num_queues;
+};
+
+struct cpt_device_table {
+	atomic_t count;
+	struct cpt_device_desc desc[CPT_MAX_VF_NUM];
+};
+
+static struct cpt_device_table se_devices = {
+	.count = ATOMIC_INIT(0)
+};
+
+static struct cpt_device_table ae_devices = {
+	.count = ATOMIC_INIT(0)
+};
+
+static inline int get_se_device(struct pci_dev **pdev, int *cpu_num)
+{
+	int count, ret = 0;
+
+	count = atomic_read(&se_devices.count);
+	if (count < 1)
+		return -ENODEV;
+
+	*cpu_num = get_cpu();
+
+	if (se_devices.desc[0].pf_type == OTX_CPT_SE) {
+		/*
+		 * On OcteonTX platform there is one CPT instruction queue bound
+		 * to each VF. We get maximum performance if one CPT queue
+		 * is available for each cpu otherwise CPT queues need to be
+		 * shared between cpus.
+		 */
+		if (*cpu_num >= count)
+			*cpu_num %= count;
+		*pdev = se_devices.desc[*cpu_num].dev;
+	} else {
+		pr_err("Unknown PF type %d\n", se_devices.desc[0].pf_type);
+		ret = -EINVAL;
+	}
+	put_cpu();
+
+	return ret;
+}
+
+static inline int validate_hmac_cipher_null(struct otx_cpt_req_info *cpt_req)
+{
+	struct otx_cpt_req_ctx *rctx;
+	struct aead_request *req;
+	struct crypto_aead *tfm;
+
+	req = container_of(cpt_req->areq, struct aead_request, base);
+	tfm = crypto_aead_reqtfm(req);
+	rctx = aead_request_ctx(req);
+	if (memcmp(rctx->fctx.hmac.s.hmac_calc,
+		   rctx->fctx.hmac.s.hmac_recv,
+		   crypto_aead_authsize(tfm)) != 0)
+		return -EBADMSG;
+
+	return 0;
+}
+
+static void otx_cpt_aead_callback(int status, void *arg1, void *arg2)
+{
+	struct otx_cpt_info_buffer *cpt_info = arg2;
+	struct crypto_async_request *areq = arg1;
+	struct otx_cpt_req_info *cpt_req;
+	struct pci_dev *pdev;
+
+	cpt_req = cpt_info->req;
+	if (!status) {
+		/*
+		 * When selected cipher is NULL we need to manually
+		 * verify whether calculated hmac value matches
+		 * received hmac value
+		 */
+		if (cpt_req->req_type == OTX_CPT_AEAD_ENC_DEC_NULL_REQ &&
+		    !cpt_req->is_enc)
+			status = validate_hmac_cipher_null(cpt_req);
+	}
+	if (cpt_info) {
+		pdev = cpt_info->pdev;
+		do_request_cleanup(pdev, cpt_info);
+	}
+	if (areq)
+		areq->complete(areq, status);
+}
+
+static void output_iv_copyback(struct crypto_async_request *areq)
+{
+	struct otx_cpt_req_info *req_info;
+	struct skcipher_request *sreq;
+	struct crypto_skcipher *stfm;
+	struct otx_cpt_req_ctx *rctx;
+	struct otx_cpt_enc_ctx *ctx;
+	u32 start, ivsize;
+
+	sreq = container_of(areq, struct skcipher_request, base);
+	stfm = crypto_skcipher_reqtfm(sreq);
+	ctx = crypto_skcipher_ctx(stfm);
+	if (ctx->cipher_type == OTX_CPT_AES_CBC ||
+	    ctx->cipher_type == OTX_CPT_DES3_CBC) {
+		rctx = skcipher_request_ctx(sreq);
+		req_info = &rctx->cpt_req;
+		ivsize = crypto_skcipher_ivsize(stfm);
+		start = sreq->cryptlen - ivsize;
+
+		if (req_info->is_enc) {
+			scatterwalk_map_and_copy(sreq->iv, sreq->dst, start,
+						 ivsize, 0);
+		} else {
+			if (sreq->src != sreq->dst) {
+				scatterwalk_map_and_copy(sreq->iv, sreq->src,
+							 start, ivsize, 0);
+			} else {
+				memcpy(sreq->iv, req_info->iv_out, ivsize);
+				kfree(req_info->iv_out);
+			}
+		}
+	}
+}
+
+static void otx_cpt_skcipher_callback(int status, void *arg1, void *arg2)
+{
+	struct otx_cpt_info_buffer *cpt_info = arg2;
+	struct crypto_async_request *areq = arg1;
+	struct pci_dev *pdev;
+
+	if (areq) {
+		if (!status)
+			output_iv_copyback(areq);
+		if (cpt_info) {
+			pdev = cpt_info->pdev;
+			do_request_cleanup(pdev, cpt_info);
+		}
+		areq->complete(areq, status);
+	}
+}
+
+static inline void update_input_data(struct otx_cpt_req_info *req_info,
+				     struct scatterlist *inp_sg,
+				     u32 nbytes, u32 *argcnt)
+{
+	req_info->req.dlen += nbytes;
+
+	while (nbytes) {
+		u32 len = min(nbytes, inp_sg->length);
+		u8 *ptr = sg_virt(inp_sg);
+
+		req_info->in[*argcnt].vptr = (void *)ptr;
+		req_info->in[*argcnt].size = len;
+		nbytes -= len;
+		++(*argcnt);
+		inp_sg = sg_next(inp_sg);
+	}
+}
+
+static inline void update_output_data(struct otx_cpt_req_info *req_info,
+				      struct scatterlist *outp_sg,
+				      u32 offset, u32 nbytes, u32 *argcnt)
+{
+	req_info->rlen += nbytes;
+
+	while (nbytes) {
+		u32 len = min(nbytes, outp_sg->length - offset);
+		u8 *ptr = sg_virt(outp_sg);
+
+		req_info->out[*argcnt].vptr = (void *) (ptr + offset);
+		req_info->out[*argcnt].size = len;
+		nbytes -= len;
+		++(*argcnt);
+		offset = 0;
+		outp_sg = sg_next(outp_sg);
+	}
+}
+
+static inline u32 create_ctx_hdr(struct skcipher_request *req, u32 enc,
+				 u32 *argcnt)
+{
+	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	struct crypto_tfm *tfm = crypto_skcipher_tfm(stfm);
+	struct otx_cpt_enc_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct otx_cpt_fc_ctx *fctx = &rctx->fctx;
+	int ivsize = crypto_skcipher_ivsize(stfm);
+	u32 start = req->cryptlen - ivsize;
+	u64 *ctrl_flags = NULL;
+	gfp_t flags;
+
+	flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
+			GFP_KERNEL : GFP_ATOMIC;
+	req_info->ctrl.s.dma_mode = OTX_CPT_DMA_GATHER_SCATTER;
+	req_info->ctrl.s.se_req = OTX_CPT_SE_CORE_REQ;
+
+	req_info->req.opcode.s.major = OTX_CPT_MAJOR_OP_FC |
+				DMA_MODE_FLAG(OTX_CPT_DMA_GATHER_SCATTER);
+	if (enc) {
+		req_info->req.opcode.s.minor = 2;
+	} else {
+		req_info->req.opcode.s.minor = 3;
+		if ((ctx->cipher_type == OTX_CPT_AES_CBC ||
+		    ctx->cipher_type == OTX_CPT_DES3_CBC) &&
+		    req->src == req->dst) {
+			req_info->iv_out = kmalloc(ivsize, flags);
+			if (!req_info->iv_out)
+				return -ENOMEM;
+
+			scatterwalk_map_and_copy(req_info->iv_out, req->src,
+						 start, ivsize, 0);
+		}
+	}
+	/* Encryption data length */
+	req_info->req.param1 = req->cryptlen;
+	/* Authentication data length */
+	req_info->req.param2 = 0;
+
+	fctx->enc.enc_ctrl.e.enc_cipher = ctx->cipher_type;
+	fctx->enc.enc_ctrl.e.aes_key = ctx->key_type;
+	fctx->enc.enc_ctrl.e.iv_source = OTX_CPT_FROM_CPTR;
+
+	if (ctx->cipher_type == OTX_CPT_AES_XTS)
+		memcpy(fctx->enc.encr_key, ctx->enc_key, ctx->key_len * 2);
+	else
+		memcpy(fctx->enc.encr_key, ctx->enc_key, ctx->key_len);
+
+	memcpy(fctx->enc.encr_iv, req->iv, crypto_skcipher_ivsize(stfm));
+
+	ctrl_flags = (u64 *)&fctx->enc.enc_ctrl.flags;
+	*ctrl_flags = cpu_to_be64(*ctrl_flags);
+
+	/*
+	 * Storing  Packet Data Information in offset
+	 * Control Word First 8 bytes
+	 */
+	req_info->in[*argcnt].vptr = (u8 *)&rctx->ctrl_word;
+	req_info->in[*argcnt].size = CONTROL_WORD_LEN;
+	req_info->req.dlen += CONTROL_WORD_LEN;
+	++(*argcnt);
+
+	req_info->in[*argcnt].vptr = (u8 *)fctx;
+	req_info->in[*argcnt].size = sizeof(struct otx_cpt_fc_ctx);
+	req_info->req.dlen += sizeof(struct otx_cpt_fc_ctx);
+
+	++(*argcnt);
+
+	return 0;
+}
+
+static inline u32 create_input_list(struct skcipher_request *req, u32 enc,
+				    u32 enc_iv_len)
+{
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	u32 argcnt =  0;
+	int ret;
+
+	ret = create_ctx_hdr(req, enc, &argcnt);
+	if (ret)
+		return ret;
+
+	update_input_data(req_info, req->src, req->cryptlen, &argcnt);
+	req_info->incnt = argcnt;
+
+	return 0;
+}
+
+static inline void create_output_list(struct skcipher_request *req,
+				      u32 enc_iv_len)
+{
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	u32 argcnt = 0;
+
+	/*
+	 * OUTPUT Buffer Processing
+	 * AES encryption/decryption output would be
+	 * received in the following format
+	 *
+	 * ------IV--------|------ENCRYPTED/DECRYPTED DATA-----|
+	 * [ 16 Bytes/     [   Request Enc/Dec/ DATA Len AES CBC ]
+	 */
+	update_output_data(req_info, req->dst, 0, req->cryptlen, &argcnt);
+	req_info->outcnt = argcnt;
+}
+
+static inline int cpt_enc_dec(struct skcipher_request *req, u32 enc)
+{
+	struct crypto_skcipher *stfm = crypto_skcipher_reqtfm(req);
+	struct otx_cpt_req_ctx *rctx = skcipher_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	u32 enc_iv_len = crypto_skcipher_ivsize(stfm);
+	struct pci_dev *pdev;
+	int status, cpu_num;
+
+	/* Validate that request doesn't exceed maximum CPT supported size */
+	if (req->cryptlen > OTX_CPT_MAX_REQ_SIZE)
+		return -E2BIG;
+
+	/* Clear control words */
+	rctx->ctrl_word.flags = 0;
+	rctx->fctx.enc.enc_ctrl.flags = 0;
+
+	status = create_input_list(req, enc, enc_iv_len);
+	if (status)
+		return status;
+	create_output_list(req, enc_iv_len);
+
+	status = get_se_device(&pdev, &cpu_num);
+	if (status)
+		return status;
+
+	req_info->callback = (void *)otx_cpt_skcipher_callback;
+	req_info->areq = &req->base;
+	req_info->req_type = OTX_CPT_ENC_DEC_REQ;
+	req_info->is_enc = enc;
+	req_info->is_trunc_hmac = false;
+	req_info->ctrl.s.grp = 0;
+
+	/*
+	 * We perform an asynchronous send and once
+	 * the request is completed the driver would
+	 * intimate through registered call back functions
+	 */
+	status = otx_cpt_do_request(pdev, req_info, cpu_num);
+
+	return status;
+}
+
+static int otx_cpt_skcipher_encrypt(struct skcipher_request *req)
+{
+	return cpt_enc_dec(req, true);
+}
+
+static int otx_cpt_skcipher_decrypt(struct skcipher_request *req)
+{
+	return cpt_enc_dec(req, false);
+}
+
+static int otx_cpt_skcipher_xts_setkey(struct crypto_skcipher *tfm,
+				       const u8 *key, u32 keylen)
+{
+	struct otx_cpt_enc_ctx *ctx = crypto_skcipher_ctx(tfm);
+	const u8 *key2 = key + (keylen / 2);
+	const u8 *key1 = key;
+	int ret;
+
+	ret = xts_check_key(crypto_skcipher_tfm(tfm), key, keylen);
+	if (ret)
+		return ret;
+	ctx->key_len = keylen;
+	memcpy(ctx->enc_key, key1, keylen / 2);
+	memcpy(ctx->enc_key + KEY2_OFFSET, key2, keylen / 2);
+	ctx->cipher_type = OTX_CPT_AES_XTS;
+	switch (ctx->key_len) {
+	case 2 * AES_KEYSIZE_128:
+		ctx->key_type = OTX_CPT_AES_128_BIT;
+		break;
+	case 2 * AES_KEYSIZE_256:
+		ctx->key_type = OTX_CPT_AES_256_BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpt_des_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			  u32 keylen, u8 cipher_type)
+{
+	struct otx_cpt_enc_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	if (keylen != DES3_EDE_KEY_SIZE)
+		return -EINVAL;
+
+	ctx->key_len = keylen;
+	ctx->cipher_type = cipher_type;
+
+	memcpy(ctx->enc_key, key, keylen);
+
+	return 0;
+}
+
+static int cpt_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			  u32 keylen, u8 cipher_type)
+{
+	struct otx_cpt_enc_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	switch (keylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX_CPT_AES_256_BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ctx->key_len = keylen;
+	ctx->cipher_type = cipher_type;
+
+	memcpy(ctx->enc_key, key, keylen);
+
+	return 0;
+}
+
+static int otx_cpt_skcipher_cbc_aes_setkey(struct crypto_skcipher *tfm,
+					   const u8 *key, u32 keylen)
+{
+	return cpt_aes_setkey(tfm, key, keylen, OTX_CPT_AES_CBC);
+}
+
+static int otx_cpt_skcipher_ecb_aes_setkey(struct crypto_skcipher *tfm,
+					   const u8 *key, u32 keylen)
+{
+	return cpt_aes_setkey(tfm, key, keylen, OTX_CPT_AES_ECB);
+}
+
+static int otx_cpt_skcipher_cfb_aes_setkey(struct crypto_skcipher *tfm,
+					   const u8 *key, u32 keylen)
+{
+	return cpt_aes_setkey(tfm, key, keylen, OTX_CPT_AES_CFB);
+}
+
+static int otx_cpt_skcipher_cbc_des3_setkey(struct crypto_skcipher *tfm,
+					    const u8 *key, u32 keylen)
+{
+	return cpt_des_setkey(tfm, key, keylen, OTX_CPT_DES3_CBC);
+}
+
+static int otx_cpt_skcipher_ecb_des3_setkey(struct crypto_skcipher *tfm,
+					    const u8 *key, u32 keylen)
+{
+	return cpt_des_setkey(tfm, key, keylen, OTX_CPT_DES3_ECB);
+}
+
+static int otx_cpt_enc_dec_init(struct crypto_skcipher *tfm)
+{
+	struct otx_cpt_enc_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	memset(ctx, 0, sizeof(*ctx));
+	/*
+	 * Additional memory for skcipher_request is
+	 * allocated since the cryptd daemon uses
+	 * this memory for request_ctx information
+	 */
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct otx_cpt_req_ctx) +
+					sizeof(struct skcipher_request));
+
+	return 0;
+}
+
+static int cpt_aead_init(struct crypto_aead *tfm, u8 cipher_type, u8 mac_type)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+
+	ctx->cipher_type = cipher_type;
+	ctx->mac_type = mac_type;
+
+	/*
+	 * When selected cipher is NULL we use HMAC opcode instead of
+	 * FLEXICRYPTO opcode therefore we don't need to use HASH algorithms
+	 * for calculating ipad and opad
+	 */
+	if (ctx->cipher_type != OTX_CPT_CIPHER_NULL) {
+		switch (ctx->mac_type) {
+		case OTX_CPT_SHA1:
+			ctx->hashalg = crypto_alloc_shash("sha1", 0,
+							  CRYPTO_ALG_ASYNC);
+			if (IS_ERR(ctx->hashalg))
+				return PTR_ERR(ctx->hashalg);
+			break;
+
+		case OTX_CPT_SHA256:
+			ctx->hashalg = crypto_alloc_shash("sha256", 0,
+							  CRYPTO_ALG_ASYNC);
+			if (IS_ERR(ctx->hashalg))
+				return PTR_ERR(ctx->hashalg);
+			break;
+
+		case OTX_CPT_SHA384:
+			ctx->hashalg = crypto_alloc_shash("sha384", 0,
+							  CRYPTO_ALG_ASYNC);
+			if (IS_ERR(ctx->hashalg))
+				return PTR_ERR(ctx->hashalg);
+			break;
+
+		case OTX_CPT_SHA512:
+			ctx->hashalg = crypto_alloc_shash("sha512", 0,
+							  CRYPTO_ALG_ASYNC);
+			if (IS_ERR(ctx->hashalg))
+				return PTR_ERR(ctx->hashalg);
+			break;
+		}
+	}
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct otx_cpt_req_ctx));
+
+	return 0;
+}
+
+static int otx_cpt_aead_cbc_aes_sha1_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_AES_CBC, OTX_CPT_SHA1);
+}
+
+static int otx_cpt_aead_cbc_aes_sha256_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_AES_CBC, OTX_CPT_SHA256);
+}
+
+static int otx_cpt_aead_cbc_aes_sha384_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_AES_CBC, OTX_CPT_SHA384);
+}
+
+static int otx_cpt_aead_cbc_aes_sha512_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_AES_CBC, OTX_CPT_SHA512);
+}
+
+static int otx_cpt_aead_ecb_null_sha1_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_CIPHER_NULL, OTX_CPT_SHA1);
+}
+
+static int otx_cpt_aead_ecb_null_sha256_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_CIPHER_NULL, OTX_CPT_SHA256);
+}
+
+static int otx_cpt_aead_ecb_null_sha384_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_CIPHER_NULL, OTX_CPT_SHA384);
+}
+
+static int otx_cpt_aead_ecb_null_sha512_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_CIPHER_NULL, OTX_CPT_SHA512);
+}
+
+static int otx_cpt_aead_gcm_aes_init(struct crypto_aead *tfm)
+{
+	return cpt_aead_init(tfm, OTX_CPT_AES_GCM, OTX_CPT_MAC_NULL);
+}
+
+static void otx_cpt_aead_exit(struct crypto_aead *tfm)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+
+	kfree(ctx->ipad);
+	kfree(ctx->opad);
+	if (ctx->hashalg)
+		crypto_free_shash(ctx->hashalg);
+	kfree(ctx->sdesc);
+}
+
+/*
+ * This is the Integrity Check Value validation (aka the authentication tag
+ * length)
+ */
+static int otx_cpt_aead_set_authsize(struct crypto_aead *tfm,
+				     unsigned int authsize)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+
+	switch (ctx->mac_type) {
+	case OTX_CPT_SHA1:
+		if (authsize != SHA1_DIGEST_SIZE &&
+		    authsize != SHA1_TRUNC_DIGEST_SIZE)
+			return -EINVAL;
+
+		if (authsize == SHA1_TRUNC_DIGEST_SIZE)
+			ctx->is_trunc_hmac = true;
+		break;
+
+	case OTX_CPT_SHA256:
+		if (authsize != SHA256_DIGEST_SIZE &&
+		    authsize != SHA256_TRUNC_DIGEST_SIZE)
+			return -EINVAL;
+
+		if (authsize == SHA256_TRUNC_DIGEST_SIZE)
+			ctx->is_trunc_hmac = true;
+		break;
+
+	case OTX_CPT_SHA384:
+		if (authsize != SHA384_DIGEST_SIZE &&
+		    authsize != SHA384_TRUNC_DIGEST_SIZE)
+			return -EINVAL;
+
+		if (authsize == SHA384_TRUNC_DIGEST_SIZE)
+			ctx->is_trunc_hmac = true;
+		break;
+
+	case OTX_CPT_SHA512:
+		if (authsize != SHA512_DIGEST_SIZE &&
+		    authsize != SHA512_TRUNC_DIGEST_SIZE)
+			return -EINVAL;
+
+		if (authsize == SHA512_TRUNC_DIGEST_SIZE)
+			ctx->is_trunc_hmac = true;
+		break;
+
+	case OTX_CPT_MAC_NULL:
+		if (ctx->cipher_type == OTX_CPT_AES_GCM) {
+			if (authsize != AES_GCM_ICV_SIZE)
+				return -EINVAL;
+		} else
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tfm->authsize = authsize;
+	return 0;
+}
+
+static struct otx_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg)
+{
+	struct otx_cpt_sdesc *sdesc;
+	int size;
+
+	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
+	sdesc = kmalloc(size, GFP_KERNEL);
+	if (!sdesc)
+		return NULL;
+
+	sdesc->shash.tfm = alg;
+
+	return sdesc;
+}
+
+static inline void swap_data32(void *buf, u32 len)
+{
+	u32 *store = (u32 *) buf;
+	int i = 0;
+
+	for (i = 0 ; i < len/sizeof(u32); i++, store++)
+		*store = cpu_to_be32(*store);
+}
+
+static inline void swap_data64(void *buf, u32 len)
+{
+	u64 *store = (u64 *) buf;
+	int i = 0;
+
+	for (i = 0 ; i < len/sizeof(u64); i++, store++)
+		*store = cpu_to_be64(*store);
+}
+
+static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
+{
+	struct sha512_state *sha512;
+	struct sha256_state *sha256;
+	struct sha1_state *sha1;
+
+	switch (mac_type) {
+	case OTX_CPT_SHA1:
+		sha1 = (struct sha1_state *) in_pad;
+		swap_data32(sha1->state, SHA1_DIGEST_SIZE);
+		memcpy(out_pad, &sha1->state, SHA1_DIGEST_SIZE);
+		break;
+
+	case OTX_CPT_SHA256:
+		sha256 = (struct sha256_state *) in_pad;
+		swap_data32(sha256->state, SHA256_DIGEST_SIZE);
+		memcpy(out_pad, &sha256->state, SHA256_DIGEST_SIZE);
+		break;
+
+	case OTX_CPT_SHA384:
+	case OTX_CPT_SHA512:
+		sha512 = (struct sha512_state *) in_pad;
+		swap_data64(sha512->state, SHA512_DIGEST_SIZE);
+		memcpy(out_pad, &sha512->state, SHA512_DIGEST_SIZE);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aead_hmac_init(struct crypto_aead *cipher)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	int state_size = crypto_shash_statesize(ctx->hashalg);
+	int ds = crypto_shash_digestsize(ctx->hashalg);
+	int bs = crypto_shash_blocksize(ctx->hashalg);
+	int authkeylen = ctx->auth_key_len;
+	u8 *ipad = NULL, *opad = NULL;
+	int ret = 0, icount = 0;
+
+	ctx->sdesc = alloc_sdesc(ctx->hashalg);
+	if (!ctx->sdesc)
+		return -ENOMEM;
+
+	ctx->ipad = kzalloc(bs, GFP_KERNEL);
+	if (!ctx->ipad) {
+		ret = -ENOMEM;
+		goto calc_fail;
+	}
+
+	ctx->opad = kzalloc(bs, GFP_KERNEL);
+	if (!ctx->opad) {
+		ret = -ENOMEM;
+		goto calc_fail;
+	}
+
+	ipad = kzalloc(state_size, GFP_KERNEL);
+	if (!ipad) {
+		ret = -ENOMEM;
+		goto calc_fail;
+	}
+
+	opad = kzalloc(state_size, GFP_KERNEL);
+	if (!opad) {
+		ret = -ENOMEM;
+		goto calc_fail;
+	}
+
+	if (authkeylen > bs) {
+		ret = crypto_shash_digest(&ctx->sdesc->shash, ctx->key,
+					  authkeylen, ipad);
+		if (ret)
+			goto calc_fail;
+
+		authkeylen = ds;
+	} else {
+		memcpy(ipad, ctx->key, authkeylen);
+	}
+
+	memset(ipad + authkeylen, 0, bs - authkeylen);
+	memcpy(opad, ipad, bs);
+
+	for (icount = 0; icount < bs; icount++) {
+		ipad[icount] ^= 0x36;
+		opad[icount] ^= 0x5c;
+	}
+
+	/*
+	 * Partial Hash calculated from the software
+	 * algorithm is retrieved for IPAD & OPAD
+	 */
+
+	/* IPAD Calculation */
+	crypto_shash_init(&ctx->sdesc->shash);
+	crypto_shash_update(&ctx->sdesc->shash, ipad, bs);
+	crypto_shash_export(&ctx->sdesc->shash, ipad);
+	ret = copy_pad(ctx->mac_type, ctx->ipad, ipad);
+	if (ret)
+		goto calc_fail;
+
+	/* OPAD Calculation */
+	crypto_shash_init(&ctx->sdesc->shash);
+	crypto_shash_update(&ctx->sdesc->shash, opad, bs);
+	crypto_shash_export(&ctx->sdesc->shash, opad);
+	ret = copy_pad(ctx->mac_type, ctx->opad, opad);
+	if (ret)
+		goto calc_fail;
+
+	kfree(ipad);
+	kfree(opad);
+
+	return 0;
+
+calc_fail:
+	kfree(ctx->ipad);
+	ctx->ipad = NULL;
+	kfree(ctx->opad);
+	ctx->opad = NULL;
+	kfree(ipad);
+	kfree(opad);
+	kfree(ctx->sdesc);
+	ctx->sdesc = NULL;
+
+	return ret;
+}
+
+static int otx_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
+					   const unsigned char *key,
+					   unsigned int keylen)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct crypto_authenc_key_param *param;
+	int enckeylen = 0, authkeylen = 0;
+	struct rtattr *rta = (void *)key;
+	int status = -EINVAL;
+
+	if (!RTA_OK(rta, keylen))
+		goto badkey;
+
+	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
+		goto badkey;
+
+	if (RTA_PAYLOAD(rta) < sizeof(*param))
+		goto badkey;
+
+	param = RTA_DATA(rta);
+	enckeylen = be32_to_cpu(param->enckeylen);
+	key += RTA_ALIGN(rta->rta_len);
+	keylen -= RTA_ALIGN(rta->rta_len);
+	if (keylen < enckeylen)
+		goto badkey;
+
+	if (keylen > OTX_CPT_MAX_KEY_SIZE)
+		goto badkey;
+
+	authkeylen = keylen - enckeylen;
+	memcpy(ctx->key, key, keylen);
+
+	switch (enckeylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX_CPT_AES_256_BIT;
+		break;
+	default:
+		/* Invalid key length */
+		goto badkey;
+	}
+
+	ctx->enc_key_len = enckeylen;
+	ctx->auth_key_len = authkeylen;
+
+	status = aead_hmac_init(cipher);
+	if (status)
+		goto badkey;
+
+	return 0;
+badkey:
+	return status;
+}
+
+static int otx_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
+					    const unsigned char *key,
+					    unsigned int keylen)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+	struct crypto_authenc_key_param *param;
+	struct rtattr *rta = (void *)key;
+	int enckeylen = 0;
+
+	if (!RTA_OK(rta, keylen))
+		goto badkey;
+
+	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
+		goto badkey;
+
+	if (RTA_PAYLOAD(rta) < sizeof(*param))
+		goto badkey;
+
+	param = RTA_DATA(rta);
+	enckeylen = be32_to_cpu(param->enckeylen);
+	key += RTA_ALIGN(rta->rta_len);
+	keylen -= RTA_ALIGN(rta->rta_len);
+	if (enckeylen != 0)
+		goto badkey;
+
+	if (keylen > OTX_CPT_MAX_KEY_SIZE)
+		goto badkey;
+
+	memcpy(ctx->key, key, keylen);
+	ctx->enc_key_len = enckeylen;
+	ctx->auth_key_len = keylen;
+	return 0;
+badkey:
+	return -EINVAL;
+}
+
+static int otx_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
+				       const unsigned char *key,
+				       unsigned int keylen)
+{
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(cipher);
+
+	/*
+	 * For aes gcm we expect to get encryption key (16, 24, 32 bytes)
+	 * and salt (4 bytes)
+	 */
+	switch (keylen) {
+	case AES_KEYSIZE_128 + AES_GCM_SALT_SIZE:
+		ctx->key_type = OTX_CPT_AES_128_BIT;
+		ctx->enc_key_len = AES_KEYSIZE_128;
+		break;
+	case AES_KEYSIZE_192 + AES_GCM_SALT_SIZE:
+		ctx->key_type = OTX_CPT_AES_192_BIT;
+		ctx->enc_key_len = AES_KEYSIZE_192;
+		break;
+	case AES_KEYSIZE_256 + AES_GCM_SALT_SIZE:
+		ctx->key_type = OTX_CPT_AES_256_BIT;
+		ctx->enc_key_len = AES_KEYSIZE_256;
+		break;
+	default:
+		/* Invalid key and salt length */
+		return -EINVAL;
+	}
+
+	/* Store encryption key and salt */
+	memcpy(ctx->key, key, keylen);
+
+	return 0;
+}
+
+static inline u32 create_aead_ctx_hdr(struct aead_request *req, u32 enc,
+				      u32 *argcnt)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	struct otx_cpt_fc_ctx *fctx = &rctx->fctx;
+	int mac_len = crypto_aead_authsize(tfm);
+	int ds;
+
+	rctx->ctrl_word.e.enc_data_offset = req->assoclen;
+
+	switch (ctx->cipher_type) {
+	case OTX_CPT_AES_CBC:
+		fctx->enc.enc_ctrl.e.iv_source = OTX_CPT_FROM_CPTR;
+		/* Copy encryption key to context */
+		memcpy(fctx->enc.encr_key, ctx->key + ctx->auth_key_len,
+		       ctx->enc_key_len);
+		/* Copy IV to context */
+		memcpy(fctx->enc.encr_iv, req->iv, crypto_aead_ivsize(tfm));
+
+		ds = crypto_shash_digestsize(ctx->hashalg);
+		if (ctx->mac_type == OTX_CPT_SHA384)
+			ds = SHA512_DIGEST_SIZE;
+		if (ctx->ipad)
+			memcpy(fctx->hmac.e.ipad, ctx->ipad, ds);
+		if (ctx->opad)
+			memcpy(fctx->hmac.e.opad, ctx->opad, ds);
+		break;
+
+	case OTX_CPT_AES_GCM:
+		fctx->enc.enc_ctrl.e.iv_source = OTX_CPT_FROM_DPTR;
+		/* Copy encryption key to context */
+		memcpy(fctx->enc.encr_key, ctx->key, ctx->enc_key_len);
+		/* Copy salt to context */
+		memcpy(fctx->enc.encr_iv, ctx->key + ctx->enc_key_len,
+		       AES_GCM_SALT_SIZE);
+
+		rctx->ctrl_word.e.iv_offset = req->assoclen - AES_GCM_IV_OFFSET;
+		break;
+
+	default:
+		/* Unknown cipher type */
+		return -EINVAL;
+	}
+	rctx->ctrl_word.flags = cpu_to_be64(rctx->ctrl_word.flags);
+
+	req_info->ctrl.s.dma_mode = OTX_CPT_DMA_GATHER_SCATTER;
+	req_info->ctrl.s.se_req = OTX_CPT_SE_CORE_REQ;
+	req_info->req.opcode.s.major = OTX_CPT_MAJOR_OP_FC |
+				 DMA_MODE_FLAG(OTX_CPT_DMA_GATHER_SCATTER);
+	if (enc) {
+		req_info->req.opcode.s.minor = 2;
+		req_info->req.param1 = req->cryptlen;
+		req_info->req.param2 = req->cryptlen + req->assoclen;
+	} else {
+		req_info->req.opcode.s.minor = 3;
+		req_info->req.param1 = req->cryptlen - mac_len;
+		req_info->req.param2 = req->cryptlen + req->assoclen - mac_len;
+	}
+
+	fctx->enc.enc_ctrl.e.enc_cipher = ctx->cipher_type;
+	fctx->enc.enc_ctrl.e.aes_key = ctx->key_type;
+	fctx->enc.enc_ctrl.e.mac_type = ctx->mac_type;
+	fctx->enc.enc_ctrl.e.mac_len = mac_len;
+	fctx->enc.enc_ctrl.flags = cpu_to_be64(fctx->enc.enc_ctrl.flags);
+
+	/*
+	 * Storing Packet Data Information in offset
+	 * Control Word First 8 bytes
+	 */
+	req_info->in[*argcnt].vptr = (u8 *)&rctx->ctrl_word;
+	req_info->in[*argcnt].size = CONTROL_WORD_LEN;
+	req_info->req.dlen += CONTROL_WORD_LEN;
+	++(*argcnt);
+
+	req_info->in[*argcnt].vptr = (u8 *)fctx;
+	req_info->in[*argcnt].size = sizeof(struct otx_cpt_fc_ctx);
+	req_info->req.dlen += sizeof(struct otx_cpt_fc_ctx);
+	++(*argcnt);
+
+	return 0;
+}
+
+static inline u32 create_hmac_ctx_hdr(struct aead_request *req, u32 *argcnt,
+				      u32 enc)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx(tfm);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+
+	req_info->ctrl.s.dma_mode = OTX_CPT_DMA_GATHER_SCATTER;
+	req_info->ctrl.s.se_req = OTX_CPT_SE_CORE_REQ;
+	req_info->req.opcode.s.major = OTX_CPT_MAJOR_OP_HMAC |
+				 DMA_MODE_FLAG(OTX_CPT_DMA_GATHER_SCATTER);
+	req_info->is_trunc_hmac = ctx->is_trunc_hmac;
+
+	req_info->req.opcode.s.minor = 0;
+	req_info->req.param1 = ctx->auth_key_len;
+	req_info->req.param2 = ctx->mac_type << 8;
+
+	/* Add authentication key */
+	req_info->in[*argcnt].vptr = ctx->key;
+	req_info->in[*argcnt].size = round_up(ctx->auth_key_len, 8);
+	req_info->req.dlen += round_up(ctx->auth_key_len, 8);
+	++(*argcnt);
+
+	return 0;
+}
+
+static inline u32 create_aead_input_list(struct aead_request *req, u32 enc)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	u32 inputlen =  req->cryptlen + req->assoclen;
+	u32 status, argcnt = 0;
+
+	status = create_aead_ctx_hdr(req, enc, &argcnt);
+	if (status)
+		return status;
+	update_input_data(req_info, req->src, inputlen, &argcnt);
+	req_info->incnt = argcnt;
+
+	return 0;
+}
+
+static inline u32 create_aead_output_list(struct aead_request *req, u32 enc,
+					  u32 mac_len)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_info *req_info =  &rctx->cpt_req;
+	u32 argcnt = 0, outputlen = 0;
+
+	if (enc)
+		outputlen = req->cryptlen +  req->assoclen + mac_len;
+	else
+		outputlen = req->cryptlen + req->assoclen - mac_len;
+
+	update_output_data(req_info, req->dst, 0, outputlen, &argcnt);
+	req_info->outcnt = argcnt;
+
+	return 0;
+}
+
+static inline u32 create_aead_null_input_list(struct aead_request *req,
+					      u32 enc, u32 mac_len)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	u32 inputlen, argcnt = 0;
+
+	if (enc)
+		inputlen =  req->cryptlen + req->assoclen;
+	else
+		inputlen =  req->cryptlen + req->assoclen - mac_len;
+
+	create_hmac_ctx_hdr(req, &argcnt, enc);
+	update_input_data(req_info, req->src, inputlen, &argcnt);
+	req_info->incnt = argcnt;
+
+	return 0;
+}
+
+static inline u32 create_aead_null_output_list(struct aead_request *req,
+					       u32 enc, u32 mac_len)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_info *req_info =  &rctx->cpt_req;
+	struct scatterlist *dst;
+	u8 *ptr = NULL;
+	int argcnt = 0, status, offset;
+	u32 inputlen;
+
+	if (enc)
+		inputlen =  req->cryptlen + req->assoclen;
+	else
+		inputlen =  req->cryptlen + req->assoclen - mac_len;
+
+	/*
+	 * If source and destination are different
+	 * then copy payload to destination
+	 */
+	if (req->src != req->dst) {
+
+		ptr = kmalloc(inputlen, (req_info->areq->flags &
+					 CRYPTO_TFM_REQ_MAY_SLEEP) ?
+					 GFP_KERNEL : GFP_ATOMIC);
+		if (!ptr) {
+			status = -ENOMEM;
+			goto error;
+		}
+
+		status = sg_copy_to_buffer(req->src, sg_nents(req->src), ptr,
+					   inputlen);
+		if (status != inputlen) {
+			status = -EINVAL;
+			goto error;
+		}
+		status = sg_copy_from_buffer(req->dst, sg_nents(req->dst), ptr,
+					     inputlen);
+		if (status != inputlen) {
+			status = -EINVAL;
+			goto error;
+		}
+		kfree(ptr);
+	}
+
+	if (enc) {
+		/*
+		 * In an encryption scenario hmac needs
+		 * to be appended after payload
+		 */
+		dst = req->dst;
+		offset = inputlen;
+		while (offset >= dst->length) {
+			offset -= dst->length;
+			dst = sg_next(dst);
+			if (!dst) {
+				status = -ENOENT;
+				goto error;
+			}
+		}
+
+		update_output_data(req_info, dst, offset, mac_len, &argcnt);
+	} else {
+		/*
+		 * In a decryption scenario calculated hmac for received
+		 * payload needs to be compare with hmac received
+		 */
+		status = sg_copy_buffer(req->src, sg_nents(req->src),
+					rctx->fctx.hmac.s.hmac_recv, mac_len,
+					inputlen, true);
+		if (status != mac_len) {
+			status = -EINVAL;
+			goto error;
+		}
+
+		req_info->out[argcnt].vptr = rctx->fctx.hmac.s.hmac_calc;
+		req_info->out[argcnt].size = mac_len;
+		argcnt++;
+	}
+
+	req_info->outcnt = argcnt;
+	return 0;
+error:
+	kfree(ptr);
+	return status;
+}
+
+static u32 cpt_aead_enc_dec(struct aead_request *req, u8 reg_type, u8 enc)
+{
+	struct otx_cpt_req_ctx *rctx = aead_request_ctx(req);
+	struct otx_cpt_req_info *req_info = &rctx->cpt_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct pci_dev *pdev;
+	u32 status, cpu_num;
+
+	/* Clear control words */
+	rctx->ctrl_word.flags = 0;
+	rctx->fctx.enc.enc_ctrl.flags = 0;
+
+	req_info->callback = otx_cpt_aead_callback;
+	req_info->areq = &req->base;
+	req_info->req_type = reg_type;
+	req_info->is_enc = enc;
+	req_info->is_trunc_hmac = false;
+
+	switch (reg_type) {
+	case OTX_CPT_AEAD_ENC_DEC_REQ:
+		status = create_aead_input_list(req, enc);
+		if (status)
+			return status;
+		status = create_aead_output_list(req, enc,
+						 crypto_aead_authsize(tfm));
+		if (status)
+			return status;
+		break;
+
+	case OTX_CPT_AEAD_ENC_DEC_NULL_REQ:
+		status = create_aead_null_input_list(req, enc,
+						     crypto_aead_authsize(tfm));
+		if (status)
+			return status;
+		status = create_aead_null_output_list(req, enc,
+						crypto_aead_authsize(tfm));
+		if (status)
+			return status;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Validate that request doesn't exceed maximum CPT supported size */
+	if (req_info->req.param1 > OTX_CPT_MAX_REQ_SIZE ||
+	    req_info->req.param2 > OTX_CPT_MAX_REQ_SIZE)
+		return -E2BIG;
+
+	status = get_se_device(&pdev, &cpu_num);
+	if (status)
+		return status;
+
+	req_info->ctrl.s.grp = 0;
+
+	status = otx_cpt_do_request(pdev, req_info, cpu_num);
+	/*
+	 * We perform an asynchronous send and once
+	 * the request is completed the driver would
+	 * intimate through registered call back functions
+	 */
+	return status;
+}
+
+static int otx_cpt_aead_encrypt(struct aead_request *req)
+{
+	return cpt_aead_enc_dec(req, OTX_CPT_AEAD_ENC_DEC_REQ, true);
+}
+
+static int otx_cpt_aead_decrypt(struct aead_request *req)
+{
+	return cpt_aead_enc_dec(req, OTX_CPT_AEAD_ENC_DEC_REQ, false);
+}
+
+static int otx_cpt_aead_null_encrypt(struct aead_request *req)
+{
+	return cpt_aead_enc_dec(req, OTX_CPT_AEAD_ENC_DEC_NULL_REQ, true);
+}
+
+static int otx_cpt_aead_null_decrypt(struct aead_request *req)
+{
+	return cpt_aead_enc_dec(req, OTX_CPT_AEAD_ENC_DEC_NULL_REQ, false);
+}
+
+static struct skcipher_alg otx_cpt_skciphers[] = { {
+	.base.cra_name = "xts(aes)",
+	.base.cra_driver_name = "cpt_xts_aes",
+	.base.cra_flags = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize = AES_BLOCK_SIZE,
+	.base.cra_ctxsize = sizeof(struct otx_cpt_enc_ctx),
+	.base.cra_alignmask = 7,
+	.base.cra_priority = 4001,
+	.base.cra_module = THIS_MODULE,
+
+	.init = otx_cpt_enc_dec_init,
+	.ivsize = AES_BLOCK_SIZE,
+	.min_keysize = 2 * AES_MIN_KEY_SIZE,
+	.max_keysize = 2 * AES_MAX_KEY_SIZE,
+	.setkey = otx_cpt_skcipher_xts_setkey,
+	.encrypt = otx_cpt_skcipher_encrypt,
+	.decrypt = otx_cpt_skcipher_decrypt,
+}, {
+	.base.cra_name = "cbc(aes)",
+	.base.cra_driver_name = "cpt_cbc_aes",
+	.base.cra_flags = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize = AES_BLOCK_SIZE,
+	.base.cra_ctxsize = sizeof(struct otx_cpt_enc_ctx),
+	.base.cra_alignmask = 7,
+	.base.cra_priority = 4001,
+	.base.cra_module = THIS_MODULE,
+
+	.init = otx_cpt_enc_dec_init,
+	.ivsize = AES_BLOCK_SIZE,
+	.min_keysize = AES_MIN_KEY_SIZE,
+	.max_keysize = AES_MAX_KEY_SIZE,
+	.setkey = otx_cpt_skcipher_cbc_aes_setkey,
+	.encrypt = otx_cpt_skcipher_encrypt,
+	.decrypt = otx_cpt_skcipher_decrypt,
+}, {
+	.base.cra_name = "ecb(aes)",
+	.base.cra_driver_name = "cpt_ecb_aes",
+	.base.cra_flags = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize = AES_BLOCK_SIZE,
+	.base.cra_ctxsize = sizeof(struct otx_cpt_enc_ctx),
+	.base.cra_alignmask = 7,
+	.base.cra_priority = 4001,
+	.base.cra_module = THIS_MODULE,
+
+	.init = otx_cpt_enc_dec_init,
+	.ivsize = 0,
+	.min_keysize = AES_MIN_KEY_SIZE,
+	.max_keysize = AES_MAX_KEY_SIZE,
+	.setkey = otx_cpt_skcipher_ecb_aes_setkey,
+	.encrypt = otx_cpt_skcipher_encrypt,
+	.decrypt = otx_cpt_skcipher_decrypt,
+}, {
+	.base.cra_name = "cfb(aes)",
+	.base.cra_driver_name = "cpt_cfb_aes",
+	.base.cra_flags = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize = AES_BLOCK_SIZE,
+	.base.cra_ctxsize = sizeof(struct otx_cpt_enc_ctx),
+	.base.cra_alignmask = 7,
+	.base.cra_priority = 4001,
+	.base.cra_module = THIS_MODULE,
+
+	.init = otx_cpt_enc_dec_init,
+	.ivsize = AES_BLOCK_SIZE,
+	.min_keysize = AES_MIN_KEY_SIZE,
+	.max_keysize = AES_MAX_KEY_SIZE,
+	.setkey = otx_cpt_skcipher_cfb_aes_setkey,
+	.encrypt = otx_cpt_skcipher_encrypt,
+	.decrypt = otx_cpt_skcipher_decrypt,
+}, {
+	.base.cra_name = "cbc(des3_ede)",
+	.base.cra_driver_name = "cpt_cbc_des3_ede",
+	.base.cra_flags = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+	.base.cra_ctxsize = sizeof(struct otx_cpt_des3_ctx),
+	.base.cra_alignmask = 7,
+	.base.cra_priority = 4001,
+	.base.cra_module = THIS_MODULE,
+
+	.init = otx_cpt_enc_dec_init,
+	.min_keysize = DES3_EDE_KEY_SIZE,
+	.max_keysize = DES3_EDE_KEY_SIZE,
+	.ivsize = DES_BLOCK_SIZE,
+	.setkey = otx_cpt_skcipher_cbc_des3_setkey,
+	.encrypt = otx_cpt_skcipher_encrypt,
+	.decrypt = otx_cpt_skcipher_decrypt,
+}, {
+	.base.cra_name = "ecb(des3_ede)",
+	.base.cra_driver_name = "cpt_ecb_des3_ede",
+	.base.cra_flags = CRYPTO_ALG_ASYNC,
+	.base.cra_blocksize = DES3_EDE_BLOCK_SIZE,
+	.base.cra_ctxsize = sizeof(struct otx_cpt_des3_ctx),
+	.base.cra_alignmask = 7,
+	.base.cra_priority = 4001,
+	.base.cra_module = THIS_MODULE,
+
+	.init = otx_cpt_enc_dec_init,
+	.min_keysize = DES3_EDE_KEY_SIZE,
+	.max_keysize = DES3_EDE_KEY_SIZE,
+	.ivsize = 0,
+	.setkey = otx_cpt_skcipher_ecb_des3_setkey,
+	.encrypt = otx_cpt_skcipher_encrypt,
+	.decrypt = otx_cpt_skcipher_decrypt,
+} };
+
+static struct aead_alg otx_cpt_aeads[] = { {
+	.base = {
+		.cra_name = "authenc(hmac(sha1),cbc(aes))",
+		.cra_driver_name = "cpt_hmac_sha1_cbc_aes",
+		.cra_blocksize = AES_BLOCK_SIZE,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_cbc_aes_sha1_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_cbc_aes_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_encrypt,
+	.decrypt = otx_cpt_aead_decrypt,
+	.ivsize = AES_BLOCK_SIZE,
+	.maxauthsize = SHA1_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha256),cbc(aes))",
+		.cra_driver_name = "cpt_hmac_sha256_cbc_aes",
+		.cra_blocksize = AES_BLOCK_SIZE,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_cbc_aes_sha256_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_cbc_aes_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_encrypt,
+	.decrypt = otx_cpt_aead_decrypt,
+	.ivsize = AES_BLOCK_SIZE,
+	.maxauthsize = SHA256_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha384),cbc(aes))",
+		.cra_driver_name = "cpt_hmac_sha384_cbc_aes",
+		.cra_blocksize = AES_BLOCK_SIZE,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_cbc_aes_sha384_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_cbc_aes_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_encrypt,
+	.decrypt = otx_cpt_aead_decrypt,
+	.ivsize = AES_BLOCK_SIZE,
+	.maxauthsize = SHA384_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha512),cbc(aes))",
+		.cra_driver_name = "cpt_hmac_sha512_cbc_aes",
+		.cra_blocksize = AES_BLOCK_SIZE,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_cbc_aes_sha512_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_cbc_aes_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_encrypt,
+	.decrypt = otx_cpt_aead_decrypt,
+	.ivsize = AES_BLOCK_SIZE,
+	.maxauthsize = SHA512_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha1),ecb(cipher_null))",
+		.cra_driver_name = "cpt_hmac_sha1_ecb_null",
+		.cra_blocksize = 1,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_ecb_null_sha1_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_ecb_null_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_null_encrypt,
+	.decrypt = otx_cpt_aead_null_decrypt,
+	.ivsize = 0,
+	.maxauthsize = SHA1_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha256),ecb(cipher_null))",
+		.cra_driver_name = "cpt_hmac_sha256_ecb_null",
+		.cra_blocksize = 1,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_ecb_null_sha256_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_ecb_null_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_null_encrypt,
+	.decrypt = otx_cpt_aead_null_decrypt,
+	.ivsize = 0,
+	.maxauthsize = SHA256_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha384),ecb(cipher_null))",
+		.cra_driver_name = "cpt_hmac_sha384_ecb_null",
+		.cra_blocksize = 1,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_ecb_null_sha384_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_ecb_null_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_null_encrypt,
+	.decrypt = otx_cpt_aead_null_decrypt,
+	.ivsize = 0,
+	.maxauthsize = SHA384_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "authenc(hmac(sha512),ecb(cipher_null))",
+		.cra_driver_name = "cpt_hmac_sha512_ecb_null",
+		.cra_blocksize = 1,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_ecb_null_sha512_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_ecb_null_sha_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_null_encrypt,
+	.decrypt = otx_cpt_aead_null_decrypt,
+	.ivsize = 0,
+	.maxauthsize = SHA512_DIGEST_SIZE,
+}, {
+	.base = {
+		.cra_name = "rfc4106(gcm(aes))",
+		.cra_driver_name = "cpt_rfc4106_gcm_aes",
+		.cra_blocksize = 1,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct otx_cpt_aead_ctx),
+		.cra_priority = 4001,
+		.cra_alignmask = 0,
+		.cra_module = THIS_MODULE,
+	},
+	.init = otx_cpt_aead_gcm_aes_init,
+	.exit = otx_cpt_aead_exit,
+	.setkey = otx_cpt_aead_gcm_aes_setkey,
+	.setauthsize = otx_cpt_aead_set_authsize,
+	.encrypt = otx_cpt_aead_encrypt,
+	.decrypt = otx_cpt_aead_decrypt,
+	.ivsize = AES_GCM_IV_SIZE,
+	.maxauthsize = AES_GCM_ICV_SIZE,
+} };
+
+static inline int is_any_alg_used(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(otx_cpt_skciphers); i++)
+		if (refcount_read(&otx_cpt_skciphers[i].base.cra_refcnt) != 1)
+			return true;
+	for (i = 0; i < ARRAY_SIZE(otx_cpt_aeads); i++)
+		if (refcount_read(&otx_cpt_aeads[i].base.cra_refcnt) != 1)
+			return true;
+	return false;
+}
+
+static inline int cpt_register_algs(void)
+{
+	int i, err = 0;
+
+	if (!IS_ENABLED(CONFIG_DM_CRYPT)) {
+		for (i = 0; i < ARRAY_SIZE(otx_cpt_skciphers); i++)
+			otx_cpt_skciphers[i].base.cra_flags &= ~CRYPTO_ALG_DEAD;
+
+		err = crypto_register_skciphers(otx_cpt_skciphers,
+						ARRAY_SIZE(otx_cpt_skciphers));
+		if (err)
+			return err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(otx_cpt_aeads); i++)
+		otx_cpt_aeads[i].base.cra_flags &= ~CRYPTO_ALG_DEAD;
+
+	err = crypto_register_aeads(otx_cpt_aeads, ARRAY_SIZE(otx_cpt_aeads));
+	if (err) {
+		crypto_unregister_skciphers(otx_cpt_skciphers,
+					    ARRAY_SIZE(otx_cpt_skciphers));
+		return err;
+	}
+
+	return 0;
+}
+
+static inline void cpt_unregister_algs(void)
+{
+	crypto_unregister_skciphers(otx_cpt_skciphers,
+				    ARRAY_SIZE(otx_cpt_skciphers));
+	crypto_unregister_aeads(otx_cpt_aeads, ARRAY_SIZE(otx_cpt_aeads));
+}
+
+static int compare_func(const void *lptr, const void *rptr)
+{
+	struct cpt_device_desc *ldesc = (struct cpt_device_desc *) lptr;
+	struct cpt_device_desc *rdesc = (struct cpt_device_desc *) rptr;
+
+	if (ldesc->dev->devfn < rdesc->dev->devfn)
+		return -1;
+	if (ldesc->dev->devfn > rdesc->dev->devfn)
+		return 1;
+	return 0;
+}
+
+static void swap_func(void *lptr, void *rptr, int size)
+{
+	struct cpt_device_desc *ldesc = (struct cpt_device_desc *) lptr;
+	struct cpt_device_desc *rdesc = (struct cpt_device_desc *) rptr;
+	struct cpt_device_desc desc;
+
+	desc = *ldesc;
+	*ldesc = *rdesc;
+	*rdesc = desc;
+}
+
+int otx_cpt_crypto_init(struct pci_dev *pdev, struct module *mod,
+			enum otx_cptpf_type pf_type,
+			enum otx_cptvf_type engine_type,
+			int num_queues, int num_devices)
+{
+	int ret = 0;
+	int count;
+
+	mutex_lock(&mutex);
+	switch (engine_type) {
+	case OTX_CPT_SE_TYPES:
+		count = atomic_read(&se_devices.count);
+		if (count >= CPT_MAX_VF_NUM) {
+			dev_err(&pdev->dev, "No space to add a new device");
+			ret = -ENOSPC;
+			goto err;
+		}
+		se_devices.desc[count].pf_type = pf_type;
+		se_devices.desc[count].num_queues = num_queues;
+		se_devices.desc[count++].dev = pdev;
+		atomic_inc(&se_devices.count);
+
+		if (atomic_read(&se_devices.count) == num_devices &&
+		    is_crypto_registered == false) {
+			if (cpt_register_algs()) {
+				dev_err(&pdev->dev,
+				   "Error in registering crypto algorithms\n");
+				ret =  -EINVAL;
+				goto err;
+			}
+			try_module_get(mod);
+			is_crypto_registered = true;
+		}
+		sort(se_devices.desc, count, sizeof(struct cpt_device_desc),
+		     compare_func, swap_func);
+		break;
+
+	case OTX_CPT_AE_TYPES:
+		count = atomic_read(&ae_devices.count);
+		if (count >= CPT_MAX_VF_NUM) {
+			dev_err(&pdev->dev, "No space to a add new device");
+			ret = -ENOSPC;
+			goto err;
+		}
+		ae_devices.desc[count].pf_type = pf_type;
+		ae_devices.desc[count].num_queues = num_queues;
+		ae_devices.desc[count++].dev = pdev;
+		atomic_inc(&ae_devices.count);
+		sort(ae_devices.desc, count, sizeof(struct cpt_device_desc),
+		     compare_func, swap_func);
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Unknown VF type %d\n", engine_type);
+		ret = BAD_OTX_CPTVF_TYPE;
+	}
+err:
+	mutex_unlock(&mutex);
+	return ret;
+}
+
+void otx_cpt_crypto_exit(struct pci_dev *pdev, struct module *mod,
+			 enum otx_cptvf_type engine_type)
+{
+	struct cpt_device_table *dev_tbl;
+	bool dev_found = false;
+	int i, j, count;
+
+	mutex_lock(&mutex);
+
+	dev_tbl = (engine_type == OTX_CPT_AE_TYPES) ? &ae_devices : &se_devices;
+	count = atomic_read(&dev_tbl->count);
+	for (i = 0; i < count; i++)
+		if (pdev == dev_tbl->desc[i].dev) {
+			for (j = i; j < count-1; j++)
+				dev_tbl->desc[j] = dev_tbl->desc[j+1];
+			dev_found = true;
+			break;
+		}
+
+	if (!dev_found) {
+		dev_err(&pdev->dev, "%s device not found", __func__);
+		goto exit;
+	}
+
+	if (engine_type != OTX_CPT_AE_TYPES) {
+		if (atomic_dec_and_test(&se_devices.count) &&
+		    !is_any_alg_used()) {
+			cpt_unregister_algs();
+			module_put(mod);
+			is_crypto_registered = false;
+		}
+	} else
+		atomic_dec(&ae_devices.count);
+exit:
+	mutex_unlock(&mutex);
+}
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h
new file mode 100644
index 0000000..67cc002
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.h
@@ -0,0 +1,188 @@
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
+#ifndef __OTX_CPT_ALGS_H
+#define __OTX_CPT_ALGS_H
+
+#include <crypto/hash.h>
+#include "otx_cpt_common.h"
+
+#define OTX_CPT_MAX_ENC_KEY_SIZE    32
+#define OTX_CPT_MAX_HASH_KEY_SIZE   64
+#define OTX_CPT_MAX_KEY_SIZE (OTX_CPT_MAX_ENC_KEY_SIZE + \
+			      OTX_CPT_MAX_HASH_KEY_SIZE)
+enum otx_cpt_request_type {
+	OTX_CPT_ENC_DEC_REQ            = 0x1,
+	OTX_CPT_AEAD_ENC_DEC_REQ       = 0x2,
+	OTX_CPT_AEAD_ENC_DEC_NULL_REQ  = 0x3,
+	OTX_CPT_PASSTHROUGH_REQ	       = 0x4
+};
+
+enum otx_cpt_major_opcodes {
+	OTX_CPT_MAJOR_OP_MISC = 0x01,
+	OTX_CPT_MAJOR_OP_FC   = 0x33,
+	OTX_CPT_MAJOR_OP_HMAC = 0x35,
+};
+
+enum otx_cpt_req_type {
+		OTX_CPT_AE_CORE_REQ,
+		OTX_CPT_SE_CORE_REQ
+};
+
+enum otx_cpt_cipher_type {
+	OTX_CPT_CIPHER_NULL = 0x0,
+	OTX_CPT_DES3_CBC = 0x1,
+	OTX_CPT_DES3_ECB = 0x2,
+	OTX_CPT_AES_CBC  = 0x3,
+	OTX_CPT_AES_ECB  = 0x4,
+	OTX_CPT_AES_CFB  = 0x5,
+	OTX_CPT_AES_CTR  = 0x6,
+	OTX_CPT_AES_GCM  = 0x7,
+	OTX_CPT_AES_XTS  = 0x8
+};
+
+enum otx_cpt_mac_type {
+	OTX_CPT_MAC_NULL = 0x0,
+	OTX_CPT_MD5      = 0x1,
+	OTX_CPT_SHA1     = 0x2,
+	OTX_CPT_SHA224   = 0x3,
+	OTX_CPT_SHA256   = 0x4,
+	OTX_CPT_SHA384   = 0x5,
+	OTX_CPT_SHA512   = 0x6,
+	OTX_CPT_GMAC     = 0x7
+};
+
+enum otx_cpt_aes_key_len {
+	OTX_CPT_AES_128_BIT = 0x1,
+	OTX_CPT_AES_192_BIT = 0x2,
+	OTX_CPT_AES_256_BIT = 0x3
+};
+
+union otx_cpt_encr_ctrl {
+	u64 flags;
+	struct {
+#if defined(__BIG_ENDIAN_BITFIELD)
+		u64 enc_cipher:4;
+		u64 reserved1:1;
+		u64 aes_key:2;
+		u64 iv_source:1;
+		u64 mac_type:4;
+		u64 reserved2:3;
+		u64 auth_input_type:1;
+		u64 mac_len:8;
+		u64 reserved3:8;
+		u64 encr_offset:16;
+		u64 iv_offset:8;
+		u64 auth_offset:8;
+#else
+		u64 auth_offset:8;
+		u64 iv_offset:8;
+		u64 encr_offset:16;
+		u64 reserved3:8;
+		u64 mac_len:8;
+		u64 auth_input_type:1;
+		u64 reserved2:3;
+		u64 mac_type:4;
+		u64 iv_source:1;
+		u64 aes_key:2;
+		u64 reserved1:1;
+		u64 enc_cipher:4;
+#endif
+	} e;
+};
+
+struct otx_cpt_cipher {
+	const char *name;
+	u8 value;
+};
+
+struct otx_cpt_enc_context {
+	union otx_cpt_encr_ctrl enc_ctrl;
+	u8 encr_key[32];
+	u8 encr_iv[16];
+};
+
+union otx_cpt_fchmac_ctx {
+	struct {
+		u8 ipad[64];
+		u8 opad[64];
+	} e;
+	struct {
+		u8 hmac_calc[64]; /* HMAC calculated */
+		u8 hmac_recv[64]; /* HMAC received */
+	} s;
+};
+
+struct otx_cpt_fc_ctx {
+	struct otx_cpt_enc_context enc;
+	union otx_cpt_fchmac_ctx hmac;
+};
+
+struct otx_cpt_enc_ctx {
+	u32 key_len;
+	u8 enc_key[OTX_CPT_MAX_KEY_SIZE];
+	u8 cipher_type;
+	u8 key_type;
+};
+
+struct otx_cpt_des3_ctx {
+	u32 key_len;
+	u8 des3_key[OTX_CPT_MAX_KEY_SIZE];
+};
+
+union otx_cpt_offset_ctrl_word {
+	u64 flags;
+	struct {
+#if defined(__BIG_ENDIAN_BITFIELD)
+		u64 reserved:32;
+		u64 enc_data_offset:16;
+		u64 iv_offset:8;
+		u64 auth_offset:8;
+#else
+		u64 auth_offset:8;
+		u64 iv_offset:8;
+		u64 enc_data_offset:16;
+		u64 reserved:32;
+#endif
+	} e;
+};
+
+struct otx_cpt_req_ctx {
+	struct otx_cpt_req_info cpt_req;
+	union otx_cpt_offset_ctrl_word ctrl_word;
+	struct otx_cpt_fc_ctx fctx;
+};
+
+struct otx_cpt_sdesc {
+	struct shash_desc shash;
+};
+
+struct otx_cpt_aead_ctx {
+	u8 key[OTX_CPT_MAX_KEY_SIZE];
+	struct crypto_shash *hashalg;
+	struct otx_cpt_sdesc *sdesc;
+	u8 *ipad;
+	u8 *opad;
+	u32 enc_key_len;
+	u32 auth_key_len;
+	u8 cipher_type;
+	u8 mac_type;
+	u8 key_type;
+	u8 is_trunc_hmac;
+};
+int otx_cpt_crypto_init(struct pci_dev *pdev, struct module *mod,
+			enum otx_cptpf_type pf_type,
+			enum otx_cptvf_type engine_type,
+			int num_queues, int num_devices);
+void otx_cpt_crypto_exit(struct pci_dev *pdev, struct module *mod,
+			 enum otx_cptvf_type engine_type);
+void otx_cpt_callback(int status, void *arg, void *req);
+
+#endif /* __OTX_CPT_ALGS_H */
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
new file mode 100644
index 0000000..a91860b
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -0,0 +1,985 @@
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
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include "otx_cptvf.h"
+#include "otx_cptvf_algs.h"
+#include "otx_cptvf_reqmgr.h"
+
+#define DRV_NAME	"octeontx-cptvf"
+#define DRV_VERSION	"1.0"
+
+static void vq_work_handler(unsigned long data)
+{
+	struct otx_cptvf_wqe_info *cwqe_info =
+					(struct otx_cptvf_wqe_info *) data;
+
+	otx_cpt_post_process(&cwqe_info->vq_wqe[0]);
+}
+
+static int init_worker_threads(struct otx_cptvf *cptvf)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+	struct otx_cptvf_wqe_info *cwqe_info;
+	int i;
+
+	cwqe_info = kzalloc(sizeof(*cwqe_info), GFP_KERNEL);
+	if (!cwqe_info)
+		return -ENOMEM;
+
+	if (cptvf->num_queues) {
+		dev_dbg(&pdev->dev, "Creating VQ worker threads (%d)\n",
+			cptvf->num_queues);
+	}
+
+	for (i = 0; i < cptvf->num_queues; i++) {
+		tasklet_init(&cwqe_info->vq_wqe[i].twork, vq_work_handler,
+			     (u64)cwqe_info);
+		cwqe_info->vq_wqe[i].cptvf = cptvf;
+	}
+	cptvf->wqe_info = cwqe_info;
+
+	return 0;
+}
+
+static void cleanup_worker_threads(struct otx_cptvf *cptvf)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+	struct otx_cptvf_wqe_info *cwqe_info;
+	int i;
+
+	cwqe_info = (struct otx_cptvf_wqe_info *)cptvf->wqe_info;
+	if (!cwqe_info)
+		return;
+
+	if (cptvf->num_queues) {
+		dev_dbg(&pdev->dev, "Cleaning VQ worker threads (%u)\n",
+			cptvf->num_queues);
+	}
+
+	for (i = 0; i < cptvf->num_queues; i++)
+		tasklet_kill(&cwqe_info->vq_wqe[i].twork);
+
+	kzfree(cwqe_info);
+	cptvf->wqe_info = NULL;
+}
+
+static void free_pending_queues(struct otx_cpt_pending_qinfo *pqinfo)
+{
+	struct otx_cpt_pending_queue *queue;
+	int i;
+
+	for_each_pending_queue(pqinfo, queue, i) {
+		if (!queue->head)
+			continue;
+
+		/* free single queue */
+		kzfree((queue->head));
+		queue->front = 0;
+		queue->rear = 0;
+		queue->qlen = 0;
+	}
+	pqinfo->num_queues = 0;
+}
+
+static int alloc_pending_queues(struct otx_cpt_pending_qinfo *pqinfo, u32 qlen,
+				u32 num_queues)
+{
+	struct otx_cpt_pending_queue *queue = NULL;
+	size_t size;
+	int ret;
+	u32 i;
+
+	pqinfo->num_queues = num_queues;
+	size = (qlen * sizeof(struct otx_cpt_pending_entry));
+
+	for_each_pending_queue(pqinfo, queue, i) {
+		queue->head = kzalloc((size), GFP_KERNEL);
+		if (!queue->head) {
+			ret = -ENOMEM;
+			goto pending_qfail;
+		}
+
+		queue->pending_count = 0;
+		queue->front = 0;
+		queue->rear = 0;
+		queue->qlen = qlen;
+
+		/* init queue spin lock */
+		spin_lock_init(&queue->lock);
+	}
+	return 0;
+
+pending_qfail:
+	free_pending_queues(pqinfo);
+
+	return ret;
+}
+
+static int init_pending_queues(struct otx_cptvf *cptvf, u32 qlen,
+			       u32 num_queues)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+	int ret;
+
+	if (!num_queues)
+		return 0;
+
+	ret = alloc_pending_queues(&cptvf->pqinfo, qlen, num_queues);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup pending queues (%u)\n",
+			num_queues);
+		return ret;
+	}
+	return 0;
+}
+
+static void cleanup_pending_queues(struct otx_cptvf *cptvf)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+
+	if (!cptvf->num_queues)
+		return;
+
+	dev_dbg(&pdev->dev, "Cleaning VQ pending queue (%u)\n",
+		cptvf->num_queues);
+	free_pending_queues(&cptvf->pqinfo);
+}
+
+static void free_command_queues(struct otx_cptvf *cptvf,
+				struct otx_cpt_cmd_qinfo *cqinfo)
+{
+	struct otx_cpt_cmd_queue *queue = NULL;
+	struct otx_cpt_cmd_chunk *chunk = NULL;
+	struct pci_dev *pdev = cptvf->pdev;
+	int i;
+
+	/* clean up for each queue */
+	for (i = 0; i < cptvf->num_queues; i++) {
+		queue = &cqinfo->queue[i];
+
+		while (!list_empty(&cqinfo->queue[i].chead)) {
+			chunk = list_first_entry(&cqinfo->queue[i].chead,
+					struct otx_cpt_cmd_chunk, nextchunk);
+
+			dma_free_coherent(&pdev->dev, chunk->size,
+					  chunk->head,
+					  chunk->dma_addr);
+			chunk->head = NULL;
+			chunk->dma_addr = 0;
+			list_del(&chunk->nextchunk);
+			kzfree(chunk);
+		}
+		queue->num_chunks = 0;
+		queue->idx = 0;
+
+	}
+}
+
+static int alloc_command_queues(struct otx_cptvf *cptvf,
+				struct otx_cpt_cmd_qinfo *cqinfo,
+				u32 qlen)
+{
+	struct otx_cpt_cmd_chunk *curr, *first, *last;
+	struct otx_cpt_cmd_queue *queue = NULL;
+	struct pci_dev *pdev = cptvf->pdev;
+	size_t q_size, c_size, rem_q_size;
+	u32 qcsize_bytes;
+	int i;
+
+
+	/* Qsize in dwords, needed for SADDR config, 1-next chunk pointer */
+	cptvf->qsize = min(qlen, cqinfo->qchunksize) *
+		       OTX_CPT_NEXT_CHUNK_PTR_SIZE + 1;
+	/* Qsize in bytes to create space for alignment */
+	q_size = qlen * OTX_CPT_INST_SIZE;
+
+	qcsize_bytes = cqinfo->qchunksize * OTX_CPT_INST_SIZE;
+
+	/* per queue initialization */
+	for (i = 0; i < cptvf->num_queues; i++) {
+		c_size = 0;
+		rem_q_size = q_size;
+		first = NULL;
+		last = NULL;
+
+		queue = &cqinfo->queue[i];
+		INIT_LIST_HEAD(&queue->chead);
+		do {
+			curr = kzalloc(sizeof(*curr), GFP_KERNEL);
+			if (!curr)
+				goto cmd_qfail;
+
+			c_size = (rem_q_size > qcsize_bytes) ? qcsize_bytes :
+					rem_q_size;
+			curr->head = dma_alloc_coherent(&pdev->dev,
+					   c_size + OTX_CPT_NEXT_CHUNK_PTR_SIZE,
+					   &curr->dma_addr, GFP_KERNEL);
+			if (!curr->head) {
+				dev_err(&pdev->dev,
+				"Command Q (%d) chunk (%d) allocation failed\n",
+					i, queue->num_chunks);
+				goto free_curr;
+			}
+			curr->size = c_size;
+
+			if (queue->num_chunks == 0) {
+				first = curr;
+				queue->base  = first;
+			}
+			list_add_tail(&curr->nextchunk,
+				      &cqinfo->queue[i].chead);
+
+			queue->num_chunks++;
+			rem_q_size -= c_size;
+			if (last)
+				*((u64 *)(&last->head[last->size])) =
+					(u64)curr->dma_addr;
+
+			last = curr;
+		} while (rem_q_size);
+
+		/*
+		 * Make the queue circular, tie back last chunk entry to head
+		 */
+		curr = first;
+		*((u64 *)(&last->head[last->size])) = (u64)curr->dma_addr;
+		queue->qhead = curr;
+	}
+	return 0;
+free_curr:
+	kfree(curr);
+cmd_qfail:
+	free_command_queues(cptvf, cqinfo);
+	return -ENOMEM;
+}
+
+static int init_command_queues(struct otx_cptvf *cptvf, u32 qlen)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+	int ret;
+
+	/* setup command queues */
+	ret = alloc_command_queues(cptvf, &cptvf->cqinfo, qlen);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to allocate command queues (%u)\n",
+			cptvf->num_queues);
+		return ret;
+	}
+	return ret;
+}
+
+static void cleanup_command_queues(struct otx_cptvf *cptvf)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+
+	if (!cptvf->num_queues)
+		return;
+
+	dev_dbg(&pdev->dev, "Cleaning VQ command queue (%u)\n",
+		cptvf->num_queues);
+	free_command_queues(cptvf, &cptvf->cqinfo);
+}
+
+static void cptvf_sw_cleanup(struct otx_cptvf *cptvf)
+{
+	cleanup_worker_threads(cptvf);
+	cleanup_pending_queues(cptvf);
+	cleanup_command_queues(cptvf);
+}
+
+static int cptvf_sw_init(struct otx_cptvf *cptvf, u32 qlen, u32 num_queues)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+	u32 max_dev_queues = 0;
+	int ret;
+
+	max_dev_queues = OTX_CPT_NUM_QS_PER_VF;
+	/* possible cpus */
+	num_queues = min_t(u32, num_queues, max_dev_queues);
+	cptvf->num_queues = num_queues;
+
+	ret = init_command_queues(cptvf, qlen);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup command queues (%u)\n",
+			num_queues);
+		return ret;
+	}
+
+	ret = init_pending_queues(cptvf, qlen, num_queues);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup pending queues (%u)\n",
+			num_queues);
+		goto setup_pqfail;
+	}
+
+	/* Create worker threads for BH processing */
+	ret = init_worker_threads(cptvf);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup worker threads\n");
+		goto init_work_fail;
+	}
+	return 0;
+
+init_work_fail:
+	cleanup_worker_threads(cptvf);
+	cleanup_pending_queues(cptvf);
+
+setup_pqfail:
+	cleanup_command_queues(cptvf);
+
+	return ret;
+}
+
+static void cptvf_free_irq_affinity(struct otx_cptvf *cptvf, int vec)
+{
+	irq_set_affinity_hint(pci_irq_vector(cptvf->pdev, vec), NULL);
+	free_cpumask_var(cptvf->affinity_mask[vec]);
+}
+
+static void cptvf_write_vq_ctl(struct otx_cptvf *cptvf, bool val)
+{
+	union otx_cptx_vqx_ctl vqx_ctl;
+
+	vqx_ctl.u = readq(cptvf->reg_base + OTX_CPT_VQX_CTL(0));
+	vqx_ctl.s.ena = val;
+	writeq(vqx_ctl.u, cptvf->reg_base + OTX_CPT_VQX_CTL(0));
+}
+
+void otx_cptvf_write_vq_doorbell(struct otx_cptvf *cptvf, u32 val)
+{
+	union otx_cptx_vqx_doorbell vqx_dbell;
+
+	vqx_dbell.u = readq(cptvf->reg_base + OTX_CPT_VQX_DOORBELL(0));
+	vqx_dbell.s.dbell_cnt = val * 8; /* Num of Instructions * 8 words */
+	writeq(vqx_dbell.u, cptvf->reg_base + OTX_CPT_VQX_DOORBELL(0));
+}
+
+static void cptvf_write_vq_inprog(struct otx_cptvf *cptvf, u8 val)
+{
+	union otx_cptx_vqx_inprog vqx_inprg;
+
+	vqx_inprg.u = readq(cptvf->reg_base + OTX_CPT_VQX_INPROG(0));
+	vqx_inprg.s.inflight = val;
+	writeq(vqx_inprg.u, cptvf->reg_base + OTX_CPT_VQX_INPROG(0));
+}
+
+static void cptvf_write_vq_done_numwait(struct otx_cptvf *cptvf, u32 val)
+{
+	union otx_cptx_vqx_done_wait vqx_dwait;
+
+	vqx_dwait.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE_WAIT(0));
+	vqx_dwait.s.num_wait = val;
+	writeq(vqx_dwait.u, cptvf->reg_base + OTX_CPT_VQX_DONE_WAIT(0));
+}
+
+static u32 cptvf_read_vq_done_numwait(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_done_wait vqx_dwait;
+
+	vqx_dwait.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE_WAIT(0));
+	return vqx_dwait.s.num_wait;
+}
+
+static void cptvf_write_vq_done_timewait(struct otx_cptvf *cptvf, u16 time)
+{
+	union otx_cptx_vqx_done_wait vqx_dwait;
+
+	vqx_dwait.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE_WAIT(0));
+	vqx_dwait.s.time_wait = time;
+	writeq(vqx_dwait.u, cptvf->reg_base + OTX_CPT_VQX_DONE_WAIT(0));
+}
+
+
+static u16 cptvf_read_vq_done_timewait(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_done_wait vqx_dwait;
+
+	vqx_dwait.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE_WAIT(0));
+	return vqx_dwait.s.time_wait;
+}
+
+static void cptvf_enable_swerr_interrupts(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_ena_w1s vqx_misc_ena;
+
+	vqx_misc_ena.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_ENA_W1S(0));
+	/* Enable SWERR interrupts for the requested VF */
+	vqx_misc_ena.s.swerr = 1;
+	writeq(vqx_misc_ena.u, cptvf->reg_base + OTX_CPT_VQX_MISC_ENA_W1S(0));
+}
+
+static void cptvf_enable_mbox_interrupts(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_ena_w1s vqx_misc_ena;
+
+	vqx_misc_ena.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_ENA_W1S(0));
+	/* Enable MBOX interrupt for the requested VF */
+	vqx_misc_ena.s.mbox = 1;
+	writeq(vqx_misc_ena.u, cptvf->reg_base + OTX_CPT_VQX_MISC_ENA_W1S(0));
+}
+
+static void cptvf_enable_done_interrupts(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_done_ena_w1s vqx_done_ena;
+
+	vqx_done_ena.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE_ENA_W1S(0));
+	/* Enable DONE interrupt for the requested VF */
+	vqx_done_ena.s.done = 1;
+	writeq(vqx_done_ena.u, cptvf->reg_base + OTX_CPT_VQX_DONE_ENA_W1S(0));
+}
+
+static void cptvf_clear_dovf_intr(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_int vqx_misc_int;
+
+	vqx_misc_int.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+	/* W1C for the VF */
+	vqx_misc_int.s.dovf = 1;
+	writeq(vqx_misc_int.u, cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+}
+
+static void cptvf_clear_irde_intr(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_int vqx_misc_int;
+
+	vqx_misc_int.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+	/* W1C for the VF */
+	vqx_misc_int.s.irde = 1;
+	writeq(vqx_misc_int.u, cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+}
+
+static void cptvf_clear_nwrp_intr(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_int vqx_misc_int;
+
+	vqx_misc_int.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+	/* W1C for the VF */
+	vqx_misc_int.s.nwrp = 1;
+	writeq(vqx_misc_int.u, cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+}
+
+static void cptvf_clear_mbox_intr(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_int vqx_misc_int;
+
+	vqx_misc_int.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+	/* W1C for the VF */
+	vqx_misc_int.s.mbox = 1;
+	writeq(vqx_misc_int.u, cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+}
+
+static void cptvf_clear_swerr_intr(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_misc_int vqx_misc_int;
+
+	vqx_misc_int.u = readq(cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+	/* W1C for the VF */
+	vqx_misc_int.s.swerr = 1;
+	writeq(vqx_misc_int.u, cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+}
+
+static u64 cptvf_read_vf_misc_intr_status(struct otx_cptvf *cptvf)
+{
+	return readq(cptvf->reg_base + OTX_CPT_VQX_MISC_INT(0));
+}
+
+static irqreturn_t cptvf_misc_intr_handler(int __always_unused irq,
+					   void *arg)
+{
+	struct otx_cptvf *cptvf = arg;
+	struct pci_dev *pdev = cptvf->pdev;
+	u64 intr;
+
+	intr = cptvf_read_vf_misc_intr_status(cptvf);
+	/* Check for MISC interrupt types */
+	if (likely(intr & OTX_CPT_VF_INTR_MBOX_MASK)) {
+		dev_dbg(&pdev->dev, "Mailbox interrupt 0x%llx on CPT VF %d\n",
+			intr, cptvf->vfid);
+		otx_cptvf_handle_mbox_intr(cptvf);
+		cptvf_clear_mbox_intr(cptvf);
+	} else if (unlikely(intr & OTX_CPT_VF_INTR_DOVF_MASK)) {
+		cptvf_clear_dovf_intr(cptvf);
+		/* Clear doorbell count */
+		otx_cptvf_write_vq_doorbell(cptvf, 0);
+		dev_err(&pdev->dev,
+		"Doorbell overflow error interrupt 0x%llx on CPT VF %d\n",
+			intr, cptvf->vfid);
+	} else if (unlikely(intr & OTX_CPT_VF_INTR_IRDE_MASK)) {
+		cptvf_clear_irde_intr(cptvf);
+		dev_err(&pdev->dev,
+		"Instruction NCB read error interrupt 0x%llx on CPT VF %d\n",
+			intr, cptvf->vfid);
+	} else if (unlikely(intr & OTX_CPT_VF_INTR_NWRP_MASK)) {
+		cptvf_clear_nwrp_intr(cptvf);
+		dev_err(&pdev->dev,
+		"NCB response write error interrupt 0x%llx on CPT VF %d\n",
+			intr, cptvf->vfid);
+	} else if (unlikely(intr & OTX_CPT_VF_INTR_SERR_MASK)) {
+		cptvf_clear_swerr_intr(cptvf);
+		dev_err(&pdev->dev,
+			"Software error interrupt 0x%llx on CPT VF %d\n",
+			intr, cptvf->vfid);
+	} else {
+		dev_err(&pdev->dev, "Unhandled interrupt in OTX_CPT VF %d\n",
+			cptvf->vfid);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static inline struct otx_cptvf_wqe *get_cptvf_vq_wqe(struct otx_cptvf *cptvf,
+						     int qno)
+{
+	struct otx_cptvf_wqe_info *nwqe_info;
+
+	if (unlikely(qno >= cptvf->num_queues))
+		return NULL;
+	nwqe_info = (struct otx_cptvf_wqe_info *)cptvf->wqe_info;
+
+	return &nwqe_info->vq_wqe[qno];
+}
+
+static inline u32 cptvf_read_vq_done_count(struct otx_cptvf *cptvf)
+{
+	union otx_cptx_vqx_done vqx_done;
+
+	vqx_done.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE(0));
+	return vqx_done.s.done;
+}
+
+static inline void cptvf_write_vq_done_ack(struct otx_cptvf *cptvf,
+					   u32 ackcnt)
+{
+	union otx_cptx_vqx_done_ack vqx_dack_cnt;
+
+	vqx_dack_cnt.u = readq(cptvf->reg_base + OTX_CPT_VQX_DONE_ACK(0));
+	vqx_dack_cnt.s.done_ack = ackcnt;
+	writeq(vqx_dack_cnt.u, cptvf->reg_base + OTX_CPT_VQX_DONE_ACK(0));
+}
+
+static irqreturn_t cptvf_done_intr_handler(int __always_unused irq,
+					   void *cptvf_dev)
+{
+	struct otx_cptvf *cptvf = (struct otx_cptvf *)cptvf_dev;
+	struct pci_dev *pdev = cptvf->pdev;
+	/* Read the number of completions */
+	u32 intr = cptvf_read_vq_done_count(cptvf);
+
+	if (intr) {
+		struct otx_cptvf_wqe *wqe;
+
+		/*
+		 * Acknowledge the number of scheduled completions for
+		 * processing
+		 */
+		cptvf_write_vq_done_ack(cptvf, intr);
+		wqe = get_cptvf_vq_wqe(cptvf, 0);
+		if (unlikely(!wqe)) {
+			dev_err(&pdev->dev, "No work to schedule for VF (%d)",
+				cptvf->vfid);
+			return IRQ_NONE;
+		}
+		tasklet_hi_schedule(&wqe->twork);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void cptvf_set_irq_affinity(struct otx_cptvf *cptvf, int vec)
+{
+	struct pci_dev *pdev = cptvf->pdev;
+	int cpu;
+
+	if (!zalloc_cpumask_var(&cptvf->affinity_mask[vec],
+				GFP_KERNEL)) {
+		dev_err(&pdev->dev,
+			"Allocation failed for affinity_mask for VF %d",
+			cptvf->vfid);
+		return;
+	}
+
+	cpu = cptvf->vfid % num_online_cpus();
+	cpumask_set_cpu(cpumask_local_spread(cpu, cptvf->node),
+			cptvf->affinity_mask[vec]);
+	irq_set_affinity_hint(pci_irq_vector(pdev, vec),
+			      cptvf->affinity_mask[vec]);
+}
+
+static void cptvf_write_vq_saddr(struct otx_cptvf *cptvf, u64 val)
+{
+	union otx_cptx_vqx_saddr vqx_saddr;
+
+	vqx_saddr.u = val;
+	writeq(vqx_saddr.u, cptvf->reg_base + OTX_CPT_VQX_SADDR(0));
+}
+
+static void cptvf_device_init(struct otx_cptvf *cptvf)
+{
+	u64 base_addr = 0;
+
+	/* Disable the VQ */
+	cptvf_write_vq_ctl(cptvf, 0);
+	/* Reset the doorbell */
+	otx_cptvf_write_vq_doorbell(cptvf, 0);
+	/* Clear inflight */
+	cptvf_write_vq_inprog(cptvf, 0);
+	/* Write VQ SADDR */
+	base_addr = (u64)(cptvf->cqinfo.queue[0].qhead->dma_addr);
+	cptvf_write_vq_saddr(cptvf, base_addr);
+	/* Configure timerhold / coalescence */
+	cptvf_write_vq_done_timewait(cptvf, OTX_CPT_TIMER_HOLD);
+	cptvf_write_vq_done_numwait(cptvf, OTX_CPT_COUNT_HOLD);
+	/* Enable the VQ */
+	cptvf_write_vq_ctl(cptvf, 1);
+	/* Flag the VF ready */
+	cptvf->flags |= OTX_CPT_FLAG_DEVICE_READY;
+}
+
+static ssize_t vf_type_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+	char *msg;
+
+	switch (cptvf->vftype) {
+	case OTX_CPT_AE_TYPES:
+		msg = "AE";
+		break;
+
+	case OTX_CPT_SE_TYPES:
+		msg = "SE";
+		break;
+
+	default:
+		msg = "Invalid";
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", msg);
+}
+
+static ssize_t vf_engine_group_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", cptvf->vfgrp);
+}
+
+static ssize_t vf_engine_group_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0)
+		return -EINVAL;
+
+	if (val >= OTX_CPT_MAX_ENGINE_GROUPS) {
+		dev_err(dev, "Engine group >= than max available groups %d",
+			OTX_CPT_MAX_ENGINE_GROUPS);
+		return -EINVAL;
+	}
+
+	ret = otx_cptvf_send_vf_to_grp_msg(cptvf, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t vf_coalesc_time_wait_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 cptvf_read_vq_done_timewait(cptvf));
+}
+
+static ssize_t vf_coalesc_num_wait_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 cptvf_read_vq_done_numwait(cptvf));
+}
+
+static ssize_t vf_coalesc_time_wait_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret != 0)
+		return ret;
+
+	if (val < OTX_CPT_COALESC_MIN_TIME_WAIT ||
+	    val > OTX_CPT_COALESC_MAX_TIME_WAIT)
+		return -EINVAL;
+
+	cptvf_write_vq_done_timewait(cptvf, val);
+	return count;
+}
+
+static ssize_t vf_coalesc_num_wait_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct otx_cptvf *cptvf = dev_get_drvdata(dev);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret != 0)
+		return ret;
+
+	if (val < OTX_CPT_COALESC_MIN_NUM_WAIT ||
+	    val > OTX_CPT_COALESC_MAX_NUM_WAIT)
+		return -EINVAL;
+
+	cptvf_write_vq_done_numwait(cptvf, val);
+	return count;
+}
+
+static DEVICE_ATTR_RO(vf_type);
+static DEVICE_ATTR_RW(vf_engine_group);
+static DEVICE_ATTR_RW(vf_coalesc_time_wait);
+static DEVICE_ATTR_RW(vf_coalesc_num_wait);
+
+static struct attribute *otx_cptvf_attrs[] = {
+	&dev_attr_vf_type.attr,
+	&dev_attr_vf_engine_group.attr,
+	&dev_attr_vf_coalesc_time_wait.attr,
+	&dev_attr_vf_coalesc_num_wait.attr,
+	NULL
+};
+
+static const struct attribute_group otx_cptvf_sysfs_group = {
+	.attrs = otx_cptvf_attrs,
+};
+
+static int otx_cptvf_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct otx_cptvf *cptvf;
+	int err;
+
+	cptvf = devm_kzalloc(dev, sizeof(*cptvf), GFP_KERNEL);
+	if (!cptvf)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, cptvf);
+	cptvf->pdev = pdev;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto clear_drvdata;
+	}
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", err);
+		goto disable_device;
+	}
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to get usable DMA configuration\n");
+		goto release_regions;
+	}
+
+	err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "Unable to get 48-bit DMA for consistent allocations\n");
+		goto release_regions;
+	}
+
+	/* MAP PF's configuration registers */
+	cptvf->reg_base = pci_iomap(pdev, OTX_CPT_VF_PCI_CFG_BAR, 0);
+	if (!cptvf->reg_base) {
+		dev_err(dev, "Cannot map config register space, aborting\n");
+		err = -ENOMEM;
+		goto release_regions;
+	}
+
+	cptvf->node = dev_to_node(&pdev->dev);
+	err = pci_alloc_irq_vectors(pdev, OTX_CPT_VF_MSIX_VECTORS,
+				    OTX_CPT_VF_MSIX_VECTORS, PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(dev, "Request for #%d msix vectors failed\n",
+			OTX_CPT_VF_MSIX_VECTORS);
+		goto unmap_region;
+	}
+
+	err = request_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_MISC),
+			  cptvf_misc_intr_handler, 0, "CPT VF misc intr",
+			  cptvf);
+	if (err) {
+		dev_err(dev, "Failed to request misc irq");
+		goto free_vectors;
+	}
+
+	/* Enable mailbox interrupt */
+	cptvf_enable_mbox_interrupts(cptvf);
+	cptvf_enable_swerr_interrupts(cptvf);
+
+	/* Check cpt pf status, gets chip ID / device Id from PF if ready */
+	err = otx_cptvf_check_pf_ready(cptvf);
+	if (err)
+		goto free_misc_irq;
+
+	/* CPT VF software resources initialization */
+	cptvf->cqinfo.qchunksize = OTX_CPT_CMD_QCHUNK_SIZE;
+	err = cptvf_sw_init(cptvf, OTX_CPT_CMD_QLEN, OTX_CPT_NUM_QS_PER_VF);
+	if (err) {
+		dev_err(dev, "cptvf_sw_init() failed");
+		goto free_misc_irq;
+	}
+	/* Convey VQ LEN to PF */
+	err = otx_cptvf_send_vq_size_msg(cptvf);
+	if (err)
+		goto sw_cleanup;
+
+	/* CPT VF device initialization */
+	cptvf_device_init(cptvf);
+	/* Send msg to PF to assign currnet Q to required group */
+	err = otx_cptvf_send_vf_to_grp_msg(cptvf, cptvf->vfgrp);
+	if (err)
+		goto sw_cleanup;
+
+	cptvf->priority = 1;
+	err = otx_cptvf_send_vf_priority_msg(cptvf);
+	if (err)
+		goto sw_cleanup;
+
+	err = request_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_DONE),
+			  cptvf_done_intr_handler, 0, "CPT VF done intr",
+			  cptvf);
+	if (err) {
+		dev_err(dev, "Failed to request done irq\n");
+		goto free_done_irq;
+	}
+
+	/* Enable done interrupt */
+	cptvf_enable_done_interrupts(cptvf);
+
+	/* Set irq affinity masks */
+	cptvf_set_irq_affinity(cptvf, CPT_VF_INT_VEC_E_MISC);
+	cptvf_set_irq_affinity(cptvf, CPT_VF_INT_VEC_E_DONE);
+
+	err = otx_cptvf_send_vf_up(cptvf);
+	if (err)
+		goto free_irq_affinity;
+
+	/* Initialize algorithms and set ops */
+	err = otx_cpt_crypto_init(pdev, THIS_MODULE,
+		    cptvf->vftype == OTX_CPT_SE_TYPES ? OTX_CPT_SE : OTX_CPT_AE,
+		    cptvf->vftype, 1, cptvf->num_vfs);
+	if (err) {
+		dev_err(dev, "Failed to register crypto algs\n");
+		goto free_irq_affinity;
+	}
+
+	err = sysfs_create_group(&dev->kobj, &otx_cptvf_sysfs_group);
+	if (err) {
+		dev_err(dev, "Creating sysfs entries failed\n");
+		goto crypto_exit;
+	}
+
+	return 0;
+
+crypto_exit:
+	otx_cpt_crypto_exit(pdev, THIS_MODULE, cptvf->vftype);
+free_irq_affinity:
+	cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_DONE);
+	cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_MISC);
+free_done_irq:
+	free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_DONE), cptvf);
+sw_cleanup:
+	cptvf_sw_cleanup(cptvf);
+free_misc_irq:
+	free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_MISC), cptvf);
+free_vectors:
+	pci_free_irq_vectors(cptvf->pdev);
+unmap_region:
+	pci_iounmap(pdev, cptvf->reg_base);
+release_regions:
+	pci_release_regions(pdev);
+disable_device:
+	pci_disable_device(pdev);
+clear_drvdata:
+	pci_set_drvdata(pdev, NULL);
+
+	return err;
+}
+
+static void otx_cptvf_remove(struct pci_dev *pdev)
+{
+	struct otx_cptvf *cptvf = pci_get_drvdata(pdev);
+
+	if (!cptvf) {
+		dev_err(&pdev->dev, "Invalid CPT-VF device\n");
+		return;
+	}
+
+	/* Convey DOWN to PF */
+	if (otx_cptvf_send_vf_down(cptvf)) {
+		dev_err(&pdev->dev, "PF not responding to DOWN msg");
+	} else {
+		sysfs_remove_group(&pdev->dev.kobj, &otx_cptvf_sysfs_group);
+		otx_cpt_crypto_exit(pdev, THIS_MODULE, cptvf->vftype);
+		cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_DONE);
+		cptvf_free_irq_affinity(cptvf, CPT_VF_INT_VEC_E_MISC);
+		free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_DONE), cptvf);
+		free_irq(pci_irq_vector(pdev, CPT_VF_INT_VEC_E_MISC), cptvf);
+		cptvf_sw_cleanup(cptvf);
+		pci_free_irq_vectors(cptvf->pdev);
+		pci_iounmap(pdev, cptvf->reg_base);
+		pci_release_regions(pdev);
+		pci_disable_device(pdev);
+		pci_set_drvdata(pdev, NULL);
+	}
+}
+
+/* Supported devices */
+static const struct pci_device_id otx_cptvf_id_table[] = {
+	{PCI_VDEVICE(CAVIUM, OTX_CPT_PCI_VF_DEVICE_ID), 0},
+	{ 0, }  /* end of table */
+};
+
+static struct pci_driver otx_cptvf_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = otx_cptvf_id_table,
+	.probe = otx_cptvf_probe,
+	.remove = otx_cptvf_remove,
+};
+
+module_pci_driver(otx_cptvf_pci_driver);
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("Marvell OcteonTX CPT Virtual Function Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
+MODULE_DEVICE_TABLE(pci, otx_cptvf_id_table);
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c b/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c
new file mode 100644
index 0000000..5663787
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_mbox.c
@@ -0,0 +1,247 @@
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
+#include <linux/delay.h>
+#include "otx_cptvf.h"
+
+#define CPT_MBOX_MSG_TIMEOUT 2000
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
+		pr_debug("MBOX msg %s received from VF%d raw_data %s",
+			 get_mbox_opcode_str(mbox_msg->msg), vf_id,
+			 raw_data_str);
+	else
+		pr_debug("MBOX msg %s received from PF raw_data %s",
+			 get_mbox_opcode_str(mbox_msg->msg), raw_data_str);
+}
+
+static void cptvf_send_msg_to_pf(struct otx_cptvf *cptvf,
+				     struct otx_cpt_mbox *mbx)
+{
+	/* Writing mbox(1) causes interrupt */
+	writeq(mbx->msg, cptvf->reg_base + OTX_CPT_VFX_PF_MBOXX(0, 0));
+	writeq(mbx->data, cptvf->reg_base + OTX_CPT_VFX_PF_MBOXX(0, 1));
+}
+
+/* Interrupt handler to handle mailbox messages from VFs */
+void otx_cptvf_handle_mbox_intr(struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_mbox mbx = {};
+
+	/*
+	 * MBOX[0] contains msg
+	 * MBOX[1] contains data
+	 */
+	mbx.msg  = readq(cptvf->reg_base + OTX_CPT_VFX_PF_MBOXX(0, 0));
+	mbx.data = readq(cptvf->reg_base + OTX_CPT_VFX_PF_MBOXX(0, 1));
+
+	dump_mbox_msg(&mbx, -1);
+
+	switch (mbx.msg) {
+	case OTX_CPT_MSG_VF_UP:
+		cptvf->pf_acked = true;
+		cptvf->num_vfs = mbx.data;
+		break;
+	case OTX_CPT_MSG_READY:
+		cptvf->pf_acked = true;
+		cptvf->vfid = mbx.data;
+		dev_dbg(&cptvf->pdev->dev, "Received VFID %d\n", cptvf->vfid);
+		break;
+	case OTX_CPT_MSG_QBIND_GRP:
+		cptvf->pf_acked = true;
+		cptvf->vftype = mbx.data;
+		dev_dbg(&cptvf->pdev->dev, "VF %d type %s group %d\n",
+			cptvf->vfid,
+			((mbx.data == OTX_CPT_SE_TYPES) ? "SE" : "AE"),
+			cptvf->vfgrp);
+		break;
+	case OTX_CPT_MSG_ACK:
+		cptvf->pf_acked = true;
+		break;
+	case OTX_CPT_MSG_NACK:
+		cptvf->pf_nacked = true;
+		break;
+	default:
+		dev_err(&cptvf->pdev->dev, "Invalid msg from PF, msg 0x%llx\n",
+			mbx.msg);
+		break;
+	}
+}
+
+static int cptvf_send_msg_to_pf_timeout(struct otx_cptvf *cptvf,
+					struct otx_cpt_mbox *mbx)
+{
+	int timeout = CPT_MBOX_MSG_TIMEOUT;
+	int sleep = 10;
+
+	cptvf->pf_acked = false;
+	cptvf->pf_nacked = false;
+	cptvf_send_msg_to_pf(cptvf, mbx);
+	/* Wait for previous message to be acked, timeout 2sec */
+	while (!cptvf->pf_acked) {
+		if (cptvf->pf_nacked)
+			return -EINVAL;
+		msleep(sleep);
+		if (cptvf->pf_acked)
+			break;
+		timeout -= sleep;
+		if (!timeout) {
+			dev_err(&cptvf->pdev->dev,
+				"PF didn't ack to mbox msg %llx from VF%u\n",
+				mbx->msg, cptvf->vfid);
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Checks if VF is able to comminicate with PF
+ * and also gets the CPT number this VF is associated to.
+ */
+int otx_cptvf_check_pf_ready(struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_mbox mbx = {};
+	int ret;
+
+	mbx.msg = OTX_CPT_MSG_READY;
+	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
+
+	return ret;
+}
+
+/*
+ * Communicate VQs size to PF to program CPT(0)_PF_Q(0-15)_CTL of the VF.
+ * Must be ACKed.
+ */
+int otx_cptvf_send_vq_size_msg(struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_mbox mbx = {};
+	int ret;
+
+	mbx.msg = OTX_CPT_MSG_QLEN;
+	mbx.data = cptvf->qsize;
+	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
+
+	return ret;
+}
+
+/*
+ * Communicate VF group required to PF and get the VQ binded to that group
+ */
+int otx_cptvf_send_vf_to_grp_msg(struct otx_cptvf *cptvf, int group)
+{
+	struct otx_cpt_mbox mbx = {};
+	int ret;
+
+	mbx.msg = OTX_CPT_MSG_QBIND_GRP;
+	/* Convey group of the VF */
+	mbx.data = group;
+	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
+	if (ret)
+		return ret;
+	cptvf->vfgrp = group;
+
+	return 0;
+}
+
+/*
+ * Communicate VF group required to PF and get the VQ binded to that group
+ */
+int otx_cptvf_send_vf_priority_msg(struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_mbox mbx = {};
+	int ret;
+
+	mbx.msg = OTX_CPT_MSG_VQ_PRIORITY;
+	/* Convey group of the VF */
+	mbx.data = cptvf->priority;
+	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
+
+	return ret;
+}
+
+/*
+ * Communicate to PF that VF is UP and running
+ */
+int otx_cptvf_send_vf_up(struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_mbox mbx = {};
+	int ret;
+
+	mbx.msg = OTX_CPT_MSG_VF_UP;
+	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
+
+	return ret;
+}
+
+/*
+ * Communicate to PF that VF is DOWN and running
+ */
+int otx_cptvf_send_vf_down(struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_mbox mbx = {};
+	int ret;
+
+	mbx.msg = OTX_CPT_MSG_VF_DOWN;
+	ret = cptvf_send_msg_to_pf_timeout(cptvf, &mbx);
+
+	return ret;
+}
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
new file mode 100644
index 0000000..df839b8
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
@@ -0,0 +1,612 @@
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
+#include "otx_cptvf.h"
+#include "otx_cptvf_algs.h"
+
+/* Completion code size and initial value */
+#define COMPLETION_CODE_SIZE	8
+#define COMPLETION_CODE_INIT	0
+
+/* SG list header size in bytes */
+#define SG_LIST_HDR_SIZE	8
+
+/* Default timeout when waiting for free pending entry in us */
+#define CPT_PENTRY_TIMEOUT	1000
+#define CPT_PENTRY_STEP		50
+
+/* Default threshold for stopping and resuming sender requests */
+#define CPT_IQ_STOP_MARGIN	128
+#define CPT_IQ_RESUME_MARGIN	512
+
+#define CPT_DMA_ALIGN		128
+
+void otx_cpt_dump_sg_list(struct pci_dev *pdev, struct otx_cpt_req_info *req)
+{
+	int i;
+
+	pr_debug("Gather list size %d\n", req->incnt);
+	for (i = 0; i < req->incnt; i++) {
+		pr_debug("Buffer %d size %d, vptr 0x%p, dmaptr 0x%p\n", i,
+			 req->in[i].size, req->in[i].vptr,
+			 (void *) req->in[i].dma_addr);
+		pr_debug("Buffer hexdump (%d bytes)\n",
+			 req->in[i].size);
+		print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1,
+				     req->in[i].vptr, req->in[i].size, false);
+	}
+
+	pr_debug("Scatter list size %d\n", req->outcnt);
+	for (i = 0; i < req->outcnt; i++) {
+		pr_debug("Buffer %d size %d, vptr 0x%p, dmaptr 0x%p\n", i,
+			 req->out[i].size, req->out[i].vptr,
+			 (void *) req->out[i].dma_addr);
+		pr_debug("Buffer hexdump (%d bytes)\n", req->out[i].size);
+		print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1,
+				     req->out[i].vptr, req->out[i].size, false);
+	}
+}
+
+static inline struct otx_cpt_pending_entry *get_free_pending_entry(
+						struct otx_cpt_pending_queue *q,
+						int qlen)
+{
+	struct otx_cpt_pending_entry *ent = NULL;
+
+	ent = &q->head[q->rear];
+	if (unlikely(ent->busy))
+		return NULL;
+
+	q->rear++;
+	if (unlikely(q->rear == qlen))
+		q->rear = 0;
+
+	return ent;
+}
+
+static inline u32 modulo_inc(u32 index, u32 length, u32 inc)
+{
+	if (WARN_ON(inc > length))
+		inc = length;
+
+	index += inc;
+	if (unlikely(index >= length))
+		index -= length;
+
+	return index;
+}
+
+static inline void free_pentry(struct otx_cpt_pending_entry *pentry)
+{
+	pentry->completion_addr = NULL;
+	pentry->info = NULL;
+	pentry->callback = NULL;
+	pentry->areq = NULL;
+	pentry->resume_sender = false;
+	pentry->busy = false;
+}
+
+static inline int setup_sgio_components(struct pci_dev *pdev,
+					struct otx_cpt_buf_ptr *list,
+					int buf_count, u8 *buffer)
+{
+	struct otx_cpt_sglist_component *sg_ptr = NULL;
+	int ret = 0, i, j;
+	int components;
+
+	if (unlikely(!list)) {
+		dev_err(&pdev->dev, "Input list pointer is NULL\n");
+		return -EFAULT;
+	}
+
+	for (i = 0; i < buf_count; i++) {
+		if (likely(list[i].vptr)) {
+			list[i].dma_addr = dma_map_single(&pdev->dev,
+							  list[i].vptr,
+							  list[i].size,
+							  DMA_BIDIRECTIONAL);
+			if (unlikely(dma_mapping_error(&pdev->dev,
+						       list[i].dma_addr))) {
+				dev_err(&pdev->dev, "Dma mapping failed\n");
+				ret = -EIO;
+				goto sg_cleanup;
+			}
+		}
+	}
+
+	components = buf_count / 4;
+	sg_ptr = (struct otx_cpt_sglist_component *)buffer;
+	for (i = 0; i < components; i++) {
+		sg_ptr->u.s.len0 = cpu_to_be16(list[i * 4 + 0].size);
+		sg_ptr->u.s.len1 = cpu_to_be16(list[i * 4 + 1].size);
+		sg_ptr->u.s.len2 = cpu_to_be16(list[i * 4 + 2].size);
+		sg_ptr->u.s.len3 = cpu_to_be16(list[i * 4 + 3].size);
+		sg_ptr->ptr0 = cpu_to_be64(list[i * 4 + 0].dma_addr);
+		sg_ptr->ptr1 = cpu_to_be64(list[i * 4 + 1].dma_addr);
+		sg_ptr->ptr2 = cpu_to_be64(list[i * 4 + 2].dma_addr);
+		sg_ptr->ptr3 = cpu_to_be64(list[i * 4 + 3].dma_addr);
+		sg_ptr++;
+	}
+	components = buf_count % 4;
+
+	switch (components) {
+	case 3:
+		sg_ptr->u.s.len2 = cpu_to_be16(list[i * 4 + 2].size);
+		sg_ptr->ptr2 = cpu_to_be64(list[i * 4 + 2].dma_addr);
+		/* Fall through */
+	case 2:
+		sg_ptr->u.s.len1 = cpu_to_be16(list[i * 4 + 1].size);
+		sg_ptr->ptr1 = cpu_to_be64(list[i * 4 + 1].dma_addr);
+		/* Fall through */
+	case 1:
+		sg_ptr->u.s.len0 = cpu_to_be16(list[i * 4 + 0].size);
+		sg_ptr->ptr0 = cpu_to_be64(list[i * 4 + 0].dma_addr);
+		break;
+	default:
+		break;
+	}
+	return ret;
+
+sg_cleanup:
+	for (j = 0; j < i; j++) {
+		if (list[j].dma_addr) {
+			dma_unmap_single(&pdev->dev, list[i].dma_addr,
+					 list[i].size, DMA_BIDIRECTIONAL);
+		}
+
+		list[j].dma_addr = 0;
+	}
+	return ret;
+}
+
+static inline int setup_sgio_list(struct pci_dev *pdev,
+				  struct otx_cpt_info_buffer **pinfo,
+				  struct otx_cpt_req_info *req, gfp_t gfp)
+{
+	u32 dlen, align_dlen, info_len, rlen;
+	struct otx_cpt_info_buffer *info;
+	u16 g_sz_bytes, s_sz_bytes;
+	int align = CPT_DMA_ALIGN;
+	u32 total_mem_len;
+
+	if (unlikely(req->incnt > OTX_CPT_MAX_SG_IN_CNT ||
+		     req->outcnt > OTX_CPT_MAX_SG_OUT_CNT)) {
+		dev_err(&pdev->dev, "Error too many sg components\n");
+		return -EINVAL;
+	}
+
+	g_sz_bytes = ((req->incnt + 3) / 4) *
+		      sizeof(struct otx_cpt_sglist_component);
+	s_sz_bytes = ((req->outcnt + 3) / 4) *
+		      sizeof(struct otx_cpt_sglist_component);
+
+	dlen = g_sz_bytes + s_sz_bytes + SG_LIST_HDR_SIZE;
+	align_dlen = ALIGN(dlen, align);
+	info_len = ALIGN(sizeof(*info), align);
+	rlen = ALIGN(sizeof(union otx_cpt_res_s), align);
+	total_mem_len = align_dlen + info_len + rlen + COMPLETION_CODE_SIZE;
+
+	info = kzalloc(total_mem_len, gfp);
+	if (unlikely(!info)) {
+		dev_err(&pdev->dev, "Memory allocation failed\n");
+		return -ENOMEM;
+	}
+	*pinfo = info;
+	info->dlen = dlen;
+	info->in_buffer = (u8 *)info + info_len;
+
+	((u16 *)info->in_buffer)[0] = req->outcnt;
+	((u16 *)info->in_buffer)[1] = req->incnt;
+	((u16 *)info->in_buffer)[2] = 0;
+	((u16 *)info->in_buffer)[3] = 0;
+	*(u64 *)info->in_buffer = cpu_to_be64p((u64 *)info->in_buffer);
+
+	/* Setup gather (input) components */
+	if (setup_sgio_components(pdev, req->in, req->incnt,
+				  &info->in_buffer[8])) {
+		dev_err(&pdev->dev, "Failed to setup gather list\n");
+		return -EFAULT;
+	}
+
+	if (setup_sgio_components(pdev, req->out, req->outcnt,
+				  &info->in_buffer[8 + g_sz_bytes])) {
+		dev_err(&pdev->dev, "Failed to setup scatter list\n");
+		return -EFAULT;
+	}
+
+	info->dma_len = total_mem_len - info_len;
+	info->dptr_baddr = dma_map_single(&pdev->dev, (void *)info->in_buffer,
+					  info->dma_len, DMA_BIDIRECTIONAL);
+	if (unlikely(dma_mapping_error(&pdev->dev, info->dptr_baddr))) {
+		dev_err(&pdev->dev, "DMA Mapping failed for cpt req\n");
+		return -EIO;
+	}
+	/*
+	 * Get buffer for union otx_cpt_res_s response
+	 * structure and its physical address
+	 */
+	info->completion_addr = (u64 *)(info->in_buffer + align_dlen);
+	info->comp_baddr = info->dptr_baddr + align_dlen;
+
+	/* Create and initialize RPTR */
+	info->out_buffer = (u8 *)info->completion_addr + rlen;
+	info->rptr_baddr = info->comp_baddr + rlen;
+
+	*((u64 *) info->out_buffer) = ~((u64) COMPLETION_CODE_INIT);
+
+	return 0;
+}
+
+
+static void cpt_fill_inst(union otx_cpt_inst_s *inst,
+			  struct otx_cpt_info_buffer *info,
+			  struct otx_cpt_iq_cmd *cmd)
+{
+	inst->u[0] = 0x0;
+	inst->s.doneint = true;
+	inst->s.res_addr = (u64)info->comp_baddr;
+	inst->u[2] = 0x0;
+	inst->s.wq_ptr = 0;
+	inst->s.ei0 = cmd->cmd.u64;
+	inst->s.ei1 = cmd->dptr;
+	inst->s.ei2 = cmd->rptr;
+	inst->s.ei3 = cmd->cptr.u64;
+}
+
+/*
+ * On OcteonTX platform the parameter db_count is used as a count for ringing
+ * door bell. The valid values for db_count are:
+ * 0 - 1 CPT instruction will be enqueued however CPT will not be informed
+ * 1 - 1 CPT instruction will be enqueued and CPT will be informed
+ */
+static void cpt_send_cmd(union otx_cpt_inst_s *cptinst, struct otx_cptvf *cptvf)
+{
+	struct otx_cpt_cmd_qinfo *qinfo = &cptvf->cqinfo;
+	struct otx_cpt_cmd_queue *queue;
+	struct otx_cpt_cmd_chunk *curr;
+	u8 *ent;
+
+	queue = &qinfo->queue[0];
+	/*
+	 * cpt_send_cmd is currently called only from critical section
+	 * therefore no locking is required for accessing instruction queue
+	 */
+	ent = &queue->qhead->head[queue->idx * OTX_CPT_INST_SIZE];
+	memcpy(ent, (void *) cptinst, OTX_CPT_INST_SIZE);
+
+	if (++queue->idx >= queue->qhead->size / 64) {
+		curr = queue->qhead;
+
+		if (list_is_last(&curr->nextchunk, &queue->chead))
+			queue->qhead = queue->base;
+		else
+			queue->qhead = list_next_entry(queue->qhead, nextchunk);
+		queue->idx = 0;
+	}
+	/* make sure all memory stores are done before ringing doorbell */
+	smp_wmb();
+	otx_cptvf_write_vq_doorbell(cptvf, 1);
+}
+
+static int process_request(struct pci_dev *pdev, struct otx_cpt_req_info *req,
+			   struct otx_cpt_pending_queue *pqueue,
+			   struct otx_cptvf *cptvf)
+{
+	struct otx_cptvf_request *cpt_req = &req->req;
+	struct otx_cpt_pending_entry *pentry = NULL;
+	union otx_cpt_ctrl_info *ctrl = &req->ctrl;
+	struct otx_cpt_info_buffer *info = NULL;
+	union otx_cpt_res_s *result = NULL;
+	struct otx_cpt_iq_cmd iq_cmd;
+	union otx_cpt_inst_s cptinst;
+	int retry, ret = 0;
+	u8 resume_sender;
+	gfp_t gfp;
+
+	gfp = (req->areq->flags & CRYPTO_TFM_REQ_MAY_SLEEP) ? GFP_KERNEL :
+							      GFP_ATOMIC;
+	ret = setup_sgio_list(pdev, &info, req, gfp);
+	if (unlikely(ret)) {
+		dev_err(&pdev->dev, "Setting up SG list failed");
+		goto request_cleanup;
+	}
+	cpt_req->dlen = info->dlen;
+
+	result = (union otx_cpt_res_s *) info->completion_addr;
+	result->s.compcode = COMPLETION_CODE_INIT;
+
+	spin_lock_bh(&pqueue->lock);
+	pentry = get_free_pending_entry(pqueue, pqueue->qlen);
+	retry = CPT_PENTRY_TIMEOUT / CPT_PENTRY_STEP;
+	while (unlikely(!pentry) && retry--) {
+		spin_unlock_bh(&pqueue->lock);
+		udelay(CPT_PENTRY_STEP);
+		spin_lock_bh(&pqueue->lock);
+		pentry = get_free_pending_entry(pqueue, pqueue->qlen);
+	}
+
+	if (unlikely(!pentry)) {
+		ret = -ENOSPC;
+		spin_unlock_bh(&pqueue->lock);
+		goto request_cleanup;
+	}
+
+	/*
+	 * Check if we are close to filling in entire pending queue,
+	 * if so then tell the sender to stop/sleep by returning -EBUSY
+	 * We do it only for context which can sleep (GFP_KERNEL)
+	 */
+	if (gfp == GFP_KERNEL &&
+	    pqueue->pending_count > (pqueue->qlen - CPT_IQ_STOP_MARGIN)) {
+		pentry->resume_sender = true;
+	} else
+		pentry->resume_sender = false;
+	resume_sender = pentry->resume_sender;
+	pqueue->pending_count++;
+
+	pentry->completion_addr = info->completion_addr;
+	pentry->info = info;
+	pentry->callback = req->callback;
+	pentry->areq = req->areq;
+	pentry->busy = true;
+	info->pentry = pentry;
+	info->time_in = jiffies;
+	info->req = req;
+
+	/* Fill in the command */
+	iq_cmd.cmd.u64 = 0;
+	iq_cmd.cmd.s.opcode = cpu_to_be16(cpt_req->opcode.flags);
+	iq_cmd.cmd.s.param1 = cpu_to_be16(cpt_req->param1);
+	iq_cmd.cmd.s.param2 = cpu_to_be16(cpt_req->param2);
+	iq_cmd.cmd.s.dlen   = cpu_to_be16(cpt_req->dlen);
+
+	/* 64-bit swap for microcode data reads, not needed for addresses*/
+	iq_cmd.cmd.u64 = cpu_to_be64(iq_cmd.cmd.u64);
+	iq_cmd.dptr = info->dptr_baddr;
+	iq_cmd.rptr = info->rptr_baddr;
+	iq_cmd.cptr.u64 = 0;
+	iq_cmd.cptr.s.grp = ctrl->s.grp;
+
+	/* Fill in the CPT_INST_S type command for HW interpretation */
+	cpt_fill_inst(&cptinst, info, &iq_cmd);
+
+	/* Print debug info if enabled */
+	otx_cpt_dump_sg_list(pdev, req);
+	pr_debug("Cpt_inst_s hexdump (%d bytes)\n", OTX_CPT_INST_SIZE);
+	print_hex_dump_debug("", 0, 16, 1, &cptinst, OTX_CPT_INST_SIZE, false);
+	pr_debug("Dptr hexdump (%d bytes)\n", cpt_req->dlen);
+	print_hex_dump_debug("", 0, 16, 1, info->in_buffer,
+			     cpt_req->dlen, false);
+
+	/* Send CPT command */
+	cpt_send_cmd(&cptinst, cptvf);
+
+	/*
+	 * We allocate and prepare pending queue entry in critical section
+	 * together with submitting CPT instruction to CPT instruction queue
+	 * to make sure that order of CPT requests is the same in both
+	 * pending and instruction queues
+	 */
+	spin_unlock_bh(&pqueue->lock);
+
+	ret = resume_sender ? -EBUSY : -EINPROGRESS;
+	return ret;
+
+request_cleanup:
+	do_request_cleanup(pdev, info);
+	return ret;
+}
+
+int otx_cpt_do_request(struct pci_dev *pdev, struct otx_cpt_req_info *req,
+		       int cpu_num)
+{
+	struct otx_cptvf *cptvf = pci_get_drvdata(pdev);
+
+	if (!otx_cpt_device_ready(cptvf)) {
+		dev_err(&pdev->dev, "CPT Device is not ready");
+		return -ENODEV;
+	}
+
+	if ((cptvf->vftype == OTX_CPT_SE_TYPES) && (!req->ctrl.s.se_req)) {
+		dev_err(&pdev->dev, "CPTVF-%d of SE TYPE got AE request",
+			cptvf->vfid);
+		return -EINVAL;
+	} else if ((cptvf->vftype == OTX_CPT_AE_TYPES) &&
+		   (req->ctrl.s.se_req)) {
+		dev_err(&pdev->dev, "CPTVF-%d of AE TYPE got SE request",
+			cptvf->vfid);
+		return -EINVAL;
+	}
+
+	return process_request(pdev, req, &cptvf->pqinfo.queue[0], cptvf);
+}
+
+static int cpt_process_ccode(struct pci_dev *pdev,
+			     union otx_cpt_res_s *cpt_status,
+			     struct otx_cpt_info_buffer *cpt_info,
+			     struct otx_cpt_req_info *req, u32 *res_code)
+{
+	u8 ccode = cpt_status->s.compcode;
+	union otx_cpt_error_code ecode;
+
+	ecode.u = be64_to_cpu(*((u64 *) cpt_info->out_buffer));
+	switch (ccode) {
+	case CPT_COMP_E_FAULT:
+		dev_err(&pdev->dev,
+			"Request failed with DMA fault\n");
+		otx_cpt_dump_sg_list(pdev, req);
+		break;
+
+	case CPT_COMP_E_SWERR:
+		dev_err(&pdev->dev,
+			"Request failed with software error code %d\n",
+			ecode.s.ccode);
+		otx_cpt_dump_sg_list(pdev, req);
+		break;
+
+	case CPT_COMP_E_HWERR:
+		dev_err(&pdev->dev,
+			"Request failed with hardware error\n");
+		otx_cpt_dump_sg_list(pdev, req);
+		break;
+
+	case COMPLETION_CODE_INIT:
+		/* check for timeout */
+		if (time_after_eq(jiffies, cpt_info->time_in +
+				  OTX_CPT_COMMAND_TIMEOUT * HZ))
+			dev_warn(&pdev->dev, "Request timed out 0x%p", req);
+		else if (cpt_info->extra_time < OTX_CPT_TIME_IN_RESET_COUNT) {
+			cpt_info->time_in = jiffies;
+			cpt_info->extra_time++;
+		}
+		return 1;
+
+	case CPT_COMP_E_GOOD:
+		/* Check microcode completion code */
+		if (ecode.s.ccode) {
+			/*
+			 * If requested hmac is truncated and ucode returns
+			 * s/g write length error then we report success
+			 * because ucode writes as many bytes of calculated
+			 * hmac as available in gather buffer and reports
+			 * s/g write length error if number of bytes in gather
+			 * buffer is less than full hmac size.
+			 */
+			if (req->is_trunc_hmac &&
+			    ecode.s.ccode == ERR_SCATTER_GATHER_WRITE_LENGTH) {
+				*res_code = 0;
+				break;
+			}
+
+			dev_err(&pdev->dev,
+				"Request failed with software error code 0x%x\n",
+				ecode.s.ccode);
+			otx_cpt_dump_sg_list(pdev, req);
+			break;
+		}
+
+		/* Request has been processed with success */
+		*res_code = 0;
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Request returned invalid status\n");
+		break;
+	}
+
+	return 0;
+}
+
+static inline void process_pending_queue(struct pci_dev *pdev,
+					 struct otx_cpt_pending_queue *pqueue)
+{
+	void (*callback)(int status, void *arg1, void *arg2);
+	struct otx_cpt_pending_entry *resume_pentry = NULL;
+	struct otx_cpt_pending_entry *pentry = NULL;
+	struct otx_cpt_info_buffer *cpt_info = NULL;
+	union otx_cpt_res_s *cpt_status = NULL;
+	struct otx_cpt_req_info *req = NULL;
+	struct crypto_async_request *areq;
+	u32 res_code, resume_index;
+
+	while (1) {
+		spin_lock_bh(&pqueue->lock);
+		pentry = &pqueue->head[pqueue->front];
+
+		if (WARN_ON(!pentry)) {
+			spin_unlock_bh(&pqueue->lock);
+			break;
+		}
+
+		res_code = -EINVAL;
+		if (unlikely(!pentry->busy)) {
+			spin_unlock_bh(&pqueue->lock);
+			break;
+		}
+
+		if (unlikely(!pentry->callback)) {
+			dev_err(&pdev->dev, "Callback NULL\n");
+			goto process_pentry;
+		}
+
+		cpt_info = pentry->info;
+		if (unlikely(!cpt_info)) {
+			dev_err(&pdev->dev, "Pending entry post arg NULL\n");
+			goto process_pentry;
+		}
+
+		req = cpt_info->req;
+		if (unlikely(!req)) {
+			dev_err(&pdev->dev, "Request NULL\n");
+			goto process_pentry;
+		}
+
+		cpt_status = (union otx_cpt_res_s *) pentry->completion_addr;
+		if (unlikely(!cpt_status)) {
+			dev_err(&pdev->dev, "Completion address NULL\n");
+			goto process_pentry;
+		}
+
+		if (cpt_process_ccode(pdev, cpt_status, cpt_info, req,
+				      &res_code)) {
+			spin_unlock_bh(&pqueue->lock);
+			return;
+		}
+		cpt_info->pdev = pdev;
+
+process_pentry:
+		/*
+		 * Check if we should inform sending side to resume
+		 * We do it CPT_IQ_RESUME_MARGIN elements in advance before
+		 * pending queue becomes empty
+		 */
+		resume_index = modulo_inc(pqueue->front, pqueue->qlen,
+					  CPT_IQ_RESUME_MARGIN);
+		resume_pentry = &pqueue->head[resume_index];
+		if (resume_pentry &&
+		    resume_pentry->resume_sender) {
+			resume_pentry->resume_sender = false;
+			callback = resume_pentry->callback;
+			areq = resume_pentry->areq;
+
+			if (callback) {
+				spin_unlock_bh(&pqueue->lock);
+
+				/*
+				 * EINPROGRESS is an indication for sending
+				 * side that it can resume sending requests
+				 */
+				callback(-EINPROGRESS, areq, cpt_info);
+				spin_lock_bh(&pqueue->lock);
+			}
+		}
+
+		callback = pentry->callback;
+		areq = pentry->areq;
+		free_pentry(pentry);
+
+		pqueue->pending_count--;
+		pqueue->front = modulo_inc(pqueue->front, pqueue->qlen, 1);
+		spin_unlock_bh(&pqueue->lock);
+
+		/*
+		 * Call callback after current pending entry has been
+		 * processed, we don't do it if the callback pointer is
+		 * invalid.
+		 */
+		if (callback)
+			callback(res_code, areq, cpt_info);
+	}
+}
+
+void otx_cpt_post_process(struct otx_cptvf_wqe *wqe)
+{
+	process_pending_queue(wqe->cptvf->pdev, &wqe->cptvf->pqinfo.queue[0]);
+}
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h
new file mode 100644
index 0000000..a4c9ff7
--- /dev/null
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.h
@@ -0,0 +1,227 @@
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
+#ifndef __OTX_CPTVF_REQUEST_MANAGER_H
+#define __OTX_CPTVF_REQUEST_MANAGER_H
+
+#include <linux/types.h>
+#include <linux/crypto.h>
+#include <linux/pci.h>
+#include "otx_cpt_hw_types.h"
+
+/*
+ * Maximum total number of SG buffers is 100, we divide it equally
+ * between input and output
+ */
+#define OTX_CPT_MAX_SG_IN_CNT		50
+#define OTX_CPT_MAX_SG_OUT_CNT		50
+
+/* DMA mode direct or SG */
+#define OTX_CPT_DMA_DIRECT_DIRECT	0
+#define OTX_CPT_DMA_GATHER_SCATTER	1
+
+/* Context source CPTR or DPTR */
+#define OTX_CPT_FROM_CPTR		0
+#define OTX_CPT_FROM_DPTR		1
+
+/* CPT instruction queue alignment */
+#define OTX_CPT_INST_Q_ALIGNMENT	128
+#define OTX_CPT_MAX_REQ_SIZE		65535
+
+/* Default command timeout in seconds */
+#define OTX_CPT_COMMAND_TIMEOUT		4
+#define OTX_CPT_TIMER_HOLD		0x03F
+#define OTX_CPT_COUNT_HOLD		32
+#define OTX_CPT_TIME_IN_RESET_COUNT     5
+
+/* Minimum and maximum values for interrupt coalescing */
+#define OTX_CPT_COALESC_MIN_TIME_WAIT	0x0
+#define OTX_CPT_COALESC_MAX_TIME_WAIT	((1<<16)-1)
+#define OTX_CPT_COALESC_MIN_NUM_WAIT	0x0
+#define OTX_CPT_COALESC_MAX_NUM_WAIT	((1<<20)-1)
+
+union otx_cpt_opcode_info {
+	u16 flags;
+	struct {
+		u8 major;
+		u8 minor;
+	} s;
+};
+
+struct otx_cptvf_request {
+	u32 param1;
+	u32 param2;
+	u16 dlen;
+	union otx_cpt_opcode_info opcode;
+};
+
+struct otx_cpt_buf_ptr {
+	u8 *vptr;
+	dma_addr_t dma_addr;
+	u16 size;
+};
+
+union otx_cpt_ctrl_info {
+	u32 flags;
+	struct {
+#if defined(__BIG_ENDIAN_BITFIELD)
+		u32 reserved0:26;
+		u32 grp:3;	/* Group bits */
+		u32 dma_mode:2;	/* DMA mode */
+		u32 se_req:1;	/* To SE core */
+#else
+		u32 se_req:1;	/* To SE core */
+		u32 dma_mode:2;	/* DMA mode */
+		u32 grp:3;	/* Group bits */
+		u32 reserved0:26;
+#endif
+	} s;
+};
+
+/*
+ * CPT_INST_S software command definitions
+ * Words EI (0-3)
+ */
+union otx_cpt_iq_cmd_word0 {
+	u64 u64;
+	struct {
+		u16 opcode;
+		u16 param1;
+		u16 param2;
+		u16 dlen;
+	} s;
+};
+
+union otx_cpt_iq_cmd_word3 {
+	u64 u64;
+	struct {
+#if defined(__BIG_ENDIAN_BITFIELD)
+		u64 grp:3;
+		u64 cptr:61;
+#else
+		u64 cptr:61;
+		u64 grp:3;
+#endif
+	} s;
+};
+
+struct otx_cpt_iq_cmd {
+	union otx_cpt_iq_cmd_word0 cmd;
+	u64 dptr;
+	u64 rptr;
+	union otx_cpt_iq_cmd_word3 cptr;
+};
+
+struct otx_cpt_sglist_component {
+	union {
+		u64 len;
+		struct {
+			u16 len0;
+			u16 len1;
+			u16 len2;
+			u16 len3;
+		} s;
+	} u;
+	u64 ptr0;
+	u64 ptr1;
+	u64 ptr2;
+	u64 ptr3;
+};
+
+struct otx_cpt_pending_entry {
+	u64 *completion_addr;	/* Completion address */
+	struct otx_cpt_info_buffer *info;
+	/* Kernel async request callback */
+	void (*callback)(int status, void *arg1, void *arg2);
+	struct crypto_async_request *areq; /* Async request callback arg */
+	u8 resume_sender;	/* Notify sender to resume sending requests */
+	u8 busy;		/* Entry status (free/busy) */
+};
+
+struct otx_cpt_pending_queue {
+	struct otx_cpt_pending_entry *head;	/* Head of the queue */
+	u32 front;			/* Process work from here */
+	u32 rear;			/* Append new work here */
+	u32 pending_count;		/* Pending requests count */
+	u32 qlen;			/* Queue length */
+	spinlock_t lock;		/* Queue lock */
+};
+
+struct otx_cpt_req_info {
+	/* Kernel async request callback */
+	void (*callback)(int status, void *arg1, void *arg2);
+	struct crypto_async_request *areq; /* Async request callback arg */
+	struct otx_cptvf_request req;/* Request information (core specific) */
+	union otx_cpt_ctrl_info ctrl;/* User control information */
+	struct otx_cpt_buf_ptr in[OTX_CPT_MAX_SG_IN_CNT];
+	struct otx_cpt_buf_ptr out[OTX_CPT_MAX_SG_OUT_CNT];
+	u8 *iv_out;     /* IV to send back */
+	u16 rlen;	/* Output length */
+	u8 incnt;	/* Number of input buffers */
+	u8 outcnt;	/* Number of output buffers */
+	u8 req_type;	/* Type of request */
+	u8 is_enc;	/* Is a request an encryption request */
+	u8 is_trunc_hmac;/* Is truncated hmac used */
+};
+
+struct otx_cpt_info_buffer {
+	struct otx_cpt_pending_entry *pentry;
+	struct otx_cpt_req_info *req;
+	struct pci_dev *pdev;
+	u64 *completion_addr;
+	u8 *out_buffer;
+	u8 *in_buffer;
+	dma_addr_t dptr_baddr;
+	dma_addr_t rptr_baddr;
+	dma_addr_t comp_baddr;
+	unsigned long time_in;
+	u32 dlen;
+	u32 dma_len;
+	u8 extra_time;
+};
+
+static inline void do_request_cleanup(struct pci_dev *pdev,
+				      struct otx_cpt_info_buffer *info)
+{
+	struct otx_cpt_req_info *req;
+	int i;
+
+	if (info->dptr_baddr)
+		dma_unmap_single(&pdev->dev, info->dptr_baddr,
+				 info->dma_len, DMA_BIDIRECTIONAL);
+
+	if (info->req) {
+		req = info->req;
+		for (i = 0; i < req->outcnt; i++) {
+			if (req->out[i].dma_addr)
+				dma_unmap_single(&pdev->dev,
+						 req->out[i].dma_addr,
+						 req->out[i].size,
+						 DMA_BIDIRECTIONAL);
+		}
+
+		for (i = 0; i < req->incnt; i++) {
+			if (req->in[i].dma_addr)
+				dma_unmap_single(&pdev->dev,
+						 req->in[i].dma_addr,
+						 req->in[i].size,
+						 DMA_BIDIRECTIONAL);
+		}
+	}
+	kzfree(info);
+}
+
+struct otx_cptvf_wqe;
+void otx_cpt_dump_sg_list(struct pci_dev *pdev, struct otx_cpt_req_info *req);
+void otx_cpt_post_process(struct otx_cptvf_wqe *wqe);
+int otx_cpt_do_request(struct pci_dev *pdev, struct otx_cpt_req_info *req,
+		       int cpu_num);
+
+#endif /* __OTX_CPTVF_REQUEST_MANAGER_H */
-- 
1.9.1


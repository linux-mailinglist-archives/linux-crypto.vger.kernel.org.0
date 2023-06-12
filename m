Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83472B6B5
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Jun 2023 06:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjFLEm4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Jun 2023 00:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjFLEmg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Jun 2023 00:42:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D00E73;
        Sun, 11 Jun 2023 21:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBI1Lr52kik5DoVeEFjZnJnBcDtWobBQ6DHqA4I8RwXWyZRzY7eAUKN9EnjZECq3dFE4H89zJQ5YyvDpWmYmlm93vhUhlE2D5m0KUhBCdEqL+MG3HSwrGkmIgkWCXqgOjM1g6efA5Ul7nZcu/CwfHPCDkJoO0By/64/B4TftHTgPMpBTkmZUEhfPx91SC3uB2xkWiwvMgmrJnppgZz69q+aKka8QUWvkx5lAgJ3PzAPB0gVkWrHM55SaWjvAUEeOhHanrZyajkYpRqQKaTsY+fMsESXL3+NbZPTVKGKR5ziG2YdCBIt5udvQlb5J7i9XW4lFpsvqRpmrdUhApoGAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAfVn+Tp6NOaS7IR660oZK9mdnFT1BxHWZYI0Sm7SxM=;
 b=XCHF/bgKSHNCz4Uq+uDQnaAJsCJQlzm4D9baX+OtAOeKC46JeU7JYQe+citZEwY0Kv0bFCdlZH/qn2tNv97MrmLqVRtL6TFbm5GUHpOiEg5cWioxIKA44s9mwHHTSL9YxbwosD3C0BAvf2oMlyxEr4wBmGrmS9uZwR+EsVQH6NNSlkRHP6QEKTN4FqW6lXN0UTTnIUTtWNexoNA7cxx3AeQzYQ+eEsgnoKwEHYCkTGf0CFtSWd1G8Yu+TQ49kaclRwWboLWeFkRFeHDPkyYCYv2mmi9/aL3MvbP4F5uF9DlLWROwKh8wDm8dJJ/yTdGte6xXZsyIpq4EvsCvmQ2fCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAfVn+Tp6NOaS7IR660oZK9mdnFT1BxHWZYI0Sm7SxM=;
 b=BWWaeu2DQBVs4nicVo2LONo40leKI6SHM09ffbZ9fcbL62f1arEfB2vrnc5SkrtlYHUugnUB0JAxHr8/pqR7E5FTTCKcO+mvjfGuY2+52lmNqgW35obzJrRnGHtaWcGv2OyOEI00ESUzlRSXFJfkBfhe083OZy1VsYP+sRtgzO8=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 04:41:39 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::db) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 04:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 04:41:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 11 Jun
 2023 23:41:37 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-crypto@vger.kernel.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <jroedel@suse.de>, <thomas.lendacky@amd.com>,
        <hpa@zytor.com>, <ardb@kernel.org>, <pbonzini@redhat.com>,
        <seanjc@google.com>, <vkuznets@redhat.com>, <jmattson@google.com>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>, <slp@redhat.com>,
        <pgonda@google.com>, <peterz@infradead.org>,
        <srinivas.pandruvada@linux.intel.com>, <rientjes@google.com>,
        <dovmurik@linux.ibm.com>, <tobin@ibm.com>, <bp@alien8.de>,
        <vbabka@suse.cz>, <kirill@shutemov.name>, <ak@linux.intel.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <alpergun@google.com>, <dgilbert@redhat.com>, <jarkko@kernel.org>,
        <ashish.kalra@amd.com>, <nikunj.dadhania@amd.com>,
        <liam.merwick@oracle.com>, <zhi.a.wang@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH RFC v9 32/51] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_UPDATE command
Date:   Sun, 11 Jun 2023 23:25:40 -0500
Message-ID: <20230612042559.375660-33-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230612042559.375660-1-michael.roth@amd.com>
References: <20230612042559.375660-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2609bb-3086-457e-c1cb-08db6aff4ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeXH5NnRpjhKUb+uvMr3z4QnLoj1z7oAd9Zkjk6leQXQK1I1bxHuPR8BuE+Y5xSmvq/CkD0RbKRZILGZ+DUtyYgh3tHogCYKnSgXWBcijrg5w7Na2Gqer5whDZunyBTP4ENlVUZAvZYUScqCoikVA3lGpB26iCy2w51UHBxFuc8OMcXOLGGRI2+J9296SCbQ0/8rg94sZ6NvqJfgy4SWziEgUHFaq26rkldGYTVnaSvIOGhe9qdOSMHad8RRf9wFdLowPFHe/6os1Xz53ni7PKdUe+pIJhpkIBjTKYnos0abNsCVe/3Di+tmPyLhrO3DF4y6FcGWvaCs1GW/B/DndRfwIMD9LcY5G417RRvLm4NIytYUp+GY/9NJOrOskAoH+X7VULSzaQFq4dLs396huAEr5XHPSgCwk8low7k8s7LqL9Lv86lK4mbdVyJlwkKB5Xa0Sh50XD+AIPoL1GLpCSeolcWwyPOP0gESUtkhJhzqfikJvRGDRRnB2vhm3QpJHvo6hBZT5LL2n3E6OWD/7oyiV2KArOaIFA507xwfaBMqOmZGlkvGoboKyd2F/Wx7OROPNT8nATRPB4WfGCbHkLh+kps4FDOZHDTMWgKZ/pBs9iyxjB1FDVZrZUdy78mRv1B3ntYSi0GxThtJjktjRh2sH9qt2feSJGnwmDaOF0GmsoiChBKFhQlcMU5jgyt6EmJKrqnzWNhcAYMnHGoIlTAkTeUoLZfMPLYzM777NkOVTPggAW7eIfl8Ebut5FyUIxvthIgEhpjlpYNsn5Kb/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(478600001)(426003)(36860700001)(1076003)(26005)(83380400001)(2616005)(336012)(47076005)(40480700001)(6666004)(2906002)(40460700003)(8676002)(4326008)(316002)(8936002)(86362001)(41300700001)(82310400005)(356005)(82740400003)(70586007)(81166007)(36756003)(44832011)(7406005)(54906003)(7416002)(6916009)(70206006)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 04:41:39.2402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2609bb-3086-457e-c1cb-08db6aff4ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

The KVM_SEV_SNP_LAUNCH_UPDATE command can be used to insert data into the
guest's memory. The data is encrypted with the cryptographic context
created with the KVM_SEV_SNP_LAUNCH_START.

In addition to the inserting data, it can insert a two special pages
into the guests memory: the secrets page and the CPUID page.

While terminating the guest, reclaim the guest pages added in the RMP
table. If the reclaim fails, then the page is no longer safe to be
released back to the system and leak them.

For more information see the SEV-SNP specification.

Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 .../virt/kvm/x86/amd-memory-encryption.rst    |  28 +++
 arch/x86/kvm/svm/sev.c                        | 189 ++++++++++++++++++
 include/uapi/linux/kvm.h                      |  19 ++
 3 files changed, 236 insertions(+)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index 3293e86f9b8a..d8492af09796 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -485,6 +485,34 @@ Returns: 0 on success, -negative on error
 
 See the SEV-SNP specification for further detail on the launch input.
 
+20. KVM_SNP_LAUNCH_UPDATE
+-------------------------
+
+The KVM_SNP_LAUNCH_UPDATE is used for encrypting a memory region. It also
+calculates a measurement of the memory contents. The measurement is a signature
+of the memory contents that can be sent to the guest owner as an attestation
+that the memory was encrypted correctly by the firmware.
+
+Parameters (in): struct  kvm_snp_launch_update
+
+Returns: 0 on success, -negative on error
+
+::
+
+        struct kvm_sev_snp_launch_update {
+                __u64 start_gfn;        /* Guest page number to start from. */
+                __u64 uaddr;            /* userspace address need to be encrypted */
+                __u32 len;              /* length of memory region */
+                __u8 imi_page;          /* 1 if memory is part of the IMI */
+                __u8 page_type;         /* page type */
+                __u8 vmpl3_perms;       /* VMPL3 permission mask */
+                __u8 vmpl2_perms;       /* VMPL2 permission mask */
+                __u8 vmpl1_perms;       /* VMPL1 permission mask */
+        };
+
+See the SEV-SNP spec for further details on how to build the VMPL permission
+mask and page type.
+
 References
 ==========
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e65f3be67c23..6a82767d940f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -234,6 +234,36 @@ static void sev_decommission(unsigned int handle)
 	sev_guest_decommission(&decommission, NULL);
 }
 
+static int snp_page_reclaim(u64 pfn)
+{
+	struct sev_data_snp_page_reclaim data = {0};
+	int err, rc;
+
+	data.paddr = __sme_set(pfn << PAGE_SHIFT);
+	rc = sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, &data, &err);
+	if (rc) {
+		/*
+		 * If the reclaim failed, then page is no longer safe
+		 * to use.
+		 */
+		snp_leak_pages(pfn, 1);
+	}
+
+	return rc;
+}
+
+static int host_rmp_make_shared(u64 pfn, enum pg_level level, bool leak)
+{
+	int rc;
+
+	rc = rmp_make_shared(pfn, level);
+	if (rc && leak)
+		snp_leak_pages(pfn,
+			       page_level_size(level) >> PAGE_SHIFT);
+
+	return rc;
+}
+
 static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 {
 	struct sev_data_deactivate deactivate;
@@ -1953,6 +1983,162 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return rc;
 }
 
+static int snp_launch_update_gfn_handler(struct kvm *kvm,
+					 struct kvm_gfn_range *range,
+					 void *opaque)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct kvm_memory_slot *memslot = range->slot;
+	struct sev_data_snp_launch_update data = {0};
+	struct kvm_sev_snp_launch_update params;
+	struct kvm_sev_cmd *argp = opaque;
+	int *error = &argp->error;
+	int i, n = 0, ret = 0;
+	unsigned long npages;
+	kvm_pfn_t *pfns;
+	gfn_t gfn;
+
+	if (!kvm_slot_can_be_private(memslot)) {
+		pr_err("SEV-SNP requires restricted memory.\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params))) {
+		pr_err("Failed to copy user parameters for SEV-SNP launch.\n");
+		return -EFAULT;
+	}
+
+	data.gctx_paddr = __psp_pa(sev->snp_context);
+
+	npages = range->end - range->start;
+	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL_ACCOUNT);
+	if (!pfns)
+		return -ENOMEM;
+
+	pr_debug("%s: GFN range 0x%llx-0x%llx, type %d\n", __func__,
+		 range->start, range->end, params.page_type);
+
+	for (gfn = range->start, i = 0; gfn < range->end; gfn++, i++) {
+		int order, level;
+		bool assigned;
+		void *kvaddr;
+
+		ret = kvm_gmem_get_pfn(kvm, memslot, gfn, &pfns[i], &order);
+		if (ret)
+			goto e_release;
+
+		n++;
+		ret = snp_lookup_rmpentry((u64)pfns[i], &assigned, &level);
+		if (ret || assigned) {
+			pr_err("Failed to ensure GFN 0x%llx is in initial shared state, ret: %d, assigned: %d\n",
+			       gfn, ret, assigned);
+			return -EFAULT;
+		}
+
+		kvaddr = pfn_to_kaddr(pfns[i]);
+		if (!virt_addr_valid(kvaddr)) {
+			pr_err("Invalid HVA 0x%llx for GFN 0x%llx\n", (uint64_t)kvaddr, gfn);
+			ret = -EINVAL;
+			goto e_release;
+		}
+
+		ret = kvm_read_guest_page(kvm, gfn, kvaddr, 0, PAGE_SIZE);
+		if (ret) {
+			pr_err("Guest read failed, ret: 0x%x\n", ret);
+			goto e_release;
+		}
+
+		ret = rmp_make_private(pfns[i], gfn << PAGE_SHIFT, PG_LEVEL_4K,
+				       sev_get_asid(kvm), true);
+		if (ret) {
+			ret = -EFAULT;
+			goto e_release;
+		}
+
+		data.address = __sme_set(pfns[i] << PAGE_SHIFT);
+		data.page_size = X86_TO_RMP_PG_LEVEL(PG_LEVEL_4K);
+		data.page_type = params.page_type;
+		data.vmpl3_perms = params.vmpl3_perms;
+		data.vmpl2_perms = params.vmpl2_perms;
+		data.vmpl1_perms = params.vmpl1_perms;
+		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
+				      &data, error);
+		if (ret) {
+			pr_err("SEV-SNP launch update failed, ret: 0x%x, fw_error: 0x%x\n",
+			       ret, *error);
+			snp_page_reclaim(pfns[i]);
+
+			/*
+			 * When invalid CPUID function entries are detected, the firmware
+			 * corrects these entries for debugging purpose and leaves the
+			 * page unencrypted so it can be provided users for debugging
+			 * and error-reporting.
+			 *
+			 * Copy the corrected CPUID page back to shared memory so
+			 * userpsace can retrieve this information.
+			 */
+			if (params.page_type == SNP_PAGE_TYPE_CPUID &&
+			    *error == SEV_RET_INVALID_PARAM) {
+				int ret;
+
+				host_rmp_make_shared(pfns[i], PG_LEVEL_4K, true);
+
+				ret = kvm_write_guest_page(kvm, gfn, kvaddr, 0, PAGE_SIZE);
+				if (ret)
+					pr_err("Failed to write CPUID page back to userspace, ret: 0x%x\n",
+					       ret);
+			}
+
+			goto e_release;
+		}
+	}
+
+	/*
+	 * Memory attribute updates via KVM_SET_MEMORY_ATTRIBUTES are serialized
+	 * via kvm->slots_lock, so use the same protocol for updating them here.
+	 */
+	mutex_lock(&kvm->slots_lock);
+	kvm_vm_set_region_attr(kvm, range->start, range->end, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	mutex_unlock(&kvm->slots_lock);
+
+e_release:
+	/* Content of memory is updated, mark pages dirty */
+	for (i = 0; i < n; i++) {
+		set_page_dirty(pfn_to_page(pfns[i]));
+		mark_page_accessed(pfn_to_page(pfns[i]));
+
+		/*
+		 * If its an error, then update RMP entry to change page ownership
+		 * to the hypervisor.
+		 */
+		if (ret)
+			host_rmp_make_shared(pfns[i], PG_LEVEL_4K, true);
+
+		put_page(pfn_to_page(pfns[i]));
+	}
+
+	kvfree(pfns);
+	return ret;
+}
+
+static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct kvm_sev_snp_launch_update params;
+
+	if (!sev_snp_guest(kvm))
+		return -ENOTTY;
+
+	if (!sev->snp_context)
+		return -EINVAL;
+
+	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+		return -EFAULT;
+
+	return kvm_vm_do_hva_range_op(kvm, params.uaddr, params.uaddr + params.len,
+				      snp_launch_update_gfn_handler, argp);
+}
+
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -2046,6 +2232,9 @@ int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_SNP_LAUNCH_START:
 		r = snp_launch_start(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SNP_LAUNCH_UPDATE:
+		r = snp_launch_update(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b4c7ac9710d3..4961d2e67a4b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1929,6 +1929,7 @@ enum sev_cmd_id {
 	/* SNP specific commands */
 	KVM_SEV_SNP_INIT,
 	KVM_SEV_SNP_LAUNCH_START,
+	KVM_SEV_SNP_LAUNCH_UPDATE,
 
 	KVM_SEV_NR_MAX,
 };
@@ -2045,6 +2046,24 @@ struct kvm_sev_snp_launch_start {
 	__u8 pad[6];
 };
 
+#define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
+#define KVM_SEV_SNP_PAGE_TYPE_VMSA		0x2
+#define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
+#define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
+#define KVM_SEV_SNP_PAGE_TYPE_SECRETS		0x5
+#define KVM_SEV_SNP_PAGE_TYPE_CPUID		0x6
+
+struct kvm_sev_snp_launch_update {
+	__u64 start_gfn;
+	__u64 uaddr;
+	__u32 len;
+	__u8 imi_page;
+	__u8 page_type;
+	__u8 vmpl3_perms;
+	__u8 vmpl2_perms;
+	__u8 vmpl1_perms;
+};
+
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
 #define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-- 
2.25.1


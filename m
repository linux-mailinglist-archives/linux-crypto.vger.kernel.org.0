Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E767869D328
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Feb 2023 19:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjBTStZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Feb 2023 13:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjBTStE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Feb 2023 13:49:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D2621944;
        Mon, 20 Feb 2023 10:48:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCgkGt85boMT7aHGqRRaG1j1g8PLMiR15H3Ft5raJJLZmdGJ/0Q/bxof3/cwvM6Kb5iZ8IS6JyW0LsWuWscXxBpqJ9tmOUv3/NGTXNmDe/gEdpBzR7KMH8MLjJgHkipbnEzxwz0aI9jBVGbWNIZxf9xHvJ9c8VhMe49CtAkbN9Go1B9EQY0qzuK14iTe0uUzBbf4+arQQayss7JHbbjvKDvk8dhyAmmyA2maeAptqKeWHAxNy9kNfMxHgiSGXwuomfUlZPGculf3r7ZLw8wkM7b4lOJAtuEIVievccfszyTXv9qXu04BYYaaHTHDIyf98edsQB4LeL5vYs+oZ5sVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNuCOPLhGkj2ZKgj57cn7yE9zrZbhXJooEIkMA/0dAg=;
 b=D/3JFmrKOha6yeax2HQo40aeGLvijcgYxk8TPm5Zs76Apdz15ZxQnzE7mACXsf5jfZ5fvHc4FLBI7r3WkrygC9zo23gal8EbNqm4nR1z2XNrxK6rbsCo83IPbxFtctih5opQF9B4MP6AaRhmDO/69gg1Pi5C7SV6Xsi5ToSF54sNfCqvUHWgWmBdMLBd9wkpmCee74tN+kCJH8TqtKjXUXnzxPHxXWLbUvGjK6e+vGIRfkjArKU3uGxI0Kq7yvxoQzUPZ9wONu3OvVWhRwwoj4IJwIlCF56OzmYb9XNoZpw4ARv6fV0OaDZMgmmRn3qbROt2QTaAG76SQCdMgLLPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNuCOPLhGkj2ZKgj57cn7yE9zrZbhXJooEIkMA/0dAg=;
 b=stz3a7EeDrJFKy4BmGS1X6ZzV4I06l2ySO0mD9FSSOfBGqPefAMX8h3zLrx9KtdR7md0bB5OtjEGCJnMjuwCH5K+veGAVIIYlJCa+YO0S3v6wQQrM1R+JrOECB8rzaIUqH4MlaEfFrAfSrvE0mUb6OiP3reQByhz7shYZNBTHv8=
Received: from CY5PR15CA0042.namprd15.prod.outlook.com (2603:10b6:930:1b::26)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 18:48:05 +0000
Received: from CY4PEPF0000C966.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::8a) by CY5PR15CA0042.outlook.office365.com
 (2603:10b6:930:1b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19 via Frontend
 Transport; Mon, 20 Feb 2023 18:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C966.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 18:48:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 12:48:04 -0600
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
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH RFC v8 21/56] crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP
Date:   Mon, 20 Feb 2023 12:38:12 -0600
Message-ID: <20230220183847.59159-22-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220183847.59159-1-michael.roth@amd.com>
References: <20230220183847.59159-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C966:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 3160cc51-63cb-460d-9fb3-08db137300a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYBdY8dJcrj1z9kWqdJYQMKD08Ij0lqrf3QFEoL+/9ijmeRT94pIchIXo1d+InQyP5cyS6N/KuvglvkhN924lUPZU18pJt6UXy+mTUaXP+W5CrdvnQ+9JKcOzeCHt95FTdf9ItzBplpsdiWqp9FdEdRHE57lPTa/pf1s6YW0oEDOy9tJ9SY2XhImOxdrdFiSRq3e12RYpbhsIjHN4OnXhF/PoZ+B8L7Csowq/mdi0eIpJ2ImVuhYz1EWZ3c5rj/rsbkRgzvSCm/gBQkiTNeNDouycm6YNO951V8e9DTIpqBdgWJnsgjdCoNCuD5bsopPEtiwud99ftXyjZe1oBfZSFmkLSTddyaY3JKSpBwYKa7Ir5TCMAViTPF8NKzVmVofktwQOlmNdNE8ExGTvHBSS80QJ9feAGum2eBC/KCrQANCIb854+g6BclqRu8VvlrBtzPBPJDPDsMA6BcOld3AxtSbjcumxBlypV7K+ZlAY7jqtT3gt3LeZ0CsFXIKM89qpS0/JqlD55yYE5Qm7K0RC/NKv4reOnek92hf32JvMSEZ+B+uIHuu27YbBDX2w6gorgDRRREwf72JJ1xqfougHtsZuWjKRKROii5QcUbIDsUmyqpNsYjTPIq0E3HirI2d0h5Yuz1zR5N56V9vIJ4/vkMrrG0J4AXZX1ZkKA/7Ti2L28bBvfqJRnEMwjeucgijikbODa03VN1vh9gzucTe9TpBARQhCN90SVKsStkwFn6mqLsAFKkPU45gBxqThTJ6jJ28e7rDaRKEv5I+vFvSSWBGa3Z3gsO80ZANkLmette112kGJVVszZTWCZKmgR3Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(478600001)(6666004)(16526019)(83380400001)(6916009)(36756003)(70206006)(70586007)(8676002)(8936002)(26005)(40480700001)(316002)(2616005)(41300700001)(1076003)(186003)(4326008)(336012)(40460700003)(426003)(47076005)(356005)(54906003)(86362001)(5660300002)(2906002)(36860700001)(81166007)(82310400005)(82740400003)(7416002)(44832011)(30864003)(7406005)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 18:48:05.5024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3160cc51-63cb-460d-9fb3-08db137300a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C966.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

Before SNP VMs can be launched, the platform must be appropriately
configured and initialized. Platform initialization is accomplished via
the SNP_INIT command. Make sure to do a WBINVD and issue DF_FLUSH
command to prepare for the first SNP guest launch after INIT.

During the execution of SNP_INIT command, the firmware configures
and enables SNP security policy enforcement in many system components.
Some system components write to regions of memory reserved by early
x86 firmware (e.g. UEFI). Other system components write to regions
provided by the operation system, hypervisor, or x86 firmware.
Such system components can only write to HV-fixed pages or Default
pages. They will error when attempting to write to other page states
after SNP_INIT enables their SNP enforcement.

Starting in SNP firmware v1.52, the SNP_INIT_EX command takes a list of
system physical address ranges to convert into the HV-fixed page states
during the RMP initialization. If INIT_RMP is 1, hypervisors should
provide all system physical address ranges that the hypervisor will
never assign to a guest until the next RMP re-initialization.
For instance, the memory that UEFI reserves should be included in the
range list. This allows system components that occasionally write to
memory (e.g. logging to UEFI reserved regions) to not fail due to
RMP initialization and SNP enablement.

Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 225 +++++++++++++++++++++++++++++++++++
 drivers/crypto/ccp/sev-dev.h |   2 +
 include/linux/psp-sev.h      |  17 +++
 3 files changed, 244 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9d84720a41d7..af20420bd6c2 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -26,6 +26,7 @@
 #include <linux/fs_struct.h>
 
 #include <asm/smp.h>
+#include <asm/e820/types.h>
 
 #include "psp-dev.h"
 #include "sev-dev.h"
@@ -34,6 +35,10 @@
 #define SEV_FW_FILE		"amd/sev.fw"
 #define SEV_FW_NAME_SIZE	64
 
+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_MIN_API_MAJOR	1
+#define SNP_MIN_API_MINOR	51
+
 static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
 
@@ -76,6 +81,13 @@ static void *sev_es_tmr;
 #define NV_LENGTH (32 * 1024)
 static void *sev_init_ex_buffer;
 
+/*
+ * SEV_DATA_RANGE_LIST:
+ *   Array containing range of pages that firmware transitions to HV-fixed
+ *   page state.
+ */
+struct sev_data_range_list *snp_range_list;
+
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -830,6 +842,186 @@ static int sev_update_firmware(struct device *dev)
 	return ret;
 }
 
+static void snp_set_hsave_pa(void *arg)
+{
+	wrmsrl(MSR_VM_HSAVE_PA, 0);
+}
+
+static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
+{
+	struct sev_data_range_list *range_list = arg;
+	struct sev_data_range *range = &range_list->ranges[range_list->num_elements];
+	size_t size;
+
+	if ((range_list->num_elements * sizeof(struct sev_data_range) +
+	     sizeof(struct sev_data_range_list)) > PAGE_SIZE)
+		return -E2BIG;
+
+	switch (rs->desc) {
+	case E820_TYPE_RESERVED:
+	case E820_TYPE_PMEM:
+	case E820_TYPE_ACPI:
+		range->base = rs->start & PAGE_MASK;
+		size = (rs->end + 1) - rs->start;
+		range->page_count = size >> PAGE_SHIFT;
+		range_list->num_elements++;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int __sev_snp_init_locked(int *error)
+{
+	struct psp_device *psp = psp_master;
+	struct sev_data_snp_init_ex data;
+	struct sev_device *sev;
+	int rc = 0;
+
+	if (!psp || !psp->sev_data)
+		return -ENODEV;
+
+	sev = psp->sev_data;
+
+	if (sev->snp_initialized)
+		return 0;
+
+	/*
+	 * The SNP_INIT requires the MSR_VM_HSAVE_PA must be set to 0h
+	 * across all cores.
+	 */
+	on_each_cpu(snp_set_hsave_pa, NULL, 1);
+
+	/*
+	 * Starting in SNP firmware v1.52, the SNP_INIT_EX command takes a list of
+	 * system physical address ranges to convert into the HV-fixed page states
+	 * during the RMP initialization.  For instance, the memory that UEFI
+	 * reserves should be included in the range list. This allows system
+	 * components that occasionally write to memory (e.g. logging to UEFI
+	 * reserved regions) to not fail due to RMP initialization and SNP enablement.
+	 */
+	if (sev_version_greater_or_equal(SNP_MIN_API_MAJOR, 52)) {
+		/*
+		 * Firmware checks that the pages containing the ranges enumerated
+		 * in the RANGES structure are either in the Default page state or in the
+		 * firmware page state.
+		 */
+		snp_range_list = sev_fw_alloc(PAGE_SIZE);
+		if (!snp_range_list) {
+			dev_err(sev->dev,
+				"SEV: SNP_INIT_EX range list memory allocation failed\n");
+			return -ENOMEM;
+		}
+
+		memset(snp_range_list, 0, PAGE_SIZE);
+
+		/*
+		 * Retrieve all reserved memory regions setup by UEFI from the e820 memory map
+		 * to be setup as HV-fixed pages.
+		 */
+
+		rc = walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, 0, ~0,
+					 snp_range_list, snp_filter_reserved_mem_regions);
+		if (rc) {
+			dev_err(sev->dev,
+				"SEV: SNP_INIT_EX walk_iomem_res_desc failed rc = %d\n", rc);
+			return rc;
+		}
+
+		memset(&data, 0, sizeof(data));
+		data.init_rmp = 1;
+		data.list_paddr_en = 1;
+		data.list_paddr = __pa(snp_range_list);
+
+		rc = __sev_do_cmd_locked(SEV_CMD_SNP_INIT_EX, &data, error);
+		if (rc)
+			return rc;
+	} else {
+		rc = __sev_do_cmd_locked(SEV_CMD_SNP_INIT, NULL, error);
+		if (rc)
+			return rc;
+	}
+
+	/* Prepare for first SNP guest launch after INIT */
+	wbinvd_on_all_cpus();
+	rc = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, error);
+	if (rc)
+		return rc;
+
+	sev->snp_initialized = true;
+	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
+
+	return rc;
+}
+
+int sev_snp_init(int *error, bool init_on_probe)
+{
+	int rc;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return -ENODEV;
+
+	if (init_on_probe && !psp_init_on_probe)
+		return 0;
+
+	mutex_lock(&sev_cmd_mutex);
+	rc = __sev_snp_init_locked(error);
+	mutex_unlock(&sev_cmd_mutex);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(sev_snp_init);
+
+static int __sev_snp_shutdown_locked(int *error)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_data_snp_shutdown_ex data;
+	int ret;
+
+	if (!sev->snp_initialized)
+		return 0;
+
+	memset(&data, 0, sizeof(data));
+	data.length = sizeof(data);
+	data.iommu_snp_shutdown = 1;
+
+	wbinvd_on_all_cpus();
+
+retry:
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN_EX, &data, error);
+	/* SHUTDOWN may require DF_FLUSH */
+	if (*error == SEV_RET_DFFLUSH_REQUIRED) {
+		ret = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, NULL);
+		if (ret) {
+			dev_err(sev->dev, "SEV-SNP DF_FLUSH failed\n");
+			return ret;
+		}
+		goto retry;
+	}
+	if (ret) {
+		dev_err(sev->dev, "SEV-SNP firmware shutdown failed\n");
+		return ret;
+	}
+
+	sev->snp_initialized = false;
+	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
+
+	return ret;
+}
+
+static int sev_snp_shutdown(int *error)
+{
+	int rc;
+
+	mutex_lock(&sev_cmd_mutex);
+	rc = __sev_snp_shutdown_locked(error);
+	mutex_unlock(&sev_cmd_mutex);
+
+	return rc;
+}
+
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -1270,6 +1462,8 @@ int sev_dev_init(struct psp_device *psp)
 
 static void sev_firmware_shutdown(struct sev_device *sev)
 {
+	int error;
+
 	sev_platform_shutdown(NULL);
 
 	if (sev_es_tmr) {
@@ -1286,6 +1480,14 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 			   get_order(NV_LENGTH));
 		sev_init_ex_buffer = NULL;
 	}
+
+	if (snp_range_list) {
+		free_pages((unsigned long)snp_range_list,
+			   get_order(PAGE_SIZE));
+		snp_range_list = NULL;
+	}
+
+	sev_snp_shutdown(&error);
 }
 
 void sev_dev_destroy(struct psp_device *psp)
@@ -1341,6 +1543,26 @@ void sev_pci_init(void)
 		}
 	}
 
+	/*
+	 * If boot CPU supports SNP, then first attempt to initialize
+	 * the SNP firmware.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP)) {
+		if (!sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR)) {
+			dev_err(sev->dev, "SEV-SNP support requires firmware version >= %d:%d\n",
+				SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
+		} else {
+			rc = sev_snp_init(&error, true);
+			if (rc) {
+				/*
+				 * Don't abort the probe if SNP INIT failed,
+				 * continue to initialize the legacy SEV firmware.
+				 */
+				dev_err(sev->dev, "SEV-SNP: failed to INIT error %#x\n", error);
+			}
+		}
+	}
+
 	/* Obtain the TMR memory area for SEV-ES use */
 	sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
 	if (!sev_es_tmr)
@@ -1356,6 +1578,9 @@ void sev_pci_init(void)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			error, rc);
 
+	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
+		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
+
 	return;
 
 err:
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 666c21eb81ab..34767657beb5 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -52,6 +52,8 @@ struct sev_device {
 	u8 build;
 
 	void *cmd_buf;
+
+	bool snp_initialized;
 };
 
 int sev_dev_init(struct psp_device *psp);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 31b045e1926f..8cfe92e82743 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -794,6 +794,21 @@ struct sev_data_snp_shutdown_ex {
  */
 int sev_platform_init(int *error);
 
+/**
+ * sev_snp_init - perform SEV SNP_INIT command
+ *
+ * @error: SEV command return code
+ * @init_on_probe: indicates if called during module probe/init
+ *
+ * Returns:
+ * 0 if the SEV successfully processed the command
+ * -%ENODEV    if the SEV device is not available
+ * -%ENOTSUPP  if the SEV does not support SEV
+ * -%ETIMEDOUT if the SEV command timed out
+ * -%EIO       if the SEV returned a non-zero return code
+ */
+int sev_snp_init(int *error, bool init_on_probe);
+
 /**
  * sev_platform_status - perform SEV PLATFORM_STATUS command
  *
@@ -901,6 +916,8 @@ sev_platform_status(struct sev_user_data_status *status, int *error) { return -E
 
 static inline int sev_platform_init(int *error) { return -ENODEV; }
 
+static inline int sev_snp_init(int *error, bool init_on_probe) { return -ENODEV; }
+
 static inline int
 sev_guest_deactivate(struct sev_data_deactivate *data, int *error) { return -ENODEV; }
 
-- 
2.25.1


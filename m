Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645E73FE163
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Sep 2021 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbhIARv1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Sep 2021 13:51:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:64268 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347421AbhIARuy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Sep 2021 13:50:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="304397953"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="304397953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="499022310"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2021 10:49:41 -0700
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Gupta Shashank <shashank.gupta@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 1/4] crypto: qat - replace deprecated MSI API
Date:   Wed,  1 Sep 2021 18:36:05 +0100
Message-Id: <20210901173608.16777-2-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210901173608.16777-1-wojciech.ziemba@intel.com>
References: <20210901173608.16777-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Replace deprecated MSI enable and disable respectively and update
handling of return values.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Co-developed-by: Gupta Shashank <shashank.gupta@intel.com>
Signed-off-by: Gupta Shashank <shashank.gupta@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_common/adf_accel_devices.h |   1 -
 drivers/crypto/qat/qat_common/adf_isr.c       | 102 +++++++++---------
 drivers/crypto/qat/qat_common/adf_vf_isr.c    |  12 +--
 3 files changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 38c0af6d4e43..87de40d6c9a5 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -45,7 +45,6 @@ struct adf_bar {
 } __packed;
 
 struct adf_accel_msix {
-	struct msix_entry *entries;
 	char **names;
 	u32 num_entries;
 } __packed;
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index c678d5c531aa..a2ab16651a56 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -27,35 +27,26 @@ static int adf_enable_msix(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	u32 msix_num_entries = 1;
+	u32 msix_num_entries = hw_data->num_banks + 1;
+	int ret;
 
 	if (hw_data->set_msix_rttable)
 		hw_data->set_msix_rttable(accel_dev);
 
-	/* If SR-IOV is disabled, add entries for each bank */
-	if (!accel_dev->pf.vf_info) {
-		int i;
-
-		msix_num_entries += hw_data->num_banks;
-		for (i = 0; i < msix_num_entries; i++)
-			pci_dev_info->msix_entries.entries[i].entry = i;
-	} else {
-		pci_dev_info->msix_entries.entries[0].entry =
-			hw_data->num_banks;
-	}
-
-	if (pci_enable_msix_exact(pci_dev_info->pci_dev,
-				  pci_dev_info->msix_entries.entries,
-				  msix_num_entries)) {
-		dev_err(&GET_DEV(accel_dev), "Failed to enable MSI-X IRQ(s)\n");
-		return -EFAULT;
+	ret = pci_alloc_irq_vectors(pci_dev_info->pci_dev, msix_num_entries,
+				    msix_num_entries, PCI_IRQ_MSIX);
+	if (unlikely(ret < 0)) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to allocate %d MSI-X vectors\n",
+			msix_num_entries);
+		return ret;
 	}
 	return 0;
 }
 
 static void adf_disable_msix(struct adf_accel_pci *pci_dev_info)
 {
-	pci_disable_msix(pci_dev_info->pci_dev);
+	pci_free_irq_vectors(pci_dev_info->pci_dev);
 }
 
 static irqreturn_t adf_msix_isr_bundle(int irq, void *bank_ptr)
@@ -139,9 +130,9 @@ static int adf_request_irqs(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct msix_entry *msixe = pci_dev_info->msix_entries.entries;
 	struct adf_etr_data *etr_data = accel_dev->transport;
-	int ret, i = 0;
+	int clust_irq = hw_data->num_banks;
+	int ret, irq, i = 0;
 	char *name;
 
 	/* Request msix irq for all banks unless SR-IOV enabled */
@@ -153,19 +144,25 @@ static int adf_request_irqs(struct adf_accel_dev *accel_dev)
 			name = *(pci_dev_info->msix_entries.names + i);
 			snprintf(name, ADF_MAX_MSIX_VECTOR_NAME,
 				 "qat%d-bundle%d", accel_dev->accel_id, i);
-			ret = request_irq(msixe[i].vector,
-					  adf_msix_isr_bundle, 0, name, bank);
+			irq = pci_irq_vector(pci_dev_info->pci_dev, i);
+			if (unlikely(irq < 0)) {
+				dev_err(&GET_DEV(accel_dev),
+					"Failed to get IRQ number of device vector %d - %s\n",
+					i, name);
+				return irq;
+			}
+			ret = request_irq(irq, adf_msix_isr_bundle, 0,
+					  &name[0], bank);
 			if (ret) {
 				dev_err(&GET_DEV(accel_dev),
-					"failed to enable irq %d for %s\n",
-					msixe[i].vector, name);
+					"Failed to allocate IRQ %d for %s\n",
+					irq, name);
 				return ret;
 			}
 
 			cpu = ((accel_dev->accel_id * hw_data->num_banks) +
 			       i) % cpus;
-			irq_set_affinity_hint(msixe[i].vector,
-					      get_cpu_mask(cpu));
+			irq_set_affinity_hint(irq, get_cpu_mask(cpu));
 		}
 	}
 
@@ -173,11 +170,17 @@ static int adf_request_irqs(struct adf_accel_dev *accel_dev)
 	name = *(pci_dev_info->msix_entries.names + i);
 	snprintf(name, ADF_MAX_MSIX_VECTOR_NAME,
 		 "qat%d-ae-cluster", accel_dev->accel_id);
-	ret = request_irq(msixe[i].vector, adf_msix_isr_ae, 0, name, accel_dev);
+	irq = pci_irq_vector(pci_dev_info->pci_dev, clust_irq);
+	if (unlikely(irq < 0)) {
+		dev_err(&GET_DEV(accel_dev),
+			"Failed to get IRQ number of device vector %d - %s\n",
+			i, name);
+		return irq;
+	}
+	ret = request_irq(irq, adf_msix_isr_ae, 0, &name[0], accel_dev);
 	if (ret) {
 		dev_err(&GET_DEV(accel_dev),
-			"failed to enable irq %d, for %s\n",
-			msixe[i].vector, name);
+			"Failed to allocate IRQ %d for %s\n", irq, name);
 		return ret;
 	}
 	return ret;
@@ -187,25 +190,27 @@ static void adf_free_irqs(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
-	struct msix_entry *msixe = pci_dev_info->msix_entries.entries;
 	struct adf_etr_data *etr_data = accel_dev->transport;
-	int i = 0;
+	int clust_irq = hw_data->num_banks;
+	int irq, i = 0;
 
 	if (pci_dev_info->msix_entries.num_entries > 1) {
 		for (i = 0; i < hw_data->num_banks; i++) {
-			irq_set_affinity_hint(msixe[i].vector, NULL);
-			free_irq(msixe[i].vector, &etr_data->banks[i]);
+			irq = pci_irq_vector(pci_dev_info->pci_dev, i);
+			irq_set_affinity_hint(irq, NULL);
+			free_irq(irq, &etr_data->banks[i]);
 		}
 	}
-	irq_set_affinity_hint(msixe[i].vector, NULL);
-	free_irq(msixe[i].vector, accel_dev);
+
+	irq = pci_irq_vector(pci_dev_info->pci_dev, clust_irq);
+	irq_set_affinity_hint(irq, NULL);
+	free_irq(irq, accel_dev);
 }
 
-static int adf_isr_alloc_msix_entry_table(struct adf_accel_dev *accel_dev)
+static int adf_isr_alloc_msix_vectors_data(struct adf_accel_dev *accel_dev)
 {
 	int i;
 	char **names;
-	struct msix_entry *entries;
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
 	u32 msix_num_entries = 1;
 
@@ -213,39 +218,30 @@ static int adf_isr_alloc_msix_entry_table(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->pf.vf_info)
 		msix_num_entries += hw_data->num_banks;
 
-	entries = kcalloc_node(msix_num_entries, sizeof(*entries),
-			       GFP_KERNEL, dev_to_node(&GET_DEV(accel_dev)));
-	if (!entries)
-		return -ENOMEM;
-
 	names = kcalloc(msix_num_entries, sizeof(char *), GFP_KERNEL);
-	if (!names) {
-		kfree(entries);
+	if (!names)
 		return -ENOMEM;
-	}
+
 	for (i = 0; i < msix_num_entries; i++) {
 		*(names + i) = kzalloc(ADF_MAX_MSIX_VECTOR_NAME, GFP_KERNEL);
 		if (!(*(names + i)))
 			goto err;
 	}
 	accel_dev->accel_pci_dev.msix_entries.num_entries = msix_num_entries;
-	accel_dev->accel_pci_dev.msix_entries.entries = entries;
 	accel_dev->accel_pci_dev.msix_entries.names = names;
 	return 0;
 err:
 	for (i = 0; i < msix_num_entries; i++)
 		kfree(*(names + i));
-	kfree(entries);
 	kfree(names);
 	return -ENOMEM;
 }
 
-static void adf_isr_free_msix_entry_table(struct adf_accel_dev *accel_dev)
+static void adf_isr_free_msix_vectors_data(struct adf_accel_dev *accel_dev)
 {
 	char **names = accel_dev->accel_pci_dev.msix_entries.names;
 	int i;
 
-	kfree(accel_dev->accel_pci_dev.msix_entries.entries);
 	for (i = 0; i < accel_dev->accel_pci_dev.msix_entries.num_entries; i++)
 		kfree(*(names + i));
 	kfree(names);
@@ -287,7 +283,7 @@ void adf_isr_resource_free(struct adf_accel_dev *accel_dev)
 	adf_free_irqs(accel_dev);
 	adf_cleanup_bh(accel_dev);
 	adf_disable_msix(&accel_dev->accel_pci_dev);
-	adf_isr_free_msix_entry_table(accel_dev);
+	adf_isr_free_msix_vectors_data(accel_dev);
 }
 EXPORT_SYMBOL_GPL(adf_isr_resource_free);
 
@@ -303,7 +299,7 @@ int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev)
 {
 	int ret;
 
-	ret = adf_isr_alloc_msix_entry_table(accel_dev);
+	ret = adf_isr_alloc_msix_vectors_data(accel_dev);
 	if (ret)
 		goto err_out;
 
@@ -328,7 +324,7 @@ int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev)
 	adf_disable_msix(&accel_dev->accel_pci_dev);
 
 err_free_msix_table:
-	adf_isr_free_msix_entry_table(accel_dev);
+	adf_isr_free_msix_vectors_data(accel_dev);
 
 err_out:
 	return ret;
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index 7828a6573f3e..695c5050b6f3 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -53,11 +53,11 @@ EXPORT_SYMBOL_GPL(adf_disable_pf2vf_interrupts);
 static int adf_enable_msi(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
-	int stat = pci_enable_msi(pci_dev_info->pci_dev);
-
-	if (stat) {
+	int stat = pci_alloc_irq_vectors(pci_dev_info->pci_dev, 1, 1,
+					 PCI_IRQ_MSI);
+	if (unlikely(stat < 0)) {
 		dev_err(&GET_DEV(accel_dev),
-			"Failed to enable MSI interrupts\n");
+			"Failed to enable MSI interrupt: %d\n", stat);
 		return stat;
 	}
 
@@ -65,7 +65,7 @@ static int adf_enable_msi(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->vf.irq_name)
 		return -ENOMEM;
 
-	return stat;
+	return 0;
 }
 
 static void adf_disable_msi(struct adf_accel_dev *accel_dev)
@@ -73,7 +73,7 @@ static void adf_disable_msi(struct adf_accel_dev *accel_dev)
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
 
 	kfree(accel_dev->vf.irq_name);
-	pci_disable_msi(pdev);
+	pci_free_irq_vectors(pdev);
 }
 
 static void adf_dev_stop_async(struct work_struct *work)
-- 
2.29.2

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.


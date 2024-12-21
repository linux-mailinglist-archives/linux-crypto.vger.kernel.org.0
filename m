Return-Path: <linux-crypto+bounces-8684-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FED9F9EDB
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Dec 2024 07:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C135188423A
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Dec 2024 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4A1E9B22;
	Sat, 21 Dec 2024 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRY2fDmi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B81F0E55;
	Sat, 21 Dec 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734762690; cv=none; b=CYymxcXo6EV7tM4E0AOj845Gfe7e4F8glEZcjvt1uueIDrM9zbD81cC4sj96KnkyPpbsLnlTT1jmxYDfoJ429g88kE7EgP5/y8mwJjt7+Eslak2SgbJ5OnpUhRgz3gR5iMdzxkoSPhmWsaO5OxqLcoPO6AXEytt9CRNAGJJbXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734762690; c=relaxed/simple;
	bh=YlzhhM4A69VbmucsjnzFvkXVMn/NOLnMKxMNKmr2SEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/moouMU8u1xjhFhSNHLhzFayoHjXR+ba5KVoT+VqKAJ/bU8Nu6Hd8FVkrjYJ1aI6cUhM946Gi0wTsedfPJN0lM4bkyRuChJ8H7aXetQJ9ZdK1CpvKVlZPQ6FqfsIutolJoihLMCE+48pONLCil+Xz1lwk+ai27+T8afjlW81ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRY2fDmi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734762687; x=1766298687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YlzhhM4A69VbmucsjnzFvkXVMn/NOLnMKxMNKmr2SEI=;
  b=HRY2fDmig4DOX5sviv2zcyftFyPreFvvw1jly2A0VBM6qLw9GUeai7IY
   Z5AYMt+m1nLFlS7f1zFvZZKLPehFTHEJr+3gHedkVfYQ0NdW5Wn2S97Zr
   V6sx982uByqOufiT1+1FJi67rhKnSuT7DWZXHolQEcf2HvB7Wu5YfOaXO
   pf8tFlFk1CU8mMSGMrn92Pd10QLL40jtxdHAbQzq+ZJVmtO3h/fi7sntY
   hjKg+vexW2qeYKx5qhAdYhC3SkLVggJpUYhy4Ipf7fDS72+NU43RTTFgC
   MI5sR2wR5b+RUbZRuuSc648waSQFatcrLLDUjd92VlTrW8fSEkUoaU+V1
   Q==;
X-CSE-ConnectionGUID: sYeIfZ9QR2q5X7gENLjj3A==
X-CSE-MsgGUID: oaJ9gvOARTy5DI8iStQYRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35021707"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="35021707"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 22:31:20 -0800
X-CSE-ConnectionGUID: OhA+j9FoSUiywuaJWmt60g==
X-CSE-MsgGUID: U0JhRZ1FRCSHZwusjIn04g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99184603"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by orviesa007.jf.intel.com with ESMTP; 20 Dec 2024 22:31:21 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v5 09/12] crypto: iaa - Distribute compress jobs from all cores to all IAAs on a package.
Date: Fri, 20 Dec 2024 22:31:16 -0800
Message-Id: <20241221063119.29140-10-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241221063119.29140-1-kanchana.p.sridhar@intel.com>
References: <20241221063119.29140-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change enables processes running on any logical core on a package to
use all the IAA devices enabled on that package for compress jobs. In
other words, compressions originating from any process in a package will be
distributed in round-robin manner to the available IAA devices on the same
package.

The main premise behind this change is to make sure that no compress
engines on any IAA device are un-utilized/under-utilized/over-utilized.
In other words, the compress engines on all IAA devices are considered a
global resource for that package, thus maximizing compression throughput.

This allows the use of all IAA devices present in a given package for
(batched) compressions originating from zswap/zram, from all cores
on this package.

A new per-cpu "global_wq_table" implements this in the iaa_crypto driver.
We can think of the global WQ per IAA as a WQ to which all cores on
that package can submit compress jobs.

To avail of this feature, the user must configure 2 WQs per IAA in order to
enable distribution of compress jobs to multiple IAA devices.

Each IAA will have 2 WQs:
 wq.0 (local WQ):
   Used for decompress jobs from cores mapped by the cpu_to_iaa() "even
   balancing of logical cores to IAA devices" algorithm.

 wq.1 (global WQ):
   Used for compress jobs from *all* logical cores on that package.

The iaa_crypto driver will place all global WQs from all same-package IAA
devices in the global_wq_table per cpu on that package. When the driver
receives a compress job, it will lookup the "next" global WQ in the cpu's
global_wq_table to submit the descriptor.

The starting wq in the global_wq_table for each cpu is the global wq
associated with the IAA nearest to it, so that we stagger the starting
global wq for each process. This results in very uniform usage of all IAAs
for compress jobs.

Two new driver module parameters are added for this feature:

g_wqs_per_iaa (default 0):

 /sys/bus/dsa/drivers/crypto/g_wqs_per_iaa

 This represents the number of global WQs that can be configured per IAA
 device. The recommended setting is 1 to enable the use of this feature
 once the user configures 2 WQs per IAA using higher level scripts as
 described in Documentation/driver-api/crypto/iaa/iaa-crypto.rst.

g_consec_descs_per_gwq (default 1):

 /sys/bus/dsa/drivers/crypto/g_consec_descs_per_gwq

 This represents the number of consecutive compress jobs that will be
 submitted to the same global WQ (i.e. to the same IAA device) from a given
 core, before moving to the next global WQ. The default is 1, which is also
 the recommended setting to avail of this feature.

The decompress jobs from any core will be sent to the "local" IAA, namely
the one that the driver assigns with the cpu_to_iaa() mapping algorithm
that evenly balances the assignment of logical cores to IAA devices on a
package.

On a 2-package Sapphire Rapids server where each package has 56 cores and
4 IAA devices, this is how the compress/decompress jobs will be mapped
when the user configures 2 WQs per IAA device (which implies wq.1 will
be added to the global WQ table for each logical core on that package):

 package(s):        2
 package0 CPU(s):   0-55,112-167
 package1 CPU(s):   56-111,168-223

 Compress jobs:
 --------------
 package 0:
 iaa_crypto will send compress jobs from all cpus (0-55,112-167) to all IAA
 devices on the package (iax1/iax3/iax5/iax7) in round-robin manner:
 iaa:   iax1           iax3           iax5           iax7

 package 1:
 iaa_crypto will send compress jobs from all cpus (56-111,168-223) to all
 IAA devices on the package (iax9/iax11/iax13/iax15) in round-robin manner:
 iaa:   iax9           iax11          iax13           iax15

 Decompress jobs:
 ----------------
 package 0:
 cpu   0-13,112-125   14-27,126-139  28-41,140-153  42-55,154-167
 iaa:  iax1           iax3           iax5           iax7

 package 1:
 cpu   56-69,168-181  70-83,182-195  84-97,196-209   98-111,210-223
 iaa:  iax9           iax11          iax13           iax15

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |   1 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 385 ++++++++++++++++++++-
 2 files changed, 378 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 74d25e62df12..c46c70ecf355 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -91,6 +91,7 @@ struct iaa_device {
 	struct list_head		wqs;
 
 	struct wq_table_entry		*iaa_local_wqs;
+	struct wq_table_entry		*iaa_global_wqs;
 
 	atomic64_t			comp_calls;
 	atomic64_t			comp_bytes;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 418f78454875..4ca9028d6050 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -42,6 +42,18 @@ static struct crypto_comp *deflate_generic_tfm;
 /* Per-cpu lookup table for balanced wqs */
 static struct wq_table_entry __percpu *wq_table = NULL;
 
+static struct wq_table_entry **pkg_global_wq_tables = NULL;
+
+/* Per-cpu lookup table for global wqs shared by all cpus. */
+static struct wq_table_entry __percpu *global_wq_table = NULL;
+
+/*
+ * Per-cpu counter of consecutive descriptors allocated to
+ * the same wq in the global_wq_table, so that we know
+ * when to switch to the next wq in the global_wq_table.
+ */
+static int __percpu *num_consec_descs_per_wq = NULL;
+
 /* Verify results of IAA compress or not */
 static bool iaa_verify_compress = false;
 
@@ -79,6 +91,16 @@ static bool async_mode = true;
 /* Use interrupts */
 static bool use_irq;
 
+/* Number of global wqs per iaa*/
+static int g_wqs_per_iaa = 0;
+
+/*
+ * Number of consecutive descriptors to allocate from a
+ * given global wq before switching to the next wq in
+ * the global_wq_table.
+ */
+static int g_consec_descs_per_gwq = 1;
+
 static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 
 LIST_HEAD(iaa_devices);
@@ -180,6 +202,60 @@ static ssize_t sync_mode_store(struct device_driver *driver,
 }
 static DRIVER_ATTR_RW(sync_mode);
 
+static ssize_t g_wqs_per_iaa_show(struct device_driver *driver, char *buf)
+{
+	return sprintf(buf, "%d\n", g_wqs_per_iaa);
+}
+
+static ssize_t g_wqs_per_iaa_store(struct device_driver *driver,
+				   const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = kstrtoint(buf, 10, &g_wqs_per_iaa);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(g_wqs_per_iaa);
+
+static ssize_t g_consec_descs_per_gwq_show(struct device_driver *driver, char *buf)
+{
+	return sprintf(buf, "%d\n", g_consec_descs_per_gwq);
+}
+
+static ssize_t g_consec_descs_per_gwq_store(struct device_driver *driver,
+					    const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = kstrtoint(buf, 10, &g_consec_descs_per_gwq);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(g_consec_descs_per_gwq);
+
 /****************************
  * Driver compression modes.
  ****************************/
@@ -465,7 +541,7 @@ static void remove_device_compression_modes(struct iaa_device *iaa_device)
  ***********************************************************/
 static struct iaa_device *iaa_device_alloc(struct idxd_device *idxd)
 {
-	struct wq_table_entry *local;
+	struct wq_table_entry *local, *global;
 	struct iaa_device *iaa_device;
 
 	iaa_device = kzalloc(sizeof(*iaa_device), GFP_KERNEL);
@@ -488,6 +564,20 @@ static struct iaa_device *iaa_device_alloc(struct idxd_device *idxd)
 	local->max_wqs = iaa_device->idxd->max_wqs;
 	local->n_wqs = 0;
 
+	/* IAA device's global wqs. */
+	iaa_device->iaa_global_wqs = kzalloc(sizeof(struct wq_table_entry), GFP_KERNEL);
+	if (!iaa_device->iaa_global_wqs)
+		goto err;
+
+	global = iaa_device->iaa_global_wqs;
+
+	global->wqs = kzalloc(iaa_device->idxd->max_wqs * sizeof(struct wq *), GFP_KERNEL);
+	if (!global->wqs)
+		goto err;
+
+	global->max_wqs = iaa_device->idxd->max_wqs;
+	global->n_wqs = 0;
+
 	INIT_LIST_HEAD(&iaa_device->wqs);
 
 	return iaa_device;
@@ -499,6 +589,8 @@ static struct iaa_device *iaa_device_alloc(struct idxd_device *idxd)
 				kfree(iaa_device->iaa_local_wqs->wqs);
 			kfree(iaa_device->iaa_local_wqs);
 		}
+		if (iaa_device->iaa_global_wqs)
+			kfree(iaa_device->iaa_global_wqs);
 		kfree(iaa_device);
 	}
 
@@ -616,6 +708,12 @@ static void free_iaa_device(struct iaa_device *iaa_device)
 		kfree(iaa_device->iaa_local_wqs);
 	}
 
+	if (iaa_device->iaa_global_wqs) {
+		if (iaa_device->iaa_global_wqs->wqs)
+			kfree(iaa_device->iaa_global_wqs->wqs);
+		kfree(iaa_device->iaa_global_wqs);
+	}
+
 	kfree(iaa_device);
 }
 
@@ -817,6 +915,58 @@ static inline int cpu_to_iaa(int cpu)
 	return (nr_iaa - 1);
 }
 
+static void free_global_wq_table(void)
+{
+	if (global_wq_table) {
+		free_percpu(global_wq_table);
+		global_wq_table = NULL;
+	}
+
+	if (num_consec_descs_per_wq) {
+		free_percpu(num_consec_descs_per_wq);
+		num_consec_descs_per_wq = NULL;
+	}
+
+	pr_debug("freed global wq table\n");
+}
+
+static int pkg_global_wq_tables_alloc(void)
+{
+	int i, j;
+
+	pkg_global_wq_tables = kzalloc(nr_packages * sizeof(*pkg_global_wq_tables), GFP_KERNEL);
+	if (!pkg_global_wq_tables)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_packages; ++i) {
+		pkg_global_wq_tables[i] = kzalloc(sizeof(struct wq_table_entry), GFP_KERNEL);
+
+		if (!pkg_global_wq_tables[i]) {
+			for (j = 0; j < i; ++j)
+				kfree(pkg_global_wq_tables[j]);
+			kfree(pkg_global_wq_tables);
+			pkg_global_wq_tables = NULL;
+			return -ENOMEM;
+		}
+		pkg_global_wq_tables[i]->wqs = NULL;
+	}
+
+	return 0;
+}
+
+static void pkg_global_wq_tables_dealloc(void)
+{
+	int i;
+
+	for (i = 0; i < nr_packages; ++i) {
+		if (pkg_global_wq_tables[i]->wqs)
+			kfree(pkg_global_wq_tables[i]->wqs);
+		kfree(pkg_global_wq_tables[i]);
+	}
+	kfree(pkg_global_wq_tables);
+	pkg_global_wq_tables = NULL;
+}
+
 static int alloc_wq_table(int max_wqs)
 {
 	struct wq_table_entry *entry;
@@ -835,6 +985,35 @@ static int alloc_wq_table(int max_wqs)
 		entry->cur_wq = 0;
 	}
 
+	global_wq_table = alloc_percpu(struct wq_table_entry);
+	if (!global_wq_table)
+		return 0;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		entry = per_cpu_ptr(global_wq_table, cpu);
+
+		entry->wqs = NULL;
+		entry->max_wqs = max_wqs;
+		entry->n_wqs = 0;
+		entry->cur_wq = 0;
+	}
+
+	num_consec_descs_per_wq = alloc_percpu(int);
+	if (!num_consec_descs_per_wq) {
+		free_global_wq_table();
+		return 0;
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		int *num_consec_descs = per_cpu_ptr(num_consec_descs_per_wq, cpu);
+		*num_consec_descs = 0;
+	}
+
+	if (pkg_global_wq_tables_alloc()) {
+		free_global_wq_table();
+		return 0;
+	}
+
 	pr_debug("initialized wq table\n");
 
 	return 0;
@@ -895,13 +1074,120 @@ static int wq_table_add_wqs(int iaa, int cpu)
 	return ret;
 }
 
+static void pkg_global_wq_tables_reinit(void)
+{
+	int i, cur_iaa = 0, pkg = 0, nr_pkg_wqs = 0;
+	struct iaa_device *iaa_device;
+	struct wq_table_entry *global;
+
+	if (!pkg_global_wq_tables)
+		return;
+
+	/* Reallocate per-package wqs. */
+	list_for_each_entry(iaa_device, &iaa_devices, list) {
+		global = iaa_device->iaa_global_wqs;
+		nr_pkg_wqs += global->n_wqs;
+
+		if (++cur_iaa == nr_iaa_per_package) {
+			nr_pkg_wqs = nr_pkg_wqs ? max_t(int, iaa_device->idxd->max_wqs, nr_pkg_wqs) : 0;
+
+			if (pkg_global_wq_tables[pkg]->wqs) {
+				kfree(pkg_global_wq_tables[pkg]->wqs);
+				pkg_global_wq_tables[pkg]->wqs = NULL;
+			}
+
+			if (nr_pkg_wqs)
+				pkg_global_wq_tables[pkg]->wqs = kzalloc(nr_pkg_wqs *
+									 sizeof(struct wq *),
+									 GFP_KERNEL);
+
+			pkg_global_wq_tables[pkg]->n_wqs = 0;
+			pkg_global_wq_tables[pkg]->cur_wq = 0;
+			pkg_global_wq_tables[pkg]->max_wqs = nr_pkg_wqs;
+
+			if (++pkg == nr_packages)
+				break;
+			cur_iaa = 0;
+			nr_pkg_wqs = 0;
+		}
+	}
+
+	pkg = 0;
+	cur_iaa = 0;
+
+	/* Re-initialize per-package wqs. */
+	list_for_each_entry(iaa_device, &iaa_devices, list) {
+		global = iaa_device->iaa_global_wqs;
+
+		if (pkg_global_wq_tables[pkg]->wqs)
+			for (i = 0; i < global->n_wqs; ++i)
+				pkg_global_wq_tables[pkg]->wqs[pkg_global_wq_tables[pkg]->n_wqs++] = global->wqs[i];
+
+		pr_debug("pkg_global_wq_tables[%d] has %d wqs", pkg, pkg_global_wq_tables[pkg]->n_wqs);
+
+		if (++cur_iaa == nr_iaa_per_package) {
+			if (++pkg == nr_packages)
+				break;
+			cur_iaa = 0;
+		}
+	}
+}
+
+static void global_wq_table_add(int cpu, struct wq_table_entry *pkg_global_wq_table)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(global_wq_table, cpu);
+
+	/* This could be NULL. */
+	entry->wqs = pkg_global_wq_table->wqs;
+	entry->max_wqs = pkg_global_wq_table->max_wqs;
+	entry->n_wqs = pkg_global_wq_table->n_wqs;
+	entry->cur_wq = 0;
+
+	if (entry->wqs)
+		pr_debug("%s: cpu %d: added %d iaa global wqs up to wq %d.%d\n", __func__,
+			 cpu, entry->n_wqs,
+			 entry->wqs[entry->n_wqs - 1]->idxd->id,
+			 entry->wqs[entry->n_wqs - 1]->id);
+}
+
+static void global_wq_table_set_start_wq(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(global_wq_table, cpu);
+	int start_wq = g_wqs_per_iaa * (cpu_to_iaa(cpu) % nr_iaa_per_package);
+
+	if ((start_wq >= 0) && (start_wq < entry->n_wqs))
+		entry->cur_wq = start_wq;
+}
+
+static void global_wq_table_add_wqs(void)
+{
+	int cpu;
+
+	if (!pkg_global_wq_tables)
+		return;
+
+	for (cpu = 0; cpu < nr_cpus; cpu += nr_cpus_per_package) {
+		/* cpu's on the same package get the same global_wq_table. */
+		int package_id = topology_logical_package_id(cpu);
+		int pkg_cpu;
+
+		for (pkg_cpu = cpu; pkg_cpu < cpu + nr_cpus_per_package; ++pkg_cpu) {
+			if (pkg_global_wq_tables[package_id]->n_wqs > 0) {
+				global_wq_table_add(pkg_cpu, pkg_global_wq_tables[package_id]);
+				global_wq_table_set_start_wq(pkg_cpu);
+			}
+		}
+	}
+}
+
 static int map_iaa_device_wqs(struct iaa_device *iaa_device)
 {
-	struct wq_table_entry *local;
+	struct wq_table_entry *local, *global;
 	int ret = 0, n_wqs_added = 0;
 	struct iaa_wq *iaa_wq;
 
 	local = iaa_device->iaa_local_wqs;
+	global = iaa_device->iaa_global_wqs;
 
 	list_for_each_entry(iaa_wq, &iaa_device->wqs, list) {
 		if (iaa_wq->mapped && ++n_wqs_added)
@@ -909,11 +1195,18 @@ static int map_iaa_device_wqs(struct iaa_device *iaa_device)
 
 		pr_debug("iaa_device %px: processing wq %d.%d\n", iaa_device, iaa_device->idxd->id, iaa_wq->wq->id);
 
-		if (WARN_ON(local->n_wqs == local->max_wqs))
-			break;
+		if ((!n_wqs_added || ((n_wqs_added + g_wqs_per_iaa) < iaa_device->n_wq)) &&
+			(local->n_wqs < local->max_wqs)) {
+
+			local->wqs[local->n_wqs++] = iaa_wq->wq;
+			pr_debug("iaa_device %px: added local wq %d.%d\n", iaa_device, iaa_device->idxd->id, iaa_wq->wq->id);
+		} else {
+			if (WARN_ON(global->n_wqs == global->max_wqs))
+				break;
 
-		local->wqs[local->n_wqs++] = iaa_wq->wq;
-		pr_debug("iaa_device %px: added local wq %d.%d\n", iaa_device, iaa_device->idxd->id, iaa_wq->wq->id);
+			global->wqs[global->n_wqs++] = iaa_wq->wq;
+			pr_debug("iaa_device %px: added global wq %d.%d\n", iaa_device, iaa_device->idxd->id, iaa_wq->wq->id);
+		}
 
 		iaa_wq->mapped = true;
 		++n_wqs_added;
@@ -969,6 +1262,10 @@ static void rebalance_wq_table(void)
 		}
 	}
 
+	if (iaa_crypto_enabled && pkg_global_wq_tables) {
+		pkg_global_wq_tables_reinit();
+		global_wq_table_add_wqs();
+	}
 	pr_debug("Finished rebalance local wqs.");
 }
 
@@ -979,7 +1276,17 @@ static void free_wq_tables(void)
 		wq_table = NULL;
 	}
 
-	pr_debug("freed local wq table\n");
+	if (global_wq_table) {
+		free_percpu(global_wq_table);
+		global_wq_table = NULL;
+	}
+
+	if (num_consec_descs_per_wq) {
+		free_percpu(num_consec_descs_per_wq);
+		num_consec_descs_per_wq = NULL;
+	}
+
+	pr_debug("freed wq tables\n");
 }
 
 /***************************************************************
@@ -1002,6 +1309,35 @@ static struct idxd_wq *wq_table_next_wq(int cpu)
 	return entry->wqs[entry->cur_wq];
 }
 
+/*
+ * Caller should make sure to call only if the
+ * per_cpu_ptr "global_wq_table" is non-NULL
+ * and has at least one wq configured.
+ */
+static struct idxd_wq *global_wq_table_next_wq(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(global_wq_table, cpu);
+	int *num_consec_descs = per_cpu_ptr(num_consec_descs_per_wq, cpu);
+
+	/*
+	 * Fall-back to local IAA's wq if there were no global wqs configured
+	 * for any IAA device, or if there were problems in setting up global
+	 * wqs for this cpu's package.
+	 */
+	if (!entry->wqs)
+		return wq_table_next_wq(cpu);
+
+	if ((*num_consec_descs) == g_consec_descs_per_gwq) {
+		if (++entry->cur_wq >= entry->n_wqs)
+			entry->cur_wq = 0;
+		*num_consec_descs = 0;
+	}
+
+	++(*num_consec_descs);
+
+	return entry->wqs[entry->cur_wq];
+}
+
 /*************************************************
  * Core iaa_crypto compress/decompress functions.
  *************************************************/
@@ -1563,6 +1899,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct idxd_wq *wq;
 	struct device *dev;
 	int order = -1;
+	struct wq_table_entry *entry;
 
 	compression_ctx = crypto_tfm_ctx(tfm);
 
@@ -1581,8 +1918,15 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		disable_async = true;
 
 	cpu = get_cpu();
-	wq = wq_table_next_wq(cpu);
+	entry = per_cpu_ptr(global_wq_table, cpu);
+
+	if (!entry || !entry->wqs || entry->n_wqs == 0) {
+		wq = wq_table_next_wq(cpu);
+	} else {
+		wq = global_wq_table_next_wq(cpu);
+	}
 	put_cpu();
+
 	if (!wq) {
 		pr_debug("no wq configured for cpu=%d\n", cpu);
 		return -ENODEV;
@@ -2446,6 +2790,7 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 
 	if (nr_iaa == 0) {
 		iaa_crypto_enabled = false;
+		pkg_global_wq_tables_dealloc();
 		free_wq_tables();
 		BUG_ON(!list_empty(&iaa_devices));
 		INIT_LIST_HEAD(&iaa_devices);
@@ -2515,6 +2860,20 @@ static int __init iaa_crypto_init_module(void)
 		goto err_sync_attr_create;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				&driver_attr_g_wqs_per_iaa);
+	if (ret) {
+		pr_debug("IAA g_wqs_per_iaa attr creation failed\n");
+		goto err_g_wqs_per_iaa_attr_create;
+	}
+
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				&driver_attr_g_consec_descs_per_gwq);
+	if (ret) {
+		pr_debug("IAA g_consec_descs_per_gwq attr creation failed\n");
+		goto err_g_consec_descs_per_gwq_attr_create;
+	}
+
 	if (iaa_crypto_debugfs_init())
 		pr_warn("debugfs init failed, stats not available\n");
 
@@ -2522,6 +2881,12 @@ static int __init iaa_crypto_init_module(void)
 out:
 	return ret;
 
+err_g_consec_descs_per_gwq_attr_create:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_g_wqs_per_iaa);
+err_g_wqs_per_iaa_attr_create:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 err_sync_attr_create:
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
@@ -2545,6 +2910,10 @@ static void __exit iaa_crypto_cleanup_module(void)
 			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_g_wqs_per_iaa);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_g_consec_descs_per_gwq);
 	idxd_driver_unregister(&iaa_crypto_driver);
 	iaa_aecs_cleanup_fixed();
 	crypto_free_comp(deflate_generic_tfm);
-- 
2.27.0



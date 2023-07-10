Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B838474DDD6
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Jul 2023 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGJTIA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Jul 2023 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGJTHv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Jul 2023 15:07:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D91E7C;
        Mon, 10 Jul 2023 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689016038; x=1720552038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=erGYJT9w1g+IFjvIiZjE8RuY1nq8clwCJH9xFFQZD28=;
  b=Om0q4g4G3lwfYlDEKzUupWj0hICC+cyEMxCFJdeRSPMPg3BqCg4d6D96
   Fw7H6jf6LWFJyX0BTCBBNn49v0XyWV6kHiAKNqeA4GjlsDCXUbVBSgBLk
   yqfQFGk7wxACpHaqRAXqFaKg0zISb9SuBdqyPh30AzEWiLwMa9Ez5tJcV
   ACU5ei5j+vWdmK5pwX92zG0N1al8+WCQAkoPDvH6x/zmhdJg1EDalVGRt
   wvdhZ7sgSIG1D0DA+yuzxfcheyhjkTC7L6cZV4YrJ3YenB4v6LFoi+kjg
   VYJS5VQEk0NEVtAs9kqNFbOe5oYAYhamtGVb0/YHsFo87B2yH9DnEz4SE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354290795"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354290795"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844991112"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="844991112"
Received: from jdmillsx-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.107.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:15 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v7 08/14] crypto: iaa - Add IAA Compression Accelerator Documentation
Date:   Mon, 10 Jul 2023 14:06:48 -0500
Message-Id: <20230710190654.299639-9-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Because the IAA Compression Accelerator requires significant user
setup in order to be used properly, this adds documentation on the
iaa_crypto driver including setup, usage, and examples.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 .../driver-api/crypto/iaa/iaa-crypto.rst      | 645 ++++++++++++++++++
 Documentation/driver-api/crypto/iaa/index.rst |  20 +
 Documentation/driver-api/crypto/index.rst     |  20 +
 Documentation/driver-api/index.rst            |   1 +
 4 files changed, 686 insertions(+)
 create mode 100644 Documentation/driver-api/crypto/iaa/iaa-crypto.rst
 create mode 100644 Documentation/driver-api/crypto/iaa/index.rst
 create mode 100644 Documentation/driver-api/crypto/index.rst

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
new file mode 100644
index 000000000000..aa7b5fa8dbfa
--- /dev/null
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -0,0 +1,645 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+IAA Compression Accelerator Crypto Driver
+=========================================
+
+Tom Zanussi <tom.zanussi@linux.intel.com>
+
+The IAA crypto driver supports compression/decompression compatible
+with the DEFLATE compression standard described in RFC 1951, which is
+the compression/decompression algorithm exported by this module.
+
+The IAA hardware spec can be found here:
+
+  https://cdrdv2.intel.com/v1/dl/getContent/721858
+
+The iaa_crypto driver is designed to work as a layer underneath
+higher-level compression devices such as zswap.
+
+Users can select IAA compress/decompress acceleration by specifying
+one of the supported IAA compression algorithms in whatever facility
+allows compression algorithms to be selected.
+
+For example, a zswap device can select the IAA 'fixed' mode
+represented by selecting the 'deflate-iaa' crypto compression
+algorithm::
+
+  # echo deflate-iaa > /sys/module/zswap/parameters/compressor
+
+This will tell zswap to use the IAA 'fixed' compression mode for all
+compresses and decompresses.
+
+Currently, there is only one compression modes available, 'fixed'
+mode.
+
+The 'fixed' compression mode implements the compression scheme
+specified by RFC 1951 and is given the crypto algorithm name
+'deflate-iaa'.  (Because the IAA hardware has a 4k history-window
+limitation, only buffers <= 4k, or that have been compressed using a
+<= 4k history window, are technically compliant with the deflate spec,
+which allows for a window of up to 32k.  Because of this limitation,
+the IAA fixed mode deflate algorithm is given its own algorithm name
+rather than simply 'deflate').
+
+'fixed' mode can be chosen as the mode to be used for
+compression/decompression via the corresponding crypto algorithm
+name::
+
+  # echo deflate-iaa >  /sys/bus/dsa/drivers/crypto/compression_mode
+
+
+Config options and other setup
+==============================
+
+The IAA crypto driver is available via menuconfig using the following
+path::
+
+  Cryptographic API -> Hardware crypto devices -> Support for Intel(R) IAA Compression Accelerator
+
+In the configuration file the option called CONFIG_CRYPTO_DEV_IAA_CRYPTO.
+
+The IAA crypto driver also supports statistics, which are available
+via menuconfig using the following path::
+
+  Cryptographic API -> Hardware crypto devices -> Support for Intel(R) IAA Compression -> Enable Intel(R) IAA Compression Accelerator Statistics
+
+In the configuration file the option called CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS.
+
+The following config options should also be enabled::
+
+  CONFIG_IRQ_REMAP=y
+  CONFIG_INTEL_IOMMU=y
+  CONFIG_INTEL_IOMMU_SVM=y
+  CONFIG_PCI_ATS=y
+  CONFIG_PCI_PRI=y
+  CONFIG_PCI_PASID=y
+  CONFIG_INTEL_IDXD=m
+  CONFIG_INTEL_IDXD_SVM=y
+
+IAA is one of the first Intel accelerator IPs that can work in
+conjunction with the Intel IOMMU.  There are multiple modes that exist
+for testing. Based on IOMMU configuration, there are 3 modes::
+
+  - Scalable
+  - Legacy
+  - No IOMMU
+
+
+Scalable mode
+-------------
+
+Scalable mode supports Shared Virtual Memory (SVM or SVA). It is
+entered when using the kernel boot commandline::
+
+  intel_iommu=on,sm_on
+
+with VT-d turned on in BIOS.
+
+With scalable mode, both shared and dedicated workqueues are available
+for use.
+
+For scalable mode, the following BIOS settings should be enabled::
+
+  Socket Configuration > IIO Configuration > Intel VT for Directed I/O (VT-d) > Intel VT for Directed I/O
+
+  Socket Configuration > IIO Configuration > PCIe ENQCMD > ENQCMDS
+
+
+Legacy mode
+-----------
+
+Legacy mode is entered when using the kernel boot commandline::
+
+  intel_iommu=off, intel_iommu=on
+
+or VT-d is not turned on in BIOS.
+
+If you have booted into Linux and not sure if VT-d is on, do a "dmesg
+| grep -i dmar". If you don't see a number of DMAR devices enumerated,
+most likely VT-d is not on.
+
+With legacy mode, only dedicated workqueues are available for use.
+
+
+No IOMMU mode
+-------------
+
+No IOMMU mode is entered when using the kernel boot commandline::
+
+  iommu=off.
+
+With no IOMMU mode, only dedicated workqueues are available for use.
+
+
+Usage
+=====
+
+accel-config
+------------
+
+Unlike typical drivers, the iaa_crypto driver does not enable the
+device on driver load.  Due to complexity and configurability of the
+accelerator devices, it was a design decision to have the user
+configure the device and manually enable the desired devices and
+workqueues.
+
+The userspace tool to help doing that is called accel-config.  Using
+accel-config to configure device or loading a previously saved config
+is highly recommended.  The device can be controlled via sysfs
+directly but comes with the warning that do this ONLY if you know
+exactly what you are doing.  This document will not cover the sysfs
+interface but assumes you will be using accel-config.
+
+The accel-config tool along with instructions for building it can be
+found here:
+
+  https://github.com/intel/idxd-config/#readme
+
+
+Typical usage
+-------------
+
+In order for the iaa_crypto module to actually do any
+compression/decompression work on behalf of a facility, one or more
+IAA workqueues need to be bound to the iaa_crypto driver.
+
+For instance, here's an example of configuring an IAA workqueue and
+binding it to the iaa_crypto driver (note that device names are
+specified as 'iax' rather than 'iaa' - this is because upstream still
+has the old 'iax' device naming in place) ::
+
+  # configure wq1.0
+
+  accel-config config-wq --group-id=0 --mode=dedicated --type=kernel --name="iaa_crypto" --device_name="crypto" iax1/wq1.0
+
+  # enable IAA device iax1
+
+  accel-config enable-device iax1
+
+  # enable wq1.0 on IAX device iax1
+
+  accel-config enable-wq iax1/wq1.0
+
+Whenever a new workqueue is bound to or unbound from the iaa_crypto
+driver, the available workqueues are 'rebalanced' such that work
+submitted from a particular CPU is given to the most appropriate
+workqueue available.  Current best practice is to configure and bind
+at least one workqueue for each IAA device, but as long as there is at
+least one workqueue configured and bound to any IAA device in the
+system, the iaa_crypto driver will work, albeit most likely not as
+efficiently.
+
+The IAA crypto algorigthms is operational and compression and
+decompression operations are fully enabled following the successful
+binding of the first IAA workqueue to the iaa_crypto driver.
+
+Similarly, the IAA crypto algorithm is not operational and compression
+and decompression operations are disabled following the unbinding of
+the last IAA worqueue to the iaa_crypto driver.
+
+As a result, the IAA crypto algorithms and thus the IAA hardware are
+only available when one or more workques are bound to the iaa_crypto
+driver.
+
+When there are no IAA workqueues bound to the driver, the IAA crypto
+algorithms can be unregistered by removing the module.
+
+
+Driver attributes
+-----------------
+
+There are a couple user-configurable driver attributes that can be
+used to configure various modes of operation.  They're listed below,
+along with their default values.  To set any of these attributes, echo
+the appropriate values to the attribute file located under
+/sys/bus/dsa/drivers/crypto/
+
+The attribute settings at the time the IAA algorithms are registered
+are captured in each algorithm's crypto_ctx and used for all compresses
+and decompresses when using that algorithm.
+
+The available attributes are:
+
+  - verify_compress
+
+    Toggle compression verification.  If set, each compress will be
+    internally decompressed and the contents verified, returning error
+    codes if unsuccessful.  This can be toggled with 0/1::
+
+      echo 0 > /sys/bus/dsa/drivers/crypto/verify_compress
+
+    The default setting is '1' - verify all compresses.
+
+  - sync_mode
+
+    Select mode to be used to wait for completion of each compresses
+    and decompress operation.
+
+    The crypto async interface support implemented by iaa_crypto
+    provides an implementation that satisfies the interface but does
+    so in a synchronous manner - it fills and submits the IDXD
+    descriptor and then loops around waiting for it to complete before
+    returning.  This isn't a problem at the moment, since all existing
+    callers (e.g. zswap) wrap any asynchronous callees in a
+    synchronous wrapper anyway.
+
+    The iaa_crypto driver does however provide true asynchronous
+    support for callers that can make use of it.  In this mode, it
+    fills and submits the IDXD descriptor, then returns immediately
+    with -EINPROGRESS.  The caller can then either poll for completion
+    itself, which requires specific code in the caller which currently
+    nothing in the upstream kernel implements, or go to sleep and wait
+    for an interrupt signaling completion.  This latter mode is
+    supported by current users in the kernel such as zswap via
+    synchronous wrappers.  Although it is supported this mode is
+    significantly slower than the synchronous mode that does the
+    polling in the iaa_crypto driver previously mentioned.
+
+    This mode can be enabled by writing 'async_irq' to the sync_mode
+    iaa_crypto driver attribute::
+
+      echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode
+
+    Async mode without interrupts (caller must poll) can be enabled by
+    writing 'async' to it::
+
+      echo async > /sys/bus/dsa/drivers/crypto/sync_mode
+
+    The mode that does the polling in the iaa_crypto driver can be
+    enabled by writing 'sync' to it::
+
+      echo sync > /sys/bus/dsa/drivers/crypto/sync_mode
+
+    The default mode is 'sync'.
+
+
+Statistics
+==========
+
+If the optional debugfs statistics support is enabled, the IAA crypto
+driver will generate statistics which can be accessed in debugfs at::
+
+  # ls -al /sys/kernel/debug/iaa-crypto/
+  total 0
+  drwxr-xr-x  2 root root 0 Mar  3 09:35 .
+  drwx------ 47 root root 0 Mar  3 09:35 ..
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_acomp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_adecomp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_comp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 max_decomp_delay_ns
+  -rw-r--r--  1 root root 0 Mar  3 09:35 stats_reset
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_comp_bytes_out
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_comp_calls
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_decomp_bytes_in
+  -rw-r--r--  1 root root 0 Mar  3 09:35 total_decomp_calls
+  -rw-r--r--  1 root root 0 Mar  3 09:35 wq_stats
+
+Most of the above statisticss are self-explanatory.  The wq_stats file
+shows per-wq stats, a set for each iaa device and wq in addition to
+some global stats::
+
+  # cat wq_stats
+  global stats:
+    total_comp_calls: 100
+    total_decomp_calls: 100
+    total_comp_bytes_out: 22800
+    total_decomp_bytes_in: 22800
+    total_completion_einval_errors: 0
+    total_completion_timeout_errors: 0
+    total_completion_comp_buf_overflow_errors: 0
+
+  iaa device:
+    id: 1
+    n_wqs: 1
+    comp_calls: 0
+    comp_bytes: 0
+    decomp_calls: 0
+    decomp_bytes: 0
+    wqs:
+      name: iaa_crypto
+      comp_calls: 0
+      comp_bytes: 0
+      decomp_calls: 0
+      decomp_bytes: 0
+
+  iaa device:
+    id: 3
+    n_wqs: 1
+    comp_calls: 0
+    comp_bytes: 0
+    decomp_calls: 0
+    decomp_bytes: 0
+    wqs:
+      name: iaa_crypto
+      comp_calls: 0
+      comp_bytes: 0
+      decomp_calls: 0
+      decomp_bytes: 0
+
+  iaa device:
+    id: 5
+    n_wqs: 1
+    comp_calls: 100
+    comp_bytes: 22800
+    decomp_calls: 100
+    decomp_bytes: 22800
+    wqs:
+      name: iaa_crypto
+      comp_calls: 100
+      comp_bytes: 22800
+      decomp_calls: 100
+      decomp_bytes: 22800
+
+Writing 0 to 'stats_reset' resets all the stats, including the
+per-device and per-wq stats::
+
+  # echo 0 > stats_reset
+  # cat wq_stats
+    global stats:
+    total_comp_calls: 0
+    total_decomp_calls: 0
+    total_comp_bytes_out: 0
+    total_decomp_bytes_in: 0
+    total_completion_einval_errors: 0
+    total_completion_timeout_errors: 0
+    total_completion_comp_buf_overflow_errors: 0
+    ...
+
+
+Use cases
+=========
+
+Simple zswap test
+-----------------
+
+For this example, the kernel should be configured according to the
+dedicated mode options described above, and zswap should be enabled as
+well::
+
+  CONFIG_ZSWAP=y
+
+This is a simple test that uses iaa_compress as the compressor for a
+swap (zswap) device.  It sets up the zswap device and then uses the
+memory_memadvise program listed below to forcibly swap out and in a
+specified number of pages, demonstrating both compress and decompress.
+
+The zswap test expects the work queues for each IAA device on the
+system to be configured properly as a kernel workqueue with a
+workqueue driver_name of "crypto".
+
+The first step is to make sure the iaa_crypto module is loaded::
+
+  modprobe iaa_crypto
+
+Following that the IAA device(s) should be configured and enabled.
+
+The zswap test expects the work queues for each IAA device on the
+system to be configured properly as a kernel workqueue with a
+workqueue driver_name of "crypto".
+
+The below script automatically does that::
+
+  #!/bin/bash
+
+  echo "IAA devices:"
+  lspci -d:0cfe
+  echo "# IAA devices:"
+  lspci -d:0cfe | wc -l
+
+  #
+  # count iaa instances
+  #
+  iaa_dev_id="0cfe"
+  num_iaa=$(lspci -d:${iaa_dev_id} | wc -l)
+  echo "Found ${num_iaa} IAA instances"
+
+  #
+  # disable iaa wqs and devices
+  #
+  echo "Disable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo disable wq iax${i}/wq${i}.0
+      accel-config disable-wq iax${i}/wq${i}.0
+      echo disable iaa iax${i}
+      accel-config disable-device iax${i}
+  done
+
+  echo "End Disable IAA"
+
+  #
+  # configure iaa wqs and devices
+  #
+  echo "Configure IAA"
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      accel-config config-wq --group-id=0 --mode=dedicated --size=128 --priority=10 --type=kernel --name="iaa_crypto" --driver_name="crypto" iax${i}/wq${i}
+  done
+
+  echo "End Configure IAA"
+
+  #
+  # enable iaa wqs and devices
+  #
+  echo "Enable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo enable iaa iaa${i}
+      accel-config enable-device iaa${i}
+      echo enable wq iaa${i}/wq${i}.0
+      accel-config enable-wq iaa${i}/wq${i}.0
+  done
+
+  echo "End Enable IAA"
+
+When the workqueues are bound to the iaa_crypto driver, you should
+see something similar to the following in dmesg output if you've
+enabled debug output (echo -n 'module iaa_crypto +p' >
+/sys/kernel/debug/dynamic_debug/control)::
+
+  [   60.752344] idxd 0000:f6:02.0: add_iaa_wq: added wq 000000004068d14d to iaa 00000000c9585ba2, n_wq 1
+  [   60.752346] iaa_crypto: rebalance_wq_table: nr_nodes=2, nr_cpus 160, nr_iaa 8, cpus_per_iaa 20
+  [   60.752347] iaa_crypto: rebalance_wq_table: iaa=0
+  [   60.752349] idxd 0000:6a:02.0: request_iaa_wq: getting wq from iaa_device 0000000042d7bc52 (0)
+  [   60.752350] idxd 0000:6a:02.0: request_iaa_wq: returning unused wq 00000000c8bb4452 (0) from iaa device 0000000042d7bc52 (0)
+  [   60.752352] iaa_crypto: rebalance_wq_table: assigned wq for cpu=0, node=0 = wq 00000000c8bb4452
+  [   60.752354] iaa_crypto: rebalance_wq_table: iaa=0
+  [   60.752355] idxd 0000:6a:02.0: request_iaa_wq: getting wq from iaa_device 0000000042d7bc52 (0)
+  [   60.752356] idxd 0000:6a:02.0: request_iaa_wq: returning unused wq 00000000c8bb4452 (0) from iaa device 0000000042d7bc52 (0)
+  [   60.752358] iaa_crypto: rebalance_wq_table: assigned wq for cpu=1, node=0 = wq 00000000c8bb4452
+  [   60.752359] iaa_crypto: rebalance_wq_table: iaa=0
+  [   60.752360] idxd 0000:6a:02.0: request_iaa_wq: getting wq from iaa_device 0000000042d7bc52 (0)
+  [   60.752361] idxd 0000:6a:02.0: request_iaa_wq: returning unused wq 00000000c8bb4452 (0) from iaa device 0000000042d7bc52 (0)
+  [   60.752362] iaa_crypto: rebalance_wq_table: assigned wq for cpu=2, node=0 = wq 00000000c8bb4452
+  [   60.752364] iaa_crypto: rebalance_wq_table: iaa=0
+  .
+  .
+  .
+
+Once the workqueues and devices have been enabled, the IAA crypto
+algorithms are enabled and available.  When the IAA crypto algorithms
+have been successfully enabled, you should see the following dmesg
+output::
+
+  [   64.893759] iaa_crypto: iaa_crypto_enable: iaa_crypto now ENABLED
+
+Now run the following zswap-specific setup commands to have zswap use
+the 'fixed' compression mode::
+
+  echo 0 > /sys/module/zswap/parameters/enabled
+  echo 50 > /sys/module/zswap/parameters/max_pool_percent
+  echo deflate-iaa > /sys/module/zswap/parameters/compressor
+  echo zsmalloc > /sys/module/zswap/parameters/zpool
+  echo 1 > /sys/module/zswap/parameters/enabled
+  echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
+
+  echo 100 > /proc/sys/vm/swappiness
+  echo never > /sys/kernel/mm/transparent_hugepage/enabled
+  echo 1 > /proc/sys/vm/overcommit_memory
+
+Finally, you can now run the zswap workload you want to measure. For
+example, using the code below, the following command will swap in and
+out 100 pages::
+
+  ./memory_madvise 100
+
+  Allocating 100 pages to swap in/out
+  Swapping out 100 pages
+  Swapping in 100 pages
+  Swapped out and in 100 pages
+
+You should see something like the following in the dmesg output if
+you've enabled debug output (echo -n 'module iaa_crypto +p' >
+/sys/kernel/debug/dynamic_debug/control)::
+
+  [  404.202972] idxd 0000:e7:02.0: iaa_comp_acompress: dma_map_sg, src_addr 223925c000, nr_sgs 1, req->src 00000000ee7cb5e6, req->slen 4096, sg_dma_len(sg) 4096
+  [  404.202973] idxd 0000:e7:02.0: iaa_comp_acompress: dma_map_sg, dst_addr 21dadf8000, nr_sgs 1, req->dst 000000008d6acea8, req->dlen 4096, sg_dma_len(sg) 8192
+  [  404.202975] idxd 0000:e7:02.0: iaa_compress: desc->src1_addr 223925c000, desc->src1_size 4096, desc->dst_addr 21dadf8000, desc->max_dst_size 4096, desc->src2_addr 2203543000, desc->src2_size 1568
+  [  404.202981] idxd 0000:e7:02.0: iaa_compress_verify: (verify) desc->src1_addr 21dadf8000, desc->src1_size 228, desc->dst_addr 223925c000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+  [  409.203227] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, src_addr 21ddd8b100, nr_sgs 1, req->src 0000000084adab64, req->slen 228, sg_dma_len(sg) 228
+  [  409.203235] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, dst_addr 21ee3dc000, nr_sgs 1, req->dst 000000004e2990d0, req->dlen 4096, sg_dma_len(sg) 4096
+  [  409.203239] idxd 0000:e7:02.0: iaa_decompress: desc->src1_addr 21ddd8b100, desc->src1_size 228, desc->dst_addr 21ee3dc000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+  [  409.203254] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, src_addr 21ddd8b100, nr_sgs 1, req->src 0000000084adab64, req->slen 228, sg_dma_len(sg) 228
+  [  409.203256] idxd 0000:e7:02.0: iaa_comp_adecompress: dma_map_sg, dst_addr 21f1551000, nr_sgs 1, req->dst 000000004e2990d0, req->dlen 4096, sg_dma_len(sg) 4096
+  [  409.203257] idxd 0000:e7:02.0: iaa_decompress: desc->src1_addr 21ddd8b100, desc->src1_size 228, desc->dst_addr 21f1551000, desc->max_dst_size 4096, desc->src2_addr 0, desc->src2_size 0
+
+In order to unregister the IAA crypto algorithms, and register new
+ones using different parameters, any users of the current algorithm
+should be stopped and the IAA workqueues and devices disabled.
+
+In the case of zswap, remove the IAA crypto algorithm as the
+compressor and turn off swap (to remove all references to
+iaa_crypto)::
+
+  echo lzo > /sys/module/zswap/parameters/compressor
+  swapoff -a
+
+  echo 0 > /sys/module/zswap/parameters/accept_threshold_percent
+  echo 0 > /sys/module/zswap/parameters/max_pool_percent
+  echo 0 > /sys/module/zswap/parameters/enabled
+
+Once zswap is disabled and no longer using iaa_crypto, the IAA wqs and
+devices can be disabled.
+
+The below script automatically does that::
+
+  #!/bin/bash
+
+  echo "IAA devices:"
+  lspci -d:0cfe
+  echo "# IAA devices:"
+  lspci -d:0cfe | wc -l
+
+  #
+  # count iaa instances
+  #
+  iaa_dev_id="0cfe"
+  num_iaa=$(lspci -d:${iaa_dev_id} | wc -l)
+  echo "Found ${num_iaa} IAA instances"
+
+  #
+  # disable iaa wqs and devices
+  #
+  echo "Disable IAA"
+
+  for ((i = 1; i < ${num_iaa} * 2; i += 2)); do
+      echo disable wq iax${i}/wq${i}.0
+      accel-config disable-wq iax${i}/wq${i}.0
+      echo disable iaa iax${i}
+      accel-config disable-device iax${i}
+  done
+
+  echo "End Disable IAA"
+
+Finally, at this point the iaa_crypto module can be removed, which
+will unregister the current IAA crypto algorithms::
+
+  rmmod iaa_crypto
+
+
+memory_madvise.c (gcc -o memory_memadvise memory_madvise.c)::
+
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <string.h>
+  #include <unistd.h>
+  #include <sys/mman.h>
+  #include <linux/mman.h>
+
+  #ifndef MADV_PAGEOUT
+  #define MADV_PAGEOUT    21      /* force pages out immediately */
+  #endif
+
+  #define PG_SZ           4096
+
+  int main(int argc, char **argv)
+  {
+        int i, nr_pages = 1;
+        int64_t *dump_ptr;
+        char *addr, *a;
+        int loop = 1;
+
+        if (argc > 1)
+                nr_pages = atoi(argv[1]);
+
+        printf("Allocating %d pages to swap in/out\n", nr_pages);
+
+        /* allocate pages */
+        addr = mmap(NULL, nr_pages * PG_SZ, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+        *addr = 1;
+
+        /* initialize data in page to all '*' chars */
+        memset(addr, '*', nr_pages * PG_SZ);
+
+         printf("Swapping out %d pages\n", nr_pages);
+
+        /* Tell kernel to swap it out */
+        madvise(addr, nr_pages * PG_SZ, MADV_PAGEOUT);
+
+        while (loop > 0) {
+                /* Wait for swap out to finish */
+                sleep(5);
+
+                a = addr;
+
+                printf("Swapping in %d pages\n", nr_pages);
+
+                /* Access the page ... this will swap it back in again */
+                for (i = 0; i < nr_pages; i++) {
+                        if (a[0] != '*') {
+                                printf("Bad data from decompress!!!!!\n");
+
+                                dump_ptr = (int64_t *)a;
+                                 for (int j = 0; j < 100; j++) {
+                                        printf("  page %d data: %#llx\n", i, *dump_ptr);
+                                        dump_ptr++;
+                                }
+                        }
+
+                        a += PG_SZ;
+                }
+
+                loop --;
+        }
+
+       printf("Swapped out and in %d pages\n", nr_pages);
diff --git a/Documentation/driver-api/crypto/iaa/index.rst b/Documentation/driver-api/crypto/iaa/index.rst
new file mode 100644
index 000000000000..aa6837e27264
--- /dev/null
+++ b/Documentation/driver-api/crypto/iaa/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+IAA (Intel Analytics Accelerator)
+=================================
+
+IAA provides hardware compression and decompression via the crypto
+API.
+
+.. toctree::
+   :maxdepth: 1
+
+   iaa-crypto
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/crypto/index.rst b/Documentation/driver-api/crypto/index.rst
new file mode 100644
index 000000000000..fb9709b98bea
--- /dev/null
+++ b/Documentation/driver-api/crypto/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Crypto Drivers
+==============
+
+Documentation for crypto drivers that may need more involved setup and
+configuration.
+
+.. toctree::
+   :maxdepth: 1
+
+   iaa/index
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index ff9aa1afdc62..2ad1237d5d5f 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -113,6 +113,7 @@ available subsections can be seen below.
    xillybus
    zorro
    hte/index
+   crypto/index
 
 .. only::  subproject and html
 
-- 
2.34.1


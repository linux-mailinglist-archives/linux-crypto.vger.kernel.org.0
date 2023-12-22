Return-Path: <linux-crypto+bounces-971-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6A81C83C
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 11:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE086B2214B
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A241168B6;
	Fri, 22 Dec 2023 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqKYVn1P"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87641168A2
	for <linux-crypto@vger.kernel.org>; Fri, 22 Dec 2023 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703241472; x=1734777472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fgLmCAhz0PnJJd9uhgQNXTHr1oIrpaLbXDNu+EDs6Ek=;
  b=HqKYVn1Pzz4X7mPP7fXGmqn9VYOtWlsai+uB/7eRELYeyqAmjif7khH0
   jJAxGC6z2smJRVM148HywrtWlGPnpuUgUS8GecwU/GCCC7b35UPeE3M7Z
   j5C0ed+xdbtau+Rd+IUikM6vdRHXWa75JlrrnV37mfPoGQRW3TJss0Jgx
   muQfqWWBbQlM0C7yhB1VP926Wo7XlEovS27vz89qNK3JV2OfcivFJR8m2
   /z6KOxVFRExPFxW5nHs0J6XbG9mpSVhiO9nb0yEKGwUTKum6DheIMcNAO
   FwFdY+ljFa+9mPI9AKlicxVz1z2H7mjDsiZYtpxyIz/D5FBHUlMoOjD00
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2948149"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2948149"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 02:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726742864"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726742864"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2023 02:37:50 -0800
From: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Subject: [PATCH v2 0/4] crypto: qat - enable telemetry for QAT GEN 4
Date: Fri, 22 Dec 2023 11:35:04 +0100
Message-ID: <20231222103508.1037442-1-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose through debugfs telemetry data for QAT GEN4 devices.

This allows to gather metrics about the performance and the utilization
of a QAT device and/or a group of ring pairs. In particular, statistics
on (1) the utilization of the PCIe channel, (2) address translation and
device TLB, when SVA is enabled and (3) the internal engines for crypto
and data compression.

The device periodically gathers telemetry data from hardware registers
and writes it into a DMA memory region which is sampled by the driver.
The driver then uses this data to compute basic metrics on the counters
and exposes them through debugfs attributes in the folder
/sys/kernel/debug/qat_<device>_<BDF>/telemetry.

Here is a summary of the changes:
 * Patch #1 adds an helper function to math.h to compute the average of
   values within an array.
 * Patch #2 includes a missing header in the file adf_accel_devices.h to
   allow to use the macro GET_DEV().
 * Patch #3 introduces device level telemetry and the associated documentation
   in /Documentation/ABI.
 * Patch #4 extends #3 by introducing ring pair level telemetry and
   documentation about it.

This set is based on earlier work done by Wojciech Ziemba.

---
v1 -> v2:
- define avg_array() in the C file where it is used
- set `accel_dev->telemetry` to NULL in adf_tl_free_mem()
- add ring pair service type info to debugfs telemetry/rp_<X>_data output
---

Lucas Segarra Fernandez (4):
  crypto: qat - include pci.h for GET_DEV()
  crypto: qat - add admin msgs for telemetry
  crypto: qat - add support for device telemetry
  crypto: qat - add support for ring pair level telemetry

 .../ABI/testing/debugfs-driver-qat_telemetry  | 228 ++++++
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   3 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   3 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   3 +
 .../intel/qat/qat_common/adf_accel_devices.h  |   6 +
 .../crypto/intel/qat/qat_common/adf_admin.c   |  37 +
 .../crypto/intel/qat/qat_common/adf_admin.h   |   4 +
 .../crypto/intel/qat/qat_common/adf_dbgfs.c   |   3 +
 .../intel/qat/qat_common/adf_gen4_hw_data.h   |   1 +
 .../crypto/intel/qat/qat_common/adf_gen4_tl.c | 153 ++++
 .../crypto/intel/qat/qat_common/adf_gen4_tl.h | 158 ++++
 .../crypto/intel/qat/qat_common/adf_init.c    |  12 +
 .../intel/qat/qat_common/adf_telemetry.c      | 288 +++++++
 .../intel/qat/qat_common/adf_telemetry.h      |  99 +++
 .../intel/qat/qat_common/adf_tl_debugfs.c     | 710 ++++++++++++++++++
 .../intel/qat/qat_common/adf_tl_debugfs.h     | 117 +++
 .../qat/qat_common/icp_qat_fw_init_admin.h    |  10 +
 17 files changed, 1835 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-qat_telemetry
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_tl.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_telemetry.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_telemetry.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.h


base-commit: b4719435c14199548ed49f036a7c31040a6b5353
-- 
2.41.0



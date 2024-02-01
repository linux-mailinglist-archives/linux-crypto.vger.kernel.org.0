Return-Path: <linux-crypto+bounces-1778-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7E845BC9
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Feb 2024 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC53F1F2C58A
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Feb 2024 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD14862171;
	Thu,  1 Feb 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ocsx4r6X"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF45626AC;
	Thu,  1 Feb 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802115; cv=none; b=e5W3/mz2ygGRnt1v/doNl1ClHtiREAh35kXBWSwH8LYkiTwpJQ7EUl/05tE0tPS6DAh2wCxvY4KO/PKO0oQM9tEnMxfYdsvA87PHttr3gL7HwqrKIY84pvoNIYMYTgIiWbWB5m811anqdkzxNqNUfULh5E5o4Kqa4+afGCK9TGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802115; c=relaxed/simple;
	bh=K2hEYfFg2ECmuL4jGX89SJFpLoVTYKtVZY6LPaqZFe8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WG3l/Xk8L9KifccZ//AwJ0/vPLmhnn5kUtr2FQAo/AzNW3HrC2IXZpYv9/9mEQY135s5209jFXtBpmw7UlRdFHtqWgnOmWodx6NXvp28I+pEXgihDOC3cXW1G0fujVudXTBTPfmFBEl+vcW7znsPo/8DQS22tmqYI+GFV6CVr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ocsx4r6X; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706802113; x=1738338113;
  h=from:to:cc:subject:date:message-id;
  bh=K2hEYfFg2ECmuL4jGX89SJFpLoVTYKtVZY6LPaqZFe8=;
  b=Ocsx4r6XTW9m+bMeBXW+zGIhKfZdPV9GlemSTC7lXwFR/9Xw8Gu7/csJ
   RiVYa1+vMm/RMruS16QiFWWnXa5rWF0vs6CQCtJXm2lQ16SN2ZxQdPK4V
   re9+UqRXIGUYevSnWfbYHOtAnSlTVQ5QfjvF4Vfgl9sN0LlOoiocanbDG
   piKHjU07shspRo+ZfngkSbBCzvqHYvOMFGtd/AHS5iOVKCdvIVm7XhcLf
   wl025Bw/34qY6VN7LCXCrbDn4nXuEBzjFYQ1YTgx3rYkOR7uHz2lRk6vj
   BPb9/aN4pbXayirpRixWZWdMvIl/iJ0nwFt3U+vZLombE7ianVll6uHFR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="401052846"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="401052846"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="133268"
Received: from qat-server-archercity1.sh.intel.com ([10.67.111.115])
  by orviesa007.jf.intel.com with ESMTP; 01 Feb 2024 07:41:50 -0800
From: Xin Zeng <xin.zeng@intel.com>
To: herbert@gondor.apana.org.au,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com,
	kevin.tian@intel.com
Cc: linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org,
	qat-linux@intel.com,
	Xin Zeng <xin.zeng@intel.com>
Subject: [PATCH 00/10] crypto: qat - enable SRIOV VF live migration for
Date: Thu,  1 Feb 2024 23:33:27 +0800
Message-Id: <20240201153337.4033490-1-xin.zeng@intel.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

This set enables live migration for Intel QAT GEN4 SRIOV Virtual
Functions (VFs).
It is composed of 10 patches. Patch 1~6 refactor the original QAT PF
driver implementation which will be reused by the following patches.
Patch 7 introduces the logic to the QAT PF driver that allows to save
and restore the state of a bank (a QAT VF is a wrapper around banks) and
drain a ring pair. Patch 8 adds the QAT PF driver a set of interfaces to
allow to save and restore the state of a VF that will be called by the
module qat_vfio_pci which will be introduced in the last patch. Patch 9
implements the defined device interfaces. The last one adds a vfio pci
extension specific for QAT which intercepts the vfio device operations
for a QAT VF to allow live migration.

Here are the steps required to test the live migration of a QAT GEN4 VF:
1. Bind one or more QAT GEN4 VF devices to the module qat_vfio_pci.ko 
2. Assign the VFs to the virtual machine and enable device live
migration 
3. Run a workload using a QAT VF inside the VM, for example using qatlib
(https://github.com/intel/qatlib) 
4. Migrate the VM from the source node to a destination node

RFC:
https://lore.kernel.org/all/20230630131304.64243-1-xin.zeng@intel.com/

Change logs:
RFC -> v1:
-  Address comments including the right module dependancy in Kconfig,
   source file name and module description (Alex)
-  Added PCI error handler and P2P state handler (Suggested by Kevin)
-  Refactor the state check duing loading ring state (Kevin) 
-  Fix missed call to vfio_put_device in the error case (Breet)
-  Migrate the shadow states in PF driver
-  Rebase on top of 6.8-rc1

Giovanni Cabiddu (2):
  crypto: qat - adf_get_etr_base() helper
  crypto: qat - relocate CSR access code

Siming Wan (3):
  crypto: qat - rename get_sla_arr_of_type()
  crypto: qat - expand CSR operations for QAT GEN4 devices
  crypto: qat - add bank save and restore flows

Xin Zeng (5):
  crypto: qat - relocate and rename 4xxx PF2VM definitions
  crypto: qat - move PFVF compat checker to a function
  crypto: qat - add interface for live migration
  crypto: qat - implement interface for live migration
  vfio/qat: Add vfio_pci driver for Intel QAT VF devices

 MAINTAINERS                                   |   8 +
 .../intel/qat/qat_420xx/adf_420xx_hw_data.c   |   3 +
 .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     |   5 +
 .../intel/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |   1 +
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |   1 +
 .../intel/qat/qat_c62x/adf_c62x_hw_data.c     |   1 +
 .../intel/qat/qat_c62xvf/adf_c62xvf_hw_data.c |   1 +
 drivers/crypto/intel/qat/qat_common/Makefile  |   6 +-
 .../intel/qat/qat_common/adf_accel_devices.h  |  74 ++
 .../intel/qat/qat_common/adf_common_drv.h     |  10 +
 .../qat/qat_common/adf_gen2_hw_csr_data.c     | 101 +++
 .../qat/qat_common/adf_gen2_hw_csr_data.h     |  86 ++
 .../intel/qat/qat_common/adf_gen2_hw_data.c   |  97 --
 .../intel/qat/qat_common/adf_gen2_hw_data.h   |  76 --
 .../qat/qat_common/adf_gen4_hw_csr_data.c     | 231 +++++
 .../qat/qat_common/adf_gen4_hw_csr_data.h     | 188 ++++
 .../intel/qat/qat_common/adf_gen4_hw_data.c   | 382 +++++---
 .../intel/qat/qat_common/adf_gen4_hw_data.h   | 127 +--
 .../intel/qat/qat_common/adf_gen4_pfvf.c      |   8 +-
 .../intel/qat/qat_common/adf_gen4_vf_mig.c    | 834 ++++++++++++++++++
 .../intel/qat/qat_common/adf_gen4_vf_mig.h    |  10 +
 .../intel/qat/qat_common/adf_mstate_mgr.c     | 310 +++++++
 .../intel/qat/qat_common/adf_mstate_mgr.h     |  87 ++
 .../intel/qat/qat_common/adf_pfvf_pf_proto.c  |   8 +-
 .../intel/qat/qat_common/adf_pfvf_utils.h     |  11 +
 drivers/crypto/intel/qat/qat_common/adf_rl.c  |  10 +-
 drivers/crypto/intel/qat/qat_common/adf_rl.h  |   2 +
 .../crypto/intel/qat/qat_common/adf_sriov.c   |   7 +-
 .../intel/qat/qat_common/adf_transport.c      |   4 +-
 .../crypto/intel/qat/qat_common/qat_mig_dev.c |  35 +
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |   1 +
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |   1 +
 drivers/vfio/pci/Kconfig                      |   2 +
 drivers/vfio/pci/Makefile                     |   2 +
 drivers/vfio/pci/intel/qat/Kconfig            |  13 +
 drivers/vfio/pci/intel/qat/Makefile           |   4 +
 drivers/vfio/pci/intel/qat/main.c             | 572 ++++++++++++
 include/linux/qat/qat_mig_dev.h               |  31 +
 38 files changed, 2963 insertions(+), 387 deletions(-)
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen2_hw_csr_data.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen2_hw_csr_data.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_csr_data.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_csr_data.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
 create mode 100644 drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.h
 create mode 100644 drivers/crypto/intel/qat/qat_common/qat_mig_dev.c
 create mode 100644 drivers/vfio/pci/intel/qat/Kconfig
 create mode 100644 drivers/vfio/pci/intel/qat/Makefile
 create mode 100644 drivers/vfio/pci/intel/qat/main.c
 create mode 100644 include/linux/qat/qat_mig_dev.h


base-commit: 57f39c1d3cff476b5ce091bbf3df520488a682e5
-- 
2.18.2



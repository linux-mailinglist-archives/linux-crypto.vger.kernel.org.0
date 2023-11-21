Return-Path: <linux-crypto+bounces-228-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8E7F362A
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 19:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5766281C8D
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45F16405
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4Hv3A/f"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC010E
	for <linux-crypto@vger.kernel.org>; Tue, 21 Nov 2023 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700587098; x=1732123098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ERuRL/m8CQew1H0KogndMWx7HFPL1zzpnSw2xKpsCyg=;
  b=L4Hv3A/fat/niptOsULnJFKVZBQp6eEecj8lj7K9QF+cCxZ/ljJTTafj
   G14xRMxROcgD1kRK3q5Rhv+GCgdqaYrV36GTxmq4/kgSqkrMwLui8lKEv
   5TOtMYslRB2q4FuEPxWQTXonSKSfTSbd2LO54DPOU6jLbJ+3XTSH9/UAK
   6dE1q9gXqWKYCjZk846h+oY09wMEA/HGgEB4gsY2ruMMOfqmDzl7AJara
   wbkvGWa/aQiYWnypkCRBFeNI5zLV9Huw+4MRuLGvVt5RwLgo+jvu0rkNB
   HhHO74YFxeKz4wCvsATF9O1E33st2C9O4lCg7Zb/i//ZNzAh2l/cg5WZk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10554051"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10554051"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1013974166"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1013974166"
Received: from r031s002_zp31l10c01.deacluster.intel.com (HELO localhost.localdomain) ([10.219.171.29])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2023 09:18:17 -0800
From: Damian Muszynski <damian.muszynski@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH] crypto: qat - add sysfs_added flag for rate limiting
Date: Tue, 21 Nov 2023 18:02:23 +0100
Message-ID: <20231121170252.8263-1-damian.muszynski@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

The qat_rl sysfs attribute group is registered within the adf_dev_start()
function, alongside other driver components.
If any of the functions preceding the group registration fails,
the adf_dev_start() function returns, and the caller, to undo the
operation, invokes adf_dev_stop() followed by adf_dev_shutdown().
However, the current flow lacks information about whether the
registration of the qat_rl attribute group was successful or not.

In cases where this condition is encountered, an error similar to
the following might be reported:

    4xxx 0000:6b:00.0: Starting device qat_dev0
    4xxx 0000:6b:00.0: qat_dev0 started 9 acceleration engines
    4xxx 0000:6b:00.0: Failed to send init message
    4xxx 0000:6b:00.0: Failed to start device qat_dev0
    sysfs group 'qat_rl' not found for kobject '0000:6b:00.0'
    ...
    sysfs_remove_groups+0x2d/0x50
    adf_sysfs_rl_rm+0x44/0x70 [intel_qat]
    adf_rl_stop+0x2d/0xb0 [intel_qat]
    adf_dev_stop+0x33/0x1d0 [intel_qat]
    adf_dev_down+0xf1/0x150 [intel_qat]
    ...
    4xxx 0000:6b:00.0: qat_dev0 stopped 9 acceleration engines
    4xxx 0000:6b:00.0: Resetting device qat_dev0

To prevent attempting to remove attributes from a group that has not
been added yet, a flag named 'sysfs_added' is introduced. This flag
is set to true upon the successful registration of the attribute group.

Fixes: d9fb8408376e ("crypto: qat - add rate limiting feature to qat_4xxx")
Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
---
 drivers/crypto/intel/qat/qat_common/adf_rl.h       | 1 +
 drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_rl.h b/drivers/crypto/intel/qat/qat_common/adf_rl.h
index eb5a330f8543..269c6656fb90 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_rl.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_rl.h
@@ -79,6 +79,7 @@ struct adf_rl_interface_data {
 	struct adf_rl_sla_input_data input;
 	enum adf_base_services cap_rem_srv;
 	struct rw_semaphore lock;
+	bool sysfs_added;
 };
 
 struct adf_rl_hw_data {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c b/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
index abf9c52474ec..bedb514d4e30 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sysfs_rl.c
@@ -441,11 +441,19 @@ int adf_sysfs_rl_add(struct adf_accel_dev *accel_dev)
 
 	data->cap_rem_srv = ADF_SVC_NONE;
 	data->input.srv = ADF_SVC_NONE;
+	data->sysfs_added = true;
 
 	return ret;
 }
 
 void adf_sysfs_rl_rm(struct adf_accel_dev *accel_dev)
 {
+	struct adf_rl_interface_data *data;
+
+	data = &GET_RL_STRUCT(accel_dev);
+	if (!data->sysfs_added)
+		return;
+
 	device_remove_group(&GET_DEV(accel_dev), &qat_rl_group);
+	data->sysfs_added = false;
 }

base-commit: f36285cc1e99472bb4c6741981594a5934ad4c4e
-- 
2.41.0



Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD11E473B
	for <lists+linux-crypto@lfdr.de>; Wed, 27 May 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgE0PXv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 May 2020 11:23:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:41779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgE0PXu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 May 2020 11:23:50 -0400
IronPort-SDR: eLkbpNrMvu2Sj33IwNcQbZgYBvKFUAe4LuvDsNDGNWO5X9Blm8iUrbaUP3llAPcoL2Rge5U9iB
 N7vBoF7wRTxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 08:23:00 -0700
IronPort-SDR: 3B1kVAso24ueWUHkcehuPj140h8aPERWVNYUPHAXjkZCMCZeoCaPuyh5j2Jr7G0l0LBuyBQYBo
 7LKwvU7o9Aew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="266869524"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2020 08:22:57 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] crypto: qat - convert to SPDX License Identifiers
Date:   Wed, 27 May 2020 16:21:28 +0100
Message-Id: <20200527152128.352735-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Replace License Headers with SPDX License Identifiers.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  | 48 +-----------------
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h  | 48 +-----------------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c        | 48 +-----------------
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     | 48 +-----------------
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h     | 48 +-----------------
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c      | 48 +-----------------
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    | 48 +-----------------
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.h    | 48 +-----------------
 drivers/crypto/qat/qat_c62x/adf_drv.c         | 48 +-----------------
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.c       | 48 +-----------------
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.h       | 48 +-----------------
 drivers/crypto/qat/qat_c62xvf/adf_drv.c       | 48 +-----------------
 .../crypto/qat/qat_common/adf_accel_devices.h | 48 +-----------------
 .../crypto/qat/qat_common/adf_accel_engine.c  | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_admin.c     | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_aer.c       | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_cfg.c       | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_cfg.h       | 48 +-----------------
 .../crypto/qat/qat_common/adf_cfg_common.h    | 48 +-----------------
 .../crypto/qat/qat_common/adf_cfg_strings.h   | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_cfg_user.h  | 48 +-----------------
 .../crypto/qat/qat_common/adf_common_drv.h    | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_ctl_drv.c   | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_dev_mgr.c   | 48 +-----------------
 .../crypto/qat/qat_common/adf_hw_arbiter.c    | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_init.c      | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_isr.c       | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 49 +------------------
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.h | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_sriov.c     | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_transport.c | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_transport.h | 48 +-----------------
 .../qat_common/adf_transport_access_macros.h  | 48 +-----------------
 .../qat/qat_common/adf_transport_debug.c      | 48 +-----------------
 .../qat/qat_common/adf_transport_internal.h   | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_vf2pf_msg.c | 48 +-----------------
 drivers/crypto/qat/qat_common/adf_vf_isr.c    | 48 +-----------------
 drivers/crypto/qat/qat_common/icp_qat_fw.h    | 48 +-----------------
 .../qat/qat_common/icp_qat_fw_init_admin.h    | 48 +-----------------
 drivers/crypto/qat/qat_common/icp_qat_fw_la.h | 48 +-----------------
 .../qat/qat_common/icp_qat_fw_loader_handle.h | 48 +-----------------
 .../crypto/qat/qat_common/icp_qat_fw_pke.h    | 48 +-----------------
 drivers/crypto/qat/qat_common/icp_qat_hal.h   | 48 +-----------------
 drivers/crypto/qat/qat_common/icp_qat_hw.h    | 48 +-----------------
 drivers/crypto/qat/qat_common/icp_qat_uclo.h  | 48 +-----------------
 drivers/crypto/qat/qat_common/qat_algs.c      | 48 +-----------------
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 49 +------------------
 drivers/crypto/qat/qat_common/qat_crypto.c    | 48 +-----------------
 drivers/crypto/qat/qat_common/qat_crypto.h    | 48 +-----------------
 drivers/crypto/qat/qat_common/qat_hal.c       | 48 +-----------------
 drivers/crypto/qat/qat_common/qat_uclo.c      | 48 +-----------------
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   | 48 +-----------------
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.h   | 48 +-----------------
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c     | 48 +-----------------
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   | 48 +-----------------
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.h   | 48 +-----------------
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c   | 48 +-----------------
 57 files changed, 114 insertions(+), 2624 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
index 6bc68bc00d76..aee494d3da52 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-	* Redistributions of source code must retain the above copyright
-	  notice, this list of conditions and the following disclaimer.
-	* Redistributions in binary form must reproduce the above copyright
-	  notice, this list of conditions and the following disclaimer in
-	  the documentation and/or other materials provided with the
-	  distribution.
-	* Neither the name of Intel Corporation nor the names of its
-	  contributors may be used to endorse or promote products derived
-	  from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_pf2vf_msg.h>
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
index afc9a0a86747..8b5dd2c94ebf 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
+++ b/drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_C3XXX_HW_DATA_H_
 #define ADF_C3XXX_HW_DATA_H_
 
diff --git a/drivers/crypto/qat/qat_c3xxx/adf_drv.c b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
index d937cc7248a5..020d099409e5 100644
--- a/drivers/crypto/qat/qat_c3xxx/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxx/adf_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
index d2d0ae445fd8..d2fedbd7113c 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h
index 934f216acf39..7945a9cd1c60 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #ifndef ADF_C3XXXVF_HW_DATA_H_
 #define ADF_C3XXXVF_HW_DATA_H_
 
diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
index 1dc5ac859f7b..11039fe55f61 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
index 618cec360b39..844ad5ed33fc 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-	* Redistributions of source code must retain the above copyright
-	  notice, this list of conditions and the following disclaimer.
-	* Redistributions in binary form must reproduce the above copyright
-	  notice, this list of conditions and the following disclaimer in
-	  the documentation and/or other materials provided with the
-	  distribution.
-	* Neither the name of Intel Corporation nor the names of its
-	  contributors may be used to endorse or promote products derived
-	  from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <adf_accel_devices.h>
 #include <adf_common_drv.h>
 #include <adf_pf2vf_msg.h>
diff --git a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
index 17a8a32d5c63..88504d2bf30d 100644
--- a/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
+++ b/drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_C62X_HW_DATA_H_
 #define ADF_C62X_HW_DATA_H_
 
diff --git a/drivers/crypto/qat/qat_c62x/adf_drv.c b/drivers/crypto/qat/qat_c62x/adf_drv.c
index 2bc06c89d2fe..4ba9c14383af 100644
--- a/drivers/crypto/qat/qat_c62x/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62x/adf_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
index 38e4bc04f407..29fd3f1091ab 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h
index a28d83e77422..a6c04cf7a43c 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h
+++ b/drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #ifndef ADF_C62XVF_HW_DATA_H_
 #define ADF_C62XVF_HW_DATA_H_
 
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
index a68358b31292..b8b021d54bb5 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 33f0a6251e38..b3500bc4a558 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_ACCEL_DEVICES_H_
 #define ADF_ACCEL_DEVICES_H_
 #include <linux/interrupt.h>
diff --git a/drivers/crypto/qat/qat_common/adf_accel_engine.c b/drivers/crypto/qat/qat_common/adf_accel_engine.c
index a42fc42704be..00d4d13e33e8 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_engine.c
+++ b/drivers/crypto/qat/qat_common/adf_accel_engine.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "adf_cfg.h"
diff --git a/drivers/crypto/qat/qat_common/adf_admin.c b/drivers/crypto/qat/qat_common/adf_admin.c
index d28cba34773e..e363d13dcd78 100644
--- a/drivers/crypto/qat/qat_common/adf_admin.c
+++ b/drivers/crypto/qat/qat_common/adf_admin.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index f5e960d23a7a..35cdc0fbbe40 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/aer.h>
diff --git a/drivers/crypto/qat/qat_common/adf_cfg.c b/drivers/crypto/qat/qat_common/adf_cfg.c
index 5c7fdb0fc53d..ac462796cefc 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg.c
+++ b/drivers/crypto/qat/qat_common/adf_cfg.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/list.h>
diff --git a/drivers/crypto/qat/qat_common/adf_cfg.h b/drivers/crypto/qat/qat_common/adf_cfg.h
index 6a9c6f6b5ec9..376cde61a60e 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_CFG_H_
 #define ADF_CFG_H_
 
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_common.h b/drivers/crypto/qat/qat_common/adf_cfg_common.h
index 1211261de7c2..e818033c1012 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_common.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_common.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_CFG_COMMON_H_
 #define ADF_CFG_COMMON_H_
 
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_strings.h b/drivers/crypto/qat/qat_common/adf_cfg_strings.h
index 7632ed0f25c5..314790f5b0af 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_strings.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_strings.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_CFG_STRINGS_H_
 #define ADF_CFG_STRINGS_H_
 
diff --git a/drivers/crypto/qat/qat_common/adf_cfg_user.h b/drivers/crypto/qat/qat_common/adf_cfg_user.h
index b5484bfa6996..86b4a3e3f355 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg_user.h
+++ b/drivers/crypto/qat/qat_common/adf_cfg_user.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_CFG_USER_H_
 #define ADF_CFG_USER_H_
 
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index d78f8d5c89c3..ae91203bb617 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_DRV_H
 #define ADF_DRV_H
 
diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
index ef0e482ee04f..4d4589d4b64c 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/drivers/crypto/qat/qat_common/adf_dev_mgr.c b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
index 2d06409bd3c4..e663054a11d5 100644
--- a/drivers/crypto/qat/qat_common/adf_dev_mgr.c
+++ b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include "adf_cfg.h"
diff --git a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c b/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
index d7dd18d9bef8..d4162783f970 100644
--- a/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
+++ b/drivers/crypto/qat/qat_common/adf_hw_arbiter.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_transport_internal.h"
diff --git a/drivers/crypto/qat/qat_common/adf_init.c b/drivers/crypto/qat/qat_common/adf_init.c
index 26556c713049..42029153408e 100644
--- a/drivers/crypto/qat/qat_common/adf_init.c
+++ b/drivers/crypto/qat/qat_common/adf_init.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index cd1cdf5305bc..36136f7db509 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index b3875fdf6cd7..519fd5acf713 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -1,50 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
-
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #include <linux/delay.h>
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
index 5acd531a11ff..0690c031bfce 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #ifndef ADF_PF2VF_MSG_H
 #define ADF_PF2VF_MSG_H
 
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index b36d8653b1ba..8827aa139f96 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #include <linux/workqueue.h>
 #include <linux/pci.h>
 #include <linux/device.h>
diff --git a/drivers/crypto/qat/qat_common/adf_transport.c b/drivers/crypto/qat/qat_common/adf_transport.c
index 2136cbe4bf6c..4625881a8832 100644
--- a/drivers/crypto/qat/qat_common/adf_transport.c
+++ b/drivers/crypto/qat/qat_common/adf_transport.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/delay.h>
 #include "adf_accel_devices.h"
 #include "adf_transport_internal.h"
diff --git a/drivers/crypto/qat/qat_common/adf_transport.h b/drivers/crypto/qat/qat_common/adf_transport.h
index 386485bd9c95..0faea1032b93 100644
--- a/drivers/crypto/qat/qat_common/adf_transport.h
+++ b/drivers/crypto/qat/qat_common/adf_transport.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_TRANSPORT_H
 #define ADF_TRANSPORT_H
 
diff --git a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h b/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
index 80e02a2a0a09..1a943f948100 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
+++ b/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_TRANSPORT_ACCESS_MACROS_H
 #define ADF_TRANSPORT_ACCESS_MACROS_H
 
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/qat/qat_common/adf_transport_debug.c
index e794e9d97b2c..2a2eccbf56ec 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/qat/qat_common/adf_transport_debug.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
diff --git a/drivers/crypto/qat/qat_common/adf_transport_internal.h b/drivers/crypto/qat/qat_common/adf_transport_internal.h
index bb883368ac01..fc610ea31869 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_internal.h
+++ b/drivers/crypto/qat/qat_common/adf_transport_internal.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_TRANSPORT_INTRN_H
 #define ADF_TRANSPORT_INTRN_H
 
diff --git a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
index cd5f37dffe8a..2c98fb63f7b7 100644
--- a/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_vf2pf_msg.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #include "adf_accel_devices.h"
 #include "adf_common_drv.h"
 #include "adf_pf2vf_msg.h"
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index 4a73fc70f7a9..c4a44dc6af3e 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw.h b/drivers/crypto/qat/qat_common/icp_qat_fw.h
index 46747f01b1d1..1b9a11f574ee 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef _ICP_QAT_FW_H_
 #define _ICP_QAT_FW_H_
 #include <linux/types.h>
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h b/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
index 72a59faa9005..2024babd7fc7 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_init_admin.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef _ICP_QAT_FW_INIT_ADMIN_H_
 #define _ICP_QAT_FW_INIT_ADMIN_H_
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_la.h b/drivers/crypto/qat/qat_common/icp_qat_fw_la.h
index c8d26697e8ea..ee0a0c944b31 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_la.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_la.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef _ICP_QAT_FW_LA_H_
 #define _ICP_QAT_FW_LA_H_
 #include "icp_qat_fw.h"
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h b/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
index 2ffef3e4fd68..3e8e291cd122 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_loader_handle.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef __ICP_QAT_FW_LOADER_HANDLE_H__
 #define __ICP_QAT_FW_LOADER_HANDLE_H__
 #include "icp_qat_uclo.h"
diff --git a/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h b/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
index 0d7a9b51ce9f..4354a68de327 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_fw_pke.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-	* Redistributions of source code must retain the above copyright
-	  notice, this list of conditions and the following disclaimer.
-	* Redistributions in binary form must reproduce the above copyright
-	  notice, this list of conditions and the following disclaimer in
-	  the documentation and/or other materials provided with the
-	  distribution.
-	* Neither the name of Intel Corporation nor the names of its
-	  contributors may be used to endorse or promote products derived
-	  from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef _ICP_QAT_FW_PKE_
 #define _ICP_QAT_FW_PKE_
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hal.h b/drivers/crypto/qat/qat_common/icp_qat_hal.h
index 7187917533d0..c0e9fc0c93dd 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_hal.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_hal.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef __ICP_QAT_HAL_H
 #define __ICP_QAT_HAL_H
 #include "icp_qat_fw_loader_handle.h"
diff --git a/drivers/crypto/qat/qat_common/icp_qat_hw.h b/drivers/crypto/qat/qat_common/icp_qat_hw.h
index 121d5e6e46ca..1f1e7465f3c1 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_hw.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_hw.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef _ICP_QAT_HW_H_
 #define _ICP_QAT_HW_H_
 
diff --git a/drivers/crypto/qat/qat_common/icp_qat_uclo.h b/drivers/crypto/qat/qat_common/icp_qat_uclo.h
index 5d1ee7e53492..dbb58eacc395 100644
--- a/drivers/crypto/qat/qat_common/icp_qat_uclo.h
+++ b/drivers/crypto/qat/qat_common/icp_qat_uclo.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef __ICP_QAT_UCLO_H__
 #define __ICP_QAT_UCLO_H__
 
diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index e14d3dd291f0..9df4aebf37ca 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/crypto.h>
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 692a7aaee749..6cd67b06979b 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -1,50 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-	* Redistributions of source code must retain the above copyright
-	  notice, this list of conditions and the following disclaimer.
-	* Redistributions in binary form must reproduce the above copyright
-	  notice, this list of conditions and the following disclaimer in
-	  the documentation and/or other materials provided with the
-	  distribution.
-	* Neither the name of Intel Corporation nor the names of its
-	  contributors may be used to endorse or promote products derived
-	  from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
-
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/module.h>
 #include <crypto/internal/rsa.h>
 #include <crypto/internal/akcipher.h>
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.c b/drivers/crypto/qat/qat_common/qat_crypto.c
index fb504cee0305..ab621b7dbd20 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.c
+++ b/drivers/crypto/qat/qat_common/qat_crypto.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/module.h>
 #include <linux/slab.h>
 #include "adf_accel_devices.h"
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.h b/drivers/crypto/qat/qat_common/qat_crypto.h
index 300bb919a33a..12682d1e9f5f 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.h
+++ b/drivers/crypto/qat/qat_common/qat_crypto.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef _QAT_CRYPTO_INSTANCE_H_
 #define _QAT_CRYPTO_INSTANCE_H_
 
diff --git a/drivers/crypto/qat/qat_common/qat_hal.c b/drivers/crypto/qat/qat_common/qat_hal.c
index ff149e176f64..9a80da0b3b28 100644
--- a/drivers/crypto/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/qat/qat_common/qat_hal.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/slab.h>
 #include <linux/delay.h>
 
diff --git a/drivers/crypto/qat/qat_common/qat_uclo.c b/drivers/crypto/qat/qat_common/qat_uclo.c
index 6bd8f6a2a24f..3f079e336f64 100644
--- a/drivers/crypto/qat/qat_common/qat_uclo.c
+++ b/drivers/crypto/qat/qat_common/qat_uclo.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index 1dfcab317bed..0461040303a2 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
index 092f7353ed23..082a04466dca 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #ifndef ADF_DH895x_HW_DATA_H_
 #define ADF_DH895x_HW_DATA_H_
 
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
index b11bf8c0e683..4e877b75822b 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
index a3b4dd8099a7..5246f0524ca3 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #include <adf_accel_devices.h>
 #include <adf_pf2vf_msg.h>
 #include <adf_common_drv.h>
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h
index 6ddc19bd4410..2bfcc67f8f39 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.h
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2015 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2015 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
+/* Copyright(c) 2015 - 2020 Intel Corporation */
 #ifndef ADF_DH895XVF_HW_DATA_H_
 #define ADF_DH895XVF_HW_DATA_H_
 
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
index 1b762eefc6c1..7d6e1db272c2 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
@@ -1,49 +1,5 @@
-/*
-  This file is provided under a dual BSD/GPLv2 license.  When using or
-  redistributing this file, you may do so under either license.
-
-  GPL LICENSE SUMMARY
-  Copyright(c) 2014 Intel Corporation.
-  This program is free software; you can redistribute it and/or modify
-  it under the terms of version 2 of the GNU General Public License as
-  published by the Free Software Foundation.
-
-  This program is distributed in the hope that it will be useful, but
-  WITHOUT ANY WARRANTY; without even the implied warranty of
-  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-  General Public License for more details.
-
-  Contact Information:
-  qat-linux@intel.com
-
-  BSD LICENSE
-  Copyright(c) 2014 Intel Corporation.
-  Redistribution and use in source and binary forms, with or without
-  modification, are permitted provided that the following conditions
-  are met:
-
-    * Redistributions of source code must retain the above copyright
-      notice, this list of conditions and the following disclaimer.
-    * Redistributions in binary form must reproduce the above copyright
-      notice, this list of conditions and the following disclaimer in
-      the documentation and/or other materials provided with the
-      distribution.
-    * Neither the name of Intel Corporation nor the names of its
-      contributors may be used to endorse or promote products derived
-      from this software without specific prior written permission.
-
-  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-*/
+// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only)
+/* Copyright(c) 2014 - 2020 Intel Corporation */
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-- 
2.26.2


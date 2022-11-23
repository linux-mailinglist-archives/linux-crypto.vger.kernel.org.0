Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75C3635C70
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Nov 2022 13:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiKWMKs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Nov 2022 07:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiKWMKq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Nov 2022 07:10:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B4564A23
        for <linux-crypto@vger.kernel.org>; Wed, 23 Nov 2022 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669205440; x=1700741440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xMt3klmCmYuDqQCxAHvsLG/GJrNWoXA6/sFjHL02hxw=;
  b=R0lVzAmQ6LQItpjipKSgxXuZbGXllD/5WyhF6QLi55ELMX/IURueYIeL
   4Iw4Xc0sWDVq3lBNchalWaMCoF3s3K3v5dTFXI/tE8ThsonHQAeBev8ER
   j741Fd4w/A5lulIAerjB/EmIEwOxv9ELTv3Cao27+D962SUxZ294DVPtU
   MeqqZ2BYn+SlqmRInKB9WY1hDHKdtD9Jtz5ikXP9ZNA9vpcstkI873IOk
   lOoJF3G2W6Se2QxjKZwHowXNxPY3nZlhqTZi2kxttLLh84Q2Hk+OYxoq4
   A/cQqeqqy9FT2IElFjrGyzz6B4Zfs3mI7jc57TE/027Oz9WLW1h+GDOfR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312752451"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312752451"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 04:10:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784227457"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="784227457"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2022 04:10:38 -0800
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v2 00/11] crypto: qat - enable compression deflate algorithm
Date:   Wed, 23 Nov 2022 12:10:21 +0000
Message-Id: <20221123121032.71991-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This set enables the offload of the compression deflate algorithm to QAT
accelerators through the acomp API.

The first part of the set (patches 1 to 8) reworks and refactors logic
that is specific to the crypto service in order to be used by the
compression service.
In particular, the first 6 patches rework the buffer list logic, which
is used to map, unmap and convert scatterlists into the format that the
QAT firmware can understand. These relocate the bufferlist logic to a
separate file, change the interfaces so that the logic is service
agnostic (not tied to compression or crypto) and extend the interface to
allow an additional pre-allocated buffer for each destination scatter list
which will be used to avoid premature overflows reported by the compression
hardware.
Patch 7 relocates the function qat_algs_alloc_flags() from a crypto
specific header to qat_bl.h.
Patch 8 moves and renames the configuration function for GEN2,
qat_crypto_dev_config(), to a new file, adf_gen2_config.h, which
contains the configuration logic for both crypto and compression
instances for QAT GEN2 devices.

The last 2 patches in the set introduce all the infrastructure required
to enable the compression service in the QAT driver and expose it through
the acomp APIs.
In particular, patch 9 introduces the logic related to the creation
and handling of compression instances and their configuration.
In addition, it adds the back-end for qat_deflate to plug into acomp,
including the logic to build descriptors for the newly added GEN2 compression
firmware APIs.

This was all kept in a single patch to avoid introducing unused logic in
the QAT driver in previous patches.

Patch 10, extends the compression logic to support to QAT GEN4 devices.

Patch 11 implements the resubmission logic for decompression requests
that is triggered if the destination buffer, allocated by the driver,
is not sufficiently big to store the output from the operation.

Changes from v1:
 - Implemented resubmission logic for decompression triggered when
   the output buffer allocated by the driver is not sufficiently large to
   store the result from the operation
 - Renamed buffer list functions that are moved to the qat_bl module

Giovanni Cabiddu (11):
  crypto: qat - relocate bufferlist logic
  crypto: qat - rename bufferlist functions
  crypto: qat - change bufferlist logic interface
  crypto: qat - generalize crypto request buffers
  crypto: qat - extend buffer list interface
  crypto: qat - relocate backlog related structures
  crypto: qat - relocate qat_algs_alloc_flags()
  crypto: qat - rename and relocate GEN2 config function
  crypto: qat - expose deflate through acomp api for QAT GEN2
  crypto: qat - enable deflate for QAT GEN4
  crypto: qat - add resubmit logic for decompression

 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |   4 +-
 .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |   2 +-
 drivers/crypto/qat/qat_4xxx/adf_drv.c         | 145 +++++-
 .../crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c  |   4 +
 drivers/crypto/qat/qat_c3xxx/adf_drv.c        |   2 +-
 .../qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c     |   4 +
 .../crypto/qat/qat_c62x/adf_c62x_hw_data.c    |   4 +
 drivers/crypto/qat/qat_c62x/adf_drv.c         |   2 +-
 .../qat/qat_c62xvf/adf_c62xvf_hw_data.c       |   4 +
 drivers/crypto/qat/qat_common/Makefile        |   8 +-
 .../crypto/qat/qat_common/adf_accel_devices.h |  14 +
 .../crypto/qat/qat_common/adf_cfg_strings.h   |   1 +
 .../crypto/qat/qat_common/adf_common_drv.h    |   9 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c   |   6 +
 .../crypto/qat/qat_common/adf_gen2_config.c   | 206 ++++++++
 .../crypto/qat/qat_common/adf_gen2_config.h   |  10 +
 drivers/crypto/qat/qat_common/adf_gen2_dc.c   |  70 +++
 drivers/crypto/qat/qat_common/adf_gen2_dc.h   |  10 +
 drivers/crypto/qat/qat_common/adf_gen4_dc.c   |  83 ++++
 drivers/crypto/qat/qat_common/adf_gen4_dc.h   |  10 +
 drivers/crypto/qat/qat_common/adf_init.c      |  11 +
 drivers/crypto/qat/qat_common/adf_sriov.c     |   4 +
 drivers/crypto/qat/qat_common/icp_qat_fw.h    |  24 +
 .../crypto/qat/qat_common/icp_qat_fw_comp.h   | 404 ++++++++++++++++
 drivers/crypto/qat/qat_common/icp_qat_hw.h    |  66 +++
 .../qat/qat_common/icp_qat_hw_20_comp.h       | 164 +++++++
 .../qat/qat_common/icp_qat_hw_20_comp_defs.h  | 300 ++++++++++++
 drivers/crypto/qat/qat_common/qat_algs.c      | 208 +-------
 drivers/crypto/qat/qat_common/qat_algs_send.h |  16 +-
 drivers/crypto/qat/qat_common/qat_bl.c        | 451 ++++++++++++++++++
 drivers/crypto/qat/qat_common/qat_bl.h        |  67 +++
 drivers/crypto/qat/qat_common/qat_comp_algs.c | 349 ++++++++++++++
 drivers/crypto/qat/qat_common/qat_comp_req.h  | 123 +++++
 .../crypto/qat/qat_common/qat_compression.c   | 297 ++++++++++++
 .../crypto/qat/qat_common/qat_compression.h   |  37 ++
 drivers/crypto/qat/qat_common/qat_crypto.c    | 120 +----
 drivers/crypto/qat/qat_common/qat_crypto.h    |  55 +--
 .../qat/qat_dh895xcc/adf_dh895xcc_hw_data.c   |   4 +
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c     |   2 +-
 .../qat_dh895xccvf/adf_dh895xccvf_hw_data.c   |   4 +
 40 files changed, 2920 insertions(+), 384 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_config.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_config.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_dc.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen2_dc.h
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_dc.c
 create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_dc.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_fw_comp.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp.h
 create mode 100644 drivers/crypto/qat/qat_common/icp_qat_hw_20_comp_defs.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_bl.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_bl.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_comp_algs.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_comp_req.h
 create mode 100644 drivers/crypto/qat/qat_common/qat_compression.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_compression.h

-- 
2.38.1


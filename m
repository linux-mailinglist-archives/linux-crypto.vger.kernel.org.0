Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963B4EDD80
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Mar 2022 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiCaPmJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Mar 2022 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiCaPlT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Mar 2022 11:41:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5922322F
        for <linux-crypto@vger.kernel.org>; Thu, 31 Mar 2022 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648741017; x=1680277017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Du4pgWMX3S8uy0yKfNcOQV8+Au4FhYTFrto3T2LHkjE=;
  b=gaRmUlb1xYRatosaXwsqjNl8rFbD7hpqLCD3UCHiB24MUTotTU/Nw/RY
   VVQmj+VO5gIiXpXxNzq8YNxVuzp8+IpPWwqfIl/9Wppr2IIji25nzxMiy
   0f06oDkZHi2o5vySnlW62iE6thl3ODcdv4aSKXGYmFkaJeN8w1ZIk+fZe
   RLTxQzucXcdDgwqA5SuGXH8OY/tEABQpssEsoGMShO8AI1qudk0faVVo6
   EAObCICMUcDEZMgF9D+Z3LP/1RbO77ndAqvwoKEEW7ItOg6+8Uezwwu8X
   DLSkPNRAJcuPfk4Se/9qXSM4EquHqBUx2+uw7aUSd3+JGiRcLYSayQ2HX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="242022730"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="242022730"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 08:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="555124758"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.76])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2022 08:36:54 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        marco.chiappero@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH v2 0/4] crypto: qat - fix dm-crypt related issues
Date:   Thu, 31 Mar 2022 16:36:48 +0100
Message-Id: <20220331153652.37020-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This set fixes the issues related with the dm-crypt + QAT driver
use-case.

The first patch fixes a potential dead-lock that might occur when using
dm-crypt + QAT in out of memory conditions. The datapaths of the aead
and skcipher implementations have been changed to use pre-allocated
buffers that are part of the request contexts.
The also removes the CRYPTO_ALG_ALLOCATES_MEMORY flag from the aead and
skcipher implementations.

The second patch refactors the submission logic in preparation for the
introduction of a backlog queue to handle crypto requests with the
CRYPTO_TFM_REQ_MAY_BACKLOG flag set.

The third patch addresses a stall in the dm-crypt + QAT usecase by
adding support for the CRYPTO_TFM_REQ_MAY_BACKLOG flag. If the HW queue
is full, the driver enqueues the request in a list and resubmit it at
a later time, avoiding losing it.

The last, re-enables the crypto instances in the QAT driver which were
disabled due to the issues above.

Changes from v1:
 - Patch #3: removed worqueues. Requests in the backlog queue are now
   resubmitted in the context of the callback of a previously submitted
   request. This reduces the CPU utilization as the resubmit backlog
   function always finds a free slot in the HW queues when resubmits a
   job.

Giovanni Cabiddu (4):
  crypto: qat - use pre-allocated buffers in datapath
  crypto: qat - refactor submission logic
  crypto: qat - add backlog mechanism
  crypto: qat - re-enable registration of algorithms

 drivers/crypto/qat/qat_4xxx/adf_drv.c         |   7 -
 drivers/crypto/qat/qat_common/Makefile        |   1 +
 drivers/crypto/qat/qat_common/adf_transport.c |  11 ++
 drivers/crypto/qat/qat_common/adf_transport.h |   1 +
 .../qat/qat_common/adf_transport_internal.h   |   1 +
 drivers/crypto/qat/qat_common/qat_algs.c      | 150 ++++++++++--------
 drivers/crypto/qat/qat_common/qat_algs_send.c |  84 ++++++++++
 drivers/crypto/qat/qat_common/qat_algs_send.h |  11 ++
 drivers/crypto/qat/qat_common/qat_asym_algs.c |  56 ++++---
 drivers/crypto/qat/qat_common/qat_crypto.c    |  10 +-
 drivers/crypto/qat/qat_common/qat_crypto.h    |  39 +++++
 11 files changed, 269 insertions(+), 102 deletions(-)
 create mode 100644 drivers/crypto/qat/qat_common/qat_algs_send.c
 create mode 100644 drivers/crypto/qat/qat_common/qat_algs_send.h

-- 
2.35.1


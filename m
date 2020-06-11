Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B61F6F5C
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2020 23:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgFKVWA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Jun 2020 17:22:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:17090 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgFKVWA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Jun 2020 17:22:00 -0400
IronPort-SDR: p5tLCwFXezY/XUhve5359ZkhPMk/j0degINTTcObJvDJm3P5dUw3wRWVw7loeOES3lKV4tYP+e
 GE2ukMQ++bCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 14:21:59 -0700
IronPort-SDR: dErQYacd4KR7IRuZYRZ2/ZbHer4mGGjXB59zuE+O984s/UU5H0nJpKWcKPwMHtOUz7D+7cA9o0
 m8BHq7F8bBwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="314926383"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.51])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2020 14:21:58 -0700
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 0/3] crypto: qat - update admin interface
Date:   Thu, 11 Jun 2020 22:14:46 +0100
Message-Id: <20200611211449.76144-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Refactor and update the admin interface in the qat driver.

These changes are on top of "crypto: qat - remove packed attribute
in etr structs" (https://patchwork.kernel.org/patch/11586063/)

Wojciech Ziemba (3):
  crypto: qat - update fw init admin msg
  crypto: qat - send admin messages to set of AEs
  crypto: qat - update timeout logic in put admin msg

 drivers/crypto/qat/qat_common/adf_admin.c     | 96 ++++++++++++-------
 .../qat/qat_common/icp_qat_fw_init_admin.h    | 75 ++++++++++-----
 2 files changed, 114 insertions(+), 57 deletions(-)

-- 
2.26.2


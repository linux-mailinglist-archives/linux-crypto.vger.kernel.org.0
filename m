Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC492A4F5D
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Nov 2020 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgKCStz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Nov 2020 13:49:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:53371 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgKCStx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Nov 2020 13:49:53 -0500
IronPort-SDR: ZtkSGSKz4Iuf90X7wx3ukVg2/6mlsYHLm6FYQ63e7aI8nyspnBRMiWLMqxbLSHXSDteM/xtvgY
 hqtavm9qke3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="253818898"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="253818898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:49:53 -0800
IronPort-SDR: Xwls4WBh9N0vJNUA3A+EaHsgTNsasVd9DTWf82V/r7L9/asaMiaxncMsCdFp6BASaVWmOV9WXA
 QdjdUTfbSybQ==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="528595224"
Received: from riglesi-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.9.152])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 10:49:50 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v2 3/3] MAINTAINERS: Add maintainers for Keem Bay OCS HCU driver
Date:   Tue,  3 Nov 2020 18:49:25 +0000
Message-Id: <20201103184925.294456-4-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103184925.294456-1-daniele.alessandrelli@linux.intel.com>
References: <20201103184925.294456-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add maintainers for the Intel Keem Bay Offload Crypto Subsystem (OCS)
Hash Control Unit (HCU) crypto driver.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 606f9d7ef19a..1a0d7368c468 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8863,6 +8863,17 @@ M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
+INTEL KEEM BAY OCS HCU CRYPTO DRIVER
+M:	Declan Murphy <declan.murphy@intel.com>
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/intel,keembay-ocs-hcu.yaml
+F:	drivers/crypto/keembay/Kconfig
+F:	drivers/crypto/keembay/Makefile
+F:	drivers/crypto/keembay/keembay-ocs-hcu-core.c
+F:	drivers/crypto/keembay/ocs-hcu.c
+F:	drivers/crypto/keembay/ocs-hcu.h
+
 INTEL MANAGEMENT ENGINE (mei)
 M:	Tomas Winkler <tomas.winkler@intel.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.26.2


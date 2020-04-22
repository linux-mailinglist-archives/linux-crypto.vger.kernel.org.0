Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4891B4588
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2020 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgDVM62 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Apr 2020 08:58:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:56500 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgDVM61 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Apr 2020 08:58:27 -0400
IronPort-SDR: Yf32zr61Tcpm3rYalfORguacY0oO9CezhpMcp6BXtWjkpIGOqsTl9W3jn2nObujxyhGNIufqe0
 y1aryWZaMoTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 05:58:27 -0700
IronPort-SDR: 0DXt+2aQneNWPvZhB68PySp4KS95cknotsuqDKdDXRNPXsRV+tM+WY/PMMEjXdPBaVB06FTBRP
 8Hi9kPxjgj1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="273874484"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Apr 2020 05:58:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6967958F; Wed, 22 Apr 2020 15:58:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>, tee-dev@lists.linaro.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] hwrng: Use UUID API for exporting the UUID
Date:   Wed, 22 Apr 2020 15:58:08 +0300
Message-Id: <20200422125808.38278-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

There is export_uuid() function which exports uuid_t to the u8 array.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/hw_random/optee-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index ddfbabaa5f8f6..49b2e02537ddb 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -226,7 +226,7 @@ static int optee_rng_probe(struct device *dev)
 		return -ENODEV;
 
 	/* Open session with hwrng Trusted App */
-	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	export_uuid(sess_arg.uuid, &rng_device->id.uuid);
 	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
 	sess_arg.num_params = 0;
 
-- 
2.26.1


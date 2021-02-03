Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F014D30DE83
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Feb 2021 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhBCPod (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Feb 2021 10:44:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:10892 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233470AbhBCPoX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Feb 2021 10:44:23 -0500
IronPort-SDR: 3mM32C2KvDdW05iB1Fh2sO8NragHbtU7FxrRgvu27NBJc5ZK7mr0o39GpVFLVr25y6O5IjtP04
 vGQStiT9RzMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168741004"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="168741004"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 07:42:35 -0800
IronPort-SDR: sF3dU3rJebhEpzkshKFrt1KKvEpsLpzf2jP6SWHyMH/vALA+vcXYHiALWQP6//W5usuxE9LO5r
 9YiXJamDxwRg==
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="433468509"
Received: from dmarkey-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.21.31])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 07:42:27 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     herbert@gondor.apana.org.au
Cc:     daniele.alessandrelli@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: keembay-ocs-aes - Fix 'q' assignment during CCM B0 generation
Date:   Wed,  3 Feb 2021 15:42:10 +0000
Message-Id: <20210203154210.246667-1-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

In ocs_aes_ccm_write_b0(), 'q' (the octet length of the binary
representation of the octet length of the payload) is set to 'iv[0]',
while it should be set to 'iv[0] & 0x7' (i.e., only the last 3
bits of iv[0] should be used), as documented in NIST Special Publication
800-38C:
https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38c.pdf

In practice, this is not an issue, since 'iv[0]' is checked to be in the
range [1-7] by ocs_aes_validate_inputs(), but let's fix the assignment
anyway, in order to make the code more robust.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 drivers/crypto/keembay/ocs-aes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/keembay/ocs-aes.c b/drivers/crypto/keembay/ocs-aes.c
index b85c89477afa..be9f32fc8f42 100644
--- a/drivers/crypto/keembay/ocs-aes.c
+++ b/drivers/crypto/keembay/ocs-aes.c
@@ -1080,15 +1080,15 @@ static int ocs_aes_ccm_write_b0(const struct ocs_aes_dev *aes_dev,
 	/*
 	 * q is the octet length of Q.
 	 * q can only be an element of {2, 3, 4, 5, 6, 7, 8} and is encoded as
-	 * q - 1 == iv[0]
+	 * q - 1 == iv[0] & 0x7;
 	 */
 	b0[0] |= iv[0] & 0x7;
 	/*
 	 * Copy the Nonce N from IV to B0; N is located in iv[1]..iv[15 - q]
 	 * and must be copied to b0[1]..b0[15-q].
-	 * q == iv[0] + 1
+	 * q == (iv[0] & 0x7) + 1
 	 */
-	q = iv[0] + 1;
+	q = (iv[0] & 0x7) + 1;
 	for (i = 1; i <= 15 - q; i++)
 		b0[i] = iv[i];
 	/*
-- 
2.26.2


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF930D8B6
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Feb 2021 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhBCLcJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Feb 2021 06:32:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:12058 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234120AbhBCLb5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Feb 2021 06:31:57 -0500
IronPort-SDR: C4FTAmDKvOX3EIUiVCucro9Qx+Z9O4ZD4H/ue48SgypCL92ZwdtkJmpp4uOflcUHjZ8eqguYkn
 mIqhnI+3ONQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="265858360"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="265858360"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 03:28:54 -0800
IronPort-SDR: x/1kVMMYJ/8NzLI3z6smp8outjpzQzfJ0+r1BucZkfqpTZYDQrTfVrdGb4ywWH5j5V7URucPt3
 RHJaErMOR1Bg==
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="371404556"
Received: from dmarkey-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.21.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 03:28:53 -0800
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     herbert@gondor.apana.org.au
Cc:     daniele.alessandrelli@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ecdh_helper - Ensure 'len >= secret.len' in decode_key()
Date:   Wed,  3 Feb 2021 11:28:37 +0000
Message-Id: <20210203112837.203732-1-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

The length ('len' parameter) passed to crypto_ecdh_decode_key() is never
checked against the length encoded in the passed buffer ('buf'
parameter). This could lead to an out-of-bounds access when the passed
length is less than the encoded length.

Add a check to prevent that.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 crypto/ecdh_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/ecdh_helper.c b/crypto/ecdh_helper.c
index 66fcb2ea8154..fca63b559f65 100644
--- a/crypto/ecdh_helper.c
+++ b/crypto/ecdh_helper.c
@@ -67,6 +67,9 @@ int crypto_ecdh_decode_key(const char *buf, unsigned int len,
 	if (secret.type != CRYPTO_KPP_SECRET_TYPE_ECDH)
 		return -EINVAL;
 
+	if (unlikely(len < secret.len))
+		return -EINVAL;
+
 	ptr = ecdh_unpack_data(&params->curve_id, ptr, sizeof(params->curve_id));
 	ptr = ecdh_unpack_data(&params->key_size, ptr, sizeof(params->key_size));
 	if (secret.len != crypto_ecdh_key_len(params))
-- 
2.26.2


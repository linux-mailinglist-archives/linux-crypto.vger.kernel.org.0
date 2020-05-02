Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB76E1C2349
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2020 07:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEBFdq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 May 2020 01:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgEBFdo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 May 2020 01:33:44 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B90424954;
        Sat,  2 May 2020 05:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397624;
        bh=cxfqhmomB4B2lqaurFr3tfvzNEiRkFVJs96YPeGZ6PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVixZg8eo4EcfgOXeA6K8AM0jaE+sVtiEisgo+HET65KuVgG76JYJvoOqNslPenhF
         vSKrsKQA5pNpBsCre1dtt6n7JXzIW1yAZETtJC6mx2VQc6UaZtsEfr4GmQaxCyBXVB
         Oq1PMUKvPffJBYL7bKggTTLaUa8d0+PX3UElQVEo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Robert Baldyga <r.baldyga@samsung.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 12/20] nfc: s3fwrn5: use crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:14 -0700
Message-Id: <20200502053122.995648-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Cc: Robert Baldyga <r.baldyga@samsung.com>
Cc: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/nfc/s3fwrn5/firmware.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index de613c623a2cf0..69857f0807040c 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -434,15 +434,7 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
 		goto out;
 	}
 
-	{
-		SHASH_DESC_ON_STACK(desc, tfm);
-
-		desc->tfm = tfm;
-
-		ret = crypto_shash_digest(desc, fw->image, image_size,
-					  hash_data);
-		shash_desc_zero(desc);
-	}
+	ret = crypto_shash_tfm_digest(tfm, fw->image, image_size, hash_data);
 
 	crypto_free_shash(tfm);
 	if (ret) {
-- 
2.26.2


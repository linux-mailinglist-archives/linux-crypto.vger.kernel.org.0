Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96936E9A1
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Apr 2021 13:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhD2Ld6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 29 Apr 2021 07:33:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Ld6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 29 Apr 2021 07:33:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lc4uc-0003Ou-4G; Thu, 29 Apr 2021 11:32:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: amd: remove redundant initialization of variable err
Date:   Thu, 29 Apr 2021 12:32:53 +0100
Message-Id: <20210429113253.63960-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable err is being initialized with a value that is
never read and it is being updated later with a new value.  The
initialization is redundant and can be removed

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/hw_random/amd-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/amd-rng.c b/drivers/char/hw_random/amd-rng.c
index 9959c762da2f..d8d4ef5214a1 100644
--- a/drivers/char/hw_random/amd-rng.c
+++ b/drivers/char/hw_random/amd-rng.c
@@ -126,7 +126,7 @@ static struct hwrng amd_rng = {
 
 static int __init mod_init(void)
 {
-	int err = -ENODEV;
+	int err;
 	struct pci_dev *pdev = NULL;
 	const struct pci_device_id *ent;
 	u32 pmbase;
-- 
2.30.2


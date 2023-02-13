Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A016940F0
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Feb 2023 10:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBMJZH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Feb 2023 04:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjBMJZD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Feb 2023 04:25:03 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E54C7A87;
        Mon, 13 Feb 2023 01:25:01 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A51120C8B78;
        Mon, 13 Feb 2023 01:24:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A51120C8B78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676280301;
        bh=u6bQzaO/aYZQza3w+Vx7rpLvq48R3EDcrSdcbhpKXaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/pSVvJB+j4QH5pKCj4jDJjTzEpFFUlGKFJ+d5EOwghKmD0Zd9B/7e2ZXPwESAx3D
         KsFe4p6MvWBY+g8NQDFyKw1MuvoppY61ily10Ri3PUtSA0EFNZZ7uQGj3iQNIuF6LI
         8lnL3yHMf2ibGfuN4cScAmo03phSD9GdEgV9kwtY=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 5/8] crypto: cpp - Bind to psp platform device on x86
Date:   Mon, 13 Feb 2023 09:24:26 +0000
Message-Id: <20230213092429.1167812-6-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The PSP in Hyper-V VMs is exposed through the ASP ACPI table and is
represented as a platform_device. Allow the ccp driver to bind to it by
adding an id_table and initing the platform_driver also on x86. At this
point probe is called for the psp device but init fails due to missing
driver data.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-dev.c      | 7 +++++++
 drivers/crypto/ccp/sp-platform.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index 7eb3e4668286..4c9f442b8a11 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -259,6 +259,12 @@ static int __init sp_mod_init(void)
 	if (ret)
 		return ret;
 
+	ret = sp_platform_init();
+	if (ret) {
+		sp_pci_exit();
+		return ret;
+	}
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 	psp_pci_init();
 #endif
@@ -286,6 +292,7 @@ static void __exit sp_mod_exit(void)
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 	psp_pci_exit();
 #endif
+	sp_platform_exit();
 
 	sp_pci_exit();
 #endif
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 7d79a8744f9a..5dcc834deb72 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -56,6 +56,12 @@ static const struct of_device_id sp_of_match[] = {
 MODULE_DEVICE_TABLE(of, sp_of_match);
 #endif
 
+static const struct platform_device_id sp_platform_match[] = {
+	{ "psp" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sp_platform_match);
+
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
@@ -212,6 +218,7 @@ static int sp_platform_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver sp_platform_driver = {
+	.id_table = sp_platform_match,
 	.driver = {
 		.name = "ccp",
 #ifdef CONFIG_ACPI
-- 
2.25.1


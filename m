Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE76E998C
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Apr 2023 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjDTQcJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Apr 2023 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjDTQcI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D418A3;
        Thu, 20 Apr 2023 09:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBKfCzlENg/md0N29FDW804u2yGMhWLAotd6pyQDcN6i9eHz9ztNNG9M1LMl94P6DvAXMD0AsjDVNnFxS82OZWqXsVHgif2k5PPko7RFxhWmE7CLXuPgjjF0Cowf6OHZphvCLrCUEb34VAYvD2L5YWnRwx4/bQyF6Gonj/RdPala6xYLvV+/Qxmb1I58gOhNpzeB2XxdTBKxGoyxb5/nXLTo1ngK5sOl7qE8rYMQaHrxhgzm2VpvqDw176PRJAkr+4bqAaaSyNTsFt0mmomK4Xfzx1QMH/jLJdWASjofqz8snI9lYFeX8lgWVM6acvrxXxz8BT8jmlF4q/vNDpopnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCK3UFN7kfeIWQFj87Ev9Xsr6tgtpWCv/5cTFSUBohk=;
 b=VBQGXmOZim+qpg7h1ceoIJjFLQ62sIX1a7r+970pWtCQE01s0OXL1VVkDDAQuULglAoJZb4nZIJ92LZsBfQ0T/ycCtHY7kUtzULm8oFsV9xBELjP8Yvle8rf41bFpwBYDXqBwOVXbI68hUmc9m0lQHngwnl8ele47ZKcFocgOvpGw/v21wXiw7VMayEjOywHeAhmN/vxA3w0fb/PJzvYaLhNdLRfobrlbqxjy5ExpoyShDCRJewYVrknOQ01wuCleQUUH3Sp06/AeAjYLDjPR1aZriYFhC9NZucnWGlXqXEyjTJDjLBR57icu2g8G9YooaTjX2sN3gxa3YCIdwHFrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCK3UFN7kfeIWQFj87Ev9Xsr6tgtpWCv/5cTFSUBohk=;
 b=IMt9MAyo4rgaX7w73ZWHSNnw/geSKkWtjzBTdirvbTOav2wNkYcg10hBrN3puD8FgJjxcwt4WA3C5mHa7l8JoiyT6HSti2jxfoSV642uSQPYp8EWGwgzBQgsNFmwBsrT6SXZqc9J7GmnVUQ4fzDt0DBaS4zUwx4sSTtbusv9fW8=
Received: from DM6PR07CA0104.namprd07.prod.outlook.com (2603:10b6:5:330::30)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 16:32:04 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::d2) by DM6PR07CA0104.outlook.office365.com
 (2603:10b6:5:330::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 16:32:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:32:01 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] crypto: ccp: move setting PSP master to earlier in the init
Date:   Thu, 20 Apr 2023 11:31:32 -0500
Message-ID: <20230420163140.14940-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a47368a-4877-46a4-4dbf-08db41bcc6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX6McMOvfkHF83uHpdyl0wE8ztJyJ6OrG/VcUSauMe0G0YrdFvmHY0kZM9kian7ok/koLGrWni24ndjUucURECGpmRiSoflPM6IHBEVUKt8y3yrhU7qGIKW4s4ZU26hwTgk7TQC3Hk75cB1kjFP09LkRX5uk6aXEJoiinM3sZDuUmX6vl6CLdNXRCeLloG6DhGDKH1kKbK10Qp3rBtiEn+l6cc/pH/R1d/1UgZi5CEv7tgvYlhhqfWo9X1ga1FLIVjl4VMD7XpgBnvwm3PorNYf/JUz6qit1FAqX3x1Wn140mZ2YnkV6HLod5H6yeiLvAtM6VRz4xqikUGGqz5N04ew9LnISratO18gUN0DggeBsmhWYKF58tE3T27JNiLAou3c+iMvRmRXzSqOnu3sMRDFirlX2CTtHZ4jEsK+vhhqkDA4AYqVys4TOI3nPkirj9fUuz7awSGFYR+TdVvX3aPq1GuSX18H1cbNwRenmgX4d1fHU0uT58/ma+2IzMCYAcjnSU/GvlSajmMD+IHBaAS28TTbL5PgyqFAm68xh6VLOOFjkfqfHN388GfKo9qdCOl4bMek714inSbsPwwRfCwwSkZ58GVoL3akqaShkIEaq7ZEWF2/PF4CD8YBP50F4Wu4spxDxb1GK6s9WLwUH3mC3YzpSUoP1fs4RnEgJjLF7bZXVdmrFi9U4Av7hIyXzWehEBKc6Z79WchxCeTLs3DzJZzOcYAowL7l5RsgxIjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(7696005)(356005)(6666004)(478600001)(54906003)(6636002)(426003)(336012)(82310400005)(26005)(186003)(1076003)(110136005)(4744005)(44832011)(5660300002)(2906002)(70586007)(70206006)(41300700001)(16526019)(4326008)(8936002)(8676002)(2616005)(40480700001)(36756003)(40460700003)(86362001)(36860700001)(47076005)(316002)(81166007)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:04.4917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a47368a-4877-46a4-4dbf-08db41bcc6a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dynamic boost control needs to use platform access symbols
that look for the PSP master as part of initialization.

So move the PSP master before psp_init() so that dynamic boost
control can be initialized properly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index e3d6955d3265..e9136e398174 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
+	/* master device must be set for platform access */
+	if (psp->sp->set_psp_master_device)
+		psp->sp->set_psp_master_device(psp->sp);
+
 	ret = psp_init(psp);
 	if (ret)
 		goto e_irq;
 
-	if (sp->set_psp_master_device)
-		sp->set_psp_master_device(sp);
-
 	/* Enable interrupt */
 	iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);
 
-- 
2.34.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6C16451D
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2020 14:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBSNPF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Feb 2020 08:15:05 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:59256 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSNPF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Feb 2020 08:15:05 -0500
Received: from beagle7.blr.asicdesigners.com (beagle7.blr.asicdesigners.com [10.193.80.123])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01JDEt3a029235;
        Wed, 19 Feb 2020 05:14:56 -0800
From:   Devulapally Shiva Krishna <shiva@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     manojmalviya@chelsio.com, ayush.sawal@chelsio.com,
        Devulapally Shiva Krishna <shiva@chelsio.com>
Subject: [PATCH Crypto] chcr: un-register crypto algorithms
Date:   Wed, 19 Feb 2020 18:43:57 +0530
Message-Id: <20200219131357.5679-1-shiva@chelsio.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When a PCI device will be removed, cxgb4(LLD) will notify chcr(ULD).
Incase if it's a last pci device, chcr should un-register all the crypto
algorithms.

Signed-off-by: Devulapally Shiva Krishna <shiva@chelsio.com>
---
 drivers/crypto/chelsio/chcr_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/chelsio/chcr_core.c b/drivers/crypto/chelsio/chcr_core.c
index 507ba20f0874..6e02254c007a 100644
--- a/drivers/crypto/chelsio/chcr_core.c
+++ b/drivers/crypto/chelsio/chcr_core.c
@@ -271,6 +271,8 @@ static int chcr_uld_state_change(void *handle, enum cxgb4_state state)
 
 	case CXGB4_STATE_DETACH:
 		chcr_detach_device(u_ctx);
+		if (!atomic_read(&drv_data.dev_count))
+			stop_crypto();
 		break;
 
 	case CXGB4_STATE_START_RECOVERY:
-- 
2.18.1


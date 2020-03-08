Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0B17D499
	for <lists+linux-crypto@lfdr.de>; Sun,  8 Mar 2020 16:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCHP52 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 8 Mar 2020 11:57:28 -0400
Received: from foss.arm.com ([217.140.110.172]:45750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCHP52 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 8 Mar 2020 11:57:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 299297FA;
        Sun,  8 Mar 2020 08:57:27 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3FE93F6CF;
        Sun,  8 Mar 2020 08:57:25 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] crypto: ccree - remove pointless comment
Date:   Sun,  8 Mar 2020 17:57:05 +0200
Message-Id: <20200308155710.14546-3-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308155710.14546-1-gilad@benyossef.com>
References: <20200308155710.14546-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

removed pointless comment

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 drivers/crypto/ccree/cc_driver.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index a0fbf254f54b..d938886390d2 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -26,7 +26,6 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 
-/* Registers definitions from shared/hw/ree_include */
 #include "cc_host_regs.h"
 #include "cc_crypto_ctx.h"
 #include "cc_hw_queue_defs.h"
-- 
2.25.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F927867
	for <lists+linux-crypto@lfdr.de>; Thu, 23 May 2019 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfEWIuj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 May 2019 04:50:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfEWIuj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 May 2019 04:50:39 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hTjQq-0002wx-Ro; Thu, 23 May 2019 10:50:36 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hTjQq-0001fL-65; Thu, 23 May 2019 10:50:36 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-crypto@vger.kernel.org
Cc:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/4] crypto: caam: remove unused defines
Date:   Thu, 23 May 2019 10:50:28 +0200
Message-Id: <20190523085030.4969-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523085030.4969-1-s.hauer@pengutronix.de>
References: <20190523085030.4969-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The CAAM driver defines its own debug() macro, but it is unused. Remove
it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg.c  | 7 -------
 drivers/crypto/caam/caamhash.c | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index bffff5415c74..fb2994f3b18f 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -77,13 +77,6 @@
 #define DESC_MAX_USED_BYTES		(CAAM_DESC_BYTES_MAX - DESC_JOB_IO_LEN)
 #define DESC_MAX_USED_LEN		(DESC_MAX_USED_BYTES / CAAM_CMD_SZ)
 
-#ifdef DEBUG
-/* for print_hex_dumps with line references */
-#define debug(format, arg...) printk(format, arg)
-#else
-#define debug(format, arg...)
-#endif
-
 struct caam_alg_entry {
 	int class1_alg_type;
 	int class2_alg_type;
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 7205d9f4029e..8aee7c9bf862 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -82,14 +82,6 @@
 #define HASH_MSG_LEN			8
 #define MAX_CTX_LEN			(HASH_MSG_LEN + SHA512_DIGEST_SIZE)
 
-#ifdef DEBUG
-/* for print_hex_dumps with line references */
-#define debug(format, arg...) printk(format, arg)
-#else
-#define debug(format, arg...)
-#endif
-
-
 static struct list_head hash_list;
 
 /* ahash per-session context */
-- 
2.20.1


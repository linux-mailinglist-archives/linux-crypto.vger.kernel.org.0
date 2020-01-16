Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C786B13D7B3
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbgAPKPS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 05:15:18 -0500
Received: from foss.arm.com ([217.140.110.172]:47492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730964AbgAPKPR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 05:15:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33D231B;
        Thu, 16 Jan 2020 02:15:16 -0800 (PST)
Received: from e110176-lin.arm.com (unknown [10.50.4.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B23F3F534;
        Thu, 16 Jan 2020 02:15:15 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] crypto: ccree - cc_do_send_request() is void func
Date:   Thu, 16 Jan 2020 12:14:41 +0200
Message-Id: <20200116101447.20374-7-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200116101447.20374-1-gilad@benyossef.com>
References: <20200116101447.20374-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

cc_do_send_request() cannot fail and always returns
-EINPROGRESS. Turn it into a void function and simplify
code.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_request_mgr.c | 36 ++++++++-------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree/cc_request_mgr.c
index d37b4ab50a25..ce09c430c8b9 100644
--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -275,12 +275,11 @@ static int cc_queues_status(struct cc_drvdata *drvdata,
  * \param len The crypto sequence length
  * \param add_comp If "true": add an artificial dout DMA to mark completion
  *
- * \return int Returns -EINPROGRESS or error code
  */
-static int cc_do_send_request(struct cc_drvdata *drvdata,
-			      struct cc_crypto_req *cc_req,
-			      struct cc_hw_desc *desc, unsigned int len,
-				bool add_comp)
+static void cc_do_send_request(struct cc_drvdata *drvdata,
+			       struct cc_crypto_req *cc_req,
+			       struct cc_hw_desc *desc, unsigned int len,
+			       bool add_comp)
 {
 	struct cc_req_mgr_handle *req_mgr_h = drvdata->request_mgr_handle;
 	unsigned int used_sw_slots;
@@ -328,9 +327,6 @@ static int cc_do_send_request(struct cc_drvdata *drvdata,
 		/* Update the free slots in HW queue */
 		req_mgr_h->q_free_slots -= total_seq_len;
 	}
-
-	/* Operation still in process */
-	return -EINPROGRESS;
 }
 
 static void cc_enqueue_backlog(struct cc_drvdata *drvdata,
@@ -390,16 +386,10 @@ static void cc_proc_backlog(struct cc_drvdata *drvdata)
 			return;
 		}
 
-		rc = cc_do_send_request(drvdata, &bli->creq, bli->desc,
-					bli->len, false);
-
+		cc_do_send_request(drvdata, &bli->creq, bli->desc, bli->len,
+				   false);
 		spin_unlock(&mgr->hw_lock);
 
-		if (rc != -EINPROGRESS) {
-			cc_pm_put_suspend(dev);
-			creq->user_cb(dev, req, rc);
-		}
-
 		/* Remove ourselves from the backlog list */
 		spin_lock(&mgr->bl_lock);
 		list_del(&bli->list);
@@ -452,8 +442,10 @@ int cc_send_request(struct cc_drvdata *drvdata, struct cc_crypto_req *cc_req,
 		return -EBUSY;
 	}
 
-	if (!rc)
-		rc = cc_do_send_request(drvdata, cc_req, desc, len, false);
+	if (!rc) {
+		cc_do_send_request(drvdata, cc_req, desc, len, false);
+		rc = -EINPROGRESS;
+	}
 
 	spin_unlock_bh(&mgr->hw_lock);
 	return rc;
@@ -493,14 +485,8 @@ int cc_send_sync_request(struct cc_drvdata *drvdata,
 		reinit_completion(&drvdata->hw_queue_avail);
 	}
 
-	rc = cc_do_send_request(drvdata, cc_req, desc, len, true);
+	cc_do_send_request(drvdata, cc_req, desc, len, true);
 	spin_unlock_bh(&mgr->hw_lock);
-
-	if (rc != -EINPROGRESS) {
-		cc_pm_put_suspend(dev);
-		return rc;
-	}
-
 	wait_for_completion(&cc_req->seq_compl);
 	return 0;
 }
-- 
2.23.0


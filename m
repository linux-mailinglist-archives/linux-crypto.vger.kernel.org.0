Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12E21BC40B
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Apr 2020 17:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgD1PtU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Apr 2020 11:49:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46628 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgD1PtU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Apr 2020 11:49:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2668D1A00DE;
        Tue, 28 Apr 2020 17:49:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 194A41A005C;
        Tue, 28 Apr 2020 17:49:18 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2510A2030C;
        Tue, 28 Apr 2020 17:49:17 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v6 1/3] crypto: algapi - create function to add request in front of queue
Date:   Tue, 28 Apr 2020 18:49:03 +0300
Message-Id: <1588088945-9067-2-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588088945-9067-1-git-send-email-iuliana.prodan@nxp.com>
References: <1588088945-9067-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add crypto_enqueue_request_head function that enqueues a
request in front of queue.
This will be used in crypto-engine, on error path. In case a request
was not executed by hardware, enqueue it back in front of queue (to
keep the order of requests).

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 crypto/algapi.c         | 8 ++++++++
 include/crypto/algapi.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index f1e6cca..92abdf6 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -914,6 +914,14 @@ int crypto_enqueue_request(struct crypto_queue *queue,
 }
 EXPORT_SYMBOL_GPL(crypto_enqueue_request);
 
+void crypto_enqueue_request_head(struct crypto_queue *queue,
+				 struct crypto_async_request *request)
+{
+	queue->qlen++;
+	list_add(&request->list, &queue->list);
+}
+EXPORT_SYMBOL_GPL(crypto_enqueue_request_head);
+
 struct crypto_async_request *crypto_dequeue_request(struct crypto_queue *queue)
 {
 	struct list_head *request;
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index e115f92..00a9cf9 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -125,6 +125,8 @@ int crypto_inst_setname(struct crypto_instance *inst, const char *name,
 void crypto_init_queue(struct crypto_queue *queue, unsigned int max_qlen);
 int crypto_enqueue_request(struct crypto_queue *queue,
 			   struct crypto_async_request *request);
+void crypto_enqueue_request_head(struct crypto_queue *queue,
+				 struct crypto_async_request *request);
 struct crypto_async_request *crypto_dequeue_request(struct crypto_queue *queue);
 static inline unsigned int crypto_queue_len(struct crypto_queue *queue)
 {
-- 
2.1.0


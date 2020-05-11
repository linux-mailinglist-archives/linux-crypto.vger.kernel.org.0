Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C751CD78A
	for <lists+linux-crypto@lfdr.de>; Mon, 11 May 2020 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgEKLTm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 11 May 2020 07:19:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52254 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgEKLTk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 11 May 2020 07:19:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BBJSah099239;
        Mon, 11 May 2020 06:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589195968;
        bh=D+FkBTnlxhFt8rwKSbgbew41pOYqmQRAEPiRqzTmXOQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k7SqLLlClB8ZEFDGzF/pEUjn9BCGo8CrPPLntbI3b+zIRIG5Y5f+HFEkqF/iHxxmM
         rptNWFqR9e5RqifD7oSS0UxIFqrIPgD+VXAzz9u9Uz7HBCgqRoZbashL7sLX+DNUEF
         u59A9G19vHup5sEpc5STyVYuRMfsE9RvYj5S1cvQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BBJSUk003413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 06:19:28 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 06:19:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 06:19:28 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BBJKOY004306;
        Mon, 11 May 2020 06:19:27 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <linux-omap@vger.kernel.org>
Subject: [PATCHv2 4/7] crypto: omap-sham: huge buffer access fixes
Date:   Mon, 11 May 2020 14:19:10 +0300
Message-ID: <20200511111913.26541-5-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511111913.26541-1-t-kristo@ti.com>
References: <20200511111913.26541-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The ctx internal buffer can only hold buflen amount of data, don't try
to copy over more than that. Also, initialize the context sg pointer
if we only have data in the context internal buffer, this can happen
when closing a hash with certain data amounts.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-sham.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 0c837bbd8f0c..9823d7dfca9c 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -751,8 +751,15 @@ static int omap_sham_align_sgs(struct scatterlist *sg,
 	int offset = rctx->offset;
 	int bufcnt = rctx->bufcnt;
 
-	if (!sg || !sg->length || !nbytes)
+	if (!sg || !sg->length || !nbytes) {
+		if (bufcnt) {
+			sg_init_table(rctx->sgl, 1);
+			sg_set_buf(rctx->sgl, rctx->dd->xmit_buf, bufcnt);
+			rctx->sg = rctx->sgl;
+		}
+
 		return 0;
+	}
 
 	new_len = nbytes;
 
@@ -896,7 +903,7 @@ static int omap_sham_prepare_request(struct ahash_request *req, bool update)
 	if (hash_later < 0)
 		hash_later = 0;
 
-	if (hash_later) {
+	if (hash_later && hash_later <= rctx->buflen) {
 		scatterwalk_map_and_copy(rctx->buffer,
 					 req->src,
 					 req->nbytes - hash_later,
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

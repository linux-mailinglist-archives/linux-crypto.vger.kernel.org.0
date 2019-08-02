Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E969B7EF94
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfHBIri (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 04:47:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37000 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHBIri (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 04:47:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BF5B5200C4E;
        Fri,  2 Aug 2019 10:47:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B356420007A;
        Fri,  2 Aug 2019 10:47:36 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 732D4205E3;
        Fri,  2 Aug 2019 10:47:36 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v5] crypto: gcm - restrict assoclen for rfc4543
Date:   Fri,  2 Aug 2019 11:47:33 +0300
Message-Id: <1564735653-7262-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Based on seqiv, IPsec ESP and rfc4543/rfc4106 the assoclen can be 16 or
20 bytes.

From esp4/esp6, assoclen is sizeof IP Header. This includes spi, seq_no
and extended seq_no, that is 8 or 12 bytes.
In seqiv, to asscolen is added the IV size (8 bytes).
Therefore, the assoclen, for rfc4543, should be restricted to 16 or 20
bytes, as for rfc4106.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
Changes since v4:
- alignment.
---
 crypto/gcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/gcm.c b/crypto/gcm.c
index 2f3b50f..7388420 100644
--- a/crypto/gcm.c
+++ b/crypto/gcm.c
@@ -1034,12 +1034,14 @@ static int crypto_rfc4543_copy_src_to_dst(struct aead_request *req, bool enc)
 
 static int crypto_rfc4543_encrypt(struct aead_request *req)
 {
-	return crypto_rfc4543_crypt(req, true);
+	return crypto_ipsec_check_assoclen(req->assoclen) ?:
+	       crypto_rfc4543_crypt(req, true);
 }
 
 static int crypto_rfc4543_decrypt(struct aead_request *req)
 {
-	return crypto_rfc4543_crypt(req, false);
+	return crypto_ipsec_check_assoclen(req->assoclen) ?:
+	       crypto_rfc4543_crypt(req, false);
 }
 
 static int crypto_rfc4543_init_tfm(struct crypto_aead *tfm)
-- 
2.1.0


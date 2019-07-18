Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777496D006
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jul 2019 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGROnb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jul 2019 10:43:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38092 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGROna (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jul 2019 10:43:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 21F1D200088;
        Thu, 18 Jul 2019 16:43:29 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15433200009;
        Thu, 18 Jul 2019 16:43:29 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C55A5205C7;
        Thu, 18 Jul 2019 16:43:28 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH] crypto: gcm - restrict assoclen for rfc4543
Date:   Thu, 18 Jul 2019 17:43:04 +0300
Message-Id: <1563460984-24593-1-git-send-email-iuliana.prodan@nxp.com>
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
---
 crypto/gcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/crypto/gcm.c b/crypto/gcm.c
index 33f45a9..4d720e6 100644
--- a/crypto/gcm.c
+++ b/crypto/gcm.c
@@ -1048,11 +1048,17 @@ static int crypto_rfc4543_copy_src_to_dst(struct aead_request *req, bool enc)
 
 static int crypto_rfc4543_encrypt(struct aead_request *req)
 {
+	if (req->assoclen != 16 && req->assoclen != 20)
+		return -EINVAL;
+
 	return crypto_rfc4543_crypt(req, true);
 }
 
 static int crypto_rfc4543_decrypt(struct aead_request *req)
 {
+	if (req->assoclen != 16 && req->assoclen != 20)
+		return -EINVAL;
+
 	return crypto_rfc4543_crypt(req, false);
 }
 
-- 
2.1.0


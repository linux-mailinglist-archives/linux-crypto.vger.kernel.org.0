Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB12B7D6
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfE0Ove (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 10:51:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54895 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfE0Ovc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 10:51:32 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 39EEF240005;
        Mon, 27 May 2019 14:51:29 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 06/14] crypto: inside-secure - change returned error when a descriptor reports an error
Date:   Mon, 27 May 2019 16:50:58 +0200
Message-Id: <20190527145106.8693-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch changes the error reported by the Inside Secure SafeXcel
driver when a result descriptor reports an error, from -EIO to -EINVAL,
as this is what the crypto framework expects. This was found while
running the crypto extra tests.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index d5392893973c..316e5e4c1c74 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -591,7 +591,7 @@ inline int safexcel_rdesc_check_errors(struct safexcel_crypto_priv *priv,
 		dev_err(priv->dev,
 			"cipher: result: result descriptor error (0x%x)\n",
 			rdesc->result_data.error_code);
-		return -EIO;
+		return -EINVAL;
 	} else if (rdesc->result_data.error_code == BIT(9)) {
 		/* Authentication failed */
 		return -EBADMSG;
-- 
2.21.0


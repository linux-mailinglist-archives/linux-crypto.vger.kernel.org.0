Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A636D778
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Jul 2019 01:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfGRX6o (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jul 2019 19:58:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53232 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfGRX6T (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jul 2019 19:58:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AD6082003CB;
        Fri, 19 Jul 2019 01:58:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A07C6200003;
        Fri, 19 Jul 2019 01:58:17 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DDEE205D1;
        Fri, 19 Jul 2019 01:58:17 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 14/14] crypto: caam - change return value in case CAAM has no MDHA
Date:   Fri, 19 Jul 2019 02:57:56 +0300
Message-Id: <1563494276-3993-15-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

To be consistent with other CAAM modules, caamhash should return 0
instead of -ENODEV in case CAAM has no MDHA.

Based on commit 1b46c90c8e00 ("crypto: caam - convert top level drivers to libraries")
the value returned by entry point is never checked and
the exit point is always executed.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamhash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index e89913b..d4e047f 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -2008,7 +2008,7 @@ int caam_algapi_hash_init(struct device *ctrldev)
 	 * is not present.
 	 */
 	if (!md_inst)
-		return -ENODEV;
+		return 0;
 
 	/* Limit digest size based on LP256 */
 	if (md_vid == CHA_VER_VID_MD_LP256)
-- 
2.1.0


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397A8138D40
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jan 2020 09:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgAMIyt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Jan 2020 03:54:49 -0500
Received: from inva020.nxp.com ([92.121.34.13]:43128 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbgAMIyt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Jan 2020 03:54:49 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F4831A161F;
        Mon, 13 Jan 2020 09:54:47 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5309F1A042D;
        Mon, 13 Jan 2020 09:54:47 +0100 (CET)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 02E5D204D3;
        Mon, 13 Jan 2020 09:54:46 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: caam/qi2 - fix typo in algorithm's driver name
Date:   Mon, 13 Jan 2020 10:54:35 +0200
Message-Id: <20200113085435.30723-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index fe2a628e8905..28669cbecf77 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -2455,7 +2455,7 @@ static struct caam_aead_alg driver_aeads[] = {
 				.cra_name = "echainiv(authenc(hmac(sha256),"
 					    "cbc(des)))",
 				.cra_driver_name = "echainiv-authenc-"
-						   "hmac-sha256-cbc-desi-"
+						   "hmac-sha256-cbc-des-"
 						   "caam-qi2",
 				.cra_blocksize = DES_BLOCK_SIZE,
 			},
-- 
2.17.1


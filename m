Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE71D229807
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jul 2020 14:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgGVMPR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jul 2020 08:15:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51518 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732261AbgGVMPP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jul 2020 08:15:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1055200901;
        Wed, 22 Jul 2020 14:15:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B3BD02008FF;
        Wed, 22 Jul 2020 14:15:13 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 52762202AC;
        Wed, 22 Jul 2020 14:15:13 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 7/7] crypto: caam/qi2 - add module alias
Date:   Wed, 22 Jul 2020 15:14:58 +0300
Message-Id: <20200722121458.8478-8-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722121458.8478-1-horia.geanta@nxp.com>
References: <20200722121458.8478-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add a module alias, to enable udev-based module autoloading:

$ modinfo -F alias drivers/crypto/caam/dpaa2_caam.ko
fsl-mc:v00001957ddpseci

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 700e1d50211f..66ae1d581168 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -5405,6 +5405,7 @@ static const struct fsl_mc_device_id dpaa2_caam_match_id_table[] = {
 	},
 	{ .vendor = 0x0 }
 };
+MODULE_DEVICE_TABLE(fslmc, dpaa2_caam_match_id_table);
 
 static struct fsl_mc_driver dpaa2_caam_driver = {
 	.driver = {
-- 
2.17.1


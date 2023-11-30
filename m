Return-Path: <linux-crypto+bounces-418-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C07FEF5F
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 13:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DB2B20C73
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CF47A56
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Nov 2023 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B281B3
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 04:28:01 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8g96-005IJp-Nl; Thu, 30 Nov 2023 20:27:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Nov 2023 20:28:05 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Thu, 30 Nov 2023 20:28:05 +0800
Subject: [PATCH 8/19] crypto: ccp - Remove cfb and ofb
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1r8g96-005IJp-Nl@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Remove the unused CFB/OFB implementation.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/ccp/ccp-crypto-aes.c |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-aes.c b/drivers/crypto/ccp/ccp-crypto-aes.c
index 918e223f21b6..d11daaf47f06 100644
--- a/drivers/crypto/ccp/ccp-crypto-aes.c
+++ b/drivers/crypto/ccp/ccp-crypto-aes.c
@@ -266,24 +266,6 @@ static struct ccp_aes_def aes_algs[] = {
 		.ivsize		= AES_BLOCK_SIZE,
 		.alg_defaults	= &ccp_aes_defaults,
 	},
-	{
-		.mode		= CCP_AES_MODE_CFB,
-		.version	= CCP_VERSION(3, 0),
-		.name		= "cfb(aes)",
-		.driver_name	= "cfb-aes-ccp",
-		.blocksize	= 1,
-		.ivsize		= AES_BLOCK_SIZE,
-		.alg_defaults	= &ccp_aes_defaults,
-	},
-	{
-		.mode		= CCP_AES_MODE_OFB,
-		.version	= CCP_VERSION(3, 0),
-		.name		= "ofb(aes)",
-		.driver_name	= "ofb-aes-ccp",
-		.blocksize	= 1,
-		.ivsize		= AES_BLOCK_SIZE,
-		.alg_defaults	= &ccp_aes_defaults,
-	},
 	{
 		.mode		= CCP_AES_MODE_CTR,
 		.version	= CCP_VERSION(3, 0),


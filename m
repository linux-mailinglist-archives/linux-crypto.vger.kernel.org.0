Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92AE79C036
	for <lists+linux-crypto@lfdr.de>; Tue, 12 Sep 2023 02:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353826AbjIKVvA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 11 Sep 2023 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjIKMDm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 11 Sep 2023 08:03:42 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D72E4B;
        Mon, 11 Sep 2023 05:03:37 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B9T7ID009467;
        Mon, 11 Sep 2023 14:03:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=DHZkvrsPbLKzcjpy5QIekMLzqwjqX3hQlQ5u65J1ZwU=; b=Cm
        s54SIReqi0bRKUISSuqQc9rlmMo4ZXeX87EHe9MJFQY+ez64pWyTYYpGxOtM5i/8
        yATOPGwUh5VWlK4tw9e64aYa345WqtoYYwkSVIEY43s/+F7hYZ8SdDmPKyvv1zN4
        52wOtlUugEYvYbDZWwnphKbqDRKexJCkyvaYPZPY3lPDFONQT1ci10Ht0A1cwAtz
        TZ3Py/ZY9uP0f/Iq79DZo8vndy1oEHB/VzYdzYVLbRa0URsq6vHgqULM9dHeEtSX
        p2hl3ayeAo4aZ7PRaV6l/+VPRQMVQy0u/47p4qvEJ1JFCRCtVZKJ2Gf3Eq3ZSrzO
        pR00qi6bkklovEao9g+Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t0du50ym9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 14:03:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E4EB100061;
        Mon, 11 Sep 2023 14:03:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 043E1237D89;
        Mon, 11 Sep 2023 14:03:22 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 14:03:21 +0200
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Lionel Debieve <lionel.debieve@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH v2 05/10] hwrng: stm32 - rework error handling in stm32_rng_read()
Date:   Mon, 11 Sep 2023 14:01:58 +0200
Message-ID: <20230911120203.774632-6-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
References: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Try to conceal seed errors when possible. If, despite the error
concealing tries, a seed error is still present, then return an error.

A clock error does not compromise the hardware block and data can
still be read from RNG_DR. Just warn that the RNG clock is too slow
and clear RNG_SR.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---

Changes in V2:
	- Use WARN_ONCE instead of WARN_ON as it was buggy

 drivers/char/hw_random/stm32-rng.c | 53 +++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index adefe8edfd07..9dac177d5286 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -43,6 +43,8 @@
 
 #define RNG_HTCR		0x10
 
+#define RNG_NB_RECOVER_TRIES	3
+
 struct stm32_rng_data {
 	u32	cr;
 	u32	nscr;
@@ -162,10 +164,10 @@ static int stm32_rng_conceal_seed_error(struct hwrng *rng)
 
 static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
-	struct stm32_rng_private *priv =
-	    container_of(rng, struct stm32_rng_private, rng);
+	struct stm32_rng_private *priv = container_of(rng, struct stm32_rng_private, rng);
+	unsigned int i = 0;
+	int retval = 0, err = 0;
 	u32 sr;
-	int retval = 0;
 
 	pm_runtime_get_sync((struct device *) priv->rng.priv);
 
@@ -174,30 +176,57 @@ static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 
 	while (max >= sizeof(u32)) {
 		sr = readl_relaxed(priv->base + RNG_SR);
-		/* Manage timeout which is based on timer and take */
-		/* care of initial delay time when enabling rng	*/
+		/*
+		 * Manage timeout which is based on timer and take
+		 * care of initial delay time when enabling the RNG.
+		 */
 		if (!sr && wait) {
-			int err;
-
 			err = readl_relaxed_poll_timeout_atomic(priv->base
 								   + RNG_SR,
 								   sr, sr,
 								   10, 50000);
-			if (err)
+			if (err) {
 				dev_err((struct device *)priv->rng.priv,
 					"%s: timeout %x!\n", __func__, sr);
+				break;
+			}
+		} else if (!sr) {
+			/* The FIFO is being filled up */
+			break;
 		}
 
-		/* If error detected or data not ready... */
 		if (sr != RNG_SR_DRDY) {
-			if (WARN_ONCE(sr & (RNG_SR_SEIS | RNG_SR_CEIS),
-					"bad RNG status - %x\n", sr))
+			if (sr & RNG_SR_SEIS) {
+				err = stm32_rng_conceal_seed_error(rng);
+				i++;
+				if (err && i > RNG_NB_RECOVER_TRIES) {
+					dev_err((struct device *)priv->rng.priv,
+						"Couldn't recover from seed error\n");
+					return -ENOTRECOVERABLE;
+				}
+
+				continue;
+			}
+
+			if (WARN_ONCE((sr & RNG_SR_CEIS), "RNG clock too slow - %x\n", sr))
 				writel_relaxed(0, priv->base + RNG_SR);
-			break;
 		}
 
+		/* Late seed error case: DR being 0 is an error status */
 		*(u32 *)data = readl_relaxed(priv->base + RNG_DR);
+		if (!*(u32 *)data) {
+			err = stm32_rng_conceal_seed_error(rng);
+			i++;
+			if (err && i > RNG_NB_RECOVER_TRIES) {
+				dev_err((struct device *)priv->rng.priv,
+					"Couldn't recover from seed error");
+				return -ENOTRECOVERABLE;
+			}
+
+			continue;
+		}
 
+		i = 0;
 		retval += sizeof(u32);
 		data += sizeof(u32);
 		max -= sizeof(u32);
-- 
2.25.1


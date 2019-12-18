Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6C11247A4
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Dec 2019 14:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfLRNGf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Dec 2019 08:06:35 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36507 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfLRNGe (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Dec 2019 08:06:34 -0500
Received: by mail-yb1-f194.google.com with SMTP id i72so701189ybg.3;
        Wed, 18 Dec 2019 05:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLvtTu0iHUAbQNrPMJwjkYDRQN1HEyZB81c7bvFy51I=;
        b=LmEgq8T3GhYVnbpj2z1maAorPmuff99uKGN0ZfuimRcg6sYy3qRPp+LdZr4PRj2aRw
         VZOO1lwkj6vpN+pJ0y4z+rcfq2yMaxfXFXAiTXwG7ZW8EIiL1Z4XLJT2p8KZcDTfqbY4
         XH7byI1snMcp+5L4HbJBnpkzxffwk2fXKCHN8n2c6t1lSRKnH/e65HPsOt91aH3bsvg3
         gPUf1VnQr+ExTS6QQ1xiP34m1WGhYSF0i6YHgSTxqBnMNMYw0n70WJATjSus/sCWilkd
         jzhTtPy/ka4da7jCc4mowI0Hyc01ACDCM3LJblEAtchxEUH2qe/Xfjp70yRyl+Skvs4n
         veGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLvtTu0iHUAbQNrPMJwjkYDRQN1HEyZB81c7bvFy51I=;
        b=CoYnr160+snsxqVeVC0fu6JSx55WcLRvgd5aablUYlCyzlciI6UO6AFHwDshIQNp9j
         4PZF1B34B3uma63waClnFKN8H2fD3szS4fLlEIAziulZVk67BlD1bViJxzAA2CuwO8Ay
         uc3BDkC4QpAcxTCg/vd0xaqOFs6PyUYebcPWnAE8xuRLdfKQvY141p4r7hAfOKJpqaZ+
         2Flo9VWYZp7I4YmOo5VbfjBBqBTe704saOBbCt2t63qbafJJQUOrYceURL8HlNLCSDXH
         Bam0yj/5iNYxK6fxjX+NyxKhPNpdDsm+Ym2IikkS7LDwpoVLZyjOZW1dLnXEHCRxOBYQ
         Kytw==
X-Gm-Message-State: APjAAAVVAuTLHsxqk5QRRhCug7oPjrKSXYO1trlqriqNDOpsVS5EvNkF
        yCuIKzErHjDGvzec85AohW8=
X-Google-Smtp-Source: APXvYqye7Sy3prxUkdr/R+2wy3dwiz8/O/H9PLFNLjpaDK4B9Cnxqzzc6zJaVzkU9mHwpecbCHQApw==
X-Received: by 2002:a25:d109:: with SMTP id i9mr1595655ybg.46.1576674392819;
        Wed, 18 Dec 2019 05:06:32 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id r64sm909603ywg.84.2019.12.18.05.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:06:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH V3 3/3] arm64: defconfig: Enable CRYPTO_DEV_FSL_CAAM
Date:   Wed, 18 Dec 2019 07:06:16 -0600
Message-Id: <20191218130616.13860-3-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218130616.13860-1-aford173@gmail.com>
References: <20191218130616.13860-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Both the i.MX8MQ and i.MX8M Mini support the CAAM driver, but it
is currently not enabled by default.

This patch enables this as a module.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Make it a module instead of building it into the kernel.
V2:  New to series

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2aea3e..d08a34371f74 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -845,6 +845,7 @@ CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 CONFIG_CRYPTO_DEV_SUN8I_CE=m
+CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-- 
2.20.1


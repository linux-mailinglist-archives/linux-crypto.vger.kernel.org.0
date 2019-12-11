Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCB11BCF1
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfLKT2S (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 14:28:18 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35604 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbfLKT2S (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:18 -0500
Received: by mail-pf1-f201.google.com with SMTP id r2so2718400pfl.2
        for <linux-crypto@vger.kernel.org>; Wed, 11 Dec 2019 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+AvX3U8tZ4b8BiNANQzx7evp/O/27ZLdKyQrn0pJXbo=;
        b=DtM9qYehCfFNg/2rDxI9xbbVLYFNzd7QNXDoduc3ewRCMVgsIBSrgdNK5ptL+U4f+2
         r67/3YrnkoLP7Kqiaz+JAnGYBbYp91kDvxX0ElG4278lRGtqmi82fxSlS+/E0HJKlCJ2
         Pxf8r+Wx2vW2j1NVRovGNlQ6d9dl9a+90t/5GtKZELnNvodiQsb9QM9G4+kICCGyWT34
         BikGd90MK2nF5sFfrxHGijgzYzgkkuRp93o8jjSmRsAr4wlMv9uTK1Col8Wpaoq82MTI
         uxNScY05gmd/DRSdPfpQ9UdSWG4SUXok6uU6aqu5cBqV2PCE4FKZHWP0rt3hpdxJsCFA
         xi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+AvX3U8tZ4b8BiNANQzx7evp/O/27ZLdKyQrn0pJXbo=;
        b=A7ops8xMZdwKLaYQXWsHAns6/lSk82KDiG2fKVewgAkd1892nu1/itThfTPWztYNFL
         SpU50+gaG5sbpMaEd67lBMVpXSsXdQ27zQ7vCdaGG2OdHJov2IkrLd3genkw7ZbAa+0X
         afV7olWc9DAYCSAhr0yGHZYNYjsC/JQ0B4zqRowg2PTpYhuxtN3wkXsWwlsGpDIIt16n
         G56RufkdyRGLxz9f9Et3CoB8yZBryvtkQpr+eIOksPqMaYDY6PAvvVxvcKei6/DXZksM
         o9N+4Qwa8cdLIefEgkVMDr+gYxVXMSYp3oTLKGTNZ8h199P4zH7/dpQBfSTEt0GMCpwl
         mA5g==
X-Gm-Message-State: APjAAAUH3ATS/koscKVpO8Cj4z6/F9kx4sJIZy6bGgMUbMSL88n2MsQU
        1+MjSqp1HH+oZ3u67o/SAYmQhbkq3bxNBVq/xDjIoA==
X-Google-Smtp-Source: APXvYqzo2ljEGvchzRcyIbUEZT9wdgSNT2CgcXIYDlIj+7NoyR/2724Q+hSDkumLb2AjZxDXvEVS1q4vfz+to4FDTj4n7g==
X-Received: by 2002:a63:d642:: with SMTP id d2mr5757128pgj.205.1576092497512;
 Wed, 11 Dec 2019 11:28:17 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:40 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 5/7] crypto: amlogic: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/crypto/amlogic/amlogic-gxl-core.o: in function `meson_crypto_probe':
drivers/crypto/amlogic/amlogic-gxl-core.c:240: undefined reference to `devm_platform_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/crypto/amlogic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/amlogic/Kconfig b/drivers/crypto/amlogic/Kconfig
index b90850d18965f..cf95476026708 100644
--- a/drivers/crypto/amlogic/Kconfig
+++ b/drivers/crypto/amlogic/Kconfig
@@ -1,5 +1,6 @@
 config CRYPTO_DEV_AMLOGIC_GXL
 	tristate "Support for amlogic cryptographic offloader"
+	depends on HAS_IOMEM
 	default y if ARCH_MESON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
-- 
2.24.0.525.g8f36a354ae-goog


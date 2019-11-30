Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20BC110DFAE
	for <lists+linux-crypto@lfdr.de>; Sat, 30 Nov 2019 23:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3WwH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 30 Nov 2019 17:52:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34140 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3WwH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 30 Nov 2019 17:52:07 -0500
Received: by mail-yw1-f65.google.com with SMTP id l14so9579703ywh.1;
        Sat, 30 Nov 2019 14:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vwkyglGpGorvOt8VZHrq8ULnpvVj1p5SSJOevBnU2o=;
        b=dT2+IP+O2lloskItMtC50uGcnA6bCqf8SFoGPWc8Hvug8ZofdNiXjH19sNBzTKFGUo
         xipC/EG29KSb20komeiZIiWko/RUn6KTMPcvu+71JUYs0397XeDbsyXTcol0KgangbFy
         cquh4yfKJdd7mMxjuykxkVWIQ7/Lg3fwG0XlfYiV+WX/KTKD+sxVTEyUrE7jHo5uOJvo
         rJHFPB0oLbc9wFqK0fF9kn55bVbNfRUlg7sGJofONDtJLGqJJrsBPePNpmPtfHd+MyB1
         OonhnH2E1Ed+eOQqzK13QcrhP+ZoB2UQFYLajvKXdO6wbA5FIIgRB6Bj4gmVOeguOHUZ
         LbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vwkyglGpGorvOt8VZHrq8ULnpvVj1p5SSJOevBnU2o=;
        b=Z5gd/aR9ArCOi2bPdgizp7kK7ijgoNaBUmSQdeSzUD6soxxR54Jc/AcIwfJ1ve4viH
         XK/+vpFB13mcGv5XllpUqSodoe0YHLBo+lMkkppx3tgr4ZR2YqBmgbwG0iozNfsllDjT
         7jd0EXikx+c6hlK5Y1/tOHCD4v6zo6oRfbns9TOZ1uzNpGmPtvwFCZz8vP4F0lH36W8j
         1iR3l5MbOPsG5IgwTd9pz2mMgKvDCHjiFCAVBd4TVh9RWTWR2sW30eXZLP96CIoJ1TiL
         dp2WHv9n92knZ8mvaE59V1nqPnsE7o5zNMcwzsl8cUWnMgNcF5bM58FbU+dyS371tism
         jOoQ==
X-Gm-Message-State: APjAAAUci9XP6MfxWEuMYPclzZrN+HKkm3Qxg+UMLBPYqd70+6daNPZm
        JtbIC3c+SDaq+82N/BquSwm4qmeYMKE=
X-Google-Smtp-Source: APXvYqzG0+1UOh78swj9TMiUg4a0b4QtGl5kLXlVeA+BzgYMDVGWmEOA28YNrHvlTRkAbmm/Y373vQ==
X-Received: by 2002:a81:7b08:: with SMTP id w8mr16074667ywc.133.1575154325471;
        Sat, 30 Nov 2019 14:52:05 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id y9sm2028163ywc.19.2019.11.30.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 14:52:04 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: caam: Change the i.MX8MQ check support all i.MX8M variants
Date:   Sat, 30 Nov 2019 16:51:51 -0600
Message-Id: <20191130225153.30111-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The i.MX8M Mini uses the same crypto engine as the i.MX8MQ, but
the driver is restricting the check to just the i.MX8MQ.

This patch lets the driver support all i.MX8M Variants if enabled.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index db22777d59b4..1ce03f8961b6 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -527,7 +527,7 @@ static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
-	{ .soc_id = "i.MX8MQ", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8M*", .data = &caam_imx7_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
 };
-- 
2.20.1


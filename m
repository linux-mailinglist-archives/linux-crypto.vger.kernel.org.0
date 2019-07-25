Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5417583A
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jul 2019 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfGYTng (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 25 Jul 2019 15:43:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34100 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfGYTnL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 25 Jul 2019 15:43:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so52029147wrm.1
        for <linux-crypto@vger.kernel.org>; Thu, 25 Jul 2019 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rCLV7+XgVoqa77OFHC2tYmqnV175cwJKyP8wP05iwpI=;
        b=RlLIlegsq38ldfiYl5JNdHC+1z0E685X1TVdFQdFCMU1V/XLKm7JrAD2RvkbUS+6jX
         BILivk9wLP0APZgO5lmITzu4fkNC5o32dWuFHM+rifJdCmOEAitkh8jjjFybowbmh8M9
         /BkfyiGnbr+MBkZK60Cm/t5fcuMHxnea/yNrmTo5itWn9JD9WK6PBWKaJASAaw0LJ/JG
         soehhQzDJiTgZgrtbwxxGvSfkqmG2US8YOUdv8bTBv94MlMDY+ttdRrFyyyODXI6Jc3i
         XOXSQ0HRjUOZHf0HzFZXtf6pBDT5YS5QzvWqcGQBXqj2aFF69BTfnskgOd21uJc18QP/
         kPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rCLV7+XgVoqa77OFHC2tYmqnV175cwJKyP8wP05iwpI=;
        b=Rq7eesC/KhhC5OcUSZWy0FegXLRqQk7YoyXEBjQUgTFCXjCxXwLyvZaAzym8BtLdzr
         1NJgKWjj7iDD/II6ZGPnXdw52Q/F+iqxVk+yzsE045AftZCKtIpSaohk99RMm43GvVtx
         B58E2Q1qUuYyRSa+cN7l+o3k0XD5EAeN8uj1jrS1Q5JGXEFX4NIW36b3amWB3r2GLlkt
         3NiG3tcWjfHGv1ic9ke9dPjd6ANLzO9jx61+L6o1CtzmPps0LmceB46CN7HYJJ5QUBge
         TOBOEq5EIRTW4RgVEgZ3aWekUivHq3/0dKz+RRX38oOYrl4WbrjIydeGWhbitEJlTDcD
         CHFA==
X-Gm-Message-State: APjAAAXgLp5ijuAgnUDQAmDb5aMUagh86RuKx5OIl7qOfMs9vMdbENm/
        OthTdvm41fX55h1trXcOJp5ulg==
X-Google-Smtp-Source: APXvYqyWLBlCaPGOONr/8VuVeNPBnAgDE597l7zfFJNDEyXa14Jyu2F+mFFV14v0+EMTQFwN3Z2iUA==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr56554103wrv.327.1564083789686;
        Thu, 25 Jul 2019 12:43:09 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y16sm103410662wrg.85.2019.07.25.12.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 12:43:09 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        khilman@baylibre.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, baylibre-upstreaming@groups.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/4] MAINTAINERS: Add myself as maintainer of amlogic crypto
Date:   Thu, 25 Jul 2019 19:42:55 +0000
Message-Id: <1564083776-20540-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564083776-20540-1-git-send-email-clabbe@baylibre.com>
References: <1564083776-20540-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

I will maintain the amlogic crypto driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93d6cae3274d..48e7fd110688 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1450,6 +1450,13 @@ F:	drivers/mmc/host/meson*
 F:	drivers/soc/amlogic/
 N:	meson
 
+ARM/Amlogic Meson SoC Crypto Drivers
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/amlogic/
+F:	Documentation/devicetree/bindings/crypto/amlogic*
+
 ARM/Amlogic Meson SoC Sound Drivers
 M:	Jerome Brunet <jbrunet@baylibre.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.21.0


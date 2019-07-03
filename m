Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FC5DF77
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jul 2019 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGCIOq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jul 2019 04:14:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41141 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfGCION (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jul 2019 04:14:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so848522pff.8;
        Wed, 03 Jul 2019 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNJCQUNcof8kUIy33ye35eh+3AWm1VC+G5oQzkM3XSE=;
        b=W1PlvIKgP130iBW/CWaGg2E4gyreddiydyWXoUFaUxVZda2Sa+Ywmjc4qtpjQfAFil
         w6TcV2W4rf12tLJf0F4jS4OWmfauCs0HyJ6aN0VOx+Spl11pm76ZVRC3Pw2HUnP5/zI2
         ZrllQ63V+fmRd0NjBC7vrNbBVB4b11xbj6M8mwzupQWAItiRTTWEZzPfDO9WQI4ZAX7k
         aUwUZsZz/rjL1Hr94Myg9iQxF5L+NaTXfb7uI13uO9UxaOlP+8iBjZkKWZ0ozlEQ9AJX
         3wpnJgzKhd8hAant7dFiJx2sK4NbzEyPBdR+qCJlLW24sh8yH8IMlGTrK8nf24o+ierA
         G8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNJCQUNcof8kUIy33ye35eh+3AWm1VC+G5oQzkM3XSE=;
        b=hyPkyCAN0ck3z2UDTE2D0O8nPLdIItYW0bn0NrePutPjWUlv3LKtVpEM58WRPA44OG
         G/lYitONHEas4SADDpVla4ABTlTCYnHZll47Jd2kyiulPQlixH5ZbdJmtL5MHwc0Fhyh
         DDbCQyXBwKRJb+du32RVbv17O0ipTRammuBn78QxXZNKFESlasAKJGyHVq+McWNFOx3p
         CHOzQ8PmxvdvIsgcxQGvcWdTIW7yjffiWduQeeV2kYPERa5MaqZCI0VLe+hAoY46SLvj
         haEZ7k3/ax/cB/ABzJG+5/csSc/rqsxB80HYaRfrt5BZd4mADBb6bciQacbdf2Cy7ana
         NjKA==
X-Gm-Message-State: APjAAAV+ufrSpetaLQpp1j8qNPybqyvaV+LS4fZPSEv27DaY329Grmjf
        W9juA4UMVU9HJvmAKwZsPdMY/nuGFoU=
X-Google-Smtp-Source: APXvYqzLhtW9WvGwVBrx3SpH3veFov4tarZ2p7IpD8tq3OaiQwQgT2pZm4IoMoiEEQ13tlrXBiTpAw==
X-Received: by 2002:a63:a41:: with SMTP id z1mr35542460pgk.290.1562141652048;
        Wed, 03 Jul 2019 01:14:12 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d2sm1445306pgo.0.2019.07.03.01.14.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 01:14:11 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/16] crypto: caam - move cpu_to_caam_dma() selection to runtime
Date:   Wed,  3 Jul 2019 01:13:22 -0700
Message-Id: <20190703081327.17505-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703081327.17505-1-andrew.smirnov@gmail.com>
References: <20190703081327.17505-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Instead of selecting the implementation of
cpu_to_caam_dma()/caam_dma_to_cpu() at build time using the
preprocessor, convert the code to do that at run-time using IS_ENABLED
macro. This is needed to add support for i.MX8MQ. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/regs.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index fb494d14f262..511e28ba740a 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -188,13 +188,21 @@ static inline u64 caam_dma64_to_cpu(u64 value)
 	return caam64_to_cpu(value);
 }
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-#define cpu_to_caam_dma(value) cpu_to_caam_dma64(value)
-#define caam_dma_to_cpu(value) caam_dma64_to_cpu(value)
-#else
-#define cpu_to_caam_dma(value) cpu_to_caam32(value)
-#define caam_dma_to_cpu(value) caam32_to_cpu(value)
-#endif /* CONFIG_ARCH_DMA_ADDR_T_64BIT */
+static inline u64 cpu_to_caam_dma(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return cpu_to_caam_dma64(value);
+	else
+		return cpu_to_caam32(value);
+}
+
+static inline u64 caam_dma_to_cpu(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return caam_dma64_to_cpu(value);
+	else
+		return caam32_to_cpu(value);
+}
 
 /*
  * jr_outentry
-- 
2.21.0


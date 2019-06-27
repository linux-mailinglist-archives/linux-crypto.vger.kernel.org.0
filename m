Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D35887F
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0Rfe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 13:35:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33099 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0Rfd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 13:35:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so1347272pgk.0;
        Thu, 27 Jun 2019 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=84ahqC+50mO9UAvH/8d+QbUCMmIMaV0w1CUferEMczw=;
        b=PQeEpo4wE9FmqoMEGX+E1GRBFCAtoLnmlmwiA3EMaSdvtKw48PTDtpIl+OEA0Q7n/L
         rsX1UoffZBqTwE+9nK/4H0ZY9fqoFM/APDLPfJzqFkxHWFBvLZi5mp9iDqP492hXf0hb
         TJRc7/Cs3J9xEHPlNQ1BDXvhsCYdSXIk3bxCfbt/eJxCX9Bb3P9BPoF+JE35+e3MsinN
         qbOYzYeV9Pq4eGXZ2bmO46Mj6UMSwPp2akfLm2ZaCg5eWSG97fIoS/dL3NusrsCnZxxJ
         TbkDgvxaVSuX4fGJv5qWzhcNY77KV6UEg09VOqDRCi5EXyQMvpEypYdFXGNNnY+pyvvt
         y2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=84ahqC+50mO9UAvH/8d+QbUCMmIMaV0w1CUferEMczw=;
        b=DKtVBRqZti4Z7m393uJ2rh8AGdLOFBY9LN69wWtNoimFuPseIAXVXxN6GuxnIF8ixP
         HsQJb+HKYC4+ltun78d/C+HDUlAnQFtom/jtMMWlDWhjPMl0EBp+KsOndpq+nKYlZ7BI
         MXuJvwVW4tRw6IsogBYAXFeDiUn9cT37CczSHDIhVCUuOnB21W/5cm0EzX3Iwq4Au4H4
         3QfXVGV0rHwUCtu3G5AjW2QDWd1CwDFMJPpowL4BxyHVbx07QeHTmdM5HNLWjq4wah/S
         OIr7GaKXZrhnRscL1/zPo/oc0C0vttkTgftybH9lUx0A2iejP6zxHazhAfCMjrEGUtnC
         0WQQ==
X-Gm-Message-State: APjAAAWqZpHuAroiL+syH2BWaQLJO4dH4G6LoXjmEdY6hHfaPPpiKzQv
        6HviKx7uGdRrGJp8snw2arg=
X-Google-Smtp-Source: APXvYqxeCvY50jYpTWVeQxBWVRm9La51KkeHY6C5ZyqNYd1dHoCt4hRfyl9lKtVVM4bUl7byG1qlKg==
X-Received: by 2002:a63:18c:: with SMTP id 134mr4728426pgb.432.1561656932949;
        Thu, 27 Jun 2019 10:35:32 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id c130sm3739317pfc.184.2019.06.27.10.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:35:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Lamparter <chunkeey@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/87] crypto: amcc: Remove call to memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:35:23 +0800
Message-Id: <20190627173524.2403-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

    In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
    dma_alloc_coherent has already zeroed the memory.
    So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/crypto/amcc/crypto4xx_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 16d911aaa508..5e7f2e233406 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -182,7 +182,6 @@ static u32 crypto4xx_build_pdr(struct crypto4xx_device *dev)
 				  dev->pdr_pa);
 		return -ENOMEM;
 	}
-	memset(dev->pdr, 0, sizeof(struct ce_pd) * PPC4XX_NUM_PD);
 	dev->shadow_sa_pool = dma_alloc_coherent(dev->core_dev->device,
 				   sizeof(union shadow_sa_buf) * PPC4XX_NUM_PD,
 				   &dev->shadow_sa_pool_pa,
-- 
2.11.0


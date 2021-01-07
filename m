Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906F2ECFD1
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Jan 2021 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAGMck (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 7 Jan 2021 07:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbhAGMcj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 7 Jan 2021 07:32:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBAEC0612F8;
        Thu,  7 Jan 2021 04:31:58 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e2so3392567plt.12;
        Thu, 07 Jan 2021 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hdFxs07OBJ0o+UoENy6opg4NHXCcbJpiwkpmIdQiwws=;
        b=dQn+QrXHQpOycT6rbO+tf/VR/2QMy4WJQF4X1T/636no6mAkXVAUjrvWMo2nT3dhFS
         MRRo62EKaGJGptO13DIwa9Vfw1/KvufSuLeEwv0p+z6zizrGznfJEWjEMmUYfoKXa5av
         vaNh0FRL0qWbKfl2tWLS12tIf0FIF9NcCzWZmVgwNXTNPnU+q7TYDy8xjYu6yqUln3Xu
         consEYNhfD0raTk6uE5r5k4ZmRqPEPFhYDR3tmSOElpVw4P6ZDKVtdlw8DoACyY0M+dK
         D++6FYanSQwP8nPSDOjL1iy35Zd3R1kjHN7FknwJFVRwqmtIFwRRYb5R8MOuyUqhU4O2
         2GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hdFxs07OBJ0o+UoENy6opg4NHXCcbJpiwkpmIdQiwws=;
        b=CJdZ7BRoDRn89B5tc6iFlfvzcs23nzJKKJB72N4kz1X/1LpJlvZytkLFqc1wu5SlEA
         Zi2/5p7EBdMnHI4VcvT4E8q86yNMHZ4ZRkzXA1OGllXRI7qQWwRKFyWX85qljFeq1a5r
         Vhi3facp0FLg/ymaxLFeP6sRUyyiQw8QXY5qh+aZW0OK9aqR23RDpkRjMvc4hRWO7KB6
         GYp1hxOBQT/Gh75UhltkLzXeZjUEKV4YWTlb7IM4GJlK/grG9PiNOCHvzIX8hB8hL0dw
         NQNHTVmfFM+1i8VOEzyTvLh5fNzP7J9k4zChDk/QkxvVkGdvTnKf4A2hSqnIDpU5j/gf
         gI4Q==
X-Gm-Message-State: AOAM531bnhA/o4dPWnQH5i70E4Yle4L9rMEOxQibzjHOXaFxFkHL/KFf
        f+oMXhOeyiTPkBs4kWaynds=
X-Google-Smtp-Source: ABdhPJzM7buCkj+xCGO+fl9i/Vq0V/mCKApgwiynjVFCmVMVTl6IZTP5hTcXLXfj7QsK6v7+eTgE8g==
X-Received: by 2002:a17:902:c195:b029:db:c725:2522 with SMTP id d21-20020a170902c195b02900dbc7252522mr8855200pld.83.1610022718182;
        Thu, 07 Jan 2021 04:31:58 -0800 (PST)
Received: from localhost.localdomain ([49.207.216.201])
        by smtp.gmail.com with ESMTPSA id h12sm6356014pgk.70.2021.01.07.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 04:31:57 -0800 (PST)
From:   Allen Pais <allen.lkml@gmail.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        jesper.nilsson@axis.com, lars.persson@axis.com,
        horia.geanta@nxp.com, aymen.sghaier@nxp.com, gcherian@marvell.com,
        thomas.lendacky@amd.com, john.allen@amd.com, gilad@benyossef.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        matthias.bgg@gmail.com, jamie@jamieiles.com,
        giovanni.cabiddu@intel.com, heiko@sntech.de, krzk@kernel.org,
        vz@mleia.com, k.konieczny@samsung.com,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        qat-linux@intel.com, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Allen Pais <apais@linux.microsoft.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 17/19] crypto: s5p: convert tasklets to use new tasklet_setup() API
Date:   Thu,  7 Jan 2021 17:59:42 +0530
Message-Id: <20210107122944.16363-14-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107122944.16363-1-allen.lkml@gmail.com>
References: <20210107122944.16363-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/crypto/s5p-sss.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
index 682c8a450a57..128512a365e1 100644
--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -1445,9 +1445,9 @@ static int s5p_hash_handle_queue(struct s5p_aes_dev *dd,
  * s5p_hash_tasklet_cb() - hash tasklet
  * @data:	ptr to s5p_aes_dev
  */
-static void s5p_hash_tasklet_cb(unsigned long data)
+static void s5p_hash_tasklet_cb(struct tasklet_struct *t)
 {
-	struct s5p_aes_dev *dd = (struct s5p_aes_dev *)data;
+	struct s5p_aes_dev *dd = from_tasklet(dd, t, hash_tasklet);
 
 	if (!test_bit(HASH_FLAGS_BUSY, &dd->hash_flags)) {
 		s5p_hash_handle_queue(dd, NULL);
@@ -1975,9 +1975,9 @@ static void s5p_aes_crypt_start(struct s5p_aes_dev *dev, unsigned long mode)
 	s5p_aes_complete(req, err);
 }
 
-static void s5p_tasklet_cb(unsigned long data)
+static void s5p_tasklet_cb(struct tasklet_struct *t)
 {
-	struct s5p_aes_dev *dev = (struct s5p_aes_dev *)data;
+	struct s5p_aes_dev *dev = from_tasklet(dev, t, tasklet);
 	struct crypto_async_request *async_req, *backlog;
 	struct s5p_aes_reqctx *reqctx;
 	unsigned long flags;
@@ -2258,7 +2258,7 @@ static int s5p_aes_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 	s5p_dev = pdata;
 
-	tasklet_init(&pdata->tasklet, s5p_tasklet_cb, (unsigned long)pdata);
+	tasklet_setup(&pdata->tasklet, s5p_tasklet_cb);
 	crypto_init_queue(&pdata->queue, CRYPTO_QUEUE_LEN);
 
 	for (i = 0; i < ARRAY_SIZE(algs); i++) {
@@ -2268,8 +2268,7 @@ static int s5p_aes_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->use_hash) {
-		tasklet_init(&pdata->hash_tasklet, s5p_hash_tasklet_cb,
-			     (unsigned long)pdata);
+		tasklet_setup(&pdata->hash_tasklet, s5p_hash_tasklet_cb);
 		crypto_init_queue(&pdata->hash_queue, SSS_HASH_QUEUE_LENGTH);
 
 		for (hash_i = 0; hash_i < ARRAY_SIZE(algs_sha1_md5_sha256);
-- 
2.25.1


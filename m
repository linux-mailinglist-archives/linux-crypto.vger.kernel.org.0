Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02525D783
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Sep 2020 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgIDLhE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Sep 2020 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgIDLKR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD09C061251
        for <linux-crypto@vger.kernel.org>; Fri,  4 Sep 2020 04:10:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o21so5724726wmc.0
        for <linux-crypto@vger.kernel.org>; Fri, 04 Sep 2020 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=a8BrO6udlqxdyuGU28A92cZCiYcUSD2su+5p7v7c3nvkb6/7BpS8K4IuVu5hUkvCGI
         OGWfgVVb8EafZ6VWTYtBakT9kf+WAtF3GfdYPafixsaXbZUhpKPvIXurJlVy3/yZYSt+
         4LTEwMPOiYKMTLgrKwz/2FKIURBdsrb7ffYKITbEeheUTjkoOkQGQFLs2S0seQLKVjLG
         LhVQ4BSyz9tlfwDDje+IR8ZDQVaeug4muuinxWCdk5Sqne0m7tx6uITRkuYnHrKgMJe1
         n1UBhPayZ1GqzXEhM0hy4KcVJ5EljdpwClVU1hUOmNvSdttGEmNhbzD7s8KSKxtZIN7P
         tE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FT+2gDwi+eo+TtESsfWRD1fT3NbLCZL+Gr5RVIpvd9A=;
        b=NDIK/aJ0fV3OnY9Td/LAPC1BnyM4jZS9rwzB+UniuGx8Hbe13S1Lgy3xM3qMKkTYp6
         Mj+ty+WmNc3lxXrBiNuCQXhA5cEm+I6ENFvq3AzSdu5v2hjQCOX+dMjCQN8WQHKiX3nm
         /c0eYnQXosLoK+UrqyPlv7BxcVDLETNicCXXyD1v/eXmvkYJuqrqUVnvCNNcRcr9qnlW
         kOYPK9BdzoUai2gO9JoIHkr9vMHvKlbNCExAKyO4RTj/2cH45PmkIXBiUewYV2NvGbt2
         nmcy/BCLRYYIl77rtTpDT3VxFLindHTaVw1Ax+txxFfdBosnHNxBHMOWhsEgBTYYRomq
         bJ2g==
X-Gm-Message-State: AOAM531bJpQLh34EC1dEu7tBSrTUzPSDe9gvZQnFXkui8TsgU83lVz4K
        G/BEybUT2uGepOJXkRkWI7NFsw==
X-Google-Smtp-Source: ABdhPJy04C8/p+fmq52PwzrBd2umCaqC3Mr5btRRscqtBGxSf3nIJbcHD7PikiMxfyp9Rp49HbattQ==
X-Received: by 2002:a1c:a3c4:: with SMTP id m187mr7482650wme.159.1599217815551;
        Fri, 04 Sep 2020 04:10:15 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 04/18] crypto: sun8i-ss: fix a trivial typo
Date:   Fri,  4 Sep 2020 11:09:49 +0000
Message-Id: <1599217803-29755-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This fixes a trivial typo.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 377ea7acb54d..da71d8059019 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -100,7 +100,7 @@ struct ss_clock {
  * @alg_hash:	list of supported hashes. for each SS_ID_ this will give the
  *              corresponding SS_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @ss_clks!	list of clock needed by this variant
+ * @ss_clks:	list of clock needed by this variant
  */
 struct ss_variant {
 	char alg_cipher[SS_ID_CIPHER_MAX];
-- 
2.26.2


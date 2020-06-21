Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5467202C51
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2020 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgFUTcK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Jun 2020 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgFUTbS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Jun 2020 15:31:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1EC06179A
        for <linux-crypto@vger.kernel.org>; Sun, 21 Jun 2020 12:31:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so12604672wrm.4
        for <linux-crypto@vger.kernel.org>; Sun, 21 Jun 2020 12:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgwWsZ4vgrBdNIRZyns63cVZRVYxjzfpG44UZZ9qy6E=;
        b=AQxes4jDEkOJtaNCtYYi8ZGqsolaCbfgiINJB07Ifa3ZBfgCWMFUfrtivzTvAsJaj4
         VbobKmUSAkIWcQg+BudWmvWJaEbB5P+HbxpkvZm2wyQTa6auqw2a341WMs1b6RVxHgkJ
         itCZyEnCKXYnCCvH/y3zc3bpqalXoCYaCn1x34rA9BYsByYKOTWmVgpvbmWyK86+u01x
         lfCtMvn9UIMcfN4oG2kV2qyMBHUGVHtA5ZGWj+b+s/Zh6sDQeTOy32eoBEzw1P+ll9QM
         GgMkQc/oP9EOJ6B1hLc8dfvAwIUzKAZx2juNl9VHKXrgEgzMp6gUpGV5Ji9gulcUC5RW
         J/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GgwWsZ4vgrBdNIRZyns63cVZRVYxjzfpG44UZZ9qy6E=;
        b=RE/pysdfNN7ejML5t+kL9ewzUOxiKBvMCSwLL233SGNVpFRsgr/nirzgwTHq/j4CYe
         oJ0al/4XG7UZvn4lDtc7KygkPOhycl3/U3D4WBo/bQ0tFsRHaL5x0c+sW9IQ6CgQ0vNa
         H2+/MQllcNta1JHFxu/IsjXDJNoauAkKSmv3ep1F9BWnLtBhBuSGoPiTHQD99jtgg8O+
         wVLNuLqqKq+5DpeVeuQyDFH9BZ7+L7CducBur30kg0A3ltiUeL+e0xIwrZ5Ja9P7T9c6
         b72LydK0787Jl+78z8r4tUykE33FRgjTbMAxKttxtsDEoeoitzTLEJD9CNYVbOubfBT4
         396g==
X-Gm-Message-State: AOAM532PMcEE91UnWfSo3EHDZ9UHNw5ZmPFkOTp5ZSXPgfqftYfG7Knt
        yhhiXnTy//WbqcMgkfQuA23qtA==
X-Google-Smtp-Source: ABdhPJwLip0kXrlfAv5IxYrcZDDIHaEW1U89Or8S2HyPV8an8VCkQGkclX3b3mgmSUkutC97mIBTdA==
X-Received: by 2002:adf:d852:: with SMTP id k18mr15469079wrl.177.1592767876948;
        Sun, 21 Jun 2020 12:31:16 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e3sm16086924wrj.17.2020.06.21.12.31.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 12:31:16 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 04/14] crypto: sun8i-ss: fix a trivial typo
Date:   Sun, 21 Jun 2020 19:30:57 +0000
Message-Id: <1592767867-35982-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
References: <1592767867-35982-1-git-send-email-clabbe@baylibre.com>
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
index 350a611b0b9e..056fcdd14201 100644
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


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE9354324
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Apr 2021 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhDEPGO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Apr 2021 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhDEPGN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Apr 2021 11:06:13 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0EC061756;
        Mon,  5 Apr 2021 08:06:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x16so5552667qvk.3;
        Mon, 05 Apr 2021 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HkmaU7uO+Gqi6kwhuOZHzewjW4WyDN9p8QYZvkjmLUQ=;
        b=o404+zvxbJSKgDlbAkPMDH2HzDB5brq2vP5av3WsRS2UuUrCuotltU74N0QB8HY2s0
         Ha91HZwZDunWX+0+9cNbsqPogw6T56JcvaNJvEk3cgb5NUNOnF8bNdvGLQUt5igABMpS
         ikfluW8Wdk7m0mkZsG/OTTloYLXSasnMUTGzVlMF+qKxLtHd1iHBGO53UpvAyPZsODE0
         9FXlkNETRqJEKspdbig8ho2/4kZYIROfVFMqjl1dNgG+ySM93k5IwuvUjq+/V/5NtqTG
         TnZDsnb+3kXYgMMaJoy4vBV/Gfr7tqV5C4s5bohYLwHTIFO4fM+2B3oxMVLf5ILuIQDd
         wxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HkmaU7uO+Gqi6kwhuOZHzewjW4WyDN9p8QYZvkjmLUQ=;
        b=AIuuMRCpkhMPY91rdGMPxNGj7y3knIbjd3EmSrNH54kF9SB3/weLSGlCOzQw9PGcCm
         EKNTuX3t3QRdvFBbfudJr0sggWWI5pG3KPc99J147Om2HzhrEHskX7cLZ/F7p6kq8hG0
         0QGhs6dvlsnh2A1JodTqRBmXsdinhluLY+2dB8yscn9NufByP89AqGTus83+M9+7C7Mc
         tyHPvK+YTx4sqgkI+Yc5Dn/QusSRXMgX0NETKgJUHE/hrTVep8gtjql6zcJN7EWEw5gB
         ikeFxhFfoo6hviWZ8K1bJa88rDmKw1zezNijMWMGmdnSIob8hRfG3jGizO3qcR6BOlV2
         1ahQ==
X-Gm-Message-State: AOAM532EnF0AOuolpmw/sdbh1X7q8Y3ccSwWVPI/MgF+VxjV8cOi6u2K
        VLmZYVvJBlPzxsERCQAAFKg=
X-Google-Smtp-Source: ABdhPJygbYx3zJzhtrL72zf74ZJyzq2AzYW85ZUytYz9wR9ou1xTAM6ilMcXTeWHSSRpesUBgQT60g==
X-Received: by 2002:a05:6214:d65:: with SMTP id 5mr23915240qvs.56.1617635166456;
        Mon, 05 Apr 2021 08:06:06 -0700 (PDT)
Received: from ubuntu-mate-laptop.hsd1.fl.comcast.net ([2601:703:380:74f0:1809:8a92:469f:d1b4])
        by smtp.gmail.com with ESMTPSA id h13sm12362025qtn.26.2021.04.05.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 08:06:06 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] crypto: fix CRYPTO_LIB_* dependencies on CRYPTO
Date:   Mon,  5 Apr 2021 11:04:38 -0400
Message-Id: <20210405150438.177783-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently, when a config option selects a
CRYPTO_LIB_* option while CRYPTO is disabled,
Kbuild gives an unmet dependency. However,
these config options do not actually need to
depend on CRYPTO.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5809cc198fa7..fb7eca5cb8c6 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1870,9 +1870,9 @@ config CRYPTO_STATS
 config CRYPTO_HASH_INFO
 	bool
 
-source "lib/crypto/Kconfig"
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
 
 endif	# if CRYPTO
+source "lib/crypto/Kconfig"
-- 
2.27.0


Return-Path: <linux-crypto+bounces-128-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CCC7ED752
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Nov 2023 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232341C2092E
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Nov 2023 22:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605143AAD
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Nov 2023 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FE11A7;
	Wed, 15 Nov 2023 13:02:44 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d33298f8fdso49178a34.1;
        Wed, 15 Nov 2023 13:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082163; x=1700686963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTi1+MQ4t5FTtGD8dbognkLQKmg8VuTrouDfFHJxxvg=;
        b=mjoZqnDe8MUnwwGlpMZ99z59jIWVvqJ3k/eqr9rq7GXs8PB11z4PcmLsqN0NvzIsne
         yK2r1tDRWJ6Xs8He5UNVtEkPCd9zxah1u82aZaM2OYRfhKm9nQZttPXwIBxuKxmSxNhF
         3f+Sb/RIb8JoY+P4Gvgscoac8YTB41OhKWFpSzWemIENByBkRlfjALCKNEFj01or8iFe
         NOZrEPGR86tN64mf8KzZbvGENwmW7sL8/AZguJTSQjIVRYmMzKh4daLTCM8g3je5BWYH
         JQ9RuwiG/+nye72CCQmZdxCNhuKnsPQyLrgbNBX+nPF1Ip06bwgQfgNxQsg0I70U1WAT
         71MQ==
X-Gm-Message-State: AOJu0Yxn69PJ57CkJdZG2lIScUgKVs7lZx+TVqLHZSeS4GzkYVSuUD//
	1EoVqxAEuEhrCqKOF9A0POXiHO01gA==
X-Google-Smtp-Source: AGHT+IEitGC+5jlDZ7EaZ0678OAJ949TtdOz5HBhiVZghOLkf7I0tD27/xf5oMCnotNNPXveWv/0NA==
X-Received: by 2002:a05:6830:4414:b0:6ce:2789:7195 with SMTP id q20-20020a056830441400b006ce27897195mr7902852otv.31.1700082163575;
        Wed, 15 Nov 2023 13:02:43 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s30-20020a056830439e00b006ce2e464a45sm693017otv.29.2023.11.15.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:02:42 -0800 (PST)
Received: (nullmailer pid 3744532 invoked by uid 1000);
	Wed, 15 Nov 2023 21:02:42 -0000
From: Rob Herring <robh@kernel.org>
To: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] hwrng: ingenic: Replace of_device.h with explicit of.h include
Date: Wed, 15 Nov 2023 15:02:37 -0600
Message-ID: <20231115210238.3744406-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other and pull in various other headers. In
preparation to fix this, adjust the includes for what is actually needed.

of_device.h isn't needed, but of.h is and was implicitly included by it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/hw_random/ingenic-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/ingenic-rng.c b/drivers/char/hw_random/ingenic-rng.c
index 4f18c3fa5427..c74ded64fbe3 100644
--- a/drivers/char/hw_random/ingenic-rng.c
+++ b/drivers/char/hw_random/ingenic-rng.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-- 
2.42.0



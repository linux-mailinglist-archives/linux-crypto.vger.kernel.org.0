Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB5D2288B7
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Jul 2020 21:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgGUTG4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Jul 2020 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbgGUTGt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DCCC0619DD
        for <linux-crypto@vger.kernel.org>; Tue, 21 Jul 2020 12:06:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so22193843wrp.7
        for <linux-crypto@vger.kernel.org>; Tue, 21 Jul 2020 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1465M1vFg+DkpfzTSKRwwfPqDEbWJM1n/xiu1TorbUA=;
        b=VdYA0y1Ei0gkN2fH5Qc4/fLTN1tdv5jaRXoBW8fB8bS7y+8JWBj59dmlgFxZIklSri
         KlzyT7AVFAOX7+IyHHBd+JYVNIS9vvNS4i5bbK1oUvDW6FsNa9oEMfx/0ZXVOcQKEIWZ
         y6d/P6l/J5gM4/O3FakMjDIL2jDczigmpGnLgk5QztRyrzS5zgkXt1MX+7I4GaFR9mG9
         Jx6rjJZnalkxw2okQZ71h0w3F8LFRiaGBQuJTdle7IHH2eQrMEe/lfv7retAwE/vR1zE
         Thhd9c2xvAKYVlpaqQtDe2DES0AtA6S6Kx8V9VHn/7faVctMUf2KtoJq7pMwSClPmldw
         hQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1465M1vFg+DkpfzTSKRwwfPqDEbWJM1n/xiu1TorbUA=;
        b=LeFJSatsL/jWuUQYTcNT0nwYH5LJLt2d1kKYqkbvFB2+goMvET3RtBufglDcveB5Sf
         dx0HuLTjw7bHA6E5HTh+Jysg0QTvZK6ri1TMjaK1NsAnWnFsxmRMAPF01tgeZXWrE2mp
         Mn2ySU2D/siBrcgEP+NxuUEjcjQHe4gvQTFpH9CNDe18UmbRtBpVo8S1sDtdexZyiliY
         pQOruBJd7TCYOh5/HdRimDsltwlvFGPU9jz8QnlgT+1bmN8qUoHwsc+/fZPBRrAqx5vg
         mtdmp+BpoBCHV3ArwNFlKTnD5Rt2wCINTy8kpRwnVc3yPP+89lR0I1zk0Fh+itgTMGPN
         dRPQ==
X-Gm-Message-State: AOAM531aJcaSDh5/Gn6csTdj15PJMJ0AGm6+P8Gfc8Q92rCNmZSuxoG4
        ipZvyFyYQLnUnasCpmB3zXF5uGAsjz8=
X-Google-Smtp-Source: ABdhPJww2rOK5JGcPh/ySRPPA16Y9CW/XUyXRggGARtVhNZDO0D0LkeGkihk/Ar/wr+nKq0+UQa9/A==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr27797401wru.329.1595358407703;
        Tue, 21 Jul 2020 12:06:47 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:47 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 06/17] crypto: sun8i-ss: better debug printing
Date:   Tue, 21 Jul 2020 19:06:20 +0000
Message-Id: <1595358391-34525-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch reworks the way debug info are printed.
Instead of printing raw numbers, let's add a bit of context.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 12fa24e0c127..de32107817b3 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -424,19 +424,19 @@ static int sun8i_ss_dbgfs_read(struct seq_file *seq, void *v)
 			continue;
 		switch (ss_algs[i].type) {
 		case CRYPTO_ALG_TYPE_SKCIPHER:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.skcipher.base.cra_driver_name,
 				   ss_algs[i].alg.skcipher.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
 			break;
 		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
 				   ss_algs[i].alg.rng.base.cra_driver_name,
 				   ss_algs[i].alg.rng.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
 			break;
 		case CRYPTO_ALG_TYPE_AHASH:
-			seq_printf(seq, "%s %s %lu %lu\n",
+			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
 				   ss_algs[i].alg.hash.halg.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
-- 
2.26.2


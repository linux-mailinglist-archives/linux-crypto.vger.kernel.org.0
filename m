Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4266D2288B6
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Jul 2020 21:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgGUTGz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Jul 2020 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbgGUTGs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69BC0619E1
        for <linux-crypto@vger.kernel.org>; Tue, 21 Jul 2020 12:06:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so3940286wmo.1
        for <linux-crypto@vger.kernel.org>; Tue, 21 Jul 2020 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=cykZt9SLBOXQ0t4KCQOFymxUT+H6oX5W8y2T9eEEOPDEhHCHv5nRhT5EH8+U98zkP4
         GyZAF5AkKIn4TZht24/Y8bejgoFVKMtegMVWppeeGzo0x0+3JlzUpi6QH9pQiBmRt/2S
         AxnhMEV/b2QRNDOTcJBjs4nhjMMuBlQfczYvsHWs6+aODH91/MIX5WrgMvhQ3YYOtaOm
         hKSjlDEPcOGY4qZOxtP7/j0MsP6m7vxaQCektmb1K+Od+NoQkbydLSlsUuf+NXSUeI2a
         /XHdHtWWTqm/dlk9YAucOE69XRRbCwhaTjVI1x0wgItFFwukO32xwmfUESI6ZL+c4ZLW
         b2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=liOvMqJ23zZD+1Jnxjs/VNAD87FK/p7rypoysOK5cqw=;
        b=PtUBevWAFgI6qMenB1g6YxjZgUZMAJ1uIxlsuXmQg92nGd5rzNi8NEIgyolXxbKJ5R
         gsNASjln3Z5rZtIUO7GuNaq0v2oZoabkC4cuvBy3FHZcfbNmpLJz/56dnwG2m1hzv2yb
         O9DiJJMpePm15g8nbZwpNKQQ9jgHYKDcknSctQmtjMq3Jc8EGo3M0b//10YZ5Sz8B59z
         xOsMREG68ETHhsHH51vpkzeIRWRfopWCeaH4Of9Psv1nvNKNbCRWZ84TAYDhCJGvPQ/m
         sFAwrtoA2AwSsu0qkxGM+0SvRa7QWakO7/g+9hoCFCQW6Z1GhbxJKSStzpdLTYTfhsh6
         j69w==
X-Gm-Message-State: AOAM532HzffV4aLHqv3/1iYlGTENLFDjnwqM2lB7draL04Yz3PFKeheN
        ulZJjQLeqn5RIplq1VXBChxMUw==
X-Google-Smtp-Source: ABdhPJzVcmQOfucyIsbFTNaNbdEQpJ3na/D8aPC43ZWPeRQZNgJRL2BPgLO7XglJeWLBYKtYK3HPCA==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr5510705wml.142.1595358406758;
        Tue, 21 Jul 2020 12:06:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 05/17] crypto: sun8i-ss: Add more comment on some structures
Date:   Tue, 21 Jul 2020 19:06:19 +0000
Message-Id: <1595358391-34525-6-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds some comment on structures used by sun8i-ss.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index da71d8059019..1a66457f4a20 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -195,6 +195,8 @@ struct sun8i_cipher_req_ctx {
  * @keylen:		len of the key
  * @ss:			pointer to the private data of driver handling this TFM
  * @fallback_tfm:	pointer to the fallback TFM
+ *
+ * enginectx must be the first element
  */
 struct sun8i_cipher_tfm_ctx {
 	struct crypto_engine_ctx enginectx;
-- 
2.26.2


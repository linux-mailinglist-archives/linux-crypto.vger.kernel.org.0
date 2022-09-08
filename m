Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBF5B2760
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Sep 2022 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIHUBr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Sep 2022 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIHUBo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Sep 2022 16:01:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE56FE4BC
        for <linux-crypto@vger.kernel.org>; Thu,  8 Sep 2022 13:01:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so26041710edd.4
        for <linux-crypto@vger.kernel.org>; Thu, 08 Sep 2022 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Po1p0rTvG7YGCHnTloMal9wCRi9fHpBptpbCbwsONI=;
        b=uq/1F+Jn3KbvrIbwUC2FgQsMGBcoqJcPk14nCHeuSDtIvGx0FY/HErATB7IZ7X/0Be
         0x44zT1EiYD9LjBFOY2kB3tCyd2Zz/dY7Wv7qF4PZPpU7Ox8h+oq0REI93GPX1TB4RBP
         aqq6GROLpsYHNtuc5LG0LEMWchpTXs+e+Fmp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Po1p0rTvG7YGCHnTloMal9wCRi9fHpBptpbCbwsONI=;
        b=Zzwu+gVU65WNvNLdwLeFivhpmPOlbccEPuwv8JX2QrXqcKTUovNvNQOHZzzLhs4/ZJ
         nPTmL5k2zdbpAV4l6FQlw+0kMHkeuyTq4uRMV0nW7fE/nLLaxRO5T6gentN/BVRkIpSK
         NZ5zRaaYx1+ZNDZwZdUh3OMyrtxHzS8Mp8Og4iuZK4g//VKlpVoSXfj9HKGpfzp9VNwi
         A6N7/D9pOBYvVmqO6nmQ3vIWWUWGHrf61qTfCmP7rpKoBO24lRfUYjkiULu1KW3U4CEl
         SpX35nxACIoAIDqrvLAzk8FEPl1DWScj+cTQqtkvBddZdytx45PXZWAsIwWev4qPSdmJ
         J91w==
X-Gm-Message-State: ACgBeo1F96SByidJEV8QJnxFCw9oXVm5wnJYe9QnOXVQ+9kTFPWiDyc5
        Gt5ayJhR1LgDHf6K4tj8t0RxUzSqYjr+9g==
X-Google-Smtp-Source: AA6agR4npFZGDVBKRyr5tobS4dLlprhevP2ZMxeJFfZyZE6JGoNKnvhUohU2xcPhJez/GiGB2UK7Rg==
X-Received: by 2002:a05:6402:e94:b0:443:e3fe:7c87 with SMTP id h20-20020a0564020e9400b00443e3fe7c87mr8865411eda.144.1662667272600;
        Thu, 08 Sep 2022 13:01:12 -0700 (PDT)
Received: from localhost.localdomain ([104.28.243.158])
        by smtp.gmail.com with ESMTPSA id kx11-20020a170907774b00b00778e3e2830esm521202ejc.9.2022.09.08.13.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:01:12 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lei he <helei.sig11@bytedance.com>, kernel-team@cloudflare.com
Subject: [PATCH 4/4] crypto: remove unused field in pkcs8_parse_context
Date:   Thu,  8 Sep 2022 21:00:36 +0100
Message-Id: <20220908200036.2034-5-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908200036.2034-1-ignat@cloudflare.com>
References: <20220908200036.2034-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

remove unused field 'algo_oid' in pkcs8_parse_context

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/asymmetric_keys/pkcs8_parser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index e507c635ead5..f81317234331 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -21,7 +21,6 @@ struct pkcs8_parse_context {
 	struct public_key *pub;
 	unsigned long	data;			/* Start of data */
 	enum OID	last_oid;		/* Last OID encountered */
-	enum OID	algo_oid;		/* Algorithm OID */
 	u32		key_size;
 	const void	*key;
 	const void	*algo_param;
--
2.36.1


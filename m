Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75683CC38E
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfJDT3e (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 15:29:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34945 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDT3d (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 15:29:33 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so16033202iop.2;
        Fri, 04 Oct 2019 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7pCNQCHb6KRDiY0XtxNFr6uVRkF5l7XBcVc0Vj3CfgE=;
        b=MPzXPeLXLefPwoDusyqcFMUVdH+/dEnYOXjidD4FgXIDGgs3G/qm6aoCkPadG3WrYH
         wTKcoajFHb3l6GK4Tv2pMKkS6WRpyg9DSMBLLqU0PRUr0Jozgicqo3x7tjfpv5Q5kN44
         2537i5K1H/Y0hn2xaNOXFkyRHSU1u49td4V4jO6mUwDBxjmt1GkX3RMLFO9RHH1sxG9/
         fCi71JziSLYKL45OHB7qs4GAEnKKp7znVWcIjoNbDohxhFrGY+/s0QuZxieSF09X5BXY
         WBwM563VyAPbz5n3HHcXsj818kyKcf9jn67nQlm3NZDYUMXw2tlD1zDWoiFRN8A6QrP+
         e/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7pCNQCHb6KRDiY0XtxNFr6uVRkF5l7XBcVc0Vj3CfgE=;
        b=bG4CM2MlUTzmvXzyvaqWmWVU8ThbZ/nS3V8Ah4tUfmihVGb6NK19G/m4ENRlm6tdMr
         0Q7bV9u4dtUsVP+1lMKQd9vASH85aPQ8XR+FPZfRGaQwuNVtEOIKWcL6T4X8qEtUH7Rl
         GenT9IAr1g0OjVKK3nfq+jMcRd5XZPNKIlIpmQ69mZ5zNqjIaPJG0sjxPyQel2rBzN2z
         tSLSYbEQ0Ln8hn0yCW+S1GUK8V/L6M8inJ+ngxUXwl5xpLOZsh6SO+DhnxfI0oumOJ+q
         U7nnYKgeB9ovuk6fzyZww/zhqr3xOjwTNe39gmivJtlCnFXNbC2MGZjPRRSFZkZUsk1q
         BqoA==
X-Gm-Message-State: APjAAAW2fMfuBZj9DDnCDlvbu5N/wlnwPfe+IZk0z7adRmDUd4iO80m+
        +xXbyzDE/sgBbsc4U7hTBBc=
X-Google-Smtp-Source: APXvYqxXjt48yFxM2eDQB81Cru1JZg8SDiyzxHPbR3CSFuvbjBxjqKRAWwoMDADXhP4QdAqTqk9ulw==
X-Received: by 2002:a6b:f312:: with SMTP id m18mr1677033ioh.210.1570217372869;
        Fri, 04 Oct 2019 12:29:32 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r22sm3970335ilb.85.2019.10.04.12.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 12:29:32 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: user - fix memory leak in crypto_report
Date:   Fri,  4 Oct 2019 14:29:16 -0500
Message-Id: <20191004192923.17491-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In crypto_report, a new skb is created via nlmsg_new(). This skb should
be released if crypto_report_alg() fails.

Fixes: a38f7907b926 ("crypto: Add userspace configuration API")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 crypto/crypto_user_base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/crypto_user_base.c b/crypto/crypto_user_base.c
index 910e0b46012e..b785c476de67 100644
--- a/crypto/crypto_user_base.c
+++ b/crypto/crypto_user_base.c
@@ -213,8 +213,10 @@ static int crypto_report(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 drop_alg:
 	crypto_mod_put(alg);
 
-	if (err)
+	if (err) {
+		kfree_skb(skb);
 		return err;
+	}
 
 	return nlmsg_unicast(net->crypto_nlsk, skb, NETLINK_CB(in_skb).portid);
 }
-- 
2.17.1


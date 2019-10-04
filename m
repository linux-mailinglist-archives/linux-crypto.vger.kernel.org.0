Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925C2CC39E
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 21:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfJDTfE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 15:35:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36406 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTfE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 15:35:04 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so16026274iof.3;
        Fri, 04 Oct 2019 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YUxdWoMjBc3fq7ZEjHVbfnvWMNYpsAW2uL8SUTPJJOk=;
        b=KfPgoQZiuCc2H7qvFQGzN/Y3EGPnFsu/TLq9CSR8tecMTpa9YL5eWsqgES34oDbm/Z
         tBCmz9oK9X/m4/+VrPKpX573tizGffhrsfpuA+Fq69Y2qLjGgld9HOjAHd01oZ83u+Oe
         IfpTdiUjqLS2q1WMSLKP4SYO6lGOL2hAK3fuICIkeFaCYYGEBCZ2DyuGyNv2KTqUkk7I
         KQb1aZ8FaukkgvjqFvRKzmxBX1EAfsP/eODyKd0CEqnIZdQbkd0Y6geyteNUOKSTNqcn
         /XpZgD+IsGXz2qWx9KTOw6csMacDX9jweaZEo3BHAZO4XGnVw+LP8rKJvYE92arFNI4q
         +LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YUxdWoMjBc3fq7ZEjHVbfnvWMNYpsAW2uL8SUTPJJOk=;
        b=MZTiefsa/zD0rlKyJnXaNkjhKxyXM1RPbiOfRsBzjAXppzdpVXEsMuoNuMbb7UL0XD
         StXE1INBYwfkI73zbAuORpk1uc3QBCg0KUc6/FT8QWdwM6pVw3g0pWbwPcnA3YhdqbTk
         0XWZReG3dHpnGJ+HjFibx9C5K2a5pTK2zAXRfXgJvSLWuhLdI26dNRjOdqmwW02tAThC
         Z86x/deIZhaQiRbpDadvJVNEx7tRQ0TT1d27Rf93LQStQ5vJW01jA5g//b8D5aB1Q4md
         mqI61eE+ughOjC7Ef3gIldPML4dtt/zOjR45rFV078yk8vaefDXDqdVnXIL309NOfiRj
         iGPg==
X-Gm-Message-State: APjAAAWuXZ3QkwcdijV+oJ20x5WQPqQsko2OjLI/I2ZE5tL5mXtDiZ9P
        Kn6oGyHFRVspaJiNUH3WmBs=
X-Google-Smtp-Source: APXvYqxdxqTqNQ2D2g2hs/N3xw+sie1sFybvZM7Bv8s50eW0Wl4EA5uLHeMeKaifDlU11aRt9jEhKg==
X-Received: by 2002:a5d:88d1:: with SMTP id i17mr14654011iol.235.1570217702565;
        Fri, 04 Oct 2019 12:35:02 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t8sm3372621ild.7.2019.10.04.12.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 12:35:01 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: user - fix memory leak in crypto_reportstat
Date:   Fri,  4 Oct 2019 14:34:54 -0500
Message-Id: <20191004193455.18348-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

In crypto_reportstat, a new skb is created by nlmsg_new(). This skb is
leaked if crypto_reportstat_alg() fails. Required release for skb is
added.

Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 crypto/crypto_user_stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 8bad88413de1..1be95432fa23 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -328,8 +328,10 @@ int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
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


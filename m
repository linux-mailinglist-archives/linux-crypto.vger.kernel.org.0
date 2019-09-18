Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F37EB5E05
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Sep 2019 09:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfIRH3J (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Sep 2019 03:29:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43434 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRH3J (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Sep 2019 03:29:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id r9so5647647edl.10
        for <linux-crypto@vger.kernel.org>; Wed, 18 Sep 2019 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAUp7GUy7+YR4UkJWKFGN2oQNliV/e1MDD0neuFDSNg=;
        b=HoYLeJDji281qlqnWxubAf5BROHoj3b+TI+m0+tn47U9Cieern97B5DQ9JVcsHAbw8
         NrTqYBNOCEvNCiPTiEbQdiUEC7gMTq2dCq/nr5YI1TqqoSGmBoMldt/lwTeaLpDdWOmh
         /3kBmcuOcb15WEC3gsPJSFcqu+gP1vbwMz1ewHf4cJz33sSOmpCfip+8hOK8fBnlWWt2
         TiiAX169hrW6fZPWWKQfpBd3RpoeBR7Z5vmX5IXwwE/9b+gbeIzkDOOgqxmaCXrqoFJi
         ua+2IAH5auPt1Sh+Ejz4zoytwkkjbRFeypWW+0ifA86icSQVjbVe/12pmM83Mob9CNDZ
         YkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SAUp7GUy7+YR4UkJWKFGN2oQNliV/e1MDD0neuFDSNg=;
        b=JPajAQJ8U2VyC9XyIL6hkeskjYilhg7Nzhm6d0zMjq1hr9CDk/RDU/rU3H1O9JzYdT
         +GwPpkpTaLm4qkslOjWm7paXQwXpEadtr4LTwEPPm9HkJAuDhY0uGjJhvmzx2D+lG+dh
         IjEqiVRn2Wt1ldcsz2L/cP5wX+baaHfpPzXnRusJqnn+ptbX8xo+tIFpJjN5ZPdwPBDt
         cDmvWsHT4mVM6MlFBO4u+M9Zsu8bkitXdcE6Ww8gNw+DZnECs4usdoRWB4Pe+8Rl4Oty
         53siz0p3/kpB2HX/9+vkyfIe9WyawDFQiuapGlzgCmiSJAGKXpm6Xhw7q/yan8SMzMLn
         7zwQ==
X-Gm-Message-State: APjAAAVI5pywYXBu1ZTbcAZzh4gC9Yp/k1/rqrgIerr23ITtc/kG5K9U
        GhveK43QeBoIEJdngTn1jCk0ubEXtJiYYi0C
X-Google-Smtp-Source: APXvYqykp/i56Wi55mw2HpUfFK71RtGnBQGDnWDExCEJYINRTOr+rGQkrS3KrytqSRhqPGhrRXtm9g==
X-Received: by 2002:a50:8a9d:: with SMTP id j29mr8941846edj.283.1568791747233;
        Wed, 18 Sep 2019 00:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:200:301a:5:438:b21e:5369:b7fd])
        by smtp.gmail.com with ESMTPSA id a20sm849952edt.95.2019.09.18.00.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:29:06 -0700 (PDT)
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     smueller@chronox.de, "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH] jitterentropy: fix comments
Date:   Wed, 18 Sep 2019 12:28:49 +0500
Message-Id: <20190918072849.6749-1-patrakov@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

One should not say "ec can be NULL" and then dereference it.
One cannot talk about the return value if the function returns void.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 crypto/jitterentropy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 77fa2120fe0c..9597f9f5723d 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -172,7 +172,7 @@ static __u64 jent_loop_shuffle(struct rand_data *ec,
  * implies that careful retesting must be done.
  *
  * Input:
- * @ec entropy collector struct -- may be NULL
+ * @ec entropy collector struct
  * @time time stamp to be injected
  * @loop_cnt if a value not equal to 0 is set, use the given value as number of
  *	     loops to perform the folding
@@ -400,8 +400,8 @@ static void jent_gen_entropy(struct rand_data *ec)
  * primes the test if needed.
  *
  * Return:
- * 0 if FIPS test passed
- * < 0 if FIPS test failed
+ * returns normally if FIPS test passed
+ * panics the kernel if FIPS test failed
  */
 static void jent_fips_test(struct rand_data *ec)
 {
-- 
2.23.0


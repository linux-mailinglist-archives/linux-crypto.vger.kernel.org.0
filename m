Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B69711180
	for <lists+linux-crypto@lfdr.de>; Thu, 25 May 2023 19:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjEYRAW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 25 May 2023 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYRAV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 25 May 2023 13:00:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542BF189
        for <linux-crypto@vger.kernel.org>; Thu, 25 May 2023 10:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685034007; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PPcQt+iJJF5FY8pY2ZsiR8MUmn3H9dWzR8XvrpSKxvT26ov6XW51iHmN1uenY3fviO
    eiRXUQ91eyMYDOfP7firp37dLu9/+DjG0xfE/UO6QZtTvvBQOSUoaTIY6smqi8djUBz5
    3S9vKQ3cfmhPcgh9yulJ9KfC6iSh4ixCB8eLUxD8QDD505tEHMrugSCmJl4d9lwJg7Jd
    GssiALEy5BgLx8D46rKKPNAidP52e/8XosgdnkgHKpDtv+q2iEvo9eUdkm232HDhVU8F
    TyyJofnITv8S7t6eb2NjkIG9fDnKJmcbkwgYpvhV+rIXF/jTxr+L2i39+AGkyIgJl7up
    6Smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685034007;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Xf/y4dfFph+WE/8Eb+V5Jm2vrKBGMeqkk3toL58uv/s=;
    b=l6mw7QGQyYu/LxvCJ0YYesNNBLRiMM2GbmMRBMtz3yMJe1vTJ3oYfEr/SrtndgXNSu
    xuBkCsavJLuLy3q5WpM5bIREHSEQXLSDWA69MxCmQe5YdPGHOLSq4Rrl/+MGeaBAjSRq
    G0osGMYDN2IzE4JJ6Hko4amwZai7Bhrj6d0TO/Tkee8FdxKF/ZNGwndrUwFPHqRI5oBg
    7Umv+mLvSjB10kkOKLcx0V+MatEsGxRgLSXqfWB9RibJlM+LzlEfUS0rct0bvyxIsgbB
    mvIK6Qn4E2KLF4VBlte1mbZO4kDyMixfu87+lIE13OjawoPEJc5g/PDZS/j5qmhtiNxs
    1log==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685034007;
    s=strato-dkim-0002; d=chronox.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Xf/y4dfFph+WE/8Eb+V5Jm2vrKBGMeqkk3toL58uv/s=;
    b=RoSxjFLWmxgoLBdtzgWYbusxCGTte9iXD5ZZuM7wtq1R+qXfGtHHSMH6iwqs3K/P1H
    rCcP6lraf0JQo3w9tQQ/zN2IWY4WkkrvG0cyNtNwyVJBkqL8cGk7FTouNVVhPG5joEbw
    NLeLHIqrHWFRi2kell8fNO9O/bDxZEAspjtOWM4wglu2rPsn8/2TGUXioCqvVsiCsnts
    DMoiJm1jODvlJuAfj84DpLrDnJzVrrOQ/Z1hnb0RBUE9vZT3YAkAGaTpo93oM67rWMNw
    +WcK6/HapIsB1LO7ZJ/sqsTpr2TjQVOQvBAwlMCmjt4H6eowT9fGxcf3+v8ybrgEeXFq
    pOnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685034007;
    s=strato-dkim-0003; d=chronox.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Xf/y4dfFph+WE/8Eb+V5Jm2vrKBGMeqkk3toL58uv/s=;
    b=K5rDLaHm+M3KlqdEQeV0cESwF8AlVUqAae85rbBY34e8a6rs3ZBwqiNdwTpSlZR8i6
    zrznTlUfnnByQnxN1ECg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9y2gdNk2TvDz0d0rb"
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id ta02b6z4PH06die
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 May 2023 19:00:06 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Cc:     Vladis Dronov <vdronov@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        Joachim Vandersmissen <git@jvdsn.com>,
        John Cabaj <john.cabaj@canonical.com>
Subject: [PATCH] crypto: jitter - correct health test during initialization
Date:   Thu, 25 May 2023 19:00:05 +0200
Message-ID: <12219330.O9o76ZdvQC@positron.chronox.de>
MIME-Version: 1.0
Autocrypt: addr=smueller@chronox.de;
 keydata=
 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
 kBFBHm+xdudNab2U0OpfqrWerOw3WcGd2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

With the update of the permanent and intermittent health errors, the
actual indicator for the health test indicates a potential error only
for the one offending time stamp gathered in the current iteration
round. The next iteration round will "overwrite" the health test result.

Thus, the entropy collection loop in jent_gen_entropy checks for
the health test failure upon each loop iteration. However, the
initialization operation checked for the APT health test once for
an APT window which implies it would not catch most errors.

Thus, the check for all health errors is now invoked unconditionally
during each loop iteration for the startup test.

With the change, the error JENT_ERCT becomes unused as all health
errors are only reported with the JENT_HEALTH return code. This
allows the removal of the error indicator.

Fixes: 3fde2fe99aa6 ("crypto: jitter - permanent and intermittent health errors"
)
Reported-by: Joachim Vandersmissen <git@jvdsn.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/jitterentropy.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index dc423210c9f9..c7d7f2caa779 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -118,7 +118,6 @@ struct rand_data {
 				   * zero). */
 #define JENT_ESTUCK		8 /* Too many stuck results during init. */
 #define JENT_EHEALTH		9 /* Health test failed during initialization */
-#define JENT_ERCT		10 /* RCT failed during initialization */
 
 /*
  * The output n bits can receive more than n bits of min entropy, of course,
@@ -713,14 +712,12 @@ int jent_entropy_init(void *hash_state)
 			if ((nonstuck % JENT_APT_WINDOW_SIZE) == 0) {
 				jent_apt_reset(&ec,
 					       delta & JENT_APT_WORD_MASK);
-				if (jent_health_failure(&ec))
-					return JENT_EHEALTH;
 			}
 		}
 
-		/* Validate RCT */
-		if (jent_rct_failure(&ec))
-			return JENT_ERCT;
+		/* Validate health test result */
+		if (jent_health_failure(&ec))
+			return JENT_EHEALTH;
 
 		/* test whether we have an increasing timer */
 		if (!(time2 > time))
-- 
2.40.1





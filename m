Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6AF8808D
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Aug 2019 18:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406394AbfHIQxj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 12:53:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39381 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIQxj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 12:53:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id e16so2378637edv.6
        for <linux-crypto@vger.kernel.org>; Fri, 09 Aug 2019 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3PJRZIrMW6wNyS7x+TJC9MmNtfowlUvPpbRGCeBr7JU=;
        b=muZLT4e5INFu5sD5s/VlFa3XYC7VovjreKLRznh2PpHgyLtw1FEh2JI8Xspd9mZvyL
         V/snVVUV+J9NtHz6OYAsCPbp5VsGQ7GTAXbCRftVdXwyXXcw1wkSg5AAiGf4W+X9var6
         kBGCGOmKDgM81IST6Hrh0pXRjtGRVma6fTYXvuHrHsN/gBpXGPVkx/J5D5TceoLbNSJA
         ArBxe+QK4FfYLgIw0Ml2HkBcKdsZCeCPl8io1HjkIUFa3++8VP5Y5K8gO6aXE2NEBKCB
         Tq15HCWNVqt1ZoADdtmIed1jbB2y9lTV7hTwfYlEIHGeLQVkGj4tEkeJGTdjkUZNCyra
         GDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3PJRZIrMW6wNyS7x+TJC9MmNtfowlUvPpbRGCeBr7JU=;
        b=K8sG8z4jV9q4vGQKRfAkM0+fGXt8W+xNrdVCyiiu17/ri6SpoFIHJd0I/Fs6j7nZNE
         lb3Dy7cdvuxZYR9t2VO+qZYi/CIN4bBahUDuEwpUCVJlGYAoGTqH0BMaQ/7m43IU3uZO
         lITqeexE30cSX1rszvP0zsGosdLmGTVyIposGELp42XG2ij1CDnDosFCw6yMsH/r/7Yi
         JtRNa0jjI47SIh4mXPtLBZC9Bwrj+sJ7uIHokayITBdEOTyQwM8o//77tMu9zDRUYNqW
         j3OljaH7ZSep1mtzAZ+S2Dh91iunBRkoBYTqOO4BM7xlEmEFnFNzOeamKAV/mGkn/XuT
         lpEA==
X-Gm-Message-State: APjAAAV5NfFLgBCKsCi+Q+tSEEOcYbele/Yu0QdPZFF3Q/zj0Zmow/2v
        z7kW0J/KO5DgIn5p5kD9DA3ckrF2
X-Google-Smtp-Source: APXvYqyNuI9AoHn62Xb0BIXSSBmAXmrjnq0r69NQ7QtBC7w2OFMCEXrbxHNK3EB3ID8m4l+kzuLvtg==
X-Received: by 2002:a50:994f:: with SMTP id l15mr23097734edb.112.1565369617944;
        Fri, 09 Aug 2019 09:53:37 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id fy18sm317063ejb.24.2019.08.09.09.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 09:53:37 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH] crypto: aead - Do not allow authsize=0 if auth. alg has digestsize>0
Date:   Fri,  9 Aug 2019 17:51:07 +0200
Message-Id: <1565365867-8251-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Return -EINVAL on an attempt to set the authsize to 0 with an auth.
algorithm with a non-zero digestsize (i.e. anything but digest_null)
as authenticating the data and then throwing away the result does not
make any sense at all.

The digestsize zero exception is for use with digest_null for testing
purposes only.

Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
---
 crypto/aead.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 4908b5e..e423107 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -75,7 +75,8 @@ int crypto_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
 {
 	int err;
 
-	if (authsize > crypto_aead_maxauthsize(tfm))
+	if ((!authsize && crypto_aead_maxauthsize(tfm)) ||
+	    authsize > crypto_aead_maxauthsize(tfm))
 		return -EINVAL;
 
 	if (crypto_aead_alg(tfm)->setauthsize) {
-- 
1.8.3.1


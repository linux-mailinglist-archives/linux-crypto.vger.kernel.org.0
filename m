Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8018232814
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Jun 2019 07:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFCFlk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 3 Jun 2019 01:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfFCFlk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 3 Jun 2019 01:41:40 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28FBC247CC
        for <linux-crypto@vger.kernel.org>; Mon,  3 Jun 2019 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559540499;
        bh=RRtDtWxurxgUphxg2/Vae6VKX4m2RpPi2rEn83c+N7o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SxwRf2Sx+MZYbVxAHVy1WlIa10aMiV1TQLvvLFiINizByzLqTo7kQAOrTBJQ6P1Rw
         urZJWo2IgVHqcSnp+Yq44awx+ZBEPTNUmZjnR0dUtC50nRfNLNAOzyTiFS0pEsCIvM
         lxD6/V4o2knfL9NeHvrSEG5+RR7QfPYyaWDKMpH0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] crypto: algapi - require cra_name and cra_driver_name
Date:   Sun,  2 Jun 2019 22:40:58 -0700
Message-Id: <20190603054058.5449-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603054058.5449-1-ebiggers@kernel.org>
References: <20190603054058.5449-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that all algorithms explicitly set cra_driver_name, make it required
for algorithm registration and remove the code that generated a default
cra_driver_name.

Also add an explicit check that cra_name is set too, since that's
obviously required too, yet it didn't seem to be checked anywhere.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/algapi.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 7c51f45d1cf16..5278e139a161e 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -26,23 +26,6 @@
 
 static LIST_HEAD(crypto_template_list);
 
-static inline int crypto_set_driver_name(struct crypto_alg *alg)
-{
-	static const char suffix[] = "-generic";
-	char *driver_name = alg->cra_driver_name;
-	int len;
-
-	if (*driver_name)
-		return 0;
-
-	len = strlcpy(driver_name, alg->cra_name, CRYPTO_MAX_ALG_NAME);
-	if (len + sizeof(suffix) > CRYPTO_MAX_ALG_NAME)
-		return -ENAMETOOLONG;
-
-	memcpy(driver_name + len, suffix, sizeof(suffix));
-	return 0;
-}
-
 static inline void crypto_check_module_sig(struct module *mod)
 {
 	if (fips_enabled && mod && !module_sig_ok(mod))
@@ -54,6 +37,9 @@ static int crypto_check_alg(struct crypto_alg *alg)
 {
 	crypto_check_module_sig(alg->cra_module);
 
+	if (!alg->cra_name[0] || !alg->cra_driver_name[0])
+		return -EINVAL;
+
 	if (alg->cra_alignmask & (alg->cra_alignmask + 1))
 		return -EINVAL;
 
@@ -79,7 +65,7 @@ static int crypto_check_alg(struct crypto_alg *alg)
 
 	refcount_set(&alg->cra_refcnt, 1);
 
-	return crypto_set_driver_name(alg);
+	return 0;
 }
 
 static void crypto_free_instance(struct crypto_instance *inst)
-- 
2.21.0


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018A72CF2AA
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Dec 2020 18:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgLDRFw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Dec 2020 12:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388471AbgLDRFw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Dec 2020 12:05:52 -0500
Received: from latitanza.investici.org (latitanza.investici.org [IPv6:2001:888:2000:56::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37AFC061A52
        for <linux-crypto@vger.kernel.org>; Fri,  4 Dec 2020 09:05:03 -0800 (PST)
Received: from mx3.investici.org (unknown [127.0.0.1])
        by latitanza.investici.org (Postfix) with ESMTP id 4CnfFJ4PVmz8sgM;
        Fri,  4 Dec 2020 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1607101460;
        bh=gIk9W+Rj/wr2yLXrcQnEBv0D9GdsEMSYb5Q/KwMf3wA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPSMRQkbP8NPk5NKlROEj7mrY8QRY3USoQVGMdhcC+Ii+r5Y4xY2pSBE2b9LkLTou
         ZJYYc6olk86+NUF/V0c72u05Bkc3o7ue9Rz1RNdfqFsXuCtAmc+AVaaNJVkzrr9D7g
         eR7OklxOVtWZKHJT1SgDvPUcVE1UNI/P4XTy6EHo=
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CnfFJ07MFz8sfb;
        Fri,  4 Dec 2020 17:04:19 +0000 (UTC)
From:   laniel_francis@privacyrequired.com
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 03/12] crypto: Replace strstarts() by str_has_prefix().
Date:   Fri,  4 Dec 2020 18:03:09 +0100
Message-Id: <20201204170319.20383-4-laniel_francis@privacyrequired.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
References: <20201204170319.20383-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Francis Laniel <laniel_francis@privacyrequired.com>

The two functions indicates if a string begins with a given prefix.
The only difference is that strstarts() returns a bool while str_has_prefix()
returns the length of the prefix if the string begins with it or 0 otherwise.

Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
---
 crypto/essiv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/essiv.c b/crypto/essiv.c
index d012be23d496..f85d4416891f 100644
--- a/crypto/essiv.c
+++ b/crypto/essiv.c
@@ -504,7 +504,7 @@ static int essiv_create(struct crypto_template *tmpl, struct rtattr **tb)
 			goto out_free_inst;
 		aead_alg = crypto_spawn_aead_alg(&ictx->u.aead_spawn);
 		block_base = &aead_alg->base;
-		if (!strstarts(block_base->cra_name, "authenc(")) {
+		if (!str_has_prefix(block_base->cra_name, "authenc(")) {
 			pr_warn("Only authenc() type AEADs are supported by ESSIV\n");
 			err = -EINVAL;
 			goto out_drop_skcipher;
-- 
2.20.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01121AF50
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2020 08:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGJGVq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jul 2020 02:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgGJGVp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jul 2020 02:21:45 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB792078B;
        Fri, 10 Jul 2020 06:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594362105;
        bh=CrjMfI1mii5iCwsAATxtZlT+5Cxljmnsjcm8uss3FRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0rfPIo/Db0XgO108fE0FT6aVsjQOS/3Hp3XCinTZSFi4ITPNf0nQ2Swl4o9FRYPJ
         M1BF3YpfdXWcKjPFHUP6D+AJlvv44HJ7WoNMaEoafE2H8on9VNq5o6i7mTeHIavJPE
         S6d5XMWlnSi3lxGaO/88zX2XjV8WBUTty2QpuxT8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>, linux-crypto@vger.kernel.org
Cc:     dm-devel@redhat.com
Subject: [PATCH v2 2/7] crypto: seqiv - remove seqiv_create()
Date:   Thu,  9 Jul 2020 23:20:37 -0700
Message-Id: <20200710062042.113842-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710062042.113842-1-ebiggers@kernel.org>
References: <20200710062042.113842-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

seqiv_create() is pointless because it just checks that the template is
being instantiated as an AEAD, then calls seqiv_aead_create().  But
seqiv_aead_create() does the exact same check, via aead_geniv_alloc().

Just remove seqiv_create() and use seqiv_aead_create() directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/seqiv.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/crypto/seqiv.c b/crypto/seqiv.c
index e48f875a7aac..23e22d8b63e6 100644
--- a/crypto/seqiv.c
+++ b/crypto/seqiv.c
@@ -164,23 +164,9 @@ static int seqiv_aead_create(struct crypto_template *tmpl, struct rtattr **tb)
 	return err;
 }
 
-static int seqiv_create(struct crypto_template *tmpl, struct rtattr **tb)
-{
-	struct crypto_attr_type *algt;
-
-	algt = crypto_get_attr_type(tb);
-	if (IS_ERR(algt))
-		return PTR_ERR(algt);
-
-	if ((algt->type ^ CRYPTO_ALG_TYPE_AEAD) & CRYPTO_ALG_TYPE_MASK)
-		return -EINVAL;
-
-	return seqiv_aead_create(tmpl, tb);
-}
-
 static struct crypto_template seqiv_tmpl = {
 	.name = "seqiv",
-	.create = seqiv_create,
+	.create = seqiv_aead_create,
 	.module = THIS_MODULE,
 };
 
-- 
2.27.0


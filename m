Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14B12D413
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Dec 2019 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfL3TmA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Dec 2019 14:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3TmA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Dec 2019 14:42:00 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56CAD2071E
        for <linux-crypto@vger.kernel.org>; Mon, 30 Dec 2019 19:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577734919;
        bh=Ojy5RggFGZ1qJfcD29JB42N1iaZRbjBGYTko6X4EEbQ=;
        h=From:To:Subject:Date:From;
        b=U3CRSgN2ZfiGzIH97umXfdwoMg2Y0swIOEzRBzGatDluPNJUEeePUP9ukk3GNY8t3
         CR7WOP/CrcUozEJQ94Ggfrg545ed5l5464xUeAgtuPcPBmaOi3QWRTbzVW1ytobrGF
         LZfh8kb0UWOwANz0wokMnqlWx8r5bIYSoBwbHK3Q=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: skcipher - remove skcipher_walk_aead()
Date:   Mon, 30 Dec 2019 13:41:15 -0600
Message-Id: <20191230194115.71642-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

skcipher_walk_aead() is unused and is identical to
skcipher_walk_aead_encrypt(), so remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/skcipher.c                  | 9 ---------
 include/crypto/internal/skcipher.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/crypto/skcipher.c b/crypto/skcipher.c
index 8dc9dc80b379..21f1421980e6 100644
--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -549,15 +549,6 @@ static int skcipher_walk_aead_common(struct skcipher_walk *walk,
 	return err;
 }
 
-int skcipher_walk_aead(struct skcipher_walk *walk, struct aead_request *req,
-		       bool atomic)
-{
-	walk->total = req->cryptlen;
-
-	return skcipher_walk_aead_common(walk, req, atomic);
-}
-EXPORT_SYMBOL_GPL(skcipher_walk_aead);
-
 int skcipher_walk_aead_encrypt(struct skcipher_walk *walk,
 			       struct aead_request *req, bool atomic)
 {
diff --git a/include/crypto/internal/skcipher.h b/include/crypto/internal/skcipher.h
index b81cb4902abc..e387424f6247 100644
--- a/include/crypto/internal/skcipher.h
+++ b/include/crypto/internal/skcipher.h
@@ -135,8 +135,6 @@ int skcipher_walk_virt(struct skcipher_walk *walk,
 void skcipher_walk_atomise(struct skcipher_walk *walk);
 int skcipher_walk_async(struct skcipher_walk *walk,
 			struct skcipher_request *req);
-int skcipher_walk_aead(struct skcipher_walk *walk, struct aead_request *req,
-		       bool atomic);
 int skcipher_walk_aead_encrypt(struct skcipher_walk *walk,
 			       struct aead_request *req, bool atomic);
 int skcipher_walk_aead_decrypt(struct skcipher_walk *walk,
-- 
2.24.1


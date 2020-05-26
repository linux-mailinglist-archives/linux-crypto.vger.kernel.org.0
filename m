Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5E1C233F
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2020 07:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgEBFde (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 May 2020 01:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgEBFdd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 May 2020 01:33:33 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D9D5206D9
        for <linux-crypto@vger.kernel.org>; Sat,  2 May 2020 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588397613;
        bh=oBgtRZJ95t0RPE1PvPURSgv/NWE/2cwO3eTdsW65i6s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HijCSXk8llDX/K/Vs+fKG49fcNVvd9NOD3xrUuspSRiIBahSQK+zg7EdrvJADX3Ao
         EsTtBrzJxplkDfa430wjy4lLofANPnPH0Q2KpYyc7vuvalnwUf6vQB7OXY9GAsEgR8
         9S7nL/DV1Q9kW6VwOxoTajwI09PodSJYkJxeCX+E=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 02/20] crypto: arm64/aes-glue - use crypto_shash_tfm_digest()
Date:   Fri,  1 May 2020 22:31:04 -0700
Message-Id: <20200502053122.995648-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
References: <20200502053122.995648-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Instead of manually allocating a 'struct shash_desc' on the stack and
calling crypto_shash_digest(), switch to using the new helper function
crypto_shash_tfm_digest() which does this for us.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/crypto/aes-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index ed5409c6abf4e9..395bbf64b2abb3 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -158,7 +158,6 @@ static int __maybe_unused essiv_cbc_set_key(struct crypto_skcipher *tfm,
 					    unsigned int key_len)
 {
 	struct crypto_aes_essiv_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
-	SHASH_DESC_ON_STACK(desc, ctx->hash);
 	u8 digest[SHA256_DIGEST_SIZE];
 	int ret;
 
@@ -166,8 +165,7 @@ static int __maybe_unused essiv_cbc_set_key(struct crypto_skcipher *tfm,
 	if (ret)
 		return ret;
 
-	desc->tfm = ctx->hash;
-	crypto_shash_digest(desc, in_key, key_len, digest);
+	crypto_shash_tfm_digest(ctx->hash, in_key, key_len, digest);
 
 	return aes_expandkey(&ctx->key2, digest, sizeof(digest));
 }
-- 
2.26.2


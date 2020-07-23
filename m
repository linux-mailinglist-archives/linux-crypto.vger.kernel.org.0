Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0622AA09
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGWHvT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:51:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34622 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgGWHvT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:51:19 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyW08-0005oy-S3; Thu, 23 Jul 2020 17:50:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:50:48 +1000
Date:   Thu, 23 Jul 2020 17:50:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] crypto: x86/curve25519 - Remove unused carry variables
Message-ID: <20200723075048.GA10966@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The carry variables are assigned but never used, which upsets
the compiler.  This patch removes them.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index 8a17621f7d3a..8acbb6584a37 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -948,10 +948,8 @@ static void store_felem(u64 *b, u64 *f)
 {
 	u64 f30 = f[3U];
 	u64 top_bit0 = f30 >> (u32)63U;
-	u64 carry0;
 	u64 f31;
 	u64 top_bit;
-	u64 carry;
 	u64 f0;
 	u64 f1;
 	u64 f2;
@@ -970,11 +968,11 @@ static void store_felem(u64 *b, u64 *f)
 	u64 o2;
 	u64 o3;
 	f[3U] = f30 & (u64)0x7fffffffffffffffU;
-	carry0 = add_scalar(f, f, (u64)19U * top_bit0);
+	add_scalar(f, f, (u64)19U * top_bit0);
 	f31 = f[3U];
 	top_bit = f31 >> (u32)63U;
 	f[3U] = f31 & (u64)0x7fffffffffffffffU;
-	carry = add_scalar(f, f, (u64)19U * top_bit);
+	add_scalar(f, f, (u64)19U * top_bit);
 	f0 = f[0U];
 	f1 = f[1U];
 	f2 = f[2U];
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

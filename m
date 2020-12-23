Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40652E19C3
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgLWIOP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 03:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgLWIOP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 03:14:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 346EF224D3;
        Wed, 23 Dec 2020 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608711176;
        bh=Kg5dRTba2a6zJZ3NuTGgwpK24+5oriIRi29coh0tJW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYRMu+FBeoVMUcupJYwwZOqU7b3daxt5OZvbwW9/YVdasPjxbBiMVzwBWPD20425A
         F0qckfosbCHfAIJtvgLvuvKtjKx8+eBrYBRRC+vuLx7b0DkgjpWDt+XFUzsYNIJh6O
         sozVo5XLKJqpFQYkyNl5bBl157MTdk4GC3zN2FHXEesCYgC+L/xYoRq72ngY16rHec
         a/pXSSAsN/fDc36zkWWSSruVA4tu7SmOU5y6uAzUFME0Aw9RjsEB9rr8xZ4V8sf3Pl
         YQe93nZ9/BtOidJkcPJbBmQqHTDcM0lbSTzT6OpXBQTnH6yLkw85LXjXGORDsMQ/mV
         3UUGpJz9yy+3Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v3 07/14] crypto: blake2s - add comment for blake2s_state fields
Date:   Wed, 23 Dec 2020 00:09:56 -0800
Message-Id: <20201223081003.373663-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223081003.373663-1-ebiggers@kernel.org>
References: <20201223081003.373663-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The first three fields of 'struct blake2s_state' are used in assembly
code, which isn't immediately obvious, so add a comment to this effect.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/blake2s.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
index 734ed22b7a6aa..f1c8330a61a91 100644
--- a/include/crypto/blake2s.h
+++ b/include/crypto/blake2s.h
@@ -24,6 +24,7 @@ enum blake2s_lengths {
 };
 
 struct blake2s_state {
+	/* 'h', 't', and 'f' are used in assembly code, so keep them as-is. */
 	u32 h[8];
 	u32 t[2];
 	u32 f[2];
-- 
2.29.2


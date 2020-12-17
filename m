Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499002DDB49
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 23:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgLQW0V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 17:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732081AbgLQW0V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 17:26:21 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v2 08/11] crypto: blake2s - remove unneeded includes
Date:   Thu, 17 Dec 2020 14:21:35 -0800
Message-Id: <20201217222138.170526-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217222138.170526-1-ebiggers@kernel.org>
References: <20201217222138.170526-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It doesn't make sense for the generic implementation of BLAKE2s to
include <crypto/internal/simd.h> and <linux/jump_label.h>, as these are
things that would only be useful in an architecture-specific
implementation.  Remove these unnecessary includes.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/blake2s_generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/crypto/blake2s_generic.c b/crypto/blake2s_generic.c
index e3aa6e7ff3d83..b89536c3671cf 100644
--- a/crypto/blake2s_generic.c
+++ b/crypto/blake2s_generic.c
@@ -4,11 +4,9 @@
  */
 
 #include <crypto/internal/blake2s.h>
-#include <crypto/internal/simd.h>
 #include <crypto/internal/hash.h>
 
 #include <linux/types.h>
-#include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-- 
2.29.2


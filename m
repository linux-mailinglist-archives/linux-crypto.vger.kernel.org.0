Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5151F2DDB46
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 23:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgLQWZl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 17:25:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbgLQWZl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 17:25:41 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v2 04/11] crypto: blake2b - update file comment
Date:   Thu, 17 Dec 2020 14:21:31 -0800
Message-Id: <20201217222138.170526-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217222138.170526-1-ebiggers@kernel.org>
References: <20201217222138.170526-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The file comment for blake2b_generic.c makes it sound like it's the
reference implementation of BLAKE2b with only minor changes.  But it's
actually been changed a lot.  Update the comment to make this clearer.

Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/blake2b_generic.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index ee5084f3c92e1..9d6c0dbf1a8b5 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -1,21 +1,18 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR Apache-2.0)
 /*
- * BLAKE2b reference source code package - reference C implementations
+ * Generic implementation of the BLAKE2b digest algorithm.  Based on the BLAKE2b
+ * reference implementation, but it has been heavily modified for use in the
+ * kernel.  The reference implementation was:
  *
- * Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under the
- * terms of the CC0, the OpenSSL Licence, or the Apache Public License 2.0, at
- * your option.  The terms of these licenses can be found at:
+ *	Copyright 2012, Samuel Neves <sneves@dei.uc.pt>.  You may use this under
+ *	the terms of the CC0, the OpenSSL Licence, or the Apache Public License
+ *	2.0, at your option.  The terms of these licenses can be found at:
  *
- * - CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
- * - OpenSSL license   : https://www.openssl.org/source/license.html
- * - Apache 2.0        : https://www.apache.org/licenses/LICENSE-2.0
+ *	- CC0 1.0 Universal : http://creativecommons.org/publicdomain/zero/1.0
+ *	- OpenSSL license   : https://www.openssl.org/source/license.html
+ *	- Apache 2.0        : https://www.apache.org/licenses/LICENSE-2.0
  *
- * More information about the BLAKE2 hash function can be found at
- * https://blake2.net.
- *
- * Note: the original sources have been modified for inclusion in linux kernel
- * in terms of coding style, using generic helpers and simplifications of error
- * handling.
+ * More information about BLAKE2 can be found at https://blake2.net.
  */
 
 #include <asm/unaligned.h>
-- 
2.29.2


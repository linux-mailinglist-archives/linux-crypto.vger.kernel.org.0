Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1194AF179A
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 14:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfKFNsu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 6 Nov 2019 08:48:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:32906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfKFNsu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 6 Nov 2019 08:48:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89D89B387;
        Wed,  6 Nov 2019 13:48:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 57D2FDA79A; Wed,  6 Nov 2019 14:48:55 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-crypto@vger.kernel.org
Cc:     ebiggers@kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 5/7] crypto: blake2b: open code set last block helper
Date:   Wed,  6 Nov 2019 14:48:29 +0100
Message-Id: <8b671f0aec1c18f26dde397da71f38595ffb7db6.1573047517.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573047517.git.dsterba@suse.com>
References: <cover.1573047517.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The helper is trival and called once, inlining makes things simpler.
There's a comment to tie it back to the idea behind the code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 crypto/blake2b_generic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/crypto/blake2b_generic.c b/crypto/blake2b_generic.c
index 442c639c9ad9..463ac597ef04 100644
--- a/crypto/blake2b_generic.c
+++ b/crypto/blake2b_generic.c
@@ -65,11 +65,6 @@ static const u8 blake2b_sigma[12][16] = {
 	{ 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 }
 };
 
-static void blake2b_set_lastblock(struct blake2b_state *S)
-{
-	S->f[0] = (u64)-1;
-}
-
 static void blake2b_increment_counter(struct blake2b_state *S, const u64 inc)
 {
 	S->t[0] += inc;
@@ -231,7 +226,8 @@ static int blake2b_final(struct shash_desc *desc, u8 *out)
 	size_t i;
 
 	blake2b_increment_counter(state, state->buflen);
-	blake2b_set_lastblock(state);
+	/* Set last block */
+	state->f[0] = (u64)-1;
 	/* Padding */
 	memset(state->buf + state->buflen, 0, BLAKE2B_BLOCKBYTES - state->buflen);
 	blake2b_compress(state, state->buf);
-- 
2.23.0


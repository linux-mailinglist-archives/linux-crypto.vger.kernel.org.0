Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A17227893
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Jul 2020 08:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGUGGG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Jul 2020 02:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgGUGGF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Jul 2020 02:06:05 -0400
Received: from e123331-lin.nice.arm.com (adsl-199.37.6.218.tellas.gr [37.6.218.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59C920B1F;
        Tue, 21 Jul 2020 06:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595311565;
        bh=XtTK+cV+VfPCXbD2exTCRA6j8JIzptjXd2OWkYXVZ48=;
        h=From:To:Cc:Subject:Date:From;
        b=S7sKq7S3humtFeC2krQ096pF0ybIDlvYJKTyXFrDwdrQQKuQfn4jec2YIYlR5nF6h
         UG/Ja5osygMGYTv4IjKkL8NR19+Mk0PGdIdC9wk36zoI493+nnBz3j70kkOWi/a0G4
         xu7L/gdtfFE7wveEUq5Ro60WZLksdcYVM6uJR/PI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, colin.king@canonical.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: xts - Replace memcpy() invocation with simple assignment
Date:   Tue, 21 Jul 2020 09:05:54 +0300
Message-Id: <20200721060554.8151-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Colin reports that the memcpy() call in xts_cts_final() trigggers a
"Overlapping buffer in memory copy" warning in Coverity, which is a
false postive, given that tail is guaranteed to be smaller than or
equal to the distance between source and destination.

However, given that any additional bytes that we copy will be ignored
anyway, we can simply copy XTS_BLOCK_SIZE unconditionally, which means
we can use struct assignment of the array members instead, which is
likely to be more efficient as well.

Addresses-Coverity: ("Overlapping buffer in memory copy")
Fixes: 8083b1bf8163 ("crypto: xts - add support for ciphertext stealing")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 crypto/xts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index 3c3ed02c7663..ad45b009774b 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -171,7 +171,7 @@ static int xts_cts_final(struct skcipher_request *req,
 				      offset - XTS_BLOCK_SIZE);
 
 	scatterwalk_map_and_copy(b, rctx->tail, 0, XTS_BLOCK_SIZE, 0);
-	memcpy(b + 1, b, tail);
+	b[1] = b[0];
 	scatterwalk_map_and_copy(b, req->src, offset, tail, 0);
 
 	le128_xor(b, &rctx->t, b);
-- 
2.17.1


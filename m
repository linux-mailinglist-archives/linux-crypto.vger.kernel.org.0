Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8AB14A3F6
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Jan 2020 13:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgA0MdP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Jan 2020 07:33:15 -0500
Received: from foss.arm.com ([217.140.110.172]:43906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgA0MdP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Jan 2020 07:33:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0850830E;
        Mon, 27 Jan 2020 04:33:15 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2C023F52E;
        Mon, 27 Jan 2020 04:33:13 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: testmgr - properly mark the end of scatterlist
Date:   Mon, 27 Jan 2020 14:33:11 +0200
Message-Id: <20200127123311.7137-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The inauthentic AEAD test were using a scatterlist which
could have a mismarked end node.

Fixes: 49763fc6b1 ("crypto: testmgr - generate inauthentic AEAD test vectors")
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

---
 crypto/testmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 88f33c0efb23..6c432aecff97 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -2225,6 +2225,8 @@ static void generate_aead_message(struct aead_request *req,
 			generate_random_bytes((u8 *)vec->ptext, vec->plen);
 			sg_set_buf(&src[i++], vec->ptext, vec->plen);
 		}
+		if (i)
+			sg_mark_end(&src[(i-1)]);
 		sg_init_one(&dst, vec->ctext, vec->alen + vec->clen);
 		memcpy(iv, vec->iv, ivsize);
 		aead_request_set_callback(req, 0, crypto_req_done, &wait);
-- 
2.23.0


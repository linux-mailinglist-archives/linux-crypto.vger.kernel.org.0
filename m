Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC1730C6
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Feb 2020 07:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgB1GLQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Feb 2020 01:11:16 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:36187 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1GLQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Feb 2020 01:11:16 -0500
Received: from localhost.localdomain (cyclone.blr.asicdesigners.com [10.193.186.206])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01S6B529029866;
        Thu, 27 Feb 2020 22:11:07 -0800
From:   Vinay Kumar Yadav <vinay.yadav@chelsio.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Cc:     Vinay Kumar Yadav <vinay.yadav@chelsio.com>
Subject: [PATCH] Crypto/chtls: Fixed boolinit.cocci warning
Date:   Fri, 28 Feb 2020 11:39:40 +0530
Message-Id: <20200228060939.44038-1-vinay.yadav@chelsio.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

crypto: chtls - Fixed boolinit.cocci warning

Signed-off-by: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
---
 drivers/crypto/chelsio/chtls/chtls_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 781fe7c55a27..bd47119f4fda 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -1081,10 +1081,10 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 				pg_size = page_size(page);
 			if (off < pg_size &&
 			    skb_can_coalesce(skb, i, page, off)) {
-				merge = 1;
+				merge = true;
 				goto copy;
 			}
-			merge = 0;
+			merge = false;
 			if (i == (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
 			    MAX_SKB_FRAGS))
 				goto new_buf;
-- 
2.24.1


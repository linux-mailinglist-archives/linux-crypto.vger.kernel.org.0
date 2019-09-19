Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E34B822B
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Sep 2019 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392446AbfISUFE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Sep 2019 16:05:04 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:48109 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbfISUFE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Sep 2019 16:05:04 -0400
Received: from localhost.localdomain ([93.22.37.255])
        by mwinf5d35 with ME
        id 3Y4t2100P5WHhHH03Y4tp2; Thu, 19 Sep 2019 22:05:02 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 19 Sep 2019 22:05:02 +0200
X-ME-IP: 93.22.37.255
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     atul.gupta@chelsio.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, akpm@linux-foundation.org,
        willy@infradead.org, kirill.shutemov@linux.intel.com,
        kstewart@linuxfoundation.org, yuehaibing@huawei.com,
        tglx@linutronix.de
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: chtls - simplify a bit 'create_flowc_wr_skb()'
Date:   Thu, 19 Sep 2019 22:04:28 +0200
Message-Id: <20190919200428.2664-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use '__skb_put_data()' instead of rewritting it.
This improves readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/chelsio/chtls/chtls_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 0891ab829b1b..2512bfb24d71 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -97,7 +97,7 @@ static struct sk_buff *create_flowc_wr_skb(struct sock *sk,
 	if (!skb)
 		return NULL;
 
-	memcpy(__skb_put(skb, flowclen), flowc, flowclen);
+	__skb_put_data(skb, flowc, flowclen);
 	skb_set_queue_mapping(skb, (csk->txq_idx << 1) | CPL_PRIORITY_DATA);
 
 	return skb;
-- 
2.20.1


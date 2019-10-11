Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF99D3FD8
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2019 14:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJKMo7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Oct 2019 08:44:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727589AbfJKMo6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Oct 2019 08:44:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A4318DD6829E73B8D62;
        Fri, 11 Oct 2019 20:44:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 11 Oct 2019
 20:44:53 +0800
To:     <atul.gupta@chelsio.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <willy@infradead.org>, <kstewart@linuxfoundation.org>,
        <ira.weiny@intel.com>, <akpm@linux-foundation.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] crypto: chtls - remove the redundant check in chtls_recvmsg()
Message-ID: <3c88d0b1-b6c6-9641-ffdf-20104a684402@huawei.com>
Date:   Fri, 11 Oct 2019 20:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

A warning message reported by a static analysis tool:
  "
  Either the condition 'if(skb)' is redundant or there is possible null
  pointer dereference: skb.
  "

Remove the unused redundant check.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 drivers/crypto/chelsio/chtls/chtls_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 0891ab8..0125f4e 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -1841,8 +1841,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tp->urg_data = 0;

 		if (avail + offset >= skb->len) {
-			if (likely(skb))
-				chtls_free_skb(sk, skb);
+			chtls_free_skb(sk, skb);
 			buffers_freed++;

 			if  (copied >= target &&
-- 
2.7.4.3


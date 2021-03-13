Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B323F339CA3
	for <lists+linux-crypto@lfdr.de>; Sat, 13 Mar 2021 08:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCMHsG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 13 Mar 2021 02:48:06 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:33866 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhCMHrt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 13 Mar 2021 02:47:49 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 1E911400105;
        Sat, 13 Mar 2021 15:47:47 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Hadar Gat <hadar.gat@arm.com>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] char: hw_random: delete redundant printing of return value
Date:   Sat, 13 Mar 2021 15:47:42 +0800
Message-Id: <1615621663-1948-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZH08dSEhCGkhKQ0tKVkpNSk5NSUpNTUxPS0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Txw5Hj8LC1EwPR8vCS1J
        CR8KCjZVSlVKTUpOTUlKTU1MTE9LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTUxKNwY+
X-HM-Tid: 0a782a8e3a01d991kuws1e911400105
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/char/hw_random/cctrng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 7a293f2..1e551e3
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -527,10 +527,8 @@ static int cctrng_probe(struct platform_device *pdev)
 
 	/* Then IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed getting IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	/* parse sampling rate from device tree */
 	rc = cc_trng_parse_sampling_ratio(drvdata);
-- 
2.7.4


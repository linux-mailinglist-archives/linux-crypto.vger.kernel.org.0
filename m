Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3672A91FF
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKFJBg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 04:01:36 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:58871 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKFJBg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 04:01:36 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id C38CF667279;
        Fri,  6 Nov 2020 17:01:32 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] crypto: Fix return value check in aead_crypt()
Date:   Fri,  6 Nov 2020 17:01:27 +0800
Message-Id: <1604653287-16577-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0JOSU9LQ0lOGkJLVkpNS09NTkhJQkhPS0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Eio6LD8YKxwJHCFNEyMO
        URpPCj1VSlVKTUtPTU5ISUJIQ0lKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTEhLNwY+
X-HM-Tid: 0a759cca1ed09373kuwsc38cf667279
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix passing zero to 'PTR_ERR' warning

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/crypto/caam/caamalg_qi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 66f60d7..add60e8
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -1166,7 +1166,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 	/* allocate extended descriptor */
 	edesc = aead_edesc_alloc(req, encrypt);
 	if (IS_ERR_OR_NULL(edesc))
-		return PTR_ERR(edesc);
+		return PTR_ERR_OR_ZERO(edesc);
 
 	/* Create and submit job descriptor */
 	ret = caam_qi_enqueue(ctx->qidev, &edesc->drv_req);
-- 
2.7.4


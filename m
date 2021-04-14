Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213EA35F2A1
	for <lists+linux-crypto@lfdr.de>; Wed, 14 Apr 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhDNLkN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Apr 2021 07:40:13 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:53648 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhDNLkM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Apr 2021 07:40:12 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id E5DE0400495;
        Wed, 14 Apr 2021 19:39:48 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] crypto: ux500: cryp: Remove duplicate argument
Date:   Wed, 14 Apr 2021 19:38:59 +0800
Message-Id: <20210414113910.10651-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUpNSVYYHkxNGkoZSkNNGk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Pjo6Tj8PKBMrOBQXFiEu
        SDgwCQJVSlVKTUpDT0tLSENCT0xNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTkJONwY+
X-HM-Tid: 0a78d02e27e4d991kuwse5de0400495
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the following coccicheck warning:

./drivers/crypto/ux500/cryp/cryp_p.h:84:6-27:duplicated argument to |

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/crypto/ux500/cryp/cryp_p.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_p.h b/drivers/crypto/ux500/cryp/cryp_p.h
index 0df84eaa8531..cbbca0020eb1 100644
--- a/drivers/crypto/ux500/cryp/cryp_p.h
+++ b/drivers/crypto/ux500/cryp/cryp_p.h
@@ -81,7 +81,6 @@
 					 CRYP_CR_PRLG_MASK |\
 					 CRYP_CR_ALGODIR_MASK |\
 					 CRYP_CR_ALGOMODE_MASK |\
-					 CRYP_CR_DATATYPE_MASK |\
 					 CRYP_CR_KEYSIZE_MASK |\
 					 CRYP_CR_KEYRDEN_MASK |\
 					 CRYP_CR_DATATYPE_MASK)
-- 
2.25.1


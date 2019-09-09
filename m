Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF100AD2DE
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Sep 2019 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfIIFx4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Sep 2019 01:53:56 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.239]:35226 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbfIIFxz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Sep 2019 01:53:55 -0400
X-Greylist: delayed 1371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 01:53:55 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0DD0A49ABB
        for <linux-crypto@vger.kernel.org>; Mon,  9 Sep 2019 00:29:57 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7CFRiGu7f90on7CFRi0c9v; Mon, 09 Sep 2019 00:29:57 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZeDC3momsOT8YDmWDluDBvJqw1Yr3vZVteUjPazb11I=; b=Um5pUjFoBY6v0BZ8qlZ+WKF0wl
        k8adoXfVN1zPhyJVO9MqjIguf2vcuZ4qPTS5wVQN/rAYPNPK78j/tJfddGNWlpy7xp8MExbuDJJO1
        a5HiMfKRoJzyFKVYUtI5qX4WV3zwWgjH9lR2q/oBmcJcj+pXQtuSEfcuYogyVR2ZZQJlUmWXNAAhi
        hQe15/xbDYVIbCqo18WTqvRmD1Fggv1ARP2eCPVKpeeNzDw0vXPeoC3PtjxeTjZtbOHNirxxMVPJO
        K67OdD73jDqR3IqhPp7GM9RP6xRxzAeAnoRgEgPIhGty/6Zm2+ShrtzyGg2BWsinqe5sMx503/Ghi
        GaBOWeDQ==;
Received: from [148.69.85.38] (port=16527 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i7CFP-001YEo-QC; Mon, 09 Sep 2019 00:29:55 -0500
Date:   Mon, 9 Sep 2019 00:29:52 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] crypto: talitos - fix missing break in switch statement
Message-ID: <20190909052952.GA32131@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 148.69.85.38
X-Source-L: No
X-Exim-ID: 1i7CFP-001YEo-QC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [148.69.85.38]:16527
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add missing break statement in order to prevent the code from falling
through to case CRYPTO_ALG_TYPE_AHASH.

Fixes: aeb4c132f33d ("crypto: talitos - Convert to new AEAD interface")
Cc: stable@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/crypto/talitos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index c9d686a0e805..4818ae427098 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3140,6 +3140,7 @@ static int talitos_remove(struct platform_device *ofdev)
 			break;
 		case CRYPTO_ALG_TYPE_AEAD:
 			crypto_unregister_aead(&t_alg->algt.alg.aead);
+			break;
 		case CRYPTO_ALG_TYPE_AHASH:
 			crypto_unregister_ahash(&t_alg->algt.alg.hash);
 			break;
-- 
2.23.0


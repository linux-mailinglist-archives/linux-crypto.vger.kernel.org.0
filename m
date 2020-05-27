Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF711E400D
	for <lists+linux-crypto@lfdr.de>; Wed, 27 May 2020 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgE0L3c (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 May 2020 07:29:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgE0L3b (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 May 2020 07:29:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jduFO-0000sM-Co; Wed, 27 May 2020 11:29:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: chelsio: remove redundant premature assignment to iv
Date:   Wed, 27 May 2020 12:29:22 +0100
Message-Id: <20200527112922.171745-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable iv is being assigned twice with the same value, the first
assignment is redundant and can be removed and instead keep the
latter assignment of iv as it is closer to the point it is being
used.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/chelsio/chcr_ipsec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_ipsec.c b/drivers/crypto/chelsio/chcr_ipsec.c
index af961dcd317b..f9ad8c93e5ff 100644
--- a/drivers/crypto/chelsio/chcr_ipsec.c
+++ b/drivers/crypto/chelsio/chcr_ipsec.c
@@ -398,7 +398,6 @@ inline void *copy_esn_pktxt(struct sk_buff *skb,
 	memset(pos, 0, len);
 	aadiv = (struct chcr_ipsec_aadiv *)pos;
 	esphdr = (struct ip_esp_hdr *)skb_transport_header(skb);
-	iv = skb_transport_header(skb) + sizeof(struct ip_esp_hdr);
 	xo = xfrm_offload(skb);
 
 	aadiv->spi = (esphdr->spi);
-- 
2.25.1


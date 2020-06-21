Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEE202A4A
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2020 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgFULUS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Jun 2020 07:20:18 -0400
Received: from foss.arm.com ([217.140.110.172]:58580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbgFULUO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Jun 2020 07:20:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3880101E;
        Sun, 21 Jun 2020 04:20:13 -0700 (PDT)
Received: from e110176-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87AF63F6CF;
        Sun, 21 Jun 2020 04:20:12 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ofir Drang <ofir.drang@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 3/3] crypto: ccree: remove unused field
Date:   Sun, 21 Jun 2020 14:19:59 +0300
Message-Id: <20200621112000.31495-4-gilad@benyossef.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621112000.31495-1-gilad@benyossef.com>
References: <20200621112000.31495-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove yet another unused field left over from times gone by.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_cipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index 162871464438..442965b4cd9b 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -49,7 +49,6 @@ enum cc_key_type {
 struct cc_cipher_ctx {
 	struct cc_drvdata *drvdata;
 	int keylen;
-	int key_round_number;
 	int cipher_mode;
 	int flow_mode;
 	unsigned int flags;
-- 
2.27.0


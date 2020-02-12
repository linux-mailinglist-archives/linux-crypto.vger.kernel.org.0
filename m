Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211D015A454
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Feb 2020 10:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgBLJMF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Feb 2020 04:12:05 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:52402 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgBLJLv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Feb 2020 04:11:51 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 1lBp220095USYZQ06lBpcF; Wed, 12 Feb 2020 10:11:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1o3h-0000Zh-3Q; Wed, 12 Feb 2020 10:11:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1neL-0002NE-EZ; Wed, 12 Feb 2020 09:45:37 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] crypto: qat - spelling s/Decrytp/Decrypt/
Date:   Wed, 12 Feb 2020 09:45:36 +0100
Message-Id: <20200212084536.9083-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix a typo in a comment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 833bb1d3a11bc5e8..e14d3dd291f0946c 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -97,7 +97,7 @@ struct qat_alg_cd {
 			struct icp_qat_hw_cipher_algo_blk cipher;
 			struct icp_qat_hw_auth_algo_blk hash;
 		} qat_enc_cd;
-		struct qat_dec { /* Decrytp content desc */
+		struct qat_dec { /* Decrypt content desc */
 			struct icp_qat_hw_auth_algo_blk hash;
 			struct icp_qat_hw_cipher_algo_blk cipher;
 		} qat_dec_cd;
-- 
2.17.1


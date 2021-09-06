Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07F40142A
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Sep 2021 03:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbhIFBcj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 5 Sep 2021 21:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351816AbhIFBbF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 5 Sep 2021 21:31:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0310D61246;
        Mon,  6 Sep 2021 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891468;
        bh=/e15gvj7qBjprY6aQymNkjhUTUd5HRUn2s6Stl57cDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heKbaZHEjfqLlsoh2DL4pqFoPX+uRwPrVBrG2TGBf/08+mmJOiwAW9mhmUZ6ZBoOB
         sFQQO0XFe6/FU/qHJ17k9Qym/f3dTZp+eeX/f6fsgiCCTZ6FtAQ7vYmPS1wtlNPBv3
         /IyWFG6O/nXlln/ZL8+zr7U7ThrlwkArcqf0mSIppr0mJWsqt41KuM79g+PGQj/7BC
         KoPpLJmQS8HbLxV7aXYR6kC0jn0xi08pJ4+keCVcH3nrSw1oJMWQ1KxUxxDFS9WhUE
         e6bU4jGMV4TlAuN2geOExTaiTRMt0oa5c3mt1M8ZbhnWrU6++XFWVBdA5xgsKC8c+D
         ie463/fQePrww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/14] crypto: qat - handle both source of interrupt in VF ISR
Date:   Sun,  5 Sep 2021 21:24:11 -0400
Message-Id: <20210906012415.931147-10-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012415.931147-1-sashal@kernel.org>
References: <20210906012415.931147-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 0a73c762e1eee33a5e5dc0e3488f1b7cd17249b3 ]

The top half of the VF drivers handled only a source at the time.
If an interrupt for PF2VF and bundle occurred at the same time, the ISR
scheduled only the bottom half for PF2VF.
This patch fixes the VF top half so that if both sources of interrupt
trigger at the same time, both bottom halves are scheduled.

This patch is based on earlier work done by Conor McLoughlin.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_vf_isr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index 4c1217ba83ae..36db3c443e7e 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -203,6 +203,7 @@ static irqreturn_t adf_isr(int irq, void *privdata)
 	struct adf_bar *pmisc =
 			&GET_BARS(accel_dev)[hw_data->get_misc_bar_id(hw_data)];
 	void __iomem *pmisc_bar_addr = pmisc->virt_addr;
+	bool handled = false;
 	u32 v_int;
 
 	/* Read VF INT source CSR to determine the source of VF interrupt */
@@ -215,7 +216,7 @@ static irqreturn_t adf_isr(int irq, void *privdata)
 
 		/* Schedule tasklet to handle interrupt BH */
 		tasklet_hi_schedule(&accel_dev->vf.pf2vf_bh_tasklet);
-		return IRQ_HANDLED;
+		handled = true;
 	}
 
 	/* Check bundle interrupt */
@@ -227,10 +228,10 @@ static irqreturn_t adf_isr(int irq, void *privdata)
 		WRITE_CSR_INT_FLAG_AND_COL(bank->csr_addr, bank->bank_number,
 					   0);
 		tasklet_hi_schedule(&bank->resp_handler);
-		return IRQ_HANDLED;
+		handled = true;
 	}
 
-	return IRQ_NONE;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int adf_request_msi_irq(struct adf_accel_dev *accel_dev)
-- 
2.30.2


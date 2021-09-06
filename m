Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8695940131F
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Sep 2021 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbhIFBYR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 5 Sep 2021 21:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239196AbhIFBXE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 5 Sep 2021 21:23:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1129461132;
        Mon,  6 Sep 2021 01:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891296;
        bh=/aeM0nKRuFKXwYv5VlQpAM6LhcfpYnf7ULc5SzJRo+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TE++OBtDgiTx4Hu0p6V0/bzflfr/NOicrfJnSsQG4bKpnSRjUmmz5Ivnm72guIZzU
         ufH8NegCrY93d0Z6cpj1AGEiu1xH+57mVz0cv97DrmMqegFx6KcGqfF/G1Hs35tIl1
         tKG7190U6ULc0EZsXDhMGm90Oj0kftCbjX9UpPNwSNwRlcv7g7Ty/+dhPgrgAsJ/hA
         SFE/hMY679+Ps9ffLD/2bsmIfiyFFy2h1hgmM7a1czX8PsvG++L024umxgNzxPegHC
         gFm/fd9ZS+cstddUxhndRhwoKMMQfE870S/GjkB17elEqSuWUMkR5puyrUh5junGPS
         JCjPJiNU9f8lQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 34/46] crypto: qat - do not export adf_iov_putmsg()
Date:   Sun,  5 Sep 2021 21:20:39 -0400
Message-Id: <20210906012052.929174-34-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012052.929174-1-sashal@kernel.org>
References: <20210906012052.929174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 645ae0af1840199086c33e4f841892ebee73f615 ]

The function adf_iov_putmsg() is only used inside the intel_qat module
therefore should not be exported.
Remove EXPORT_SYMBOL for the function adf_iov_putmsg().

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index 663638bb5c97..efa4bffb4f60 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -186,7 +186,6 @@ int adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(adf_iov_putmsg);
 
 void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
 {
-- 
2.30.2


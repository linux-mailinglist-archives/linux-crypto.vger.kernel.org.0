Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73E980329
	for <lists+linux-crypto@lfdr.de>; Sat,  3 Aug 2019 01:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437489AbfHBXUf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 19:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387495AbfHBXUe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77CF20B7C;
        Fri,  2 Aug 2019 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788034;
        bh=9gp3B9gbhH2ZTSo7+j6VMH2Gi2WUfP7gR3sWVzmuTSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKmn9VW1iKWlTX8Kt3LRZcO76QAt6JTZh8Li9HFVWVZq5JrRtjP110s3JbSX3dhM2
         o/Owc4P8nENVX1QvjP0PypYeGTgAofnneLkE44qldFRaIf2O73AhWjlJQYia4PR/HN
         PLSyaeEsqKBQCC9ZQwjccd/VWsMcP2Dm/OatznsI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] crypto: ccp - Include DMA declarations explicitly
Date:   Fri,  2 Aug 2019 18:20:11 -0500
Message-Id: <20190802232013.15957-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190802232013.15957-1-helgaas@kernel.org>
References: <20190802232013.15957-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

ccp-dev.h uses dma_direction, which is defined in linux/dma-direction.h.
Include that explicitly instead of relying on it being included via
linux/pci.h, since ccp-dev.h requires nothing else from linux/pci.h.

Similarly, ccp-dmaengine.c uses dma_get_mask(), which is defined in
linux/dma-mapping.h, so include that explicitly since it requires nothing
else from linux/pci.h.

A future patch will remove the includes of linux/pci.h where it is not
needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/crypto/ccp/ccp-dev.h       | 1 +
 drivers/crypto/ccp/ccp-dmaengine.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/crypto/ccp/ccp-dev.h b/drivers/crypto/ccp/ccp-dev.h
index 5e624920fd99..89aee0900a06 100644
--- a/drivers/crypto/ccp/ccp-dev.h
+++ b/drivers/crypto/ccp/ccp-dev.h
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/wait.h>
+#include <linux/dma-direction.h>
 #include <linux/dmapool.h>
 #include <linux/hw_random.h>
 #include <linux/bitops.h>
diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index 7f22a45bbc11..f69d495873f0 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-- 
2.22.0.770.g0f2c4a37fd-goog


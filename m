Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE98411794
	for <lists+linux-crypto@lfdr.de>; Thu,  2 May 2019 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBKst (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 May 2019 06:48:49 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:25399 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBKss (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 May 2019 06:48:48 -0400
Received: from beagle7.asicdesigners.com (beagle7.asicdesigners.com [10.192.192.157])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x42Amipi028182;
        Thu, 2 May 2019 03:48:44 -0700
From:   Atul Gupta <atul.gupta@chelsio.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net, dt@chelsio.com,
        atul.gupta@chelsio.com
Subject: [PATCH 4/4] MAINTAINERS: Maintainer for Chelsio crypto driver
Date:   Thu,  2 May 2019 03:48:13 -0700
Message-Id: <20190502104813.22391-1-atul.gupta@chelsio.com>
X-Mailer: git-send-email 2.20.0.rc2.7.g965798d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Modified the maintainer name

Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..0d0dda5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4254,7 +4254,7 @@ F:	drivers/infiniband/hw/cxgb3/
 F:	include/uapi/rdma/cxgb3-abi.h
 
 CXGB4 CRYPTO DRIVER (chcr)
-M:	Harsh Jain <harsh@chelsio.com>
+M:	Atul Gupta <atul.gupta@chelsio.com>
 L:	linux-crypto@vger.kernel.org
 W:	http://www.chelsio.com
 S:	Supported
-- 
1.8.3.1


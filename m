Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18EA1613B3
	for <lists+linux-crypto@lfdr.de>; Mon, 17 Feb 2020 14:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgBQNj4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 17 Feb 2020 08:39:56 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:35970 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgBQNjz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 17 Feb 2020 08:39:55 -0500
Received: from chumthang.blr.asicdesigners.com (chumthang.blr.asicdesigners.com [10.193.186.96])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01HDddcD022495;
        Mon, 17 Feb 2020 05:39:40 -0800
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     vinay.yadav@chelsio.com, rohitm@chelsio.com,
        Ayush Sawal <ayush.sawal@chelsio.com>
Subject: [PATCH] MAINTAINERS: Update maintainers for chelsio crypto drivers
Date:   Mon, 17 Feb 2020 19:09:27 +0530
Message-Id: <20200217133927.22443-1-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca87
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This updates the maintainer list for chelsio crypto drivers.

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..12765a0b08e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4542,7 +4542,9 @@ S:	Supported
 F:	drivers/scsi/cxgbi/cxgb3i
 
 CXGB4 CRYPTO DRIVER (chcr)
-M:	Atul Gupta <atul.gupta@chelsio.com>
+M:	Ayush Sawal <ayush.sawal@chelsio.com>
+M:	Vinay Kumar Yadav <vinay.yadav@chelsio.com>
+M:	Rohit Maheshwari <rohitm@chelsio.com>
 L:	linux-crypto@vger.kernel.org
 W:	http://www.chelsio.com
 S:	Supported
-- 
2.25.0.114.g5b0ca87


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA913F2A0
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbgAPRYI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 12:24:08 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:38265 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733197AbgAPRYH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:07 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 817523b2;
        Thu, 16 Jan 2020 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=50bNfiEpYG6sVj+x/enmT20pq+8=; b=HaChmZtNljAHfXiuU4oi
        nTKdEllGn9MOg1FY92BAlaYRF+9CV85OYvMNUBbseZITJ36cvU5dYhy7fVFfogt6
        xNpi/rL3u/0VcBtp9qUvnF6LkS7/q5Q9klgEFXkzwtrblC8h0lIq93Vr8c6TSgUT
        pdmpW//kUgs284tZezRurW2e11v3AIopHwkNARYrWtmS5wlvje6xqa20uQ3WPWSz
        mOBmfyGnDMkqYTH42S7BW3a4tRl0m5n9sgGYG4IuwXVHaadmfJEKO54eneVRYVHS
        lzQMgJbeW2CdFCLa65U5hAftmuCGCEnl/OCCmSG3VmBbDPy6M7GEO3PqyiaNHwk+
        Gg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6f70810e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 16 Jan 2020 16:23:46 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] crypto: x86/poly1305: fix .gitignore typo
Date:   Thu, 16 Jan 2020 18:23:55 +0100
Message-Id: <20200116172355.13255-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Admist the kbuild robot induced changes, the .gitignore file for the
generated file wasn't updated with the non-clashing filename. This
commit adjusts that.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/crypto/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/crypto/.gitignore b/arch/x86/crypto/.gitignore
index c406ea6571fa..30be0400a439 100644
--- a/arch/x86/crypto/.gitignore
+++ b/arch/x86/crypto/.gitignore
@@ -1 +1 @@
-poly1305-x86_64.S
+poly1305-x86_64-cryptogams.S
-- 
2.24.1


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2875F28D6FD
	for <lists+linux-crypto@lfdr.de>; Wed, 14 Oct 2020 01:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgJMX1H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 13 Oct 2020 19:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgJMX1H (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 13 Oct 2020 19:27:07 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 508E7221FC;
        Tue, 13 Oct 2020 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602631627;
        bh=mjfg69poC9wP7Of+UI7cHThU0f9/Uq356LBAlVBWEnY=;
        h=From:To:Cc:Subject:Date:From;
        b=zAnRQX+Px/HlOGhZH0Dy91TSuYljnMn+Iq2Fg8l2e+SrYPxisBWOPPJP/RnOhNbcZ
         mQEMvvK7iq+YRDIsXDMSV/GDtmFkFByF75t/kfUEJQ76XtNYOT342DyWKlNHrHm4PZ
         TNpNyV+lcnfqWtGrwlpO3cMfx/+72qF/Fck09N9g=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: x86 - remove unused file aes_glue.c
Date:   Tue, 13 Oct 2020 16:26:50 -0700
Message-Id: <20201013232650.2361475-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 1d2c3279311e ("crypto: x86/aes - drop scalar assembler
implementations") was meant to remove aes_glue.c, but it actually left
it as an unused one-line file.  Remove this unused file.

Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/aes_glue.c | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/x86/crypto/aes_glue.c

diff --git a/arch/x86/crypto/aes_glue.c b/arch/x86/crypto/aes_glue.c
deleted file mode 100644
index 7b7dc05fa1a4..000000000000
--- a/arch/x86/crypto/aes_glue.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-- 
2.28.0.1011.ga647a8990f-goog


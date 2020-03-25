Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB4192A7E
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 14:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCYNzc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 09:55:32 -0400
Received: from foss.arm.com ([217.140.110.172]:48816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgCYNzc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 09:55:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00E061045;
        Wed, 25 Mar 2020 06:55:32 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B1D3F71E;
        Wed, 25 Mar 2020 06:55:31 -0700 (PDT)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] arm64: lib: Consistently enable crc32 extension
Date:   Wed, 25 Mar 2020 13:55:22 +0000
Message-Id: <20200325135522.7782-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325135522.7782-1-broonie@kernel.org>
References: <20200325135522.7782-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently most of the assembly files that use architecture extensions
enable them using the .arch directive but crc32.S uses .cpu instead. Move
that over to .arch for consistency.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/lib/crc32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
index 243e107e9896..0f9e10ecda23 100644
--- a/arch/arm64/lib/crc32.S
+++ b/arch/arm64/lib/crc32.S
@@ -9,7 +9,7 @@
 #include <asm/alternative.h>
 #include <asm/assembler.h>
 
-	.cpu		generic+crc
+	.arch		armv8-a+crc
 
 	.macro		__crc32, c
 	cmp		x2, #16
-- 
2.20.1


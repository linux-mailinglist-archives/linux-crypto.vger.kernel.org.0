Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B192F192A7D
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYNza (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 09:55:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgCYNza (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 09:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C25DDFEC;
        Wed, 25 Mar 2020 06:55:29 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 445B83F71E;
        Wed, 25 Mar 2020 06:55:29 -0700 (PDT)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] arm64: crypto: Consistently enable extension
Date:   Wed, 25 Mar 2020 13:55:21 +0000
Message-Id: <20200325135522.7782-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325135522.7782-1-broonie@kernel.org>
References: <20200325135522.7782-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Currently most of the crypto files enable the crypto extension using the
.arch directive but crct10dif-ce-core.S uses .cpu instead. Move that over
to .arch for consistency.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/crypto/crct10dif-ce-core.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-core.S b/arch/arm64/crypto/crct10dif-ce-core.S
index 5a95c2628fbf..111d9c9abddd 100644
--- a/arch/arm64/crypto/crct10dif-ce-core.S
+++ b/arch/arm64/crypto/crct10dif-ce-core.S
@@ -66,7 +66,7 @@
 #include <asm/assembler.h>
 
 	.text
-	.cpu		generic+crypto
+	.arch		armv8-a+crypto
 
 	init_crc	.req	w19
 	buf		.req	x20
-- 
2.20.1


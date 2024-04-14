Return-Path: <linux-crypto+bounces-3484-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E08A1C88
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Apr 2024 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F761F23CB7
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Apr 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E78978C80;
	Thu, 11 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sox4PT1d"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7C78C6C;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852745; cv=none; b=uOEUQQgTyQJ+x5UKfhOrmz2DWuG2QYCO0m3/oSX1M3Xdkln58kiFrK9rncn0senLM25V6tLheYF635BzkCaJm6CEQyyavZUMe5OeQsv4DtLWOJe5zFrlq1ZsvKsfdNUerJSnp7CwFRtt1oWdiBlssvSzL5r2Kd2Hc1clMAmz3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852745; c=relaxed/simple;
	bh=sclbn/VSrfoogdQKY3CA8N8Boiy93My3gD2GlPibz+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6dE8i0BJG5fhCGODyzmm3YJN6120zsFGoJu2wvECMHkSsJDTCpN9Ms5bat1QvKW338y+UuMVv9TZDrIWVNZscCmVNkar43vfIl6Ek1RMYEjr+sc9v9vtyk8Dn+rZTPypG4SBMlP2uan60HiFUHNZXCOYdnT1Ow7wiW082LQrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sox4PT1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB3C4AF07;
	Thu, 11 Apr 2024 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852745;
	bh=sclbn/VSrfoogdQKY3CA8N8Boiy93My3gD2GlPibz+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sox4PT1dhDleQ2En1sA6z1o840zMV02X0SYTZ2GW471vgvaBH4aoGoh9W1SsDd+m3
	 kgjawz0HP3Ajk1Zaw5IO36N9h0rmvzSV16V44eqI/cMFpX1m+OPeKGxVWAxsrX/rJP
	 8vkjzu0hpUUt/11aWTa237pckWIRAfUTo2znanZifINMpqp1EmpHwRm1nvHTeq1/id
	 yMpY6L0yy9lkbRlHISVyBpyy2YLMzIHV3n1/YrJm9YzKv7Pna4wP38GcY1heoOICy8
	 pMa9GkPqn2VVdCznsHrBh16xrv+YSaN6WyewPiJYcvZQ25g9ZhzGJByxWovLy5UhSN
	 nCs5rPSaIA6bw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: [PATCH v2 4/4] crypto: x86/sha256-ni - simplify do_4rounds
Date: Thu, 11 Apr 2024 09:23:59 -0700
Message-ID: <20240411162359.39073-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411162359.39073-1-ebiggers@kernel.org>
References: <20240411162359.39073-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instead of loading the message words into both MSG and \m0 and then
adding the round constants to MSG, load the message words into \m0 and
the round constants into MSG and then add \m0 to MSG.  This shortens the
source code slightly.  It changes the instructions slightly, but it
doesn't affect binary code size and doesn't seem to affect performance.

Suggested-by: Stefan Kanthak <stefan.kanthak@nexgo.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/sha256_ni_asm.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/sha256_ni_asm.S b/arch/x86/crypto/sha256_ni_asm.S
index ffc9f1c75c15..d515a55a3bc1 100644
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@ -76,17 +76,15 @@
 #define ABEF_SAVE	%xmm9
 #define CDGH_SAVE	%xmm10
 
 .macro do_4rounds	i, m0, m1, m2, m3
 .if \i < 16
-	movdqu		\i*4(DATA_PTR), MSG
-	pshufb		SHUF_MASK, MSG
-	movdqa		MSG, \m0
-.else
-	movdqa		\m0, MSG
+	movdqu		\i*4(DATA_PTR), \m0
+	pshufb		SHUF_MASK, \m0
 .endif
-	paddd		(\i-32)*4(SHA256CONSTANTS), MSG
+	movdqa		(\i-32)*4(SHA256CONSTANTS), MSG
+	paddd		\m0, MSG
 	sha256rnds2	STATE0, STATE1
 .if \i >= 12 && \i < 60
 	movdqa		\m0, TMP
 	palignr		$4, \m3, TMP
 	paddd		TMP, \m1
-- 
2.44.0



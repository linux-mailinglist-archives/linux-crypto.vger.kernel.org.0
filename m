Return-Path: <linux-crypto+bounces-21219-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJwLJV5eoGlViwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21219-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 15:53:18 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F401A7FF8
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2DEA30D9253
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA123E9F60;
	Thu, 26 Feb 2026 14:46:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B23E9580;
	Thu, 26 Feb 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117182; cv=none; b=nFm8vX5k+0OGAAPGoK2xmgP1ouxphxRcBHKbp7Biii4BrQRIeiFUsq08w8r3cLqHlsb9/188pk6SnrL00E2WrYGLHejSWT+Lia7dgTp+/kcQnunyHIWpxJ2S7bd0mcF4B6pSKUZp4v2OjgUBxrdhFe5xD3e/KGpp3hmU9pbB+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117182; c=relaxed/simple;
	bh=sFFfItmaKIbkDnrCPQAQMxVftGsTIbo583JAPwG/djw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPII6Ak5x1MLpJ2QCLq2QmE835kJJ/38s3oFdUY68OhUTjoT2dJH3X2dxVnSfCWrYtZBpaxdpjYNgtXnkdOL/zY9N9inSeEgsuvF8+p8S/1I6zSTYE5nze3fSLTfSwjDILFMj+SjvwPdyo+1yUHKh5LRGQQDo1rWMgcjaL5v7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FF8C116C6;
	Thu, 26 Feb 2026 14:46:20 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/5] crypto: Clean up CRYPTO_CRC32 usage
Date: Thu, 26 Feb 2026 15:46:09 +0100
Message-ID: <0f76ebf05bb1b6ca50db97988f9ac20944534b4c.1772116160.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772116160.git.geert+renesas@glider.be>
References: <cover.1772116160.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21219-lists,linux-crypto=lfdr.de,renesas];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:mid,glider.be:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18F401A7FF8
X-Rspamd-Action: no action

F2fs and RoCEv2 stopped using this CRC32 implementation in commits
3ca4bec40ee211cd ("f2fs: switch to using the crc32 library") and
ccca5e8aa1457231 ("RDMA/rxe: switch to using the crc32 library").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 crypto/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5e66de2948ed02f9..b4bb85e8e2261209 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1060,8 +1060,6 @@ config CRYPTO_CRC32
 	help
 	  CRC32 CRC algorithm (IEEE 802.3)
 
-	  Used by RoCEv2 and f2fs.
-
 endmenu
 
 menu "Compression"
-- 
2.43.0



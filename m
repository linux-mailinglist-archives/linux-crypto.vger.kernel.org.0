Return-Path: <linux-crypto+bounces-21217-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK6iHkdeoGlViwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21217-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 15:52:55 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 021961A7FCC
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A943071A44
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Feb 2026 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6323E8C5D;
	Thu, 26 Feb 2026 14:46:19 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55971335BBB;
	Thu, 26 Feb 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117179; cv=none; b=p10F3fFqXq6Hr8UyXDr8GabFzpyo60lqtnNAsN3Vls/qUPlcuo3GOzvmyYDC27Tn8iMB9fjk0TmelaAiPtlHYVb+N5RjteYFnZOBCYd0NnRW51EhHOsqvPc579EhlWbT9EzMzFssC1UbWFYh4VxzHln5G7Bc9qLbT0FfMyF4LpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117179; c=relaxed/simple;
	bh=MS2dV98khEDsVe1bAQd9M5OGNZSmvkPi0bQ7XxrStyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqaVktiT9DQicfNOA2Yg9fSSMyCH5KFOQT/Mzf8m7B6rTowb3Ak/QZOYIy3dQHKbzPpVzI/5DU5UI1/ygRqijr3odmTDWV5S018B0VoPULaSsyf5ZrGDd7oREE+M59C4n5RFx8DI0wGCIDdE+sVxuaDKA1z+AFu+rv2Xzu62ucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB30C19423;
	Thu, 26 Feb 2026 14:46:17 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Eric Biggers <ebiggers@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/5] crypto: Clean up CRYPTO_XXHASH usage
Date: Thu, 26 Feb 2026 15:46:07 +0100
Message-ID: <3b632975201074ccaa129f4901a66aff87b19742.1772116160.git.geert+renesas@glider.be>
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
	TAGGED_FROM(0.00)[bounces-21217-lists,linux-crypto=lfdr.de,renesas];
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
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:mid,glider.be:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 021961A7FCC
X-Rspamd-Action: no action

Btrfs stopped using this xxHash implementation in commit
fe11ac191ce0ad91 ("btrfs: switch to library APIs for checksums").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 crypto/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index c84fda3acdbda57c..49293b656aff6f52 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1036,8 +1036,6 @@ config CRYPTO_XXHASH
 
 	  Extremely fast, working at speeds close to RAM limits.
 
-	  Used by the btrfs filesystem.
-
 endmenu
 
 menu "CRCs (cyclic redundancy checks)"
-- 
2.43.0



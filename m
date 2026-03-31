Return-Path: <linux-crypto+bounces-22639-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONC/FFo2y2l1EwYAu9opvQ
	(envelope-from <linux-crypto+bounces-22639-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 04:50:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2223638EB
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 04:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 949113074572
	for <lists+linux-crypto@lfdr.de>; Tue, 31 Mar 2026 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AD36C5A1;
	Tue, 31 Mar 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfEIztJq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C1368962;
	Tue, 31 Mar 2026 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774925150; cv=none; b=oqzVKNaw2LVOd+wLwLPPccvQxuJRF+K5vGao8LtZvdn7yMVj0kpbu8wt1h6YO2ZroDWqH/tiCoWfN33vF8ajhhdypRkZWpkSrd0OZKzA/l62lT06FBKkxD/9hVwho3DibLzaGHR+QS0BgqKD2jV2ZCmKGcooWYDNSNhQW3df6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774925150; c=relaxed/simple;
	bh=Zk4WrQTTIdYLO7MirDNZSMGBvIM2BIBFlpAB+Vr4q9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vANDSr9C1ZPvrpyMBYL3qCUZaZrggpbQLrSLL5ewcfP8zyMTV19mea93vmMQzxKveZjWFT+mtye27lUoDLEwLWGZHZwgRUBOr5OW7rvOTvFeGwQ5Zf6komORdVzlCrMPAcS7sg1G2DE9e1dgMz8ILZM4eD9CQvaYl1lqx/pvMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfEIztJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F3C4CEF7;
	Tue, 31 Mar 2026 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774925149;
	bh=Zk4WrQTTIdYLO7MirDNZSMGBvIM2BIBFlpAB+Vr4q9A=;
	h=From:To:Cc:Subject:Date:From;
	b=hfEIztJqUtvxEhwIp6AvEQ7L6q8YJOgakR/i01l7WDAlsGd+22yacM7OTfUR5lfA5
	 wxHv5Shhn/0dSR/gQRWKOgc1022AcV7HnzfwNd5P3qwAOSf97IfHE0QIKFrivAQuOw
	 sp5tAe9bXSlYMhIt82WbRpT2NDUBexm1CACnbqNMQhQgVx0f23AgQdPf0jjCHvn6kd
	 qct7u0/cpg12cla5IOgoG8mYEJ8jjT4TCGfdrXL+tfMknt54vjZi7VLDPIspxqkrfE
	 k1dnMDREuM4O2w60zm2tuFCi24KilNDjmWRy6aFPlGUzMxtHHL5EUdRlskQ3S2xrJP
	 EdzRClSQ7MDSw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/crypto: Include <crypto/utils.h> instead of <crypto/algapi.h>
Date: Mon, 30 Mar 2026 19:44:38 -0700
Message-ID: <20260331024438.51783-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22639-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD2223638EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since the lib/crypto/ files that include <crypto/algapi.h> need it only
for the transitive inclusion of <crypto/utils.h> (and not all the
traditional crypto API stuff that the rest of <crypto/algapi.h> is
filled with), replace these inclusions with direct inclusions of
<crypto/utils.h>.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/aescfb.c | 2 +-
 lib/crypto/chacha.c | 2 +-
 lib/crypto/memneq.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/crypto/aescfb.c b/lib/crypto/aescfb.c
index e38848d101e3..82cd55436055 100644
--- a/lib/crypto/aescfb.c
+++ b/lib/crypto/aescfb.c
@@ -4,11 +4,11 @@
  *
  * Copyright 2023 Google LLC
  */
 
 #include <crypto/aes.h>
-#include <crypto/algapi.h>
+#include <crypto/utils.h>
 #include <linux/export.h>
 #include <linux/module.h>
 
 /**
  * aescfb_encrypt - Perform AES-CFB encryption on a block of data
diff --git a/lib/crypto/chacha.c b/lib/crypto/chacha.c
index e0c7cb4af318..86e5d382a4e0 100644
--- a/lib/crypto/chacha.c
+++ b/lib/crypto/chacha.c
@@ -3,12 +3,12 @@
  * The ChaCha stream cipher (RFC7539)
  *
  * Copyright (C) 2015 Martin Willi
  */
 
-#include <crypto/algapi.h> // for crypto_xor_cpy
 #include <crypto/chacha.h>
+#include <crypto/utils.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
 static void __maybe_unused
diff --git a/lib/crypto/memneq.c b/lib/crypto/memneq.c
index 44daacb8cb51..08924acd44bc 100644
--- a/lib/crypto/memneq.c
+++ b/lib/crypto/memneq.c
@@ -57,11 +57,11 @@
  * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <crypto/algapi.h>
+#include <crypto/utils.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
 
 /* Generic path for arbitrary size */
@@ -157,11 +157,11 @@ static inline unsigned long __crypto_memneq_16(const void *a, const void *b)
 }
 
 /* Compare two areas of memory without leaking timing information,
  * and with special optimizations for common sizes.  Users should
  * not call this function directly, but should instead use
- * crypto_memneq defined in crypto/algapi.h.
+ * crypto_memneq defined in crypto/utils.h.
  */
 noinline unsigned long __crypto_memneq(const void *a, const void *b,
 				       size_t size)
 {
 	switch (size) {

base-commit: d2a68aba8505ce88b39c34ecb3b707c776af79d4
prerequisite-patch-id: bb75bceea1086ce63912baf959cd010cdd451208
prerequisite-patch-id: 0bd0bf7e94c78811a3371910650acf3a62b7de2c
-- 
2.53.0



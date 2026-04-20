Return-Path: <linux-crypto+bounces-23216-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKdfK4jK5WlIoAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23216-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:41:12 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42F427558
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 908BD3047DFE
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6438947F;
	Mon, 20 Apr 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7cq0ufp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88F3890EA;
	Mon, 20 Apr 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667027; cv=none; b=OFznAyWE+8BZ2x3XnNh5PmGZoqZuWC2FpW7ypw4mzSYmdVeaUiV7qYpRQD85pIU+rFOpQ1klJ3XDfGp6nEvsPZ8gDYLP+7cAJ7XtT94tHpDiC6nEwnoOZpDPila6TDVcIbia78lBBkFP++vL/zXMFhlGFZmloCMp0S0JX1Av/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667027; c=relaxed/simple;
	bh=M0KgVBpaULYW7MXoHvE0TXN3GODSbGpQTuXcYyoSu/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbVU5MThp8Fb7s04ReSCJc98YDProckA4aaV/hPnhMyM8tPkxuH5sLOxYyoTJOF57leC2ETTfZyMM9mtAnT26Luwodi/9534N8GJOxOk/h8lulbPHWWY/x/SzWL3pwaryEIrGJWOIlJOZoendaAWo+17/yIW0Cz7VBIq+Xwe21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7cq0ufp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C98EC2BCB3;
	Mon, 20 Apr 2026 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776667027;
	bh=M0KgVBpaULYW7MXoHvE0TXN3GODSbGpQTuXcYyoSu/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7cq0ufpqxJxWNF3lBDXwXgu9jNApDlzbGFo0eG/joPRVbdnl3/Zgjh6oV6wK0DFs
	 /q4rSoV9zYH1ZBs3yZFNJdwF+X9d2viiWLDjxNCcqEQLaI5/3dCWn3AeBYug9FaDFb
	 AqdXhvPwTrFSA3Tq1lg0ER5I+OINGRD2jXvxwbW1eji/uTPGCHhtZvd+bUyurRKfdF
	 7vug2fyo/m8mUxsoCOkqxDOiVBh2vPNSF/fvEtNPuRmsYZg+owr7J+YbsSTxS7P6m5
	 HcpGcNR7YH5kyC9FNORSTduW9VBox4hv+0G4gEArbd8PUgIK+8UFDiedEcHIFeR0H1
	 PDLQ6h+zGHOvg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 25/38] crypto: drbg - Move module aliases to end of file
Date: Sun, 19 Apr 2026 23:34:09 -0700
Message-ID: <20260420063422.324906-26-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420063422.324906-1-ebiggers@kernel.org>
References: <20260420063422.324906-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23216-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chronox.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D42F427558
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the MODULE_ALIAS_CRYPTO lines in the middle of the file to the end
so that they are in the usual place and next to the other one.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/drbg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index c29f4ca93d1b..439581d7bb83 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -157,13 +157,10 @@ static int drbg_uninstantiate(struct drbg_state *drbg);
 
 /******************************************************************
  * HMAC DRBG functions
  ******************************************************************/
 
-MODULE_ALIAS_CRYPTO("drbg_pr_hmac_sha512");
-MODULE_ALIAS_CRYPTO("drbg_nopr_hmac_sha512");
-
 /* update function of HMAC DRBG as defined in 10.1.2.2 */
 static void drbg_hmac_update(struct drbg_state *drbg, struct list_head *seed,
 			     int reseed)
 {
 	int i = 0;
@@ -881,5 +878,7 @@ module_init(drbg_init);
 module_exit(drbg_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
 MODULE_DESCRIPTION("NIST SP800-90A Deterministic Random Bit Generator (DRBG)");
 MODULE_ALIAS_CRYPTO("stdrng");
+MODULE_ALIAS_CRYPTO("drbg_pr_hmac_sha512");
+MODULE_ALIAS_CRYPTO("drbg_nopr_hmac_sha512");
-- 
2.53.0



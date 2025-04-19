Return-Path: <linux-crypto+bounces-12011-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41EA9447A
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Apr 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6162A1893E9F
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Apr 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68E1E0489;
	Sat, 19 Apr 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg5496XI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444E1DF75C;
	Sat, 19 Apr 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079454; cv=none; b=r0goUZiFlJqoGyMV9CnDlPLtn5+DlENjBUZtdG0Q0EaQMB7nz88LPVfC7MgUNwKQWHKCKnc7OkEf7JR3p3mDBFYXErEp2BpsLVTpm0USA4aSoMqqPE2UvvM0U5vqrYDNgew8rc7kzApGiUq8edSYxHQ6NXLi1wXMPfrkjhrZ3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079454; c=relaxed/simple;
	bh=XtyEiCkEKuikYYRpeUpbHx3EOmA+Ieo50jo5BElj4QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAe/ObRXfGefP4vAPyt2mMQnJao/Fj0Ll6lvLV0BaLEiBRLuH24J1hP3j4LSLeK4dhoMXsgDaQ5bZaUbfJI7IBStFZDWmIeNO9NcjJJIClBcKPg19fkOzip9B6xAD+y883QcOzDU+e9i8UXAZ91qMmyJFd1g5FjR+x6A9yCJQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg5496XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89071C4CEE7;
	Sat, 19 Apr 2025 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745079453;
	bh=XtyEiCkEKuikYYRpeUpbHx3EOmA+Ieo50jo5BElj4QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lg5496XIE7QMKhR+payE/ypvMqKYJE/Q5ubTeWaC7JMuArlPtfI/WQeyQ6SZ2kGmI
	 DeKZwZqxxqd+W/HOZZJrhhVA9zFkbkzke58Y3TUFgahhk3EsX0Pgs8vh7Jbi6D3Sgx
	 RZ33vsPZEalz2UhOqpoUyR94KC9yl2x4ur5wlueOOlcmzbTIcvEjTw0VdwF/BQSieD
	 THGCPtw4bJCbgzVp1L3d3L5VCHTElqoXNdwowITTN4p/6GQ4UqkvEMddjKtRaLc8Ul
	 jQjnxJQNG0Yv70paoCyjGd2e5mu7dzJaFvejQsOUoqH7sGBvaqjCEK2gUO32Txwkz5
	 W2bjShHEzhj4A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] crypto: testmgr - remove panic_on_fail
Date: Sat, 19 Apr 2025 09:15:38 -0700
Message-ID: <20250419161543.139344-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419161543.139344-1-ebiggers@kernel.org>
References: <20250419161543.139344-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The cryptomgr.panic_on_fail=1 kernel command-line parameter is not very
useful now that the tests have been fixed to WARN on failure, since
developers can just use panic_on_warn=1 instead.  There's no need for a
special option just for the crypto self-tests.  Remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/testmgr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 82977ea25db3..d075c48ff1a2 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -43,13 +43,10 @@ MODULE_IMPORT_NS("CRYPTO_INTERNAL");
 
 static bool notests;
 module_param(notests, bool, 0644);
 MODULE_PARM_DESC(notests, "disable crypto self-tests");
 
-static bool panic_on_fail;
-module_param(panic_on_fail, bool, 0444);
-
 #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
 static bool noextratests;
 module_param(noextratests, bool, 0644);
 MODULE_PARM_DESC(noextratests, "disable expensive crypto self-tests");
 
@@ -5858,15 +5855,14 @@ int alg_test(const char *driver, const char *alg, u32 type, u32 mask)
 		rc |= alg_test_descs[j].test(alg_test_descs + j, driver,
 					     type, mask);
 
 test_done:
 	if (rc) {
-		if (fips_enabled || panic_on_fail) {
+		if (fips_enabled) {
 			fips_fail_notify();
-			panic("alg: self-tests for %s (%s) failed in %s mode!\n",
-			      driver, alg,
-			      fips_enabled ? "fips" : "panic_on_fail");
+			panic("alg: self-tests for %s (%s) failed in fips mode!\n",
+			      driver, alg);
 		}
 		pr_warn("alg: self-tests for %s using %s failed (rc=%d)",
 			alg, driver, rc);
 		WARN(rc != -ENOENT,
 		     "alg: self-tests for %s using %s failed (rc=%d)",
-- 
2.49.0



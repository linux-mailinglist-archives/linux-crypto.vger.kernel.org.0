Return-Path: <linux-crypto+bounces-21927-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKCKHCeJtGmBpQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21927-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 23:01:11 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A228A3EA
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 23:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D4A9305A22A
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE3331202;
	Fri, 13 Mar 2026 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdBMBGT5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE94086A;
	Fri, 13 Mar 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439265; cv=none; b=DZ7yyvd8scPyA/Ocpx/G+7YPgRNPEVuYhm5mhLQrzOxEQQbC98ZUNn6yGKb1kI5w0+ebtOLVCuRUF7qtktd2OM2oXMNqkQoy/ABt84oH5PbqKe1VHYizL1eliBB+IWt9aaUx4MHfadiPJSyZANpaG7ABq8q0Ald5Jz7/TMaAFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439265; c=relaxed/simple;
	bh=7QDRyFIidNdnS/IymmhgjqWXPSBQRh/5QSogWq470Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ti7guo2h6l4p1Mtkgn0H+bhmY25n7hoax9GeeSuzNMMqsJK9+GkeGFRhUV+8KWjUWhYE8ZrmDBF/rcCnv3N9Ek+5EsyGjwHoQQzc6IjtROFejt07pVMUjqAqKyoqkV6gU81npDxZQjF3tT3UWr5odN6ALTJ8ta3fFLBjMdDlRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdBMBGT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D55C19421;
	Fri, 13 Mar 2026 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439264;
	bh=7QDRyFIidNdnS/IymmhgjqWXPSBQRh/5QSogWq470Rc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hdBMBGT59RCduU4R4D3fr/pSYqwwEtcGZH/dlOOIIp07tq5F/KvpwDdap/oVXZY+J
	 9Atis5fOkvkmTep9/4BoWMU83ISUKDMByueb4rOjP3mMQQ2fPjuHiRgFF7JmdLOY/L
	 gmoQPIAyz5Tu1zhgkL67ICjydgJoj/ttvxtz7M1EOOCDUBp1Z9OrgVTtRS9R0Hesz2
	 a841b7OHUI3GD2pJgBx4+LEs7f9yvDJGcv3ew8xT7K36xeJ167ok/9upWVm8ObiheU
	 If51b816zuuSfOCksmhikag0kQh9O26nhp/+zjMrvy4it0EjTdEXOTjdXpBuH6fsZ4
	 pr0e1U1L3VwmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD8107BCDD;
	Fri, 13 Mar 2026 22:01:04 +0000 (UTC)
From: Paul Louvel via B4 Relay <devnull+paul.louvel.bootlin.com@kernel.org>
Date: Fri, 13 Mar 2026 23:00:58 +0100
Subject: [PATCH] crypto: replace broken libkcapi link in Crypto API
 documentation
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-crypto-api-libkcapi-broken-link-v1-1-a218033d7f05@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqEMAyF4atI1hOoypTqVWQWWqOGSltSEUW8u
 3V279u8/4JEwpSgLS4Q2jlx8BnlpwC79H4m5DEbKlVpVZc1WjnjFrCPjCsPzr5jkODIZ3uH+qt
 0Q8aSNgbySxSa+PgXut99P3SKL6FxAAAA
X-Change-ID: 20260313-crypto-api-libkcapi-broken-link-65069e8ce688
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773439265; l=1586;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=zS0LL2f4m8BpZe7orBEj/v0/x6tFu/8SdGToDAw0bi0=;
 b=NIAz75h6nVAXaHqDss1V8y1Brf27u6DV/G7fj85LfthqkQA8XSJmHWntcSAnqc97VUo0tAVOr
 Fs1/dKE1UTXD/oKNhHfVL2aQ1JYdDSF7+cUQl8PE7ppCNDfM79YIXyp
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Endpoint-Received: by B4 Relay for paul.louvel@bootlin.com/20260313 with
 auth_id=681
X-Original-From: Paul Louvel <paul.louvel@bootlin.com>
Reply-To: paul.louvel@bootlin.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21927-lists,linux-crypto=lfdr.de,paul.louvel.bootlin.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-crypto@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[paul.louvel@bootlin.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:replyto,bootlin.com:mid]
X-Rspamd-Queue-Id: 331A228A3EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Louvel <paul.louvel@bootlin.com>

The "User Space Interface" section of the Crypto API documentation
contains a link to the libkcapi project that no longer works.

Update the link to point to the correct upstream location so that
users can access the library documentation.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
The "User Space Interface" of the Crypto API documentation has a broken
link to libkcapi. Replacing it with a working one.
---
 Documentation/crypto/userspace-if.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
index 021759198fe7..79e41845f611 100644
--- a/Documentation/crypto/userspace-if.rst
+++ b/Documentation/crypto/userspace-if.rst
@@ -23,7 +23,7 @@ user space, however. This includes the difference between synchronous
 and asynchronous invocations. The user space API call is fully
 synchronous.
 
-[1] https://www.chronox.de/libkcapi/index.html
+[1] https://www.chronox.de/libkcapi/
 
 User Space API General Remarks
 ------------------------------
@@ -406,4 +406,4 @@ Please see [1] for libkcapi which provides an easy-to-use wrapper around
 the aforementioned Netlink kernel interface. [1] also contains a test
 application that invokes all libkcapi API calls.
 
-[1] https://www.chronox.de/libkcapi/index.html
+[1] https://www.chronox.de/libkcapi/

---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260313-crypto-api-libkcapi-broken-link-65069e8ce688

Best regards,
-- 
Paul Louvel <paul.louvel@bootlin.com>




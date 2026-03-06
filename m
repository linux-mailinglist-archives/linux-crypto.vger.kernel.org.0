Return-Path: <linux-crypto+bounces-21672-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNKRFJlSq2n3cAEAu9opvQ
	(envelope-from <linux-crypto+bounces-21672-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 23:18:01 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A45F228469
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 23:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 328FF300C3BE
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2026 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AB34F27D;
	Fri,  6 Mar 2026 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Xs67FUKs"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAC27A904
	for <linux-crypto@vger.kernel.org>; Fri,  6 Mar 2026 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835476; cv=none; b=cW6ibIboW0ryu7cVx8ZiuvtvKrjOFAnoIIJL5lfMry9dQrtarFs+QrFtvsFnl415UE9MVcXwHEhP/e1U16j2Wf70zHNaqy6b16QFVAJD12tVcYz+fdBjUYIzLre9di9z12dsH9VF5zESwsSSMdWgkeSwIqPoC2vO+j9p8ITaB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835476; c=relaxed/simple;
	bh=fSwr0ullfbREp0kep0S6IWBiUGNeTKkTL/4Zfgz2mUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOTD91Zh//hxjIDtnLToBdilYPfT12dfA3hOL5Ih4va+5UTHzaAM4Fbna2IvFvVopdRGNK0Q5FAsnyJfpODeqzAyBFR9j9OiVKH8Czh8J/cu56wEwBeZKdxOwC0ct64FRqAVFqLedI7f/1TfJ9JgtaASbQFNIXnbwfYaYW3bIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Xs67FUKs; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22901 invoked from network); 6 Mar 2026 23:17:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1772835464; bh=ma/oSoBqzYB5BDGqEVHE7XguKpNXuAmKrAV3pLLp04c=;
          h=From:To:Cc:Subject;
          b=Xs67FUKsz1kqmUjgr4ZZtaC00az2n2wdqP22Qel8/6V1OuQ8RqxDwYqeFbn6jGmru
           Y8J5PTHQXcce2iqzKIyieX2/Wx2O2CY5PHhtDEWuyR1/cIGTGwyGQQlupDacc4u8AL
           GI6hVMO+k7OkCXiPmRpLWNkLKLilyahh/UhYthpjYIuj1SaoNMWKuW7fs/3uT6v1FZ
           2OJXQuqywwleFbpeCCerg1+dUQZJflwe4gUcPIJJLBfE+7DJnpuymC0op6+hEv71GZ
           92dphW7LgqIEQAUSZqo+6/HYwunzEO0mZ0a+S0ergGdDEG7E9V5PjXc44F7pyGdEwI
           QutgL+JBxLZAQ==
Received: from 83.24.116.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.116.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <ansuelsmth@gmail.com>; 6 Mar 2026 23:17:44 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: ansuelsmth@gmail.com,
	atenart@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vschagen@icloud.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] crypto: inside-secure/eip93 - register hash before authenc algorithms
Date: Fri,  6 Mar 2026 23:17:40 +0100
Message-ID: <20260306221742.1801119-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: d8f1101690aa9173361d06dc4931a3fc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000009 [Uerx]                               
X-Rspamd-Queue-Id: 5A45F228469
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,icloud.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21672-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wp.pl:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Register hash before hmac and authenc algorithms. This will ensure
selftests pass at startup. Previously, selftests failed on the
crypto_alloc_ahash() function since the associated algorithm was
not yet registered.

Fixes following error:
...
[   18.375811] alg: self-tests for authenc(hmac(sha1),cbc(aes)) using authenc(hmac(sha1-eip93),cbc(aes-eip93)) failed (rc=-2)
[   18.382140] alg: self-tests for authenc(hmac(sha224),rfc3686(ctr(aes))) using authenc(hmac(sha224-eip93),rfc3686(ctr(aes-eip93))) failed (rc=-2)
[   18.395029] alg: aead: authenc(hmac(sha256-eip93),cbc(des-eip93)) setkey failed on test vector 0; expected_error=0, actual_error=-2, flags=0x1
[   18.409734] alg: aead: authenc(hmac(md5-eip93),cbc(des3_ede-eip93)) setkey failed on test vector 0; expected_error=0, actual_error=-2, flags=0x1
...

Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/crypto/inside-secure/eip93/eip93-main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
index b7fd9795062d..76858bb4fcc2 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-main.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -36,6 +36,14 @@ static struct eip93_alg_template *eip93_algs[] = {
 	&eip93_alg_cbc_aes,
 	&eip93_alg_ctr_aes,
 	&eip93_alg_rfc3686_aes,
+	&eip93_alg_md5,
+	&eip93_alg_sha1,
+	&eip93_alg_sha224,
+	&eip93_alg_sha256,
+	&eip93_alg_hmac_md5,
+	&eip93_alg_hmac_sha1,
+	&eip93_alg_hmac_sha224,
+	&eip93_alg_hmac_sha256,
 	&eip93_alg_authenc_hmac_md5_cbc_des,
 	&eip93_alg_authenc_hmac_sha1_cbc_des,
 	&eip93_alg_authenc_hmac_sha224_cbc_des,
@@ -52,14 +60,6 @@ static struct eip93_alg_template *eip93_algs[] = {
 	&eip93_alg_authenc_hmac_sha1_rfc3686_aes,
 	&eip93_alg_authenc_hmac_sha224_rfc3686_aes,
 	&eip93_alg_authenc_hmac_sha256_rfc3686_aes,
-	&eip93_alg_md5,
-	&eip93_alg_sha1,
-	&eip93_alg_sha224,
-	&eip93_alg_sha256,
-	&eip93_alg_hmac_md5,
-	&eip93_alg_hmac_sha1,
-	&eip93_alg_hmac_sha224,
-	&eip93_alg_hmac_sha256,
 };
 
 inline void eip93_irq_disable(struct eip93_device *eip93, u32 mask)
-- 
2.47.3



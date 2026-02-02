Return-Path: <linux-crypto+bounces-20568-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALKqOdcHgWkCDwMAu9opvQ
	(envelope-from <linux-crypto+bounces-20568-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Feb 2026 21:23:51 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E2BD10C7
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Feb 2026 21:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D4E3057E61
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Feb 2026 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74542FCBE1;
	Mon,  2 Feb 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="H1OT7OR7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC172C026E
	for <linux-crypto@vger.kernel.org>; Mon,  2 Feb 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063737; cv=none; b=iFROaHQcZ0pvG5dI7e2urCvIrFLCKEnDn7MSXXXq7UGvqhHQCasho6jU8BrULux7R/csdxfxxxEP2yPILAnQ6w28JR6UBHEiOGs5PXy094FxhhoVBiqwPYr3y7wctFGO/RgN8MxqPRUsF4zUtzp1Yb0Smz/g/ilTozzHL7aXlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063737; c=relaxed/simple;
	bh=NYsBpadv+oKMPWlove9C1RU82vXECSdkhVJBBSVbTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSNjmYZetL+K9XbllN8AsparMiGGidSExV5svYcufcKg8vK8b5ltO06GCTRNoINbAsBOEM+hqwG5jjS6fHLdv78K/2Xsbj7uma/I4G3XNq5z9PTDI/J0NQFISKAqA5CuPJ+0trSQIvSExXahnIYstNEPnZEqr8tzF7POnN0qW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=H1OT7OR7; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 18678 invoked from network); 2 Feb 2026 21:22:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1770063725; bh=BQjJql/5vXMCWwbkNOlFIsPVXWXsK7DIDr/zxXVBYQE=;
          h=From:To:Cc:Subject;
          b=H1OT7OR7CpxPUEIkcTLsjp4K+a/P2vKJ0orJgD84ydfJPL46t7tVULwU43+jT9trg
           8tUQynp3OjzBR+a+sgTWdoQ5ooqqKv2xcvsSw1anu/IDf2ThsGuo8FVfv3aqAo3us2
           /6QCD7RslM5FBxOFNHmSg6i6JbEnDbD8K2DkGnvyaylKtuS9/EwfonT+yXlQsuyPV4
           izoeFf6gOPO3INJwqP/pdTaMeFmivbzVYkH35p0ZNDoJM2camGYwKdqxcKl0T5bwrZ
           DI5al/9f/hVk7f74PzOfpE52FkF+/ASnxcrO30NiPOArVAtIc/e7LL2dWueunRriyG
           Yu/XXcdZLBuow==
Received: from 83.5.238.100.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.238.100])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <atenart@kernel.org>; 2 Feb 2026 21:22:05 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: atenart@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH 1/2] crypto: safexcel - Group authenc ciphersuites
Date: Mon,  2 Feb 2026 21:21:07 +0100
Message-ID: <20260202202203.124015-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 3267e414e15d8a9c908e7b6f13dfe0b0
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000008 [kfvk]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20568-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,wp.pl:dkim,wp.pl:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62E2BD10C7
X-Rspamd-Action: no action

Move authenc(sha1,des) and authenc(sha1,3des) ciphersuites to appropriate
groups. No functional changes intended.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/crypto/inside-secure/safexcel.c | 4 ++--
 drivers/crypto/inside-secure/safexcel.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index c3b2b22934b7..9c00573abd8c 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1209,7 +1209,6 @@ static struct safexcel_alg_template *safexcel_algs[] = {
 	&safexcel_alg_authenc_hmac_sha256_cbc_aes,
 	&safexcel_alg_authenc_hmac_sha384_cbc_aes,
 	&safexcel_alg_authenc_hmac_sha512_cbc_aes,
-	&safexcel_alg_authenc_hmac_sha1_cbc_des3_ede,
 	&safexcel_alg_authenc_hmac_sha1_ctr_aes,
 	&safexcel_alg_authenc_hmac_sha224_ctr_aes,
 	&safexcel_alg_authenc_hmac_sha256_ctr_aes,
@@ -1241,11 +1240,12 @@ static struct safexcel_alg_template *safexcel_algs[] = {
 	&safexcel_alg_hmac_sha3_256,
 	&safexcel_alg_hmac_sha3_384,
 	&safexcel_alg_hmac_sha3_512,
-	&safexcel_alg_authenc_hmac_sha1_cbc_des,
+	&safexcel_alg_authenc_hmac_sha1_cbc_des3_ede,
 	&safexcel_alg_authenc_hmac_sha256_cbc_des3_ede,
 	&safexcel_alg_authenc_hmac_sha224_cbc_des3_ede,
 	&safexcel_alg_authenc_hmac_sha512_cbc_des3_ede,
 	&safexcel_alg_authenc_hmac_sha384_cbc_des3_ede,
+	&safexcel_alg_authenc_hmac_sha1_cbc_des,
 	&safexcel_alg_authenc_hmac_sha256_cbc_des,
 	&safexcel_alg_authenc_hmac_sha224_cbc_des,
 	&safexcel_alg_authenc_hmac_sha512_cbc_des,
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 0f27367a85fa..ca012e2845f7 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -950,7 +950,6 @@ extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_aes;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_aes;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha384_cbc_aes;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_aes;
-extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des3_ede;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_ctr_aes;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_ctr_aes;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_ctr_aes;
@@ -982,11 +981,12 @@ extern struct safexcel_alg_template safexcel_alg_hmac_sha3_224;
 extern struct safexcel_alg_template safexcel_alg_hmac_sha3_256;
 extern struct safexcel_alg_template safexcel_alg_hmac_sha3_384;
 extern struct safexcel_alg_template safexcel_alg_hmac_sha3_512;
-extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des;
+extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des3_ede;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_des3_ede;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_des3_ede;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_des3_ede;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha384_cbc_des3_ede;
+extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha1_cbc_des;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha256_cbc_des;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha224_cbc_des;
 extern struct safexcel_alg_template safexcel_alg_authenc_hmac_sha512_cbc_des;
-- 
2.47.3



Return-Path: <linux-crypto+bounces-24261-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EPCGlSDC2oZIwUAu9opvQ
	(envelope-from <linux-crypto+bounces-24261-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 23:23:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EC573C70
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 23:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B66483014870
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB1399002;
	Mon, 18 May 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="T684Eppc"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07239659E
	for <linux-crypto@vger.kernel.org>; Mon, 18 May 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139402; cv=none; b=BwoKIIaJXsJhX8TYmJ8T+MOXv7aawUSuu0bSnzmGUS1AZTpgM3QbCi5CvsnkzzwFDWCqpnhMTE2RIInypq2aIThKh+frh8WlkcWMIGXh0/kXD5J2WWh3T1ETiWnp5/E7Cuawj99+AFf+9LU6rfeIgWgF/SBAb6SeVKO8MseAX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139402; c=relaxed/simple;
	bh=WWpzuMje5GQNlJBgpYdegGU0Q9eZufYdiO6EniVNsRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJPjs4KRobA0HF3XTSk3BFcoFyVIwBDfEzBW1WALKxnMP9ZOxj06k7Yva7zddpUJEf1CP+lVjrC51CF71rKltCQQs9DMyMooUOeF2Zcp5dZ/ZDV3WWPG0nZ61yBVc7qQgNAcNdG8rRp6yGS83zQN1qrsO3uEkeR8SE0j7D91r84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=T684Eppc; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 36564 invoked from network); 18 May 2026 23:23:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1779139389; bh=CmDq8CG0IJtcFrB7cJnbGyjKAEPFJey91/u4IK6ch5s=;
          h=From:To:Cc:Subject;
          b=T684EppcPfL70NZ8lbUkCE6RMRHT8opIRMYMP1I4FRkGfhhADgulAJWi93uQ3UPGl
           TvkJ6Tu2HGfXR9SG53eNZpQezZyMF8hr98q5UDpyPtoGZOhruM7urheAuPlaJC+VMs
           YRLdu+ZuaVFKjj0btPW0IZklNVKBZj8VTnCQPVsVBquB0p9l3eVTQCLRREelkC+Y3+
           os4SVajbec2nj3avBzDhlcKC3KTLfHXbVhX9SluJoQ2F6tuNI8XbgN4bPZttWYLL49
           8Kd6RvriAjoslSVLCiB57e8OtxnEsoEHIHt1vrdzaqtzzlPGfPsyuJAQJiyZP9K+fP
           r4X4KBb0O9uJA==
Received: from 83.24.127.64.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.127.64])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <ansuelsmth@gmail.com>; 18 May 2026 23:23:09 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: ansuelsmth@gmail.com,
	atenart@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] crypto: inside-secure/eip93 - Drop superfluous blank line
Date: Mon, 18 May 2026 23:22:56 +0200
Message-ID: <20260518212304.290520-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: f059ebea7562a00be02f43679f476794
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000008 [oUv2]                               
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24261-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wp.pl];
	DKIM_TRACE(0.00)[wp.pl:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 737EC573C70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

No need for a blank line.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/crypto/inside-secure/eip93/eip93-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
index 7dccfdeb7b11..320a37d1f7dc 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-main.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -439,7 +439,6 @@ static int eip93_crypto_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = eip93_desc_init(eip93);
-
 	if (ret)
 		return ret;
 
-- 
2.53.0



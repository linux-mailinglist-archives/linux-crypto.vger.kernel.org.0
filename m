Return-Path: <linux-crypto+bounces-24262-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CaSDQKEC2oZIwUAu9opvQ
	(envelope-from <linux-crypto+bounces-24262-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 23:26:26 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83232573CCD
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 23:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50DE3040462
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56C3932E3;
	Mon, 18 May 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="FH9Re2T0"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BF399015
	for <linux-crypto@vger.kernel.org>; Mon, 18 May 2026 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139512; cv=none; b=VLHN63WwxBNMPeP226iNOh+RWTkY+wlBSGAregb5PHAoA0CzaqNGumYdcfhxx0pgApJege2PxdCKG/8FXGsnBOwW+x6rABI/b45qynbwEiKYHGbNFC63eDa/pvCvGMtJEhZpL8JMc8y/EReOOvwsYO/rrXVw0gGO18nuo7E+iFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139512; c=relaxed/simple;
	bh=AbvkrBYocTwsgw545YTujBgB19l5nmISKQnQXK9oyIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJWLl9iBPPKZt5/FUNsbG1doKjAcq6nIMd/geVphwSToj10fz2TTXSE374lKmRRWvhnT0X0WcdKSAeAXBzNVj6IGFaLsvPrswBsO7iE44ExepTI7Wkeo8A2iFkI3MxKKNKSsFaZ6E6lQHTCRosOyLqdZ2zX+UbM3FSjwLX2cGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=FH9Re2T0; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 44396 invoked from network); 18 May 2026 23:25:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1779139508; bh=qfV6mKkqYHmvXW2NJ0BMnBU3ViOZ1fsAA2f/heqCiZ8=;
          h=From:To:Cc:Subject;
          b=FH9Re2T08oyxJgggoCfWUDdPGaG+jmqse11XyXb5hWEKeNSrnHH91hGcb3UWab85C
           Xr2jP7u+zxwV1q/dEmAgK4zKIfZsh+3N9LwHa2DLOxLca/UxHGHk4+CAGe3sFJHqcL
           /tyo7Sf7k/VYfzFL3FtRNily7Ndal6cwIQmDlFnWDXX+nJw6GzUoDeoo118NidPKXg
           WKzhik2/WnzJIa7KSbxH7tymOtAN6gzO69dBuKcQR78x35EQMV0aqDYF1jxm0pYdJs
           a8sqeqF7pOkdK0rHMXgonwTG1glrRqs/h5bp1MpCd4Ex1pMaui5EUHUF8AW2VGZj17
           4XZHy4uR9obZg==
Received: from 83.24.127.64.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.127.64])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <ansuelsmth@gmail.com>; 18 May 2026 23:25:08 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: ansuelsmth@gmail.com,
	atenart@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] crypto: inside-secure/eip93 - Add check for devm_request_threaded_irq
Date: Mon, 18 May 2026 23:24:59 +0200
Message-ID: <20260518212506.292170-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 39f47015a7c0f2b3863711e5b31cc843
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000008 [wfu2]                               
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24262-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wp.pl:email,wp.pl:mid,wp.pl:dkim]
X-Rspamd-Queue-Id: 83232573CCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As the potential failure of the devm_request_threaded_irq(),
it should be better to check the return value and return
error if fails.

Fixes: 9739f5f93b78 ("crypto: eip93 - Add Inside Secure SafeXcel EIP-93 crypto engine support")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/crypto/inside-secure/eip93/eip93-main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/inside-secure/eip93/eip93-main.c b/drivers/crypto/inside-secure/eip93/eip93-main.c
index 7dccfdeb7b11..276839e1a515 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-main.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-main.c
@@ -433,6 +433,8 @@ static int eip93_crypto_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(eip93->dev, eip93->irq, eip93_irq_handler,
 					NULL, IRQF_ONESHOT,
 					dev_name(eip93->dev), eip93);
+	if (ret)
+		return ret;
 
 	eip93->ring = devm_kcalloc(eip93->dev, 1, sizeof(*eip93->ring), GFP_KERNEL);
 	if (!eip93->ring)
-- 
2.53.0



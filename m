Return-Path: <linux-crypto+bounces-21039-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PiMHZZimGkVHgMAu9opvQ
	(envelope-from <linux-crypto+bounces-21039-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Feb 2026 14:33:10 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD060167D56
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Feb 2026 14:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFBE63058562
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Feb 2026 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F5344021;
	Fri, 20 Feb 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NQgoFklQ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FD33987;
	Fri, 20 Feb 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594372; cv=none; b=iCjXkI2xftv9v2AjhzfAdqBuSXMKXif66nXKinthUDcHZm6nkLyQl7DBjLrVdMqtjREWsFYYp1lk0kKobJhhSeAQpcEPrxsQIqpAf5S3o/3hwK2QRNxe+xd2rznsgJhzpQpCaG6qIorZavAl+5/qUkfxpIDKuqw347bcc6S2rcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594372; c=relaxed/simple;
	bh=wYqdHt6VumXCo8KYxClK4m7+eBdpv3IEO6zO5lzrj3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPzxlFULZ+DvlL3QBRP5KRdObh7yLGPWfcFNJAck2wIOOymwy8TIsWM8j8MWbnuawUh2qjLDjmHq6IUPYNql6uFf0aDAe+g3Q34Dva4MLggrNHwzs1obYrz0MCHgsnDF4srcKfvzkSBhhI+n4l1k1oacimtLjGBOJtS5WBy2iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NQgoFklQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771594359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qv9W0wQRDmkr+3Q7aTuBQudRy6movyrphWCLG7hTrqc=;
	b=NQgoFklQEOjaZj22rTHsNvV11JTkMU/g01rNteMF9rdRZ0STWk0GB9Zj2SjLfHk4/4CCTl
	B1pc3y3OaEhO8yWZAwUVQC9nS6fxPnW1YzhI58J65EghaRK6P708PDME1ZJRgTxEQCfeWX
	9EgEQ6TgcDu/wG0anpb5hM8ze91MNwE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Lothar Rubusch <l.rubusch@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: atmel-sha204a - Fix uninitialized data access on OTP read error
Date: Fri, 20 Feb 2026 14:31:36 +0100
Message-ID: <20260220133135.1122081-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,microchip.com,bootlin.com,tuxon.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-21039-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmd.data:url,linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD060167D56
X-Rspamd-Action: no action

Return early if atmel_i2c_send_receive() fails to avoid checking
potentially uninitialized data in 'cmd.data'.

Cc: stable@vger.kernel.org
Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/atmel-sha204a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0fcf4a39de27..f4a04b297257 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -103,6 +103,10 @@ static int atmel_sha204a_otp_read(struct i2c_client *client, u16 addr, u8 *otp)
 	}
 
 	ret = atmel_i2c_send_receive(client, &cmd);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to read otp at %04X\n", addr);
+		return ret;
+	}
 
 	if (cmd.data[0] == 0xff) {
 		dev_err(&client->dev, "failed, device not ready\n");
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4



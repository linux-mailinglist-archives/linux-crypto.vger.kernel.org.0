Return-Path: <linux-crypto+bounces-20902-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDF+IEu/kWmAlwEAu9opvQ
	(envelope-from <linux-crypto+bounces-20902-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Feb 2026 13:42:51 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92B13EAC6
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Feb 2026 13:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E2263004D8E
	for <lists+linux-crypto@lfdr.de>; Sun, 15 Feb 2026 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CAB2F12DB;
	Sun, 15 Feb 2026 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wPRLSg96"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1C2DB7A9
	for <linux-crypto@vger.kernel.org>; Sun, 15 Feb 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771159356; cv=none; b=kTyil58t/ztWkLnj+stIqcerg3R5VFDpkgptjX4EljMj4DLkwMY7i3fr+AnSu55tRLLfGZQUhc1Jj4Tx4mg7/UZ1ogkE2u+qd1hBFijQzio6pk1XZ2aOz4qwsxuRCI3WCR4ogdxTTwJ554oBwD8sKufzZ70DhLsbCsEOqhxN7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771159356; c=relaxed/simple;
	bh=5+P4obm2qvRoLyi5dg9blApuyDkgjQ2CAHmPVE8AfNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jX/lEZeqI6ITQJihcrer3u2hedpmqyvaP7bzCv27VkY1qcfRho/RiI0DMQxQJ4LRtKF0P/xdyVkCMcqgaRe0bU85LGhHgwusMSdvMZmvEUYLyfgCqwzC3tVP/xFewVXY76cuYJEK1aqa8d4W7Ng3mcD+JcjksayK5Kfh9Kjgl14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wPRLSg96; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771159342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VQDv5dqbLfmwjDpjsrsMcIq7TVKy2xH2Iv9N7SxzQ0w=;
	b=wPRLSg96xUsy8p0iOsCDwnH5cj+9uMxzlvIGTbWq/QghBk2JoFRnw8cPsLy1GFm1cKZBJP
	Y4M/bazNKlIAqhLC4Gp5JMR4uwl/vV//2IPvgAA9Wo+2NyHa/Vuzp/bfh54JxG6b7uR43v
	Ls9QuLvIJwWiPrbMj3k+fFMyYhtFmwY=
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
Subject: [PATCH] crypto: atmel-sha204a - Fix OTP sysfs read and error handling
Date: Sun, 15 Feb 2026 13:41:26 +0100
Message-ID: <20260215124125.465162-2-thorsten.blum@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20902-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,microchip.com,bootlin.com,tuxon.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF92B13EAC6
X-Rspamd-Action: no action

Fix otp_show() to read and print all 64 bytes of the OTP zone.
Previously, the loop only printed half of the OTP (32 bytes), and
partial output was returned on read errors.

Propagate the actual error from atmel_sha204a_otp_read() instead of
producing partial output.

Replace sprintf() with sysfs_emit_at(), which is preferred for
formatting sysfs output because it provides safer bounds checking.

Cc: stable@vger.kernel.org
Fixes: 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.
---
 drivers/crypto/atmel-sha204a.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 0fcf4a39de27..793c8d739a0a 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/workqueue.h>
 #include "atmel-i2c.h"
 
@@ -119,21 +120,21 @@ static ssize_t otp_show(struct device *dev,
 {
 	u16 addr;
 	u8 otp[OTP_ZONE_SIZE];
-	char *str = buf;
 	struct i2c_client *client = to_i2c_client(dev);
-	int i;
+	ssize_t len = 0;
+	int i, ret;
 
-	for (addr = 0; addr < OTP_ZONE_SIZE/4; addr++) {
-		if (atmel_sha204a_otp_read(client, addr, otp + addr * 4) < 0) {
+	for (addr = 0; addr < OTP_ZONE_SIZE / 4; addr++) {
+		ret = atmel_sha204a_otp_read(client, addr, otp + addr * 4);
+		if (ret < 0) {
 			dev_err(dev, "failed to read otp zone\n");
-			break;
+			return ret;
 		}
 	}
 
-	for (i = 0; i < addr*2; i++)
-		str += sprintf(str, "%02X", otp[i]);
-	str += sprintf(str, "\n");
-	return str - buf;
+	for (i = 0; i < OTP_ZONE_SIZE; i++)
+		len += sysfs_emit_at(buf, len, "%02X", otp[i]);
+	return sysfs_emit_at(buf, len, "\n");
 }
 static DEVICE_ATTR_RO(otp);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4



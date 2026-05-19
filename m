Return-Path: <linux-crypto+bounces-24317-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AjbIt3MDGrAlwUAu9opvQ
	(envelope-from <linux-crypto+bounces-24317-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:49:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D3584D99
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20B8F30578BA
	for <lists+linux-crypto@lfdr.de>; Tue, 19 May 2026 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1493BED47;
	Tue, 19 May 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPoiAN64"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF723B38BB
	for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223693; cv=none; b=EFlw0ICZwfPoEEe2IqLPUmp7RPoAqZV/EVa2VamyHflyQBFtSFfW7AgLZ/PSNkzQSkGOhWCAsFLijPjTNINNTpuhKfaSEPwAFBBsEGmke6fF9AE73o3q1p9n5Jt1ZVSwlW/g9yJI2HsUI1kocbVM9TNXv6g/+pR62NV6beL9tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223693; c=relaxed/simple;
	bh=lLAXP5B8iQxWueO/YFGp6YJLOvSNEYcvKWK7YpLnyyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GS/sJI7MGfam2Wz3YhVYW2lE4FE/UXCbxk8iSmwDM0Ds9qsqJ9AhbPnGwDB0+iNoeByjVm//ASLvkNHoBK7gUFJ7VksJ6Cgh0vgaHoFA99usX2edVgcoZvhj/vumYVkuvwzve56e8GWiKzb+r2POP0OCx1TxGfvbVP3G+adB9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPoiAN64; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4493cf2f982so250110f8f.2
        for <linux-crypto@vger.kernel.org>; Tue, 19 May 2026 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779223690; x=1779828490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0c34ELoPJoazDfI83jDiunrFakmVLtTU4AFI7jrtuhM=;
        b=ZPoiAN64K1TfudKRs+wFJF7l0DxeKRSiZwrOaZNCBhUWwTArl513nWbng9QBHwzCvf
         Y0xfxOjb5E48eaDraMx0zfMqyrNfvQpW42sZ61wkN8zdIbThSaC/XTyZJKj8cBeQstfe
         xvItWSpZFUsWLL5cQp4Ypn2mhI/G7V6c2Kjenp1CjxspW7/5ak103HPg9EShSVq5qCD1
         svZQf/t3Tu/gefUmterq5RJOyklhaxwcC9mUaZn2gd7pVj0v+cWGmSUF7dIGx48AEhMg
         SJbbvUvXiuGFkKim+V6aGb/gf+ZKIleFS+tOq2AHykOUTiQIr/eItposdeTuzgTjjTiI
         WCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223690; x=1779828490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0c34ELoPJoazDfI83jDiunrFakmVLtTU4AFI7jrtuhM=;
        b=fk6E+6W4gumk2tloyc6p4FddzCh4V4fkmn6X8j67tgyJpn0BIxO08ui2bx5/mK18Bg
         Juw4v0uU8U6AgNqL/1Y1Q2FPa4d1pZUKkRbAqk7QFL81+jRWExeG7uforlvAnofCTNV2
         lXepSxctoOeInmpImgfuK1eXsS1TOff8toi4mJNJ1e6aW3/qBXOX1IoOGk6JYXpOFTQl
         sVii5CWRzylmD5yIAV8Xp0XiNNZXDdUtfQNfQeZG6wxn4942IkW7pt7FerHcjJesr5RL
         +672dYpmAZMkltuMx4F6xaCcXVQsotDst/FJ017Xfas3nz5UusLxN9uCg3FoNEAdidsl
         g8uQ==
X-Gm-Message-State: AOJu0YyaFthkHv9MgOH7xIBr25CYVG92kxBUA4sFv3oQSEwNWZDYSlNQ
	0ed/OO/2yWGtmq3mTv3anO6+2TLkRj+hqU7UBrprqOZOFkHcAQyvWuKe
X-Gm-Gg: Acq92OER9k47kBwtutd5qociiQYaeWe1jbLy/TDANZIp9CJBkEma0beQg2P0sezmecx
	KO1hW/6H1Xf+U2yz8sHkkeh/vkY387W4xbRNNidwGtrVIDR/UJYoA31GzOoMExI2nygvigdM9RN
	VG0HSBab3kWdaWYZn2A1yZmjA03v8YpxwPqXxmIMnLEKlpbjFajgEeERw5i3x7VEKDfFd3BH0mQ
	y9XFlW/L5Sbu1kGoRB6uKg2jYeMd8+ntGKsGm2naye1iDSbT6ycz8uF/7V0rNC61zED9WjTBMQ2
	79zS/dYfW5gCcD9KijbJ/EzzTh5ED0Qu9iBEgCdObguKcTyQdtWus5FlS5twBebS7gnP9GXasiY
	S90XaaJx0jRL1zn3+gL4n5qX4wZx7HXq0HrbOG5R4Wzd+jPNRABnpOUaAcLiD1nb6z0wfEhchlf
	FO3DPxUiLDPnb7XBT4gCbyin70XXyAEdPo54YmbZRDNxPnRdgKzkjsHtdCKCvuJpE=
X-Received: by 2002:a05:600c:4455:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-48fe5fcb2dfmr159641895e9.2.1779223690355;
        Tue, 19 May 2026 13:48:10 -0700 (PDT)
Received: from menon.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm356457755e9.0.2026.05.19.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:48:10 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: thorsten.blum@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v2 01/12] crypto: atmel-ecc - rename driver_data before moving it into atmel-i2c
Date: Tue, 19 May 2026 20:47:52 +0000
Message-Id: <20260519204803.17034-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260519204803.17034-1-l.rubusch@gmail.com>
References: <20260519204803.17034-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-24317-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E6D3584D99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename the local driver_data instance to atmel_i2c_mgmt in
preparation for moving the shared I2C client management
infrastructure into the atmel-i2c core driver in a subsequent
change.

No functional changes intended.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/crypto/atmel-ecc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 9660f6426a84..c9f798ebf44f 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -23,7 +23,7 @@
 #include <crypto/kpp.h>
 #include "atmel-i2c.h"
 
-static struct atmel_ecc_driver_data driver_data;
+static struct atmel_ecc_driver_data atmel_i2c_mgmt;
 
 /**
  * struct atmel_ecdh_ctx - transformation context
@@ -209,14 +209,14 @@ static struct i2c_client *atmel_ecc_i2c_client_alloc(void)
 	int min_tfm_cnt = INT_MAX;
 	int tfm_cnt;
 
-	spin_lock(&driver_data.i2c_list_lock);
+	spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
 
-	if (list_empty(&driver_data.i2c_client_list)) {
-		spin_unlock(&driver_data.i2c_list_lock);
+	if (list_empty(&atmel_i2c_mgmt.i2c_client_list)) {
+		spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 		return ERR_PTR(-ENODEV);
 	}
 
-	list_for_each_entry(i2c_priv, &driver_data.i2c_client_list,
+	list_for_each_entry(i2c_priv, &atmel_i2c_mgmt.i2c_client_list,
 			    i2c_client_list_node) {
 		tfm_cnt = atomic_read(&i2c_priv->tfm_count);
 		if (tfm_cnt < min_tfm_cnt) {
@@ -232,7 +232,7 @@ static struct i2c_client *atmel_ecc_i2c_client_alloc(void)
 		client = min_i2c_priv->client;
 	}
 
-	spin_unlock(&driver_data.i2c_list_lock);
+	spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 
 	return client;
 }
@@ -323,16 +323,16 @@ static int atmel_ecc_probe(struct i2c_client *client)
 
 	i2c_priv = i2c_get_clientdata(client);
 
-	spin_lock(&driver_data.i2c_list_lock);
+	spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
 	list_add_tail(&i2c_priv->i2c_client_list_node,
-		      &driver_data.i2c_client_list);
-	spin_unlock(&driver_data.i2c_list_lock);
+		      &atmel_i2c_mgmt.i2c_client_list);
+	spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 
 	ret = crypto_register_kpp(&atmel_ecdh_nist_p256);
 	if (ret) {
-		spin_lock(&driver_data.i2c_list_lock);
+		spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
 		list_del(&i2c_priv->i2c_client_list_node);
-		spin_unlock(&driver_data.i2c_list_lock);
+		spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 
 		dev_err(&client->dev, "%s alg registration failed\n",
 			atmel_ecdh_nist_p256.base.cra_driver_name);
@@ -363,9 +363,9 @@ static void atmel_ecc_remove(struct i2c_client *client)
 
 	crypto_unregister_kpp(&atmel_ecdh_nist_p256);
 
-	spin_lock(&driver_data.i2c_list_lock);
+	spin_lock(&atmel_i2c_mgmt.i2c_list_lock);
 	list_del(&i2c_priv->i2c_client_list_node);
-	spin_unlock(&driver_data.i2c_list_lock);
+	spin_unlock(&atmel_i2c_mgmt.i2c_list_lock);
 }
 
 static const struct of_device_id atmel_ecc_dt_ids[] = {
@@ -394,8 +394,8 @@ static struct i2c_driver atmel_ecc_driver = {
 
 static int __init atmel_ecc_init(void)
 {
-	spin_lock_init(&driver_data.i2c_list_lock);
-	INIT_LIST_HEAD(&driver_data.i2c_client_list);
+	spin_lock_init(&atmel_i2c_mgmt.i2c_list_lock);
+	INIT_LIST_HEAD(&atmel_i2c_mgmt.i2c_client_list);
 	return i2c_add_driver(&atmel_ecc_driver);
 }
 
-- 
2.39.5



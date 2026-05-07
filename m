Return-Path: <linux-crypto+bounces-23834-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACa3GO4j/Wn6YAAAu9opvQ
	(envelope-from <linux-crypto+bounces-23834-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 01:44:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 247904F0344
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 01:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5796A303C67C
	for <lists+linux-crypto@lfdr.de>; Thu,  7 May 2026 23:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABAC37C920;
	Thu,  7 May 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbi0XKxp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9F33E373
	for <linux-crypto@vger.kernel.org>; Thu,  7 May 2026 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197478; cv=none; b=TTx3Y3HhSywLjl/qa+R8qA8X8YhtuNbXv/RjmNeOTG/TT36husxzbkX0PEYQdCHEs+mH3vQPv6iaExBnB1wTRZOd1bdFf0oCYMn32IIn0IuQuzpEv8r2WqrixIXvd1wOwgZxUKiNtcb9ogzx2AtEZbfbO6E1FGJez7y3YAqQO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197478; c=relaxed/simple;
	bh=gcQ2TuQUxnhuK45sKX3v074CH0TDFNFxzFXxOOiZPoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pa+wObJC2YQhEaaKRsqZfgWgV7MGyFdwhj58fG7ZnuNgV2uoaAc/oYgwQjvidtr+2RxwS8DhXdU8v4mHwmOEDKV/s8Z/TTUxsfI95EG5zeSEAFLdjjUp/vcnfF7quX3x8ApVZGXS+DAlD9x5jGF89sH22kiE/wmfNuOXDQZd+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbi0XKxp; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acae26e564so13467036d6.2
        for <linux-crypto@vger.kernel.org>; Thu, 07 May 2026 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778197476; x=1778802276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqqSkARmaTN3p49h4nEScAG9LlwTFVMGsDAkq9FOFjE=;
        b=Xbi0XKxp1n/gBmPoQ22L812nnfMMQ7w3Ipjyt06ErBKWtW6XgqLI4yTbaCHMY/s8hH
         XoP2DpvqDF/doEmpcaddYuLs9xo53paRtkTMrR0r2hwachxr+b1Rl6Mn8XNF/PmdAx88
         XTvraGYoCF4TWW0s+HluR2zVydf1EFBjCssxlevBU8+dUV+SYFKbNDM9losmIHpbmD5Z
         SDKY50xz2kfA/E59byIHxzZ0/BsR6ampIzZhnEgt/J37zbtyeBGwgK6FqqkDtKLDhul5
         TRVvNiWCvj9mND0ASuRYDvYirKYJuJiPzptQh+LQ5712leRzb9EFU6iNNI716cwZunlj
         nelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778197476; x=1778802276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqqSkARmaTN3p49h4nEScAG9LlwTFVMGsDAkq9FOFjE=;
        b=VTs8bJXHGyjEf6oejz+7qJoMeSpDjVczhR90vqMiPOb7YlDEWovVURaKWX/5Vqrwjj
         RUciXIS0v8aaSBq4zfEMrVqw17p99AwoMU4/zeerWsWS0TGpMk7t5z1ISPPW28Z3Jvat
         nccl0GQdKpHdmuHPmf4+PZ0fVjDVidUswcbHqxLoRfTzGYnVx+yBqR7tX3eEgyVokR/V
         7qCEt1Or9heeMsS6DsE2NAJSo1LYSdfGVQkVvbh0+LhyY1ISeoljV0rwEypfEuV1NLec
         DGh0VIyDhiT2keBfE1QzoDSaPoIGBq8pnm7SnYSVjlSLwKlS0FgjtPVCVxNeo3g4h7Um
         e8+w==
X-Gm-Message-State: AOJu0YzG63kfR/AcOJbXtr09aClPyjdKebJOyyS9ejXADmGouxFUjxqp
	OG8O61FpqaDualxNa1gwoY9kcmoALlYwHbJd9c+TkNA/Jde/ASg1Qk5zUw4EAcRT
X-Gm-Gg: Acq92OFg+2uH74Hr/VQEL+vGFKOpt7JJ3h+TmCl4HXtRETnaAYBx4R3asivoLlbJCwK
	kNG+Y9CWIk17lUwJpw5VLbiE56yeGBHRw1ln9MVgdjsWPsnZExbmEjNJcxO22zqFq7MSX/Go6Do
	WltYoKjhQq8MY5vJLXNki9De2KgKBEzddDJXZJdoOGxdKv0wXKgxFR9zHO2Xra1e4pQwxUlrD+3
	iCYDBdAWV3q4zaZZ8Rc76Wn9hxxEGbBW8DxBsSPvZLQ80QyNTxhq7fv2YzkFmiH+lFVr9plwx2+
	u7OAaaLfBqg69oG/QBy5y2m+oDuO0JrABu0r3QR7zKzTXp2tOpN86QaPav5rGl29PK1PAXlp+Q8
	iNnWvDfE90eE7sHhsvl03W+6SU1KUvcKPwEAm2e/ULkQwpGUinyysQueieMgKGUB+20C2Z8krka
	nbZ9uUvOXsBusvHg09qfK8j68rFHuC6gaT/9ysutDEhvzkctbQBEGHXb+OlyzatKmLZXBkT2ZfJ
	fOdQVI3cz6lNY4agxv4+1pZI2rLNBYelmE=
X-Received: by 2002:a05:6214:4a88:b0:8a7:3317:6043 with SMTP id 6a1803df08f44-8bc42492ae8mr151438526d6.3.1778197475975;
        Thu, 07 May 2026 16:44:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8123sm217144146d6.35.2026.05.07.16.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 16:44:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] talitos: use devm_platform_ioremap_resource()
Date: Thu,  7 May 2026 16:44:16 -0700
Message-ID: <20260507234416.677882-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 247904F0344
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23834-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

platform_get_resource and devm_ioremap effectively open codes this.

The return type of devm_platform_ioremap_resource() is also nice as it
has multiple errors that it can return.

Because it internally calls devm_request_mem_region(), reg values and
sizes cannot overlap. This was manually verified to be the case for all
talitos users.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/talitos.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index bd4cc06ee13c..bdf7549fdf0a 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3412,7 +3412,6 @@ static int talitos_probe(struct platform_device *ofdev)
 	unsigned int num_channels;
 	int i, err;
 	int stride;
-	struct resource *res;
 
 	if (of_property_read_u32(np, "fsl,num-channels", &num_channels))
 		return -EINVAL;
@@ -3431,13 +3430,10 @@ static int talitos_probe(struct platform_device *ofdev)
 
 	spin_lock_init(&priv->reg_lock);
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENXIO;
-	priv->reg = devm_ioremap(dev, res->start, resource_size(res));
-	if (!priv->reg) {
+	priv->reg = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(priv->reg)) {
 		dev_err(dev, "failed to of_iomap\n");
-		err = -ENOMEM;
+		err = PTR_ERR(priv->reg);
 		goto err_out;
 	}
 
-- 
2.54.0



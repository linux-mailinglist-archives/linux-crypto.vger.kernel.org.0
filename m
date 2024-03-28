Return-Path: <linux-crypto+bounces-3034-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D528908DF
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Mar 2024 20:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C871F25192
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Mar 2024 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE9137934;
	Thu, 28 Mar 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="g1vJID4F"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD193130E3E
	for <linux-crypto@vger.kernel.org>; Thu, 28 Mar 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653125; cv=none; b=HSZv7lX0hokMpX0ZQ4VU1Z7P855gCkxdtFoJXMeB44na7Kp96vl/mw2OEgrW+W2O2K8JMqbZXtCsjTlzdAFyw6j5JJlm47VsUmb/hc5fnhGxc6uHtXUHbak4Kcgjq/JhUSQRi7GwNHiJvAZQ17+cBaiBMahR01qMQ//420z8tQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653125; c=relaxed/simple;
	bh=WdT850BrFUtNSdscPDHstvsJSbWJCrq+fJKOb4t3NGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IFjCBm8gMeQCoEnpjcaf0NdgLlOOaXfsU1YY+u4oRo+zfVDBWjSXPGPjX6q+T6ggnDqYm2tWEiHoY82Y7lT27pZzmfkuqT/3nEXMKoEtw3BPptN8IkaS1i9lCBqnvp/9p30o5f9fBhyWf6DLQOMHx1vZKjRnpSxWDYSGvnClKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=g1vJID4F; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso2016477a12.2
        for <linux-crypto@vger.kernel.org>; Thu, 28 Mar 2024 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711653121; x=1712257921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wZ6xWGSDhVRLxzfYy01JgWDM8uMS6wBHVe0w0OdNVk=;
        b=g1vJID4FobpWIKOwA+7AACSU3CZwgsa2k/GOFqOnhibRoTywBnEIrXfEmmJZaAN46L
         0ARQ8IalTiwraLK9TuOM2g0K9Av/rkwJ+pH3onlDgXxEDK5L/n+IqbYhv4HZOHTWPej/
         V0dgA3Gnsxo9n2AUetSGwgKKIJkMhxI6KHpMFeMZ6ZCTFqBsTCId4BsKgk8PJ7iVDDVy
         0LnOei1h9XDUc9S+QUqWtfzGu6WIN9PImS+BoF7WZk78AI+fNz9y8+K7KRrbRnDXaoUb
         FLUmc1j7wE/Y6IrdyFK2Sryioznk8opuaj8w0uHDd4+9QJX5qFiW4U1btxNeJBnfyFIi
         qf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653121; x=1712257921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wZ6xWGSDhVRLxzfYy01JgWDM8uMS6wBHVe0w0OdNVk=;
        b=ltBFJohUzlIyyGo4AgMyYpEfVEZeX06R6Z4OUW15+XMc5BD+UPgYexA5/ZYY2X3j6j
         iqwKEa66zd2Ho2Du3PlR3Na+MlflKSiNZUTJdmyMGoSSg0d+8nBtKkax/6IcPCnSE3L5
         thI0JJSGEvyikdUjQathts2OpdBiRLhCbr1Z4dGV/k9IcrTPe6XnesnAxKSHMz8jvjBb
         8cN9FRefKtkXhL9+2BsVpL4A3kCxmHvGdkc6WorJPDyrOf4Mh+62xZVvXZmHxgD4nHm7
         lq5DOFsjjTT9jsqSgNOh/uDD8xBg7Dqk235FyVZAC2QbRvix4xGlcrYccz+xaCsiJVfm
         axvQ==
X-Gm-Message-State: AOJu0YxOzLXhxg5e7hG5CXORc4iLR5I708/manbEnEVffMK2t8pkZT7v
	JN0j+XA0OoJGL7Kjt4u82J6YgvBt4ExlR4AzS8PQscPC7+6E3ulLXVZqCZbEETYgtYHMM26NnN3
	NK1A=
X-Google-Smtp-Source: AGHT+IFhc0Re0LenOTCoW82MfYtfd+rbj0ZdqwrNRv+4gqtnacw26OX8Olim4sk0Ad9fmd0Mg3pMiQ==
X-Received: by 2002:a17:906:180b:b0:a47:35e5:7da0 with SMTP id v11-20020a170906180b00b00a4735e57da0mr98456eje.41.1711653121106;
        Thu, 28 Mar 2024 12:12:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id n9-20020a1709062bc900b00a469d3df3c1sm1068587ejg.96.2024.03.28.12.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:12:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] crypto: jitter - Replace http with https
Date: Thu, 28 Mar 2024 20:05:12 +0100
Message-ID: <20240328190511.473822-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PDF is also available via https.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/jitterentropy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index 26a9048bc893..f2ffd6332c6c 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -157,8 +157,8 @@ struct rand_data {
 /*
  * See the SP 800-90B comment #10b for the corrected cutoff for the SP 800-90B
  * APT.
- * http://www.untruth.org/~josh/sp80090b/UL%20SP800-90B-final%20comments%20v1.9%2020191212.pdf
  * In in the syntax of R, this is C = 2 + qbinom(1 − 2^(−30), 511, 2^(-1/osr)).
+ * https://www.untruth.org/~josh/sp80090b/UL%20SP800-90B-final%20comments%20v1.9%2020191212.pdf
  * (The original formula wasn't correct because the first symbol must
  * necessarily have been observed, so there is no chance of observing 0 of these
  * symbols.)
-- 
2.44.0



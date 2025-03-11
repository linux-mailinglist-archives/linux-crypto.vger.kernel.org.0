Return-Path: <linux-crypto+bounces-10689-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488BA5BC16
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Mar 2025 10:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D413AE2B0
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Mar 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7C3230BD1;
	Tue, 11 Mar 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WNUwZmYd"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F022F155
	for <linux-crypto@vger.kernel.org>; Tue, 11 Mar 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685148; cv=none; b=cocU1V9vpvwkDphb4eJGeqBuraMn2NmiBcHbj0OncXo5OVOtpcmuYqo+351kmUd5eDaDZe3AIkW34sYS1MUmbppWzQDdw9Vabi5ACkoTWz6cyxDMAhnBjgJsY8MkznXxiEImhckewewE7WuNDgIyGMA0FNEWreuGXvGVWmQbOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685148; c=relaxed/simple;
	bh=UD83xHC/OFAOwSB+qvX6FSvB95/U7FyJrkvlFwf+cOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/C9oZFiJL1M1RJ3XCv4+te/6+FaFzpBHuvrkWquil1abCU/VgjBJwHXOHNelII6ymfp4KwkIcihq0LGSWnCMlSAsdZ/qQ4xq47raAgLmkA+zI7fBVpbGeopz3vt2vDO346vHYclhlceA7jIqUhgY4BjyRIftH625fmXNiAd1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WNUwZmYd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso15445895e9.1
        for <linux-crypto@vger.kernel.org>; Tue, 11 Mar 2025 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741685144; x=1742289944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5gyJf+BPkvynCiKQ4tiqU3JQCzOM6uVqE1SpUYdFf4=;
        b=WNUwZmYdkHghb0n3Ip53/XINgRIGTb2wtZ+bZIfalI4KlMj87Pltu9GhhzttDO5tE3
         0cHqWQ94Y51TgsA2d5/xc+AC80T/KxtibRDtDJFcwZzi8BsecwmRXwhVn99rIeei9s3M
         FVMOF0flNLd/CS5CvvNETGFgFg1loHhRNstbk4+iVPDlKZtanjwHagJYYE/oXGNFY2kU
         j46AzkGghvnRbHJtX8zXva7LGRqq/5ZUmvOXzBc6NXgTQNkg/aHZOQdNZmmX21KsUDQp
         UFUua/oqx9V0aLu1CU7z9X+gmuXPXaw1bI4DKMAq261/W0BWBf96nKQkMxma/Cyly3Yh
         sERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685144; x=1742289944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5gyJf+BPkvynCiKQ4tiqU3JQCzOM6uVqE1SpUYdFf4=;
        b=pjdM6jbDm7CmVD2zgp1HaeSPDIn77KGzsC9GGmOmqDohPf4vV2n3n6VlZ+wO5rIKLc
         vclIrt39vvBCIIn/0pYiNHkszhARyLdHjYZbIu4SPsQ4Ymu0Ce+xxfP7l1HBUqTS7cMC
         a7lDolc+g1/dfVWXwNqCWPJhWQB6dgbIslj/SFVeItjmKY7CK376CbUVBngjXiEdLuRF
         6vsfT5dia0cUNY1PeqmugNDsN85gPVKTJrVvWsS1K7dl9kzBsaIj2LTarzpkNVYxWKPh
         gr/7tkLN5aEV1SgeiEDVskZDeV3CMSalKD9OYOtkSFmAVINcvoLyx9CweqIQp2NLa+eD
         8GAw==
X-Gm-Message-State: AOJu0YwUe91fbD6tiZjRvK4Xuq6Et0VfOMQlF0VsVsQvsvFAhjj8gMsc
	OrDWdxlV7U5r39Ab771ZHF0Yc+4t/HgXIXOutvE7Di4cQWmtZsmRtLh9vdOvUBQ=
X-Gm-Gg: ASbGncvMhRORio1cS5/fb93cCY8xcLrmCjwcnym1knrE6kHloAUvahFONja/cRd0h4p
	KXuOLj3kUiF4+H1IScevtZJSLK2JrRtDdnD7csrmCYOgScs/bT3dVNilOGBVq+poHzZk3U+3EPY
	tVV1/ogycCc+W4J85fQNhK1EcxbG81q3pXj5eztFZMa6X/YrGYbOS/D6YhIj4ooyo+F1O9H7NlV
	0JtfV20Fbya8btkJbZVldq0y+AdeVETK/61GaS/pI5lVqr7yjYViSEvLtu5nZZnlW/6dz0Gn7dB
	M+HH+I27eLbp8DXjbGuALsbWDL9ATxudCy1o
X-Google-Smtp-Source: AGHT+IHTyMRZ8iCL2pWXxScJdsm/h83C134LYTw05J5QlNSMtDGV1tUZg3DCFGmvEQ2L4hlmXhtLMQ==
X-Received: by 2002:a05:600c:354c:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-43d0094d42emr56383185e9.16.1741685144555;
        Tue, 11 Mar 2025 02:25:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5946:3143:114d:3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm107436465e9.15.2025.03.11.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:25:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 10:25:32 +0100
Subject: [PATCH v7 1/8] dmaengine: add DMA_PREP_LOCK and DMA_PREP_UNLOCK
 flag
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qce-cmd-descr-v7-1-db613f5d9c9f@linaro.org>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
In-Reply-To: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=k2JNoMjqu4cYCUFiyyJ8BPrYhDNDgsHQ3cmq2EXWh1k=;
 b=kA0DAAoBEacuoBRx13IByyZiAGfQAZWh0+HkXZGtwrVkV1G+XYQw0IWSpnVma/ebtd5F7Du/S
 IkCMwQAAQoAHRYhBBad62wLw8RgE9LHnxGnLqAUcddyBQJn0AGVAAoJEBGnLqAUcddyugMQAIb2
 9t62ThB4WAqWMp3QPQOIzKHALZYmvL4AHTh9fIp1/ow2BhYp7c/Zv+VbTeVDCy0FH2GtIK1ug6z
 FPn0S9v28+YzAsGaFkop5aGnZ9XqxKgJlRrRk+0OrXk3SWyFMGmdma+M+l5KY0eidSnPqEGbSY+
 Q+IY8XFnp4jnpUGLY+MLS/n3bP6UshcG9s/GKHuNAjR5x38vZfGztqfHWP0xN4UnMOQmNQ42w26
 ctpPVOaxlelQcJvupoTgk1hbRTPPd53OVbn7XAxQT/WkcRYSS3rwN6Llb0IOusf0e6Ai1BEzE23
 UoRwDDnxCqNjFXCBeq7sf/IaX94knSksW2xpibpnHa16eMnNrSpNhEYTGUQ7NTnGmQa60cX0p1g
 t16UQRof0YGyy0yy91dstL3fnutR9Y+KJH3XwRooqQESV/YSkN39asspgrStieDyJjGBWC5XLcU
 KhDfAqoSZaVBzVSpgcdCvk+Fecllq2DGeUuwo7lRVkJLoHbJDmCzppR+yDd+aRbff0vXPcfIq+B
 C11yi4JZ8AslaKvk7h644Y2SVg9IQE1VbNzZ+MRrg16Bd+NnFPz49qXL1l+2r55gQqkinLffep5
 4OfN8d0viViFKkWJ8XLS8wxldDK0nXFfbw4rR5Y4jU2myRq7tpgioj5epPqEa/YVsDz4bqrTMMu
 +UG9J
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Md Sadre Alam <quic_mdalam@quicinc.com>

Add lock and unlock flags for the command descriptor. With the former set
in the requester pipe, the bam controller will lock all other pipes and
process the request only from requester pipe. Unlocking can only be
performed from the same pipe.

Setting the DMA_PREP_LOCK/DMA_PREP_UNLOCK flags in the command
descriptor means, the caller requests the BAM controller to be locked
for the duration of the transaction. In this case the BAM driver must
set the LOCK/UNLOCK bits in the HW descriptor respectively.

Only BAM IPs version 1.4.0 and above support the LOCK/UNLOCK feature.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
[Bartosz: reworked the commit message]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/driver-api/dmaengine/provider.rst | 15 +++++++++++++++
 include/linux/dmaengine.h                       |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 3085f8b460fa..a032e55d0a4f 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -628,6 +628,21 @@ DMA_CTRL_REUSE
   - This flag is only supported if the channel reports the DMA_LOAD_EOT
     capability.
 
+- DMA_PREP_LOCK
+
+  - If set, the DMA will lock all other pipes not related to the current
+    pipe group, and keep handling the current pipe only.
+
+  - All pipes not within this group will be locked by this pipe upon lock
+    event.
+
+  - only pipes which are in the same group and relate to the same Environment
+    Execution(EE) will not be locked by a certain pipe.
+
+- DMA_PREP_UNLOCK
+
+  - If set, DMA will release all locked pipes
+
 General Design Notes
 ====================
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 346251bf1026..8ebd43a998a7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -200,6 +200,10 @@ struct dma_vec {
  *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
  *  to never be processed and stay in the issued queue forever. The flag is
  *  ignored if the previous transaction is not a repeated transaction.
+ *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
+ *  descriptor.
+ *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
+ *  descriptor.
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -212,6 +216,8 @@ enum dma_ctrl_flags {
 	DMA_PREP_CMD = (1 << 7),
 	DMA_PREP_REPEAT = (1 << 8),
 	DMA_PREP_LOAD_EOT = (1 << 9),
+	DMA_PREP_LOCK = (1 << 10),
+	DMA_PREP_UNLOCK = (1 << 11),
 };
 
 /**

-- 
2.45.2



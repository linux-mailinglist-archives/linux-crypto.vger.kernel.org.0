Return-Path: <linux-crypto+bounces-3155-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C742F89305F
	for <lists+linux-crypto@lfdr.de>; Sun, 31 Mar 2024 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D31728280C
	for <lists+linux-crypto@lfdr.de>; Sun, 31 Mar 2024 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7984140E4D;
	Sun, 31 Mar 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A819oDq6"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272CA13FD75
	for <linux-crypto@vger.kernel.org>; Sun, 31 Mar 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874737; cv=none; b=sH+kbY3FEEjA2mxU32PCYYC8uUW94WaaZSbJXi6vnXjnZ7TrB3AAyBPBvebrfOMJGO/0yX/0suFRRhElOpMbq9nurEAP1LyB6v3vwy0jXTn863MLZr5kBDLApHkGklr5B4M7h+O8/0nn3BAr89I2DILExeh8mTHMyW9tQyBSPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874737; c=relaxed/simple;
	bh=jCwmMevYkV3Lqd1Wbq1GxwStD6bPo7hGezrcOjB2c0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6PkPrGWKhhc8JmO9ytwNYqkF+3qKof2iYqo4scaeSkEYguoXzpetIK2K+wIc2bozAVaxQL3oXxLQTPBffgsIVfdPsfybKdB4zQRL0Tt+U9GV5MGJ5EG5tLKcZImNkBfRA0YbwHq3dZld3oSq3q51N6ChVbvv8vSglCownbC8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A819oDq6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3417a3151c4so2994415f8f.3
        for <linux-crypto@vger.kernel.org>; Sun, 31 Mar 2024 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874733; x=1712479533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No4VShp4MNQIo4/ZHdyujXMPexV2jpx81+F0aVzAh9c=;
        b=A819oDq6TPqNfQBCi+U3c7WvSHhwtD24QjeT9SXa1eOgrDiU1QieK4orI8GtDXEGvs
         iJ/8jdd3aLaALf8NbD1NeVSeJ48HPa7e33IFZBbSBWQAdWcPyvYXcfSU3KtHH1GR3bWv
         Gqb4+w2X7AzpPAzfVbvdl4zdS2ROD8tAapFexrDKll8QvAIuCedepVlWRR4BczRnLjg/
         wt0SMLJmCbosCurd5jX0fm3UHiMXqP9gA+UcV/+iU0K0iVBlh/P73kGRaMTYeAKVDew0
         UZ7490DCZjZ0rWtoFlDRoh7VzDXLPfZKklCvSLXDQD8aV09yB58b0lvEb31/IL2FRV1u
         9WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874733; x=1712479533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No4VShp4MNQIo4/ZHdyujXMPexV2jpx81+F0aVzAh9c=;
        b=k6opFwykTAdyjBpTvu3J8uh6cvmNsWHURj+oTgeKROzQ6AAmR8Mq3B4MzDz3vVBx32
         Ui2sK+oW2RoGYnw987W2JddzSpMy0wUocgQmoZLTh0McwPu3Je9mKyx0faSkmN7gEK4X
         Su6rBcb+xPxZf50YW989RGvF580vg/nbgGz/Ku+zinjP4K8zuFXRLJSK7Ov8mzd7g+G3
         fMVH9HdFVg1bXPyCOvvNP3eSccLitjKWMNhMOsnWYHnRAe1kx2Wscx1gLbfl6YqUdtJq
         /uzyr0UxFLmbTtg/++s12H5w/2BvJ47eKTB3Tffvq98Yv0PCcT9SPYFWo7acFDcqHbCw
         GUyA==
X-Forwarded-Encrypted: i=1; AJvYcCW+we7YgdmaQ+YQ5HgngR+osdiup4Ct7BvTUM97F7bbztVfWVxnC1DcjSVE3km5U3TAPQSCXMYxSAHk9+P2pFnr+ECUvOOxOXu8GpYz
X-Gm-Message-State: AOJu0Yz98c0ov7ErqE3Ep89rB9R5tgREYddEW8+Y3Nz3OIW1GO5WDu3v
	gBBaWyPyPUk/YUy0XEtFXuvsVQ535R95YmGATRsjZQY+AolOvTBsdqIPerpszKg=
X-Google-Smtp-Source: AGHT+IEJgcjNuQ7wOAQugOxbGaJ6NQntcIGj1qLI5WyqALHzfY4WmrsIZBXcqF/NvdlZCTDm990T8Q==
X-Received: by 2002:a5d:6210:0:b0:341:b8ae:4cba with SMTP id y16-20020a5d6210000000b00341b8ae4cbamr4747608wru.21.1711874732690;
        Sun, 31 Mar 2024 01:45:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:01 +0200
Subject: [PATCH v2 14/25] iommu: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-14-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=741;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jCwmMevYkV3Lqd1Wbq1GxwStD6bPo7hGezrcOjB2c0A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJcf+cWSGBZ3IzVeFjdJCrigmlZUgggoXFHx
 L3ZNzLA+GCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiXAAKCRDBN2bmhouD
 1yz4D/kBJnf+US0Wxk8tJSk6p79WwnzDbdIipicV363WstanAHtkMECia276V98GOZTHKFx91oZ
 xFs88iGedtFNe2lz5YLuDippGKnwdQKFHYxGaFMtOA9azrRcdW1Yi34mh6Rw1Y6KB74d/mkXCHR
 HBbOcVcjuwPWr03OQA+UE+F5P2l+wvvJN0pex0fSfk9v36SnhE1g0hDm+FrdISIvU+9rqTDvE5x
 iNtqop4EDmTWyLVnqUb2eIa+Hc7j/yznKufTQxPZv2tyCQlLam4t86Kfbcxm5JoW9krAef9eXbs
 A5FkPX+lIJm00PCbDmL0YHydbChvEzQky64KSuzuRwgbfQEwcB4ovbo3tkM1rdbzJo+/C1zk9ZW
 5zQkI8dbBCHRBB8AjA3mODa97MkbBBnQGITT6Mx/O7JqA/DUZNjyQIINDDOwF1gl8holNNnl92j
 uLJF2ny86nAbRgnqs+60EZkU9x5jGyVx8qY2223O3pNjBemocfp/VY1VhLTcKCqY0VFxuKboJhz
 kLGCzGWiU47obYe3V+NoxExY4fC9r8nkWuiGr4WjnlNkHfd7Qmijw9N8VOoi4GY/ZWk/oDjxV1n
 fEMEavVUWoWq/GPV2H/x//mMTkfPZ0lZn3lRXQyjfO26dT6ZkeXfV7Opjib1fX4uOFTcpfb+tX0
 W/QgwYlVrzp55nQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/iommu/virtio-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 04048f64a2c0..9ed8958a42bf 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1261,7 +1261,6 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver virtio_iommu_drv = {
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),

-- 
2.34.1



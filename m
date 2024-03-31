Return-Path: <linux-crypto+bounces-3157-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC45089307E
	for <lists+linux-crypto@lfdr.de>; Sun, 31 Mar 2024 10:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B39F1C208DC
	for <lists+linux-crypto@lfdr.de>; Sun, 31 Mar 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303967A15A;
	Sun, 31 Mar 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeAaeoy2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24408142648
	for <linux-crypto@vger.kernel.org>; Sun, 31 Mar 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874746; cv=none; b=SKpQWYPRN+iDDJaXDbOXnVay8OXXhdaZpfX7po28BZHx4jJ3dKlgHepQUWhye5qyRADq1cx/5942C3dIkDGeFJlogODm10VTlP6lVnHSv1nRGh3/DZkgOcn4459tyihOMuObSpmGOoi/e37oieDdi9e/NR9d9G6jStzFY2ecj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874746; c=relaxed/simple;
	bh=se3bAL9NWlxdnI0R5l3waFKazObx3hz9jbN0xln52SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdzR7MJ7w98BSGAnjes7Y8zPBJNjsMZc6/BH5NG7LQW3OEbciOnqihk5H9yITZyDrZOevZzIaPU7k1opp/waik1qtFW5BcsVT1Y9v7Ara1KdHRCf2gHFbQ3giPLEGEkUQsDulIu0Em1SZ9QJtGWFeHZhKn+SpZJptNKyeZ4AFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eeAaeoy2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3417a3151c5so2155184f8f.1
        for <linux-crypto@vger.kernel.org>; Sun, 31 Mar 2024 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874741; x=1712479541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCsDfZXw6LzB3XdNG+WbYeCWTW98m3a94TU3WahPKsY=;
        b=eeAaeoy2kPIK5mUUTkEhqCYjuyk8RmeqJlS2PManVXQgECNRCkyjrRYc/Sg9aKUyoT
         4yBR6lCRO71N1u60igfNcsahlSsCerxmuAte6BCwwJpAorx1Il02f6iDJwCzVPXcv/UI
         Wvf7h5nZpcbuP3Ep4Jlv2ln47gkiW/Tiygmt004xCO6sefE87a7d6/OZFuitOtsVgTab
         eV0IYC8rzdECSzT710BbX1KNwgIE9FxQirYUqM4vBzlGM2o1GWz9Bk6O1gZmxx+ILKzX
         inS97OB47B4lw7t5yMqxoy+3fiRIY6B5D7n+hT1h6LIg8MKaTWi/ZKg9+cQKWjNu/9xf
         qxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874741; x=1712479541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCsDfZXw6LzB3XdNG+WbYeCWTW98m3a94TU3WahPKsY=;
        b=TKDs/x/prSGP9mYiUhmPE1cQ+RLWFHYZCohJRq6tbyPSLoU6VOhPS4d8NvofigFx39
         cefzKftljHi/JbLsoDp0YhQYyhf4AX6bl9DCqgqBrVfKbDzn9CNYIP4+EbcRsJ4hnHqe
         D8HqjLTgg4DeDLNndpQjfjfFWIlwtXxpBI+pLNvt2o+2CnZot88eIDacjo6oY1xaFEcT
         IIAn7M63Ktn8bdNtRNOWJk6d311sjHvTHb6Qsy6+kXzYzjhOs+TaFwitR/Iuyq9tG4xB
         GLUrU6tG/sBfkPpWKUonMBu25Ztv6qKhUz4lxknrtrI3hQ1fAnDoJZDsSzbQODtme3B5
         mYLw==
X-Forwarded-Encrypted: i=1; AJvYcCVMgVPOzfoBMMzDR+HJC/dSWEQs6JnsZzv2JtLTRDlfljQB3xWa4D87VJvefPkfOayelzsUuOYWOwZhKO/dlweePWHBR6CKBqCMTbQ0
X-Gm-Message-State: AOJu0YyHrBpGHA7x9NzMSx6nCZJ5m/JRMyp6sfFuAsSCNOGflowURUaU
	4o2hbM8ijum8hE+74H0Vk9IcFDKNxOr5ADjE4SPrUd7DHRZ0nuXWhttrTNXGDz8=
X-Google-Smtp-Source: AGHT+IF3ZrUCOMfmBGxr0QtcEyHWRTvBM0iQXjRTcy/YDkzaetKNZ8K3RMX84Tih4bjsekACtKBC5w==
X-Received: by 2002:a05:6000:4027:b0:343:4609:ec27 with SMTP id cp39-20020a056000402700b003434609ec27mr2052015wrb.70.1711874741641;
        Sun, 31 Mar 2024 01:45:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:03 +0200
Subject: [PATCH v2 16/25] net: caif: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-16-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=759;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=se3bAL9NWlxdnI0R5l3waFKazObx3hz9jbN0xln52SE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJenCPpEnFAHTEofapxPYFUf4fpJ0gAnwfPB
 1J9/P7me5OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiXgAKCRDBN2bmhouD
 1wIcD/sGSIoIdHj/zYFnEhadRlmmHAAIVdCpD+G+O+AagKBU2I+fBkRPidWKXAPBKfSU3fF6iNx
 uy9LpF6AU9fW2XytaIZDWmq4ZJoJ/yAlIDFZ0Rt4uyhqB0Ggl7wHDrkYT+Ex4M4c8tLxOXPYSsD
 /bGA5wL677fAt50nzo4AT1T2X4LfwWGTL+ocvXlBhxRqPH6BXaXP1TjezXkHSM5HO95HqOW5EPM
 Loavoa3/t1lD1JXa+aAsjLL2Bb2wgcaRACpNZhtjn6Ps/S/rG7bwwek8RGlnaKxRX9GvGmlsjNG
 hBpWfYGDD2+pMIzk9NPKw/4wicHB2nBN1tqGXUwEvj19tJSZqhNt2GJZ+MmMQ0HmnNy74MgtOs6
 W//DnrXgIvSgXQJJunvc1dupJIshYqu36eDdmga1kDj9VYUZQlysCR1S3hyI2ius9goKWJBlYze
 Fu/qHoWTsTdRqlUPbU6IjDsrCWb00dmZ18/kXp0+LAYAYP2wqvZDKPx37pJZuxcFvCgr16gA+BI
 pNFOggLaDpzsFbU5gsdMYxLb9OM3j4nA6499+p8u5iFIEtJOzBSMw5Zm5ulZTlh/ED85nO/CPE3
 Vp5uHW1WKRV+ba2+hA3mDrxUmVM1OcbOXZlFGKll5nBtbAwTXF1bW9up1XBE3MAsu6b+tYKjhJh
 hYegPHr37N5IQTw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/caif/caif_virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 0b0f234b0b50..99d984851fef 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -782,7 +782,6 @@ static struct virtio_driver caif_virtio_driver = {
 	.feature_table		= features,
 	.feature_table_size	= ARRAY_SIZE(features),
 	.driver.name		= KBUILD_MODNAME,
-	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.probe			= cfv_probe,
 	.remove			= cfv_remove,

-- 
2.34.1



Return-Path: <linux-crypto+bounces-2946-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAF88E4E0
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Mar 2024 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC67529EC7C
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Mar 2024 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347FB146A81;
	Wed, 27 Mar 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTp8hAeQ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C21465A8
	for <linux-crypto@vger.kernel.org>; Wed, 27 Mar 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543332; cv=none; b=jpzodyGtDdG1136dPSd2CUYU0FQWLUWz+QEnsn1Pc4gg1RoM7CJN63jaFQw0JMuvJlb4ecaqqU8+yvKdOWnodwxcFSsLx8+GjcG28ft4FYwxPRj1UKOH/XfQHzPzJvS1S1cTqzSn0cHuMhEUlYzpXMbmQRzewPTg7V1A/HQ7JpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543332; c=relaxed/simple;
	bh=i29GGpteKXJOT7Y7HQVb9d3eZ/9hZZ41eKapONuqqTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGqG7kikA1AlIe30QX8otIn8g3lo0fUG0IeEuUMK49OsEcMJy2Toyy8xWfVCh1fZotH0MJ8zzaftZXA+QZgc39oEio5ELsmkeJOhcimoEkxdNJtSJLqTe39GkoZKmuBX16aChSQ939MTucG8UbSLslj16X2j2DcDGZr16JtV3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VTp8hAeQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a474c4faf5eso437940466b.2
        for <linux-crypto@vger.kernel.org>; Wed, 27 Mar 2024 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543328; x=1712148128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2N77S+83trKseWxbTwOaTLrIYXxobuVp9FyL/kFGQQ=;
        b=VTp8hAeQhWIxGPk+fWvBhPZPMLW2rQiXpfA1OUa07cBe0tOT/W31mS9dUqsr54ipxD
         FceoJcikL4WgnfQoOo+VKcU3Xg4ISVisGOGa4uaedOsuqz/aoq+gVfu7nl7v8mYBOSCm
         Enz7YSGkK9FQ6mPT0Y7+AzKXRU6DNGK1RrATwV123OWT6R7pJIeNvMLAcPhU1WufWgNp
         rFOCdnK1yULPMnduRO/QM61YXXUkkSNGhMe+jOwxyYsnUiDbfMlMHDNM0Bur9XnQUJsC
         9gyuHvV5GwlpuC6pwLN6rYL1dwfSIK150D3nQs1IzCIFw/rS9Lb4fkSJgp5wrtHXoo8a
         VunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543328; x=1712148128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2N77S+83trKseWxbTwOaTLrIYXxobuVp9FyL/kFGQQ=;
        b=jtDgWx7IUCUUPCjuH6gICC4rc0/LZ33EO8mUuMc6r+5/sgsxo27lTElcPR6GEFjKXK
         rrySsx+EyX4Up7Zldz2dmgDLJ+ogazOBm+IPR43465k3OoHzTEC2xgfSQw/3kIls0nQq
         NjmFMmmuV2PYwjWqyjEza+HpLIAS+w/jExxdqDc5rqyOMOGnXrMX+CvZvpTCbkBy+Smh
         A2AvuTMOCfPriVDcR+Bmy36yi3y7FXRfMvSkeGWyOWNNQ90F/9+g5knR1U0G/eyrj9aj
         i2kttt4gTmXmpSqtKRtKHFZfUGtsd8O9WN69/Eo5oQ9glDePSIaTWxoDQ+PD0dLiBbA8
         vb9A==
X-Forwarded-Encrypted: i=1; AJvYcCXr7vupVAFzGCQrnWc6JXXAe6Vr8HlHkkHqajOWyEyB+FvMr9zykTi9E9x7bjsp/R6uBaZjXhylndS/ovHBpKF2kdiWnxHlu5ZXCAJE
X-Gm-Message-State: AOJu0YwcXS5VGjMbgrZnJ3CCipUUwNMVdsnCqgaxyP5wHAtZkmhaHYMt
	1z0tPoF8zenmapcEyVJdZJKDVVdaPgnjwoDenHzIUD4UopHNcvEpCgjyvsxr1KI=
X-Google-Smtp-Source: AGHT+IEkE4pNot1uzWqq/Dxu/KgO4mLE7QfsgLYuIObS5ATO5treG1hWzzYXKuUBzpsw7NHEclpATw==
X-Received: by 2002:a17:906:718f:b0:a47:47fc:441e with SMTP id h15-20020a170906718f00b00a4747fc441emr836212ejk.47.1711543328069;
        Wed, 27 Mar 2024 05:42:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:42:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:40:55 +0100
Subject: [PATCH 02/22] um: virt-pci: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-2-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
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
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=718;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=i29GGpteKXJOT7Y7HQVb9d3eZ/9hZZ41eKapONuqqTs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPbywJQXZioM2grDNH1GhnbC9jT7FlHBu8Il
 BXxYGwRjraJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT2wAKCRDBN2bmhouD
 141rD/4uo4AQiIOCl21dlkWWoVLjNoCmALlYeYWtYXDJLeS9+PR/4c2YDTN11rNGZIY/nuXht+R
 08R2mFazQGyBslNrJRa5JhTm27rGZioRY5wiYiHqxItX9wtbLBAaPUS9Nophm+R4wqOUhsZnpH2
 iXQpVZU+WxzXQWPWb37iMmYzasbeW4glBRKXiiC3CiF8u0wRyTUDts0V602SqlnsxNufaQ8Fhkw
 v2BkNkkV2fb7XDmngW8OJ0kdV0Jyz61GQTc1t+4KdTLSlm4BqGSDVopNAVcuGaanCqBF/52q9Vw
 GwfqQB77dn2XOgo/ZR0RSXAr23vu/0OwanIMUXPmNtLP0HdBjsPDci1Vl6eBKtREXmXYWwbZZYz
 CWS0C80pM9J/VlR5mCSMck3fBmEeDTvE8F9MpZEre2yc2Q29DVx/bpfm6ztE/EyVr0F9Up8O/Tr
 VA6FaMUz1KovyBRE8weaVHwCZ12Ab+SEc/U7hZ50L35WTjMLlYVRdlVUmcIzP2KmiQnV3W6jpMz
 orbUL5s/p8br6ozoNcPu5ZcZz+mLi4MpfFyp/6zJ+ciMyf/3IUkaehDBf8Q36omx98PhwP8KxB6
 /565K/p5SNWNrrGqH3SAriemyZe8lv2MhxVq7qZ+7WqhhglZ3FWLG0w1uleUDxPVaxFkVFtntn7
 qgSaAlhyRZ+9xPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 arch/um/drivers/virt-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 97a37c062997..7cb503469bbd 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -752,7 +752,6 @@ MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver um_pci_virtio_driver = {
 	.driver.name = "virtio-pci",
-	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
 	.probe = um_pci_virtio_probe,
 	.remove = um_pci_virtio_remove,

-- 
2.34.1



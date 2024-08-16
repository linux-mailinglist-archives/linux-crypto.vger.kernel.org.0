Return-Path: <linux-crypto+bounces-6030-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44153954424
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Aug 2024 10:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C462EB240DA
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Aug 2024 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F4149DE4;
	Fri, 16 Aug 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpTbJ6w8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D142E60
	for <linux-crypto@vger.kernel.org>; Fri, 16 Aug 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796611; cv=none; b=hqAUodfTV+trNH//evgXve0qF/1kapJECaVqC19nV+lKOigUinQthHGMfreUfdBKwZTsLkkqyzoXNpe9UN4HzYsLqDPmZlsruQCMpVsAel2y8oLt2J8Hap9JHrLvaXbmO5G1K49ePEVjOimvm/yZL8rX8lMj/GcnzYWPq3l4HUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796611; c=relaxed/simple;
	bh=e/xNXA1yTLC5LO/DU6nAdSe4pBmM51YQq4u4lTp+8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGuLGyHWRyhCsmfPmCC8dQzsRe7Huymt7GY/WUMBxtJn0EtIUuIjBlxADpC0V9bNtHJiKDKuQNw/IgEzEGqRniIiIoWi5fItXVFg4OmXGy5tMWRt3cSKfzTXuOzcqZgXrf166Get3u1xxB/2Fbt62swdVezlL/O20hBNQ3+BzJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpTbJ6w8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EazSdKY3WHiN/nU9t/dUeUzLBwbhXck+n/540p19lQ=;
	b=MpTbJ6w8fTkl2N2/bi4caZGXo3VynRhz3NPTfiFQiBjVZaFC/zALPOaOw+dWFWI9qmBvEO
	MKQv9DgB9mFSgMnm556w6mGeumM+1hPHkYkeRHP6EmkdvCAEqO8Z+tw1aCXalKYMb2PIF8
	ya0uI3ECKaq4N1XAYOC9Ea2xl1Td0zM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-K8CgiuUIOeaLFK_Sro4gSw-1; Fri, 16 Aug 2024 04:23:26 -0400
X-MC-Unique: K8CgiuUIOeaLFK_Sro4gSw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef3119461bso3247191fa.2
        for <linux-crypto@vger.kernel.org>; Fri, 16 Aug 2024 01:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796605; x=1724401405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EazSdKY3WHiN/nU9t/dUeUzLBwbhXck+n/540p19lQ=;
        b=l6FrbXXGaDznt6CbS8JRvvdAq3rsCWXiXENNmPh1MbchJnbs3DyRcAuElyLuBHVGhr
         ljXRIhmvNpsYsZLCnV1Ek8s46jsyvtNGhw6CcjUenInXgwysEtyLw925iT4gVrc/FkTi
         rwmYCoE7TSwM9e8Q5CNBjaHO3EjhshC2EXocJ/B4A+utr44r+v+mI8sQSlQEN1sLWk8t
         hkhig2PWsgzNT9vayxfZWgC5VKVIaMqzZCprP6mKgCKrw3lJwbEtYQPj+eiHHQ/0Ke5H
         awPbEAdL3yC/RYzN+xWbAo9SenGWfipB/+8Hpw7JwFMbUqrKRKoXEftNjGGmfcQ/4szX
         pwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgh76KVPVFuSYGkwcAiINxgpd3tIv+PD94Hqr6uTowb83lKGCpwsFtDMOA+Ed2UtBGvVG3IXR5AFBZnmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgOGDHRJnubWiGWBJpEKCkkhN05h3yLIbj1SJJx4Tz7Xmtdkf
	Px/aFAcQnS9APahKBn1jg/fT0KHzYANStBagBfptGIQ8qIRmBqaMhxHbpUSqglE+9oZTEhqmusy
	F9SbqXAjxzrgSX9GCIk5k+c6TkGeV5UdN+BNrGWdFTn5Hz6KDlhryGnFBqyVvNQ==
X-Received: by 2002:a2e:bc20:0:b0:2f1:929b:af00 with SMTP id 38308e7fff4ca-2f3be5eaebbmr8846281fa.5.1723796604974;
        Fri, 16 Aug 2024 01:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe5LhtTKuF5e0aFj41GPtW3c5aIbAINpnbFwxkIoOI0Y9011zLBXt8oeDNyhSHXCnejTiL/g==
X-Received: by 2002:a2e:bc20:0:b0:2f1:929b:af00 with SMTP id 38308e7fff4ca-2f3be5eaebbmr8846111fa.5.1723796604362;
        Fri, 16 Aug 2024 01:23:24 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:24 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 05/10] intel_th: pci: Replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:22:57 +0200
Message-ID: <20240816082304.14115-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816082304.14115-1-pstanner@redhat.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/hwtracing/intel_th/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0d7b9839e5b6..e9d8d28e055f 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -23,7 +23,6 @@ enum {
 	TH_PCI_RTIT_BAR		= 4,
 };
 
-#define BAR_MASK (BIT(TH_PCI_CONFIG_BAR) | BIT(TH_PCI_STH_SW_BAR))
 
 #define PCI_REG_NPKDSC	0x80
 #define NPKDSC_TSACT	BIT(5)
@@ -83,10 +82,16 @@ static int intel_th_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = pcim_iomap_regions_request_all(pdev, BAR_MASK, DRIVER_NAME);
+	err = pcim_request_all_regions(pdev, DRIVER_NAME);
 	if (err)
 		return err;
 
+	if (!pcim_iomap(pdev, TH_PCI_CONFIG_BAR, 0))
+		return -ENOMEM;
+
+	if (!pcim_iomap(pdev, TH_PCI_STH_SW_BAR, 0))
+		return -ENOMEM;
+
 	if (pdev->resource[TH_PCI_RTIT_BAR].start) {
 		resource[TH_MMIO_RTIT] = pdev->resource[TH_PCI_RTIT_BAR];
 		r++;
-- 
2.46.0



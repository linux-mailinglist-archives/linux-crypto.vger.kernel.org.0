Return-Path: <linux-crypto+bounces-7610-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DB9B06B4
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2024 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB29D283333
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2024 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DAB1FB884;
	Fri, 25 Oct 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYLss4zR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B2176AB6
	for <linux-crypto@vger.kernel.org>; Fri, 25 Oct 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868446; cv=none; b=ZJWQNMtKjjBf0VkSe6e647LLV3D3oyQhHuCes+QJAwatAbdu8cMs1qIGGCZLgu7ooWY1Ce0hZt/5UgbPX+ybiecY0+yThR/2594+9L10R6c5mBE0KT4ntX/OVsm1akcl4aJlPQ2eDqeCum0XyRQPQT5IkRu+uatpQiwM3nyxUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868446; c=relaxed/simple;
	bh=s6xBjYgC8JsEjVYTXZALRaY3DljRr0l2UeRg0HzxlUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCf/LjRfsym+WF4p+ePXk6GtWDrDsxG+NOMnf7xgbML/TQmiZ3qaxhiA467SxFaherRQmXRymd/WkOvx+c+/AmersXLNsIOPoLqU3a5buhMDrFJE5/B6djkFHa7bWlrB5YKTDQ+NUI1Nrb5+2aAIpvNfOeAaOLy6Q75eVSNajn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYLss4zR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryss9fvWehXfEU+PDJn7zlGdxW8bFi37+f8Je+z7dQs=;
	b=LYLss4zRzRg2Bi4zIc0gF+BDtc2tiiJKRudJ1rVGOPa3j1n2kFEIzGOGyDvCM9vyJ9+796
	IWqf/yvdoOB2FgMl3fm+4TcBtZz6ONkXBIZS+d63Cl8P1Eyj5G7LyA/x5X8dILoKfpnZ42
	rsrxTSDQkRtgeYibysNh+NYD8y/2YF0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-oofGwsRPOKW59y8QhOeGHg-1; Fri, 25 Oct 2024 11:00:40 -0400
X-MC-Unique: oofGwsRPOKW59y8QhOeGHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d52ca258eso1143136f8f.3
        for <linux-crypto@vger.kernel.org>; Fri, 25 Oct 2024 08:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868439; x=1730473239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryss9fvWehXfEU+PDJn7zlGdxW8bFi37+f8Je+z7dQs=;
        b=Jk+qdHAKvfBLuRgRX5P2QmmvG5lyCRGlG35ejNaHJlwb9KCuKjdUw5UmAJtdtpZ/Dr
         lbScpzAvMFoEpcdwqYT9lQbC6z20LFmR0FIzbgeP1QWgWZJlw/wraDY/TIAPqAd/+laO
         W2Zdx4Kaxvxt6ikbm4DEmbq27H9SPlEUr7+e68gXqDH0KhegA8r1+uQgMRdHehSVISFR
         gi3qqv2mjV3Qxm7m9iN5rAPEL4VQkC5E7CZX/NWT/LQuuhhOakXvTX8M2KsweTgMHw+e
         6U9aOQuIttpN0cP//R7snOvn+yjmERb/kHlJOjPhAGb13TR3NfXIZdEkwgMB5Fse2hh2
         Ck7g==
X-Forwarded-Encrypted: i=1; AJvYcCVAfhmJ45vBUXDpGYH91ZKUnJtkqvAhG27ms2vH2bBtMsbU0rf0wqXtXUQ7VdwZQyD04Nff1ktHgsvIooE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzjJeWVH27qt07REE7RWzyBRERgLIn0MxPyh0AttBjQf1+RpK
	g6QH98bV6KkmZR8MpU6Jm/yz6xSrSfdurE8EePONM6PhdijYU8cxQsNX9bnTUfi+Z/y3F0xJ5C5
	OAHctqkDMUPQGeIUzzqb+6Jpi/o2ZZQHgNrGFXn/+u//pehvVA8j+barFWEwrPg==
X-Received: by 2002:a5d:56c2:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37efcf06dc1mr6436998f8f.14.1729868439580;
        Fri, 25 Oct 2024 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ckOXkNlZIey2we3esP6YdjimmyCdm/ffeP6OkAIjJrVOU9m50FFPLlquaywIvtz5sXMgiw==
X-Received: by 2002:a5d:56c2:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37efcf06dc1mr6436886f8f.14.1729868438713;
        Fri, 25 Oct 2024 08:00:38 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:38 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
Date: Fri, 25 Oct 2024 16:59:45 +0200
Message-ID: <20241025145959.185373-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025145959.185373-1-pstanner@redhat.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions_request_all() and pcim_iomap_table() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/acard-ahci.c | 6 ++++--
 drivers/ata/ahci.c       | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 547f56341705..3999305b5356 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -370,7 +370,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -386,7 +386,9 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
 		pci_enable_msi(pdev);
 
-	hpriv->mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
+	hpriv->mmio = pcim_iomap(pdev, AHCI_PCI_BAR, 0);
+	if (!hpriv->mmio)
+		return -ENOMEM;
 
 	/* save initial config */
 	ahci_save_initial_config(&pdev->dev, hpriv);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 45f63b09828a..2043dfb52ae8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1869,7 +1869,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << ahci_pci_bar, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -1893,7 +1893,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_sb600_enable_64bit(pdev))
 		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;
 
-	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
+	hpriv->mmio = pcim_iomap(pdev, ahci_pci_bar, 0);
+	if (!hpriv->mmio)
+		return -ENOMEM;
 
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
-- 
2.47.0



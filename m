Return-Path: <linux-crypto+bounces-7738-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667E9B61B3
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Oct 2024 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A84F1C216BC
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Oct 2024 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED60F1F1316;
	Wed, 30 Oct 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmlxPzbd"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF01EF0BA
	for <linux-crypto@vger.kernel.org>; Wed, 30 Oct 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287714; cv=none; b=BLDWV2sQ1Q17Jua8TH6SScoEMk54mEY7Fj38BS5+J8N/g/mGAmVZ3qXhAcU2RDeVUDODDn5KvgvzYj6lIYamVnNHljLJ34uMXLalvW27qQmIXo8RNTmv2JYbc3isVZ5BXx/JV5kRmYcB5Gj68Oh4JoQ3ymk8by1NSLtP/jgUQm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287714; c=relaxed/simple;
	bh=RRyy0x2PiBX++bfjCGlA/9AZOm7xwGM5wtpW6IKXyVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNhKj4pUPoijsCGHAwaJvOMDJVQCkZaEY941yVuzVjCmdwT7KuX1qMMNH2dp1NsFwyAG8JSHDhXHNtY9YqQfKMMdIVKSdNEY4xb3+1DASbhbxzVUEQu25tPGj/G4MC0n3yexkN7Fthbgq9jPZDrvjDZVWv/Rog4P4ydILF16caY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmlxPzbd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxQ5Vib/1yt2THpDXWI2rA9CY+VRhy0DxtAlfuLaLe4=;
	b=CmlxPzbd8N/NMLkrpXGjy/sciUPMMkUAyZpGKp+EVu5iE/EABPVdXauuUYQD7e45Zz/92X
	kKOSBGjGwgVFg7o+dFvfhYhj1w67BFKeMZE3/ksLK8Y7k25b3bg8tjCsgBlu0CDMFvfNWh
	2RxhbbjFo51gIgbp7KTrjpo8a/09f0s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-6QCKF_RsPNiGt6-aojdXdw-1; Wed, 30 Oct 2024 07:28:30 -0400
X-MC-Unique: 6QCKF_RsPNiGt6-aojdXdw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a1828916fso96260066b.1
        for <linux-crypto@vger.kernel.org>; Wed, 30 Oct 2024 04:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287709; x=1730892509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxQ5Vib/1yt2THpDXWI2rA9CY+VRhy0DxtAlfuLaLe4=;
        b=dO9LNdmKEl7JBE1xCDJhQ/ogxRc2hGmq8Cd6kOLjooRaNUcUZmuSlsbSm3dBujIEuz
         tk0sr/vrr1KpFHE2Lt4M05LWkFO9+qX/1mpJrP5KbQ8la3wQkVsWsCjo2PJytQS/ACkY
         n/evGna+SS702rxiQmSLr19H98++ZlzqQMqciGkdk/h3RXhHV/28RL75e22xeu64vJkR
         cxan3iUZ4fVmae6jOb9D8/jPnWPDwMjfOmZm2Qa1n4vzKS2gi2tYryVIkKNe1eJAVko1
         Yk6Dxly6QdJ4ipbe4QKGlNAyJm8Rebg73XE3bCAEPQI6exCY5lppfImKYLfxJvY81+zK
         wCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSRRwa9Q4sxnXmIT+fH/P8q9abLbx/oSknZpdkOivB7FMMB4HYolHP9k40FsgOiGf6IwvF4B8z7PBtAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuZ9h1xCJobb0fHe0OwHlohamzunEwbd/iKJTZq1jpHI9jrxL
	cu4u1wV0k/ekuBZJyjZf3YUHrdzUsRx70Cp51jtA8MrQxKtcHG0wvN9pSBSZU5jn/5R1Qd/uSVy
	sJJj7dWc9o/SdpHy0SYd33GMu+FSmDtE0Q/iOgeL72AN/J+aipnSEF/imcn2sjw==
X-Received: by 2002:a17:907:7f8a:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9e2b6333f2mr407075966b.25.1730287708845;
        Wed, 30 Oct 2024 04:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFETLfwRScQnX2tbEFkH21PzK0bXXqnKMORp76UY23sUZYI9iNafni9BvKTHyCoXNkZxPgyFg==
X-Received: by 2002:a17:907:7f8a:b0:a99:fbb6:4972 with SMTP id a640c23a62f3a-a9e2b6333f2mr407072266b.25.1730287708339;
        Wed, 30 Oct 2024 04:28:28 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:28 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
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
Subject: [PATCH v6 08/10] serial: rp2: Replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:41 +0100
Message-ID: <20241030112743.104395-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 8bab2aedc499..6d99a02dd439 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.47.0



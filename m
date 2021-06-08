Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C831E3A05DD
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Jun 2021 23:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhFHV02 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Jun 2021 17:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234495AbhFHV0R (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl2hI9DkGhrHAF/gZGC77L8hn5lQAm7T18qsJ8qLvm8=;
        b=LrP5T1HfkeTiKXbPBAY63Labmx2dvQ78fKYVcJxLQZBs+TdxPLsbxNdZL5aOH7MVqXxL4c
        V0RNuNelU22hgSvwq20UWV4/pMZR8I1dqbiiAIsmvAVBvKzPLPDL7HflFEM0ngghHg15dZ
        8YczHybDtjUev8/oh/jq6kF1ry4qPng=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-5tnxHVBgNBmInEG_f_4odA-1; Tue, 08 Jun 2021 17:24:21 -0400
X-MC-Unique: 5tnxHVBgNBmInEG_f_4odA-1
Received: by mail-oo1-f69.google.com with SMTP id x24-20020a4a9b980000b0290249d5c08dd6so4678475ooj.15
        for <linux-crypto@vger.kernel.org>; Tue, 08 Jun 2021 14:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl2hI9DkGhrHAF/gZGC77L8hn5lQAm7T18qsJ8qLvm8=;
        b=BWRt/pSvHdhe0FPu+c6wylQOu7k5PSTaeskZhtGEIUwkhdljYGrM4kU6XpgV1eZ7vk
         VsFH4+UkkWhabTPjEHlOs2jr7OF6IL2Rpnr9rkTcoZVbKFoqVgESHPerdlIlIg3SrLdV
         77wHHnL6nywXdh2ph+MXBb6kfgRASTI6I3UPH5J/Z1fdyfxDa6rh9IhCcO9qt1M1wtiF
         DaqCZoip+CoCPS7DqrEl0BQGyb95y6LFFCffsvkQ6jz5I5/zPAMormSVj/aNls8GMXi7
         /lmAuOydJgtEalkPQk4f50o5C6Q7whHsGSfC61TQw/qLGX2Aj2r+XRwQb81GftWSHe0B
         6u7A==
X-Gm-Message-State: AOAM531L/9mfmf0W0+rcX6DSc7FPMY4W4V/kGDhaoaoVrqKnqfS3+cp6
        hQZ6+ApDPDzowPb5stNmcXgm9IPlCEB7WT71Kp01+ySusNkvv8xppqwx8vvWs4d2wTZH7yuskws
        LHOEpzeCZi75Tame/vp6nd7M8
X-Received: by 2002:a9d:6042:: with SMTP id v2mr17663739otj.170.1623187461255;
        Tue, 08 Jun 2021 14:24:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmxpPWzOyTlGEiV6Av+AuPF28wy57ENACphojjEyHPZwmAPwtDFH5wKuVEl6aUMJEsLLhlTw==
X-Received: by 2002:a9d:6042:: with SMTP id v2mr17663714otj.170.1623187461077;
        Tue, 08 Jun 2021 14:24:21 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:20 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 08/11] fpga: region: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:47 -0700
Message-Id: <20210608212350.3029742-10-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-region.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe5..c5c55d2f20b92 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -33,14 +33,14 @@ struct fpga_region *fpga_region_class_find(
 EXPORT_SYMBOL_GPL(fpga_region_class_find);
 
 /**
- * fpga_region_get - get an exclusive reference to a fpga region
+ * fpga_region_get - get an exclusive reference to an fpga region
  * @region: FPGA Region struct
  *
  * Caller should call fpga_region_put() when done with region.
  *
  * Return fpga_region struct if successful.
  * Return -EBUSY if someone already has a reference to the region.
- * Return -ENODEV if @np is not a FPGA Region.
+ * Return -ENODEV if @np is not an FPGA Region.
  */
 static struct fpga_region *fpga_region_get(struct fpga_region *region)
 {
@@ -234,7 +234,7 @@ struct fpga_region
 EXPORT_SYMBOL_GPL(fpga_region_create);
 
 /**
- * fpga_region_free - free a FPGA region created by fpga_region_create()
+ * fpga_region_free - free an FPGA region created by fpga_region_create()
  * @region: FPGA region
  */
 void fpga_region_free(struct fpga_region *region)
@@ -257,7 +257,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
- * This function is intended for use in a FPGA region driver's probe function.
+ * This function is intended for use in an FPGA region driver's probe function.
  * After the region driver creates the region struct with
  * devm_fpga_region_create(), it should register it with fpga_region_register().
  * The region driver's remove function should call fpga_region_unregister().
@@ -291,7 +291,7 @@ struct fpga_region
 EXPORT_SYMBOL_GPL(devm_fpga_region_create);
 
 /**
- * fpga_region_register - register a FPGA region
+ * fpga_region_register - register an FPGA region
  * @region: FPGA region
  *
  * Return: 0 or -errno
@@ -303,10 +303,10 @@ int fpga_region_register(struct fpga_region *region)
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
 /**
- * fpga_region_unregister - unregister a FPGA region
+ * fpga_region_unregister - unregister an FPGA region
  * @region: FPGA region
  *
- * This function is intended for use in a FPGA region driver's remove function.
+ * This function is intended for use in an FPGA region driver's remove function.
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-- 
2.26.3


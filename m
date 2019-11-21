Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216B210503E
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Nov 2019 11:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKUKQT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 21 Nov 2019 05:16:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41306 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUKQT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 21 Nov 2019 05:16:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xALAG6r2052188;
        Thu, 21 Nov 2019 04:16:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574331366;
        bh=xuzXrhK8wsNkydl2luiWvTQcw+C29Mf+uDMeILvZ2r4=;
        h=From:To:CC:Subject:Date;
        b=pumQOLzEBmCvNsoLm6JsnPthRXHGFpy8/cHb12eiUvsMtvXxa7FXUmgNp4zvFWtW7
         UFqMOxRN1BWQfnhLzxr8jwbEOMsiLk20200nHnfbgcG2FbDSOuYi+O4geYWniYpvsH
         FZRL/fbkyA18zsaRIshRT2KUUnqkkUADuawH4oh4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xALAG6dg100499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Nov 2019 04:16:06 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 21
 Nov 2019 04:16:06 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 21 Nov 2019 04:16:05 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xALAG3b4105173;
        Thu, 21 Nov 2019 04:16:03 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <vkoul@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] crypto: atmel - Retire dma_request_slave_channel_compat()
Date:   Thu, 21 Nov 2019 12:15:59 +0200
Message-ID: <20191121101602.21941-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

Changes since v1:
- Rebased on next-20191121 to avoid conflict for atmel-aes

I'm going through the kernel to crack down on dma_request_slave_channel_compat()
users.

These drivers no longer needs it as they are only probed via DT and even if they
would probe in legacy mode, the dma_request_chan() + dma_slave_map must be used
for supporting non DT boots.

I have only compile tested the drivers!

Regards,
Peter
---
Peter Ujfalusi (3):
  crypto: atmel-aes - Retire dma_request_slave_channel_compat()
  crypto: atmel-sha - Retire dma_request_slave_channel_compat()
  crypto: atmel-tdes - Retire dma_request_slave_channel_compat()

 drivers/crypto/atmel-aes.c  | 50 ++++++++-----------------------------
 drivers/crypto/atmel-sha.c  | 39 ++++++-----------------------
 drivers/crypto/atmel-tdes.c | 47 ++++++++++------------------------
 3 files changed, 30 insertions(+), 106 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


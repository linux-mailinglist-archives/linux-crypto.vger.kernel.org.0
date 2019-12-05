Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9611E113EC3
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Dec 2019 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfLEJyg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Dec 2019 04:54:36 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:51688 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfLEJyH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Dec 2019 04:54:07 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 3yRY/RzpeZN2YvjRynj3FeTCtsfLOgf58D9QugBZOZvrSc/jDeMQkbcdCshPAGQ2RpJC1LVFfL
 mrOY9wUs/pCpKaONl/6G4wKQT8jJbqiB4mmuxxFJewJY1oyjb4foYFQHNsoOBCT4BSNhnY74op
 IOgWee1AgAuDjDtYjIRR9VMrR9ITv+bhkMXtIyrD1iHKkS1ztgVCGBE7hinHSkLRLDm+Wkm7N2
 yCLWePDopuFVrriOCNcdU81/2wt5xEUphKIqdTLowTuBVigDnDIpjn9eyZRfwWaUI1w13fGoSF
 l3k=
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="57544886"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2019 02:54:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Dec 2019 02:54:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Dec 2019 02:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZIF6GNwbHt5DPYs8ma2WKP5Gnf800zRZxqZ7+AspPn3wjHTIu1AzaRFdsdN7EHg0TKfbdekSjVZevUBRXmAG5aw/0Co5CZZbCSJGqKQyXhkE1jlcyksji3fgASCeWuyguDRI4PIK0Byu770NpOeb0xYS9vCLm62vce2sG6jTqQCJx8lGzEVxa+KvMqJ92gztahs/20L2eWioDQAXhNx7b4oziBjEE0v6OrSHLcY6LfIZH4YD+w4BGvtxJMUf1pDOO2ST8RIaaXZSvwpOMKyyJIQqWl8LxLlJ0KfCYfpp96/WMX8sQy+cfytIC5cE6/LxNe6RUTmPYj0pzYbCT05Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch07qqhA5sBB8KsHCOQsVghlIW3XngPUAwPyVHXLAAI=;
 b=DiEinIaPMubleax2PiJ+56YT+CRfpTFsBECloKAo99/xYf1InM5rby0pnz2u/lsGRRDTrQPxo/qSxuR7O+cmq0FzHgm5h7FZpNwo/4rYRpc3nWuUwx91FMkUIDf8X6vZZ9+4h+okyhPiZMzq3VXpAYpUseWMrI5/vr1yyz2TgT+mB0uu8JWt41JyhouCNoC0/xqX2L5gt7jiZiG4TsF+JZvUsweLdB4PBl3jd7BGCRSPKNaFXxyJmwd/UAQaiuji/VRrFmJionMbzlUMmXGaTWbcRtf8TcE3Ob4BtIoaHr9+MmgrPxlzO2aAzw8AVDGJr+7UNHa7vQ6jim+D+MiiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch07qqhA5sBB8KsHCOQsVghlIW3XngPUAwPyVHXLAAI=;
 b=D1qexQMnNw2LogNuiiBhVAwWyK/o5xFc2gZx6njmzYjfw/0oCgnX4Wf2JKxhVZ73Byq5mxdDEXfZJ9tGYXL+be3k60i3pEaDZImFp1qKLQvxNeU1nA05LRCaQio/lQ6Er66xHhyPgR1OoL4UcGKgJRNPaQgys1YHK7yROMshKgg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3677.namprd11.prod.outlook.com (20.178.253.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 09:54:05 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::84c:6e75:22df:cbc9]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::84c:6e75:22df:cbc9%5]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 09:54:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 13/16] crypto: atmel-{sha,tdes} - Remove unused 'err' member
 of driver data
Thread-Topic: [PATCH 13/16] crypto: atmel-{sha,tdes} - Remove unused 'err'
 member of driver data
Thread-Index: AQHVq1HtgeqNxMaumE+ZifuT+ElSjQ==
Date:   Thu, 5 Dec 2019 09:54:04 +0000
Message-ID: <20191205095326.5094-14-tudor.ambarus@microchip.com>
References: <20191205095326.5094-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191205095326.5094-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f588b54-ff10-4ed3-89e1-08d779691041
x-ms-traffictypediagnostic: MN2PR11MB3677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3677526AD8AE600E75BD5443F05C0@MN2PR11MB3677.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(2616005)(66556008)(305945005)(66476007)(66446008)(102836004)(64756008)(11346002)(5660300002)(52116002)(76176011)(99286004)(36756003)(66946007)(2906002)(54906003)(26005)(6916009)(6506007)(1076003)(8676002)(6486002)(4326008)(50226002)(1730700003)(8936002)(14454004)(81156014)(186003)(86362001)(81166006)(5640700003)(478600001)(6512007)(71200400001)(25786009)(316002)(71190400001)(14444005)(107886003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3677;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RtdDqdJTa0czJo6IIcuMqS5X6tLrglEIo7wJrQ/pbTvM1E/2EDDO2duPn5/XoIuJX5xKM//fhCzD4JVlPRNQTfvvbqmPkg6agHzMh4yYgAvskLKqB0n9hSyjYG8Old6AQ8HVgHcHJtfWBSLO0/v8+7c5iWANc2570ewj+mt+/Sv1WywyxrO/V0xSFYB2ZquhgJobwePCiyoF8e3CqZumQNBN8apeMmvdB4cbFRKzxqRydwp//DG86M3JTfL0UR+GLVOE/Gxuai8lvVULQeNw/C7zx27N4f/BJ//7O482v6NJNoNoA6q7DB6CgeowcyYq4+uFVEZ3m/iCB9b/4ffmc/gHIBqo4zTJduxW8Kf83cXNalCkBA+JBEglKH6GDBB8oj8m675ajFSxrPT7OOjoaaoGWcvTr+uW3fJgp7vcoJi4t9b/0JyiE8z68nqbaeQjNned8oa3MgJCP6ZFdvjzQU/tc3jNesGf17vPZBLk8EcVK70kw5ncawoRdKbLv1zD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f588b54-ff10-4ed3-89e1-08d779691041
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 09:54:04.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0dRBZjy5cxiyqnwFTBbWYt9wL3TLkSL2k4WmWeI7C8KzRZoAZgxNjyoM42eXqlP+H3k48RSIpTBCcRJoiWS9UOja8yBI7e7trzsaAUMUz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3677
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

'err' member was initialized to 0 but its value never changed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/crypto/atmel-sha.c  | 6 ------
 drivers/crypto/atmel-tdes.c | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 8f63a1aebd9e..391a72728c2a 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -136,7 +136,6 @@ struct atmel_sha_dev {
 	void __iomem		*io_base;
=20
 	spinlock_t		lock;
-	int			err;
 	struct tasklet_struct	done_task;
 	struct tasklet_struct	queue_task;
=20
@@ -1027,7 +1026,6 @@ static int atmel_sha_hw_init(struct atmel_sha_dev *dd=
)
 	if (!(SHA_FLAGS_INIT & dd->flags)) {
 		atmel_sha_write(dd, SHA_CR, SHA_CR_SWRST);
 		dd->flags |=3D SHA_FLAGS_INIT;
-		dd->err =3D 0;
 	}
=20
 	return 0;
@@ -1403,10 +1401,6 @@ static int atmel_sha_done(struct atmel_sha_dev *dd)
 		if (SHA_FLAGS_DMA_ACTIVE & dd->flags) {
 			dd->flags &=3D ~SHA_FLAGS_DMA_ACTIVE;
 			atmel_sha_update_dma_stop(dd);
-			if (dd->err) {
-				err =3D dd->err;
-				goto finish;
-			}
 		}
 		if (SHA_FLAGS_OUTPUT_READY & dd->flags) {
 			/* hash or semi-hash ready */
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index f44ef17420fb..d10be95a6470 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -102,7 +102,6 @@ struct atmel_tdes_dev {
 	int					irq;
=20
 	unsigned long		flags;
-	int			err;
=20
 	spinlock_t		lock;
 	struct crypto_queue	queue;
@@ -228,7 +227,6 @@ static int atmel_tdes_hw_init(struct atmel_tdes_dev *dd=
)
 	if (!(dd->flags & TDES_FLAGS_INIT)) {
 		atmel_tdes_write(dd, TDES_CR, TDES_CR_SWRST);
 		dd->flags |=3D TDES_FLAGS_INIT;
-		dd->err =3D 0;
 	}
=20
 	return 0;
@@ -1124,8 +1122,6 @@ static void atmel_tdes_done_task(unsigned long data)
 	else
 		err =3D atmel_tdes_crypt_dma_stop(dd);
=20
-	err =3D dd->err ? : err;
-
 	if (dd->total && !err) {
 		if (dd->flags & TDES_FLAGS_FAST) {
 			dd->in_sg =3D sg_next(dd->in_sg);
--=20
2.14.5


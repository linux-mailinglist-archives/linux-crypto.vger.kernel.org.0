Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBDF0A6E
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 00:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfKEXtk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Nov 2019 18:49:40 -0500
Received: from mail-sy3aus01hn2093.outbound.protection.outlook.com ([52.103.199.93]:16891
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729583AbfKEXtk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Nov 2019 18:49:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRmL/wixSVX+PLY7YZGzVHcgXRSFUXgMQ4BfO5T5wyPQ+NiEjLSXhUDj/Gp43/jgWvO3ZNxkO65KaS5WAPY7UC++rcpGvTupw6yW895QtMInV9YeqrufL1GV69JQ9CE2unNGk0u4x2/No+JeXFaOFIa9on1HiSSFg0A3zJCzcTjah2btnNR7eLlzqsLGwHlLMOGWwthmJpRNrjG0ea4PqIrXpHScBB/2/35nORyJDxRDGNckLkOneASiW+0y4q86Zs8iyIslGtsL5DpbUTpGLYk7b9mPAWuIQcP5qqVB6Oj0X1z1WplxerAuHW5xl/ot3hW+FpdaNngEMHj5nQGQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWtwMkiLLIR/kdov7sR4bI8o7/MBF+XSWpIOb6dL/5Q=;
 b=XzSw1U8aXtLBl3lUQMpMsy+FQ3wefDwJeKiML7nWkg9HTkwI9+UwFn+PQhSFAu4+LmunG7UBs4ailIGX4+HbOy0AMjJAjL2+ECLNkVifIlmw7h4WOaFL13ZmVRa52qAM5OBhkKHKzS1+PLQsfZFK7sIjLC2PGR1jc2ADMONFxPEJvupNZ99JsfvmhLK3vx9SDGnEg3KH4MfdSCgP1j7cOeeIGkyZ8P3c2LIQS+RoWXctVUxudop9on+3quAE3rQew+xHzFm1CW5GwBlgOFCTfcHi7HwE5FGcLdB4o6wgfIJv/k1J06DOKiVYniozXsc2MmZu731E8FMp9HX6RhCAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.uts.edu.au; dmarc=pass action=none
 header.from=student.uts.edu.au; dkim=pass header.d=student.uts.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentutsedu.onmicrosoft.com; s=selector2-studentutsedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWtwMkiLLIR/kdov7sR4bI8o7/MBF+XSWpIOb6dL/5Q=;
 b=ep6b6IvQTzZNw04zT6HsrwZMv11WQ4OUfWVr2LjzBWaEDuwe03tEKkqzlyc1pBtvfTJM2uxnr2gzIrZhaPFQqgok5UyO36M2Sld9FKmcexX4wmhPayI/cAcTSJW6Yx775xNSRisvRyqcf+O388lhxn3wvUelFsnvHDc6CNyqZkc=
Received: from SYAPR01MB2653.ausprd01.prod.outlook.com (52.134.184.145) by
 SYAPR01MB3085.ausprd01.prod.outlook.com (52.134.177.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 23:49:36 +0000
Received: from SYAPR01MB2653.ausprd01.prod.outlook.com
 ([fe80::b5d4:de37:9cae:d01c]) by SYAPR01MB2653.ausprd01.prod.outlook.com
 ([fe80::b5d4:de37:9cae:d01c%5]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 23:49:36 +0000
From:   Donation For You <13039134@student.uts.edu.au>
To:     Dylan Kaufer <Dylan.Kaufer@student.uts.edu.au>
Subject: Donation For You 
Thread-Topic: Donation For You 
Thread-Index: AQHVlDNchXpioM28aUyoQm1ROEQHdg==
Date:   Tue, 5 Nov 2019 23:47:19 +0000
Message-ID: <SYAPR01MB265307BFBE1EDECA1DD7ABB5A17E0@SYAPR01MB2653.ausprd01.prod.outlook.com>
Reply-To: "info.mrswanczyk@gmail.com" <info.mrswanczyk@gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:208:55::40) To SYAPR01MB2653.ausprd01.prod.outlook.com
 (2603:10c6:1:11::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Kaufer@student.uts.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-antivirus: Avast (VPS 191105-0, 11/04/2019), Outbound message
x-antivirus-status: Clean
x-originating-ip: [176.216.208.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 166ee1df-04c7-46c2-744d-08d7624a7ec6
x-ms-traffictypediagnostic: SYAPR01MB3085:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SYAPR01MB308517BCB31BA661DEDD4300F17E0@SYAPR01MB3085.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(43066004)(33656002)(66556008)(6862004)(102836004)(476003)(3480700005)(5660300002)(88552002)(66806009)(6506007)(558084003)(256004)(569274001)(2171002)(66066001)(2860700004)(2906002)(25786009)(305945005)(966005)(478600001)(6116002)(3846002)(7736002)(7416002)(74316002)(6636002)(9686003)(186003)(14454004)(386003)(486006)(6436002)(5003540100004)(71190400001)(52536014)(22416003)(8676002)(8936002)(316002)(8796002)(6666004)(81166006)(81156014)(4743002)(7696005)(786003)(66946007)(52116002)(99286004)(66476007)(66446008)(7116003)(6306002)(71200400001)(26005)(64756008)(55016002)(553104002)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:SYAPR01MB3085;H:SYAPR01MB2653.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: student.uts.edu.au does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUsiIbMFGVbS9sup74UM6QZnceV1TazxWoRfO1vlnBmgsCWHg50HWSfPfFz3g0cmF1Jj7CqzE27RQtkf8InWdLWqMBZmTIwD3bT96m1go5KMpsagLH5DHKNbjW9Y3Cv4zlHUEKmT9hrYjcYtK+uZ9a1umL5ATB5mIpRI8kpwsQSk623bARBsk6Rn6+Zf6HznaN9BbKN6WEHl/+LqTGQNx22wPLIrpG5zLtcF4Vqz/9Y4vR1pvkOPzsjRm0r0waNeD9L9Eup1N6W8C/tNuyljAy8IIKMDUguMaFcHhHWJMqPKaTuy/ooVME7oCljcGmXly1ndKP5VvpBvrZTWjcOGLB5w8Z/cAa0N3MkVvHxzdwJ/WfNDkGkKDjy2zVG4YPSxleuhVvqbJ3dzySkxzk4lhSGVrHNx7ciTbmeMjMoUb+BvoK3Z38jDSfIaBF5GFI2W
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0B5C04467A99CF4ABFF59FA282E51514@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uts.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 166ee1df-04c7-46c2-744d-08d7624a7ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 23:47:19.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8911c26-cf9f-4a9c-878e-527807be8791
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: polKdYZJIctLQ9/wVheahMTPeFDak9fNNtNpJZV58ErzvKLSjEwkGGmWzyWHkW3bcEaeO07FiPinRRX6krnbt+OEq3sUsCjLX84YPnv7IIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYAPR01MB3085
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Attention ...

I have decided to donate as part of my promises to charity project in honor=
 of my deceased wife, who died of cancer.  for a donation, contact for more=
 information


Mrs. Mavis Wanczyk

--=20
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus


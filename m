Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B47ED85F
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Nov 2019 06:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKDFQi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Nov 2019 00:16:38 -0500
Received: from mail-me1aus01hn2109.outbound.protection.outlook.com ([52.103.198.109]:38014
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfKDFQi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Nov 2019 00:16:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AInkYC0NutD3XUQ1KYTV+4+q94RrGYtlXlvapp/Xi0NInjeLS08ldPlblFMSSItpXQ/FVRT//x+h3lBs6+LCPtf8/+sLA63f9HM9CfL8s5+6QqB43nZrkTCLj3pyu6078iUyhUyp6lZoIlVWpD7UXQIcBeGyr/2LUUNRT8NWNF9y+zFdBOYEvmmVm39oPRNNyr+GhfbKzH9q+UDP2InM0Tf6iC7/nIlV9KPXXpducJxzSvu1CSStDozOsglf97Tm02ihRI68xiEbVUURIQxlvlOak0nz3gMEROpujwcps+n6YtYc6mxLWCoRAkWXOx11Grn2UMja9D3RcI9MoKM+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHR0LCawLQw0BrBRQk0jwmF0DuSo7ydVLux3J63rn44=;
 b=mZ+maIdPZyyKjoTChVXsJcWP5T4cr/BJUEnLBmoo9uYwpvPNA7eiIoLhkOnammd2c6fond6bLW17Lt9a13v4i2dXnvuMQ0SxTps9z3GVAbZgCH+d1/mu7V/rsBFU9MY9B/PWUVnPGnfz1ZdFGI5cjnqYvjJ377h8wLUuZbp6S7TjCtfoyueZTih9QFSNThNB6LP4knC+rrGsvNxpPGMUymsUVFuLPgYHDgkVnElI4pPh0WZBEb9dmKYuuN18qBFGVpwk6p2jgCHp8iB6gRA9nC6hmPfaRDnIQ6gQgCiY2EQMKskfWaZArTbHrr8LCV3dh0VV/Z7A4FsXdDLPpBPEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.uts.edu.au; dmarc=pass action=none
 header.from=student.uts.edu.au; dkim=pass header.d=student.uts.edu.au;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=studentutsedu.onmicrosoft.com; s=selector2-studentutsedu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHR0LCawLQw0BrBRQk0jwmF0DuSo7ydVLux3J63rn44=;
 b=fz5GhvrJ3/2eYjF1qZdZd4xM6fiTA6X39kpapgObn7pWKlQbrWa/q2KjgdsDzplpzG3o2qFRCMyXhdxkFx2BQk7cNf83okzfyB1TjUU2z8aM8V+C8vD6RQKMd+O5/7I9Xu/k3/PiQJjSR5bRH1fo/6TSKJYYQ3Gy2rKFKMHDrcA=
Received: from SYAPR01MB3022.ausprd01.prod.outlook.com (52.134.181.151) by
 SYAPR01MB2303.ausprd01.prod.outlook.com (52.134.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 05:16:34 +0000
Received: from SYAPR01MB3022.ausprd01.prod.outlook.com
 ([fe80::7102:dff3:2053:e07d]) by SYAPR01MB3022.ausprd01.prod.outlook.com
 ([fe80::7102:dff3:2053:e07d%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 05:16:34 +0000
From:   Donation For You <12965430@student.uts.edu.au>
To:     Lucy Parsons <Lucy.E.Parsons@student.uts.edu.au>
Subject: Donation For You 
Thread-Topic: Donation For You 
Thread-Index: AQHVks7Ar0Zgp5TYEEGnrp3bm+rDVA==
Date:   Mon, 4 Nov 2019 05:14:35 +0000
Message-ID: <SYAPR01MB3022C3DD40DA17AFA4BB43B8A17F0@SYAPR01MB3022.ausprd01.prod.outlook.com>
Reply-To: "g00glewinner2019@gmail.com" <g00glewinner2019@gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::27) To SYAPR01MB3022.ausprd01.prod.outlook.com
 (2603:10c6:1:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lucy.E.Parsons@student.uts.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-antivirus: Avast (VPS 191102-0, 11/02/2019), Outbound message
x-antivirus-status: Clean
x-originating-ip: [176.216.208.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85faa4dd-57d1-473c-3dc7-08d760e5e271
x-ms-traffictypediagnostic: SYAPR01MB2303:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SYAPR01MB23032348CFDDCEE9EF90896AAB7F0@SYAPR01MB2303.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(786003)(22416003)(81156014)(6862004)(14454004)(8676002)(8796002)(8936002)(52536014)(5003540100004)(305945005)(71190400001)(81166006)(71200400001)(43066004)(7696005)(52116002)(66946007)(66476007)(66556008)(476003)(966005)(64756008)(66446008)(486006)(33656002)(569274001)(26005)(6436002)(186003)(316002)(102836004)(6506007)(386003)(3846002)(6116002)(2171002)(74316002)(7736002)(7116003)(25786009)(99286004)(88552002)(2906002)(478600001)(4743002)(66066001)(3480700005)(5660300002)(66806009)(2860700004)(6306002)(55016002)(7416002)(6636002)(9686003)(558084003)(256004)(553104002)(81742002);DIR:OUT;SFP:1501;SCL:1;SRVR:SYAPR01MB2303;H:SYAPR01MB3022.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: student.uts.edu.au does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73ywA9XPokmsEEuWysD4v6jG0SokXRj1rgiDUO/03JpVFUGCD9hKuhvmLimxmxELAb+id5VX33i6X7xF8AdJ65ZuQrron/y44+nEFnZiV68uhcyO4HF6k0ie1NFrpsfrVCF7OtKVrNT1UDGd2lHV/9FC3DRPDa5zZ2K8VD/oT0x0sbWWm54n1IUnl2yyF0Fhpy1o1QL6tQdTPbjtfZnRAlBgr9k+Gpvd8L/Lepeb6E+owQth8bIWa3ecF7/A2C2o6tX0+PNHwq4JYPEPe6GOPsHUsJcToZYvl2BpzZPpx7uhvcReY956BdmQ9QESaHaN6bW45NRg7iicfooDCodyRqiHt9EeeR0Q1Y5176NDSMC50FryF5chAtwY46qjOZNRjANBERC8OpGedFyXjLvdUEGKoqSKrwRoAsU+zVYEGbiHCM4Gih+RNeZgwNM32XZn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D921E6EE791195408F32C85675E771EB@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: student.uts.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 85faa4dd-57d1-473c-3dc7-08d760e5e271
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 05:14:35.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8911c26-cf9f-4a9c-878e-527807be8791
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE1wQSwQOYqP90bwtWC0/jRdNAf8ZQXfghIkF96pgxH2mqJfqFDy7Nv1hEG3/byaTB7GCHlb9sILj8j1dOCali7qt3ZU0a4lOCsKYmz4d0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYAPR01MB2303
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Attention ...


I have decided to donate as part of my promises to charity project in honor=
 of my deceased wife, who died of cancer.  for a donation, contact for more=
 information

Mrs.=20

Mavis Wanczyk

--=20
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus


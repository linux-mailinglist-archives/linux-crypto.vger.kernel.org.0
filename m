Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76D2A8322
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfIDMnk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Sep 2019 08:43:40 -0400
Received: from mail-eopbgr710063.outbound.protection.outlook.com ([40.107.71.63]:26016
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfIDMnj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Sep 2019 08:43:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC6VEcJl2ZM7fLz4YzIz1KfB1uwoRXMKuuNgkyYjI+2o+Zkfhgj3kqfqSOypuwojBzA9atKigW5XAISotDZ+Jb9Vdhe0QyCX5YTEUO8iI46A+bcwvm4U1k5stIVpkj6t/FyLnewQkfMdaw53U2yy7baMt8Bk0IbGv6DwzfZHCbcn0Lnkn764VnKXl3j6R2yl9a3h0U37GlWGTeW6AIfFZkoS99vhq2RLyP3uP3rtdMOWQNndQkkG5cp2xOECJncS3AN7sVzreOId9UmZQRaAaoxJyXBKinAoGZk2j0H9PDBf0G0buCdfHS5Y3CZO1bdYuCHjuXNqaKvqXPFDW10OoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT78TkfYpZu5CIEHKVNIIgVRHh9bVyTJGmzA4iYMzBg=;
 b=bpNuwlL2t84qVUbHdWXLdNLQgj5Kebdoly3zJInCkGhW4k7Qe8zn9l1rHb9ys5OvkY7NdKPfpklWyBEMk//QEKLeN7aoAH5D1jaEkhIIZetZLguZ3Ba0A74itpQ1BJx4DHgp2qhoD67NP2olBfqAexA2wK4iGN7RvTFU0NG9o3j5eOnRKOGMqW8b4iF2HDcWaHQOL1DVJ3r42sseHlxToPHS25M8uMOpX0qDAnNST0mII1bFHGIXPfPu+xKAa5Jog/LNb+ffRcuPdujqtVU56Ty44c8kqOspiUClL4pKP3Iwjkiuy+nYSbhTLJ+ONnA5a7FPqiKMf5PTCdg6SEb7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verimatrix.com; dmarc=pass action=none
 header.from=verimatrix.com; dkim=pass header.d=verimatrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verimatrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT78TkfYpZu5CIEHKVNIIgVRHh9bVyTJGmzA4iYMzBg=;
 b=RWtGA95vlFdamPB///Yzx3ps6VUuhPfHmifTw9ygulsZ18gVxwk/l9HcN8vR/Zc6bOdveXOATk0zxDx7PDLOm9DjuPAbYatKNPneFjI6LfYR3XSLeNmXlFFJxp/HnPKmGFYKvVlL4ftZa9qWOVU2LkwIX2lN4OJSaQIGI8fX08o=
Received: from MN2PR20MB2973.namprd20.prod.outlook.com (52.132.172.146) by
 MN2PR20MB2816.namprd20.prod.outlook.com (20.178.253.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Wed, 4 Sep 2019 12:43:33 +0000
Received: from MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::6d07:5f09:97bf:c717]) by MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::6d07:5f09:97bf:c717%7]) with mapi id 15.20.2241.014; Wed, 4 Sep 2019
 12:43:33 +0000
From:   Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 -next] crypto: inside-secure - Fix build error without
 CONFIG_PCI
Thread-Topic: [PATCH v2 -next] crypto: inside-secure - Fix build error without
 CONFIG_PCI
Thread-Index: AQHVYfrTy4jcxbeEsEeyU2s27hKUDqcbaoBwgAAFDACAAAHAQIAAAu6AgAAA4VA=
Date:   Wed, 4 Sep 2019 12:43:32 +0000
Message-ID: <MN2PR20MB297384E74715B425AAB3A1C2CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <MN2PR20MB297342698B98343D49FC2C82CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu_EA8-=Vc3aAdJSz7399Y5WBeKNjw_T3LEq7yOY2XQ+BA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_EA8-=Vc3aAdJSz7399Y5WBeKNjw_T3LEq7yOY2XQ+BA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pvanleeuwen@verimatrix.com; 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cf94db-1780-4fa1-9000-08d731357f24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR20MB2816;
x-ms-traffictypediagnostic: MN2PR20MB2816:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR20MB28160BFCC3805961D7E05598CAB80@MN2PR20MB2816.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(376002)(366004)(346002)(136003)(189003)(199004)(13464003)(74316002)(186003)(7736002)(15974865002)(6246003)(14454004)(53546011)(305945005)(7696005)(6506007)(76176011)(55016002)(26005)(71190400001)(14444005)(256004)(71200400001)(9686003)(6116002)(53936002)(102836004)(6916009)(2906002)(33656002)(86362001)(81156014)(3846002)(476003)(229853002)(8676002)(99286004)(66066001)(8936002)(316002)(54906003)(76116006)(6436002)(66946007)(25786009)(66476007)(66556008)(64756008)(66446008)(478600001)(4326008)(446003)(5660300002)(486006)(11346002)(81166006)(52536014)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR20MB2816;H:MN2PR20MB2973.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: verimatrix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PEWPJQcWJZo5Jb+NAt1CuPpn5Mj+9gSgeOLv2dV96tKjqb4GeXB5PG9QP4JtLpDJ+6WkFzpaKWT//cOwObVaXzyRnfY9kfDeGvpgwhwHPuaa4ulDibL80+tY7Lf6BnK+q9Wz7jlx9WBDb0WkGuO/7oOb9wYdKxb52SE44r0eNAV3SHauPRbt88QSL6izAXtT3xyOKFXBE5odf6i5cpdMnP82CBHydaMu/TBZVnjfhjBN4Qksx7PrLiPT14KxmZW10TZ+m1FC0a6BHcGnPVSrAnJjvpP3cUBMSGUQ/En8We+O9ip7ViykpxJZ1UMELmhhkroJ1pYxDzejp5mwkH33Jw8mPiNstcr/ecvERN4wH/jrP5xYq7LMUmIrjO+/dywVIdTepZzyl0U5IEQj4UJvOVV4WNMN9AM5KpfzBOwagy8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: verimatrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf94db-1780-4fa1-9000-08d731357f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 12:43:33.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcb260f9-022d-4495-8602-eae51035a0d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJHZwVToEAFbKA4//KaX+ySz1mfckbE/LrfsEr/vzrnYjx0pZOqt4VNj5EYDU/rvLYirMHBrilDN2WU05BhBjyo5Zbw+E4rq83tVxaGA4Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2816
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJk
LmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwg
MjAxOSAyOjI3IFBNDQo+IFRvOiBQYXNjYWwgVmFuIExlZXV3ZW4gPHB2YW5sZWV1d2VuQHZlcmlt
YXRyaXguY29tPg0KPiBDYzogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPjsgYW50
b2luZS50ZW5hcnRAYm9vdGxpbi5jb207DQo+IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsg
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcHZhbmxlZXV3ZW5AaW5zaWRlc2VjdXJlLmNvbTsgbGludXgt
DQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAtbmV4dF0gY3J5cHRvOiBpbnNpZGUtc2VjdXJlIC0g
Rml4IGJ1aWxkIGVycm9yIHdpdGhvdXQgQ09ORklHX1BDSQ0KPiANCj4gT24gV2VkLCA0IFNlcCAy
MDE5IGF0IDA1OjI1LCBQYXNjYWwgVmFuIExlZXV3ZW4NCj4gPHB2YW5sZWV1d2VuQHZlcmltYXRy
aXguY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPg0KPiA+
ID4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAxOSAyOjExIFBNDQo+ID4gPiBUbzog
UGFzY2FsIFZhbiBMZWV1d2VuIDxwdmFubGVldXdlbkB2ZXJpbWF0cml4LmNvbT4NCj4gPiA+IENj
OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+OyBhbnRvaW5lLnRlbmFydEBib290
bGluLmNvbTsNCj4gPiA+IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgcHZhbmxlZXV3ZW5AaW5zaWRlc2VjdXJlLmNvbTsgbGludXgtDQo+ID4gPiBjcnlw
dG9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIC1uZXh0XSBjcnlwdG86IGluc2lkZS1zZWN1cmUgLSBGaXgg
YnVpbGQgZXJyb3Igd2l0aG91dA0KPiBDT05GSUdfUENJDQo+ID4gPg0KPiA+ID4gT24gV2VkLCA0
IFNlcCAyMDE5IGF0IDA0OjU3LCBQYXNjYWwgVmFuIExlZXV3ZW4NCj4gPiA+IDxwdmFubGVldXdl
bkB2ZXJpbWF0cml4LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBsaW51eC1jcnlwdG8tb3du
ZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1jcnlwdG8tb3duZXJAdmdlci5rZXJuZWwub3JnPiBP
bg0KPiA+ID4gQmVoYWxmIE9mDQo+ID4gPiA+ID4gWXVlSGFpYmluZw0KPiA+ID4gPiA+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAzLCAyMDE5IDM6NDUgQU0NCj4gPiA+ID4gPiBUbzogYW50b2lu
ZS50ZW5hcnRAYm9vdGxpbi5jb207IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsNCj4gPiA+ID4gPiBwdmFubGVldXdlbkBpbnNpZGVzZWN1cmUuY29tDQo+
ID4gPiA+ID4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFl1ZUhhaWJpbmcNCj4gPiA+ID4gPiA8eXVlaGFpYmluZ0BodWF3ZWku
Y29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAtbmV4dF0gY3J5cHRvOiBpbnNpZGUt
c2VjdXJlIC0gRml4IGJ1aWxkIGVycm9yIHdpdGhvdXQNCj4gQ09ORklHX1BDSQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSWYgQ09ORklHX1BDSSBpcyBub3Qgc2V0LCBidWlsZGluZyBmYWlsczoNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IHJpdmVycy9jcnlwdG8vaW5zaWRlLXNlY3VyZS9zYWZleGNlbC5j
OiBJbiBmdW5jdGlvbiBzYWZleGNlbF9yZXF1ZXN0X3JpbmdfaXJxOg0KPiA+ID4gPiA+IGRyaXZl
cnMvY3J5cHRvL2luc2lkZS1zZWN1cmUvc2FmZXhjZWwuYzo5NDQ6OTogZXJyb3I6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mDQo+IGZ1bmN0aW9uDQo+ID4gPiA+ID4gcGNpX2lycV92ZWN0b3I7DQo+
ID4gPiA+ID4gIGRpZCB5b3UgbWVhbiByY3VfaXJxX2VudGVyPyBbLVdlcnJvcj1pbXBsaWNpdC1m
dW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiA+ID4gPiAgICBpcnEgPSBwY2lfaXJxX3ZlY3Rvcihw
Y2lfcGRldiwgaXJxaWQpOw0KPiA+ID4gPiA+ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBVc2UgI2lmZGVmIGJsb2NrIHRvIGd1YXJkIHRoaXMuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gQWN0dWFsbHksIHRoaXMgaXMgaW50ZXJlc3RpbmcuIE15ICpvcmlnaW5hbCog
aW1wbGVtZW50YXRpb24gd2FzIHVzaW5nDQo+ID4gPiA+IHN0cmFpZ2h0ICNpZmRlZnMsIGJ1dCB0
aGVuIEkgZ290IHJldmlldyBmZWVkYmFjayBzdGF0aW5nIHRoYXQgSSBzaG91bGQgbm90DQo+ID4g
PiA+IGRvIHRoYXQsIGFzIGl0J3Mgbm90IGNvbXBpbGUgdGVzdGFibGUsIHN1Z2dlc3RpbmcgdG8g
dXNlIHJlZ3VsYXIgQyBpZidzDQo+ID4gPiA+IGluc3RlYWQuIFRoZW4gdGhlcmUgd2FzIHF1aXRl
IHNvbWUgYmFjay1hbmQtZm9ydGggb24gdGhlIGFjdHVhbA0KPiA+ID4gPiBpbXBsZW1lbnRhdGlv
biBhbmQgSSBlbmRlZCB1cCB3aXRoIHRoaXMuDQo+ID4gPiA+DQo+ID4gPiA+IFNvIG5vdyBpdCB0
dXJucyBvdXQgdGhhdCBkb2Vzbid0IHdvcmsgYW5kIEknbSBzdWdnZXN0ZWQgdG8gZ28gZnVsbC1j
aXJjbGUNCj4gPiA+ID4gYmFjayB0byBzdHJhaWdodCAjaWZkZWYncz8gT3IgaXMgdGhlcmUgc29t
ZSBvdGhlciB3YXkgdG8gbWFrZSB0aGlzIHdvcms/DQo+ID4gPiA+IEJlY2F1c2UgSSBkb24ndCBr
bm93IHdoZXJlIHRvIGdvIGZyb20gaGVyZSAuLi4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4gQyBjb25kaXRpb25hbHMgYXJlIHByZWZlcnJlZCBvdmVyIHByZXByb2Nlc3NvciBjb25kaXRp
b25hbCwgYnV0IGlmIHRoZQ0KPiA+ID4gY29uZGl0aW9uYWwgY29kZSByZWZlcnMgdG8gc3ltYm9s
cyB0aGF0IGFyZSBub3QgZGVjbGFyZWQgd2hlbiB0aGUNCj4gPiA+IEtjb25maWcgc3ltYm9sIGlz
IG5vdCBkZWZpbmVkLCBwcmVwcm9jZXNzb3IgY29uZGl0aW9uYWxzIGFyZSB0aGUgb25seQ0KPiA+
ID4gb3B0aW9uLg0KPiA+ID4NCj4gPiBTdXJlLCBJIGdldCB0aGF0LiBCdXQgSSAqaGFkKiB0aGUg
I2lmZGVmJ3MgYW5kIHRoZW4gb3RoZXIgcGVvcGxlIHRvbGQgbWUNCj4gPiB0byBnZXQgcmlkIG9m
IHRoZW0uIEhvdyBpcyBvbmUgc3VwcG9zZWQgdG8ga25vdyB3aGVuIHdoaWNoIHN5bWJvbHMgYXJl
DQo+ID4gZGVjbGFyZWQgZXhhY3RseT8gTW9yZW92ZXIsIEkgZmVlbCB0aGF0IGlmICNpZmRlZidz
IGFyZSBzb21ldGltZXMgdGhlDQo+ID4gb25seSB3YXksIHRoZW4geW91IHNob3VsZCBiZSBjYXJl
ZnVsIHByb3ZpZGluZyBmZWVkYmFjayBvbiB0aGUgc3ViamVjdC4NCj4gPg0KPiANCj4gSWYgeW91
IGNvbXBpbGUgeW91ciBjb2RlIHdpdGggYW5kIHdpdGhvdXQgdGhlIEtjb25maWcgc3ltYm9sIGRl
ZmluZWQsDQo+IHRoZSBjb21waWxlciB3aWxsIHRlbGwgeW91IGlmIHRoZXJlIGlzIGEgcHJvYmxl
bSBvciBub3QuDQo+IA0KUHJvYmFibHkuIE1heWJlLiBJIGRvbid0IGtub3cgbXVjaCBhYm91dCBj
b25maWd1cmluZyBMaW51eCBrZXJuZWxzIChJJ20ganVzdCANCmhhcHB5IHdpdGggd29ya2luZyBj
b25maWdzIHByb3ZpZGVkIHRvIG1lKSBzbyBJIGRvbid0IGtub3cgd2hhdCBwcm9ibGVtcw0KdGhh
dCBtaWdodCBnaXZlIChiZXlvbmQgdGhvc2UgaW4gbXkgb3duIGNvZGUpLg0KQWN0dWFsbHksIEkg
YXNzdW1lZCB0aGUgTWFjY2hpYXRvYmluIGNvbmZpZyBkaWQgbm90IGhhdmUgUENJIChhcyBBbnRv
aW5lDQphc2tlZCBtZSB0byBpZmRlZiB0aGF0IHN0dWZmIG91dCBJSVJDKSwgc28gdGhlcmUgd2Fz
IG5vIGluY2VudGl2ZSBmb3IgbWUgdG8NCnRyeSBleHBsaWN0bHkuIEJ1dCBpdCB0dXJucyBvdXQg
dGhlIE1hY2NoaWF0b2JpbiBjb25maWcgaGFzIFBDSSBhZnRlciBhbGwuDQoNCldoaWNoIG1ha2Vz
IG1lIHdvbmRlciB3aGF0IHRoZSBwb2ludCBvZiAjaWZkZWYnaW5nIG91dCB0aGUgUENJIHN0dWZm
IGlzIGluDQp0aGUgZmlyc3QgcGxhY2UsIGNvbnNpZGVyaW5nIHRoZXJlIGlzIG5vIHVzZSBjYXNl
IGZvciB0aGlzIGRyaXZlciB0aGF0IEkNCmtub3cgb2YgdGhhdCBkb2VzIG5vdCBoYXZlIFBDSSBz
dXBwb3J0IGluIHRoZSBrZXJuZWwuIEJ1dCBJIGd1ZXNzIGluIA0KdGhhdCBjYXNlIEkgd291bGQg
bWFrZSBpdCBkZXBlbmQgb24gUENJIGluIHRoZSBLY29uZmlnIGluc3RlYWQuDQpBbmQgQW50b2lu
ZSBtYXkgc3RpbGwgaGF2ZSBoYWQgYSBnb29kIHJlYXNvbiBmb3IgaGlzIHJlcXVlc3QuDQoNCj4g
PiA+IFRoaXMgaXMgdGhlIHJlYXNvbiB3ZSBoYXZlIHNvIG1hbnkgZW1wdHkgc3RhdGljIGlubGlu
ZSBmdW5jdGlvbnMgaW4NCj4gPiA+IGhlYWRlciBmaWxlcyAtIGl0IGVuc3VyZXMgdGhhdCB0aGUg
c3ltYm9scyBhcmUgZGVjbGFyZWQgZXZlbiBpZiB0aGUNCj4gPiA+IG9ubHkgaW52b2NhdGlvbnMg
YXJlIGZyb20gZGVhZCBjb2RlLg0KPiA+ID4NCj4gPiBUaGlzIHRpZXMgYmFjayBpbnRvIG15IHBy
ZXZpb3VzIHF1ZXN0aW9uOiBob3cgYW0gSSBzdXBwb3NlZCB0byBrbm93IHdoZXRoZXINCj4gPiBz
dHVmZiBpcyBuaWNlbHkgY292ZXJlZCBieSB0aGVzZSBlbXB0eSBzdGF0aWMgaW5saW5lcyBvciBu
b3Q/IElmIHRoaXMNCj4gPiBoYXBwZW5zIHRvIGJlIGEgaGl0LWFuZC1taXNzIGFmZmFpci4NCj4g
Pg0KPiANCj4gSW5kZWVkLg0KPiANCj4gPiBOb3RlIHRoYXQgSSB0ZXN0ZWQgdGhlIGNvZGUgd2l0
aCB0aGUgMiBwbGF0Zm9ybXMgYXQgbXkgZGlzcG9zYWwgLSBhY3R1YWxseQ0KPiA+IHRoZSBvbmx5
IDIgcmVsZXZhbnQgcGxhdGZvcm1zIGZvciB0aGlzIGRyaXZlciwgaWYgeW91IGFzayBtZSAtIGFu
ZCB0aGV5DQo+ID4gYm90aCBjb21waWxlZCBqdXN0IGZpbmUsIHNvIEkgaGFkIG5vIHdheSBvZiBm
aW5kaW5nIHRoaXMgInByb2JsZW0iIG15c2VsZi4NCj4gPg0KPiANCj4gRGlkIHlvdSB0cnkgZGlz
YWJsaW5nIENPTkZJR19QQ0k/DQo+IA0KTm8sIEknbSBhZnJhaWQgSSBhc3N1bWVkIHRoZSBNYWNj
aGlhdG9iaW4gY29uZmlnIGNvdmVyZWQgdGhhdCBhbHJlYWR5Lg0KKHllYWggLi4uIEkga25vdyAu
Li4gYXNzdW1wdGlvbnMgLi4uKQ0KDQo+ID4gPg0KPiA+ID4gPiA+IEZpeGVzOiA2MjVmMjY5YTVh
N2EgKCJjcnlwdG86IGluc2lkZS1zZWN1cmUgLSBhZGQgc3VwcG9ydCBmb3IgUENJIGJhc2VkIEZQ
R0ENCj4gPiA+IGRldmVsb3BtZW50DQo+ID4gPiA+ID4gYm9hcmQiKQ0KPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiB2MjogdXNlICdpZmRlZicgaW5zdGVhZCBvZiAnSVNfRU5BQkxFRCcNCj4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9jcnlwdG8vaW5zaWRlLXNlY3VyZS9zYWZl
eGNlbC5jIHwgMTMgKysrKysrKysrKy0tLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2NyeXB0by9pbnNpZGUtc2VjdXJlL3NhZmV4Y2VsLmMgYi9kcml2ZXJz
L2NyeXB0by9pbnNpZGUtDQo+ID4gPiA+ID4gc2VjdXJlL3NhZmV4Y2VsLmMNCj4gPiA+ID4gPiBp
bmRleCBlMTJhMmEzLi41MjUzOTAwIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY3J5
cHRvL2luc2lkZS1zZWN1cmUvc2FmZXhjZWwuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY3J5
cHRvL2luc2lkZS1zZWN1cmUvc2FmZXhjZWwuYw0KPiA+ID4gPiA+IEBAIC05MzcsNyArOTM3LDgg
QEAgc3RhdGljIGludCBzYWZleGNlbF9yZXF1ZXN0X3JpbmdfaXJxKHZvaWQgKnBkZXYsIGludCBp
cnFpZCwNCj4gPiA+ID4gPiAgICAgICBpbnQgcmV0LCBpcnE7DQo+ID4gPiA+ID4gICAgICAgc3Ry
dWN0IGRldmljZSAqZGV2Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLSAgICAgaWYgKElTX0VOQUJM
RUQoQ09ORklHX1BDSSkgJiYgaXNfcGNpX2Rldikgew0KPiA+ID4gPiA+ICsjaWZkZWYgQ09ORklH
X1BDSQ0KPiA+ID4gPiA+ICsgICAgIGlmIChpc19wY2lfZGV2KSB7DQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGNpX3BkZXYgPSBwZGV2Ow0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gICAgICAgICAgICAgICBkZXYgPSAmcGNpX3BkZXYtPmRldjsNCj4gPiA+ID4gPiBAQCAt
OTQ3LDcgKzk0OCwxMCBAQCBzdGF0aWMgaW50IHNhZmV4Y2VsX3JlcXVlc3RfcmluZ19pcnEodm9p
ZCAqcGRldiwgaW50IGlycWlkLA0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlycWlkLCBpcnEpOw0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
aXJxOw0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiA+IC0gICAgIH0gZWxzZSBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfT0YpKSB7DQo+ID4gPiA+ID4gKyAgICAgfSBlbHNlDQo+ID4g
PiA+ID4gKyNlbmRpZg0KPiA+ID4gPiA+ICsgICAgIHsNCj4gPiA+ID4gPiArI2lmZGVmIENPTkZJ
R19PRg0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGxm
X3BkZXYgPSBwZGV2Ow0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgY2hhciBpcnFfbmFtZVs2XSA9
IHswfTsgLyogInJpbmdYXDAiICovDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBAQCAtOTYwLDYgKzk2
NCw3IEBAIHN0YXRpYyBpbnQgc2FmZXhjZWxfcmVxdWVzdF9yaW5nX2lycSh2b2lkICpwZGV2LCBp
bnQgaXJxaWQsDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXJxX25h
bWUsIGlycSk7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBpcnE7DQo+
ID4gPiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiA+ICAg
ICAgIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgIHJldCA9IGRldm1fcmVxdWVzdF90aHJl
YWRlZF9pcnEoZGV2LCBpcnEsIGhhbmRsZXIsDQo+ID4gPiA+ID4gQEAgLTExMzcsNyArMTE0Miw4
IEBAIHN0YXRpYyBpbnQgc2FmZXhjZWxfcHJvYmVfZ2VuZXJpYyh2b2lkICpwZGV2LA0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gICAgICAgc2FmZXhjZWxfY29uZmlndXJlKHByaXYpOw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gLSAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1BDSSkgJiYgcHJpdi0+dmVy
c2lvbiA9PSBFSVAxOTdfREVWQlJEKSB7DQo+ID4gPiA+ID4gKyNpZmRlZiBDT05GSUdfUENJDQo+
ID4gPiA+ID4gKyAgICAgaWYgKHByaXYtPnZlcnNpb24gPT0gRUlQMTk3X0RFVkJSRCkgew0KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgLyoNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAqIFJlcXVl
c3QgTVNJIHZlY3RvcnMgZm9yIGdsb2JhbCArIDEgcGVyIHJpbmcgLQ0KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICogb3IganVzdCAxIGZvciBvbGRlciBkZXYgaW1hZ2VzDQo+ID4gPiA+ID4gQEAg
LTExNTMsNiArMTE1OSw3IEBAIHN0YXRpYyBpbnQgc2FmZXhjZWxfcHJvYmVfZ2VuZXJpYyh2b2lk
ICpwZGV2LA0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+
ID4gPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4gPiArI2Vu
ZGlmDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAvKiBSZWdpc3RlciB0aGUgcmluZyBJUlEg
aGFuZGxlcnMgYW5kIGNvbmZpZ3VyZSB0aGUgcmluZ3MgKi8NCj4gPiA+ID4gPiAgICAgICBwcml2
LT5yaW5nID0gZGV2bV9rY2FsbG9jKGRldiwgcHJpdi0+Y29uZmlnLnJpbmdzLA0KPiA+ID4gPiA+
IC0tDQo+ID4gPiA+ID4gMi43LjQNCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBSZWdhcmRz
LA0KPiA+ID4gPiBQYXNjYWwgdmFuIExlZXV3ZW4NCj4gPiA+ID4gU2lsaWNvbiBJUCBBcmNoaXRl
Y3QsIE11bHRpLVByb3RvY29sIEVuZ2luZXMgQCBWZXJpbWF0cml4DQo+ID4gPiA+IHd3dy5pbnNp
ZGVzZWN1cmUuY29tDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IFBhc2NhbCB2YW4gTGVldXdlbg0K
PiA+IFNpbGljb24gSVAgQXJjaGl0ZWN0LCBNdWx0aS1Qcm90b2NvbCBFbmdpbmVzIEAgVmVyaW1h
dHJpeA0KPiA+IHd3dy5pbnNpZGVzZWN1cmUuY29tDQo+ID4NCg0KDQpSZWdhcmRzLA0KUGFzY2Fs
IHZhbiBMZWV1d2VuDQpTaWxpY29uIElQIEFyY2hpdGVjdCwgTXVsdGktUHJvdG9jb2wgRW5naW5l
cyBAIFZlcmltYXRyaXgNCnd3dy5pbnNpZGVzZWN1cmUuY29tDQo=

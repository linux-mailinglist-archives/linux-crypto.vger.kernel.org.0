Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA96E87575
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Aug 2019 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfHIJR2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 05:17:28 -0400
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:62183
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbfHIJR1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 05:17:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGpLHSVK0aTi9XmzFfi1y3FTkjzz3f194Ihb4SK4WIi4G4zNXjjM4rfI3ZAuhGmjNIHq7MoS36yGgs/QNKSI6dZHJRrbLdUGUSDiM3vJqdulmybHWX9oZNKA7puv2MrEANp4v8tJuWOzYgqAcmmVys/YhzGbmg+EypclUUggROSjtf3qKjECGiBhl6Upd4HwnwqpowHUMpzSlk57aJtzCSuElY9uF5o7FdnOJyUNF9ve4ssuSFz3AtcC8a3QksnOz2RVlItp85FT89hYCs5iWiCu6JAsbrQ/6uH5ojvXL5yifWeLfgKB7CxFn4YrdJM+C77+oN2+6hmFuFP7Tu8bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht0+6V1Xpe0MValGKy/zKqnARbSXvM8z+mizZVTRDHY=;
 b=i6XG4C+NTEhGfb/veQ2OlyzfT46pQnmQMQIjp84A4CAIWzFYaiXUkNILqovCPd0TzLag2PN/FqCJ9DvBo5ZMH9/O+cekr4Q50eHX8Ck4WaCthQWpVHSHlQGbqSdpjPxoDoLiP8/wFk3Q3MLz7ITQeGTyMPwPUQEZA3jF5P8GKtF0nMUk6Q6gfOmJkeaSmMaKBFQgLi3jN8ABCu5Hb0b83PUHQXZvbXx2VrcK1mpzqINYL887b3U2kK4GNcxcOfQvzpIbjQ9VyucZRzvTY0o6LghydniQDcqpG1dqMafjhTbs+nvcvUOr3enOpkuyZgSnAQ8m6QGM03j2kYvp7wiWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verimatrix.com; dmarc=pass action=none
 header.from=verimatrix.com; dkim=pass header.d=verimatrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verimatrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht0+6V1Xpe0MValGKy/zKqnARbSXvM8z+mizZVTRDHY=;
 b=UtS2w7DZ0653llhrnedTQrhOpXLi+to3WvlByQyIzDYHiSA66bS3sFpjhzNDB/e9jcngOu8qc52FeV6FBRBAzqBmlfHXh8dk6Y73MRFEErwryAYs8v8htprnoELdVIFoPy5Kq4iXbmkNJfgfuiW+9LvrwkboyjVS7RrNenXFi/A=
Received: from MN2PR20MB2973.namprd20.prod.outlook.com (52.132.172.146) by
 MN2PR20MB2269.namprd20.prod.outlook.com (20.179.146.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 09:17:23 +0000
Received: from MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::d96f:39b2:19f4:c7c1]) by MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::d96f:39b2:19f4:c7c1%7]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 09:17:23 +0000
From:   Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [RFC PATCH v2] md/dm-crypt - reuse eboiv skcipher for IV
 generation
Thread-Topic: [RFC PATCH v2] md/dm-crypt - reuse eboiv skcipher for IV
 generation
Thread-Index: AQHVTOQKWnTPkdATo0i/D1XZtRSIkqbvRQ3wgABmBgCAAAHhUIAAJeoAgAAASmCAARpFgIAAAIWQgABIkICAAAcZkIAAQkcAgAEBE3A=
Date:   Fri, 9 Aug 2019 09:17:23 +0000
Message-ID: <MN2PR20MB2973387C1A083138866EE45FCAD60@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <20190807055022.15551-1-ard.biesheuvel@linaro.org>
 <MN2PR20MB297336108DF89337DDEEE2F6CAD40@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu_jFW26boEhpnAZg9sjWWZf60FXSWuSqNvC5FJiL7EVSA@mail.gmail.com>
 <MN2PR20MB2973A02FC4D6F1D11BA80792CAD40@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8fgg=gt4LSnCfShnf0-PZ=B1TNwM3zdQr+V6hkozgDOA@mail.gmail.com>
 <MN2PR20MB29733EEF59CCD754256D5621CAD40@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190808083059.GB5319@sol.localdomain>
 <MN2PR20MB297328E243D74E03C1EF54ACCAD70@MN2PR20MB2973.namprd20.prod.outlook.com>
 <67b4f0ee-b169-8af4-d7af-1c53a66ba587@gmail.com>
 <MN2PR20MB29739B9D16130F5C06831C92CAD70@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190808171508.GA201004@gmail.com>
In-Reply-To: <20190808171508.GA201004@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pvanleeuwen@verimatrix.com; 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f9d41c5-c90c-4a23-9b76-08d71caa637d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR20MB2269;
x-ms-traffictypediagnostic: MN2PR20MB2269:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MN2PR20MB22695E7B88E9C9496959B4CECAD60@MN2PR20MB2269.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(366004)(396003)(39850400004)(13464003)(189003)(199004)(55016002)(8676002)(6306002)(53936002)(316002)(66066001)(26005)(15974865002)(7736002)(14454004)(6116002)(3846002)(110136005)(6436002)(229853002)(9686003)(102836004)(7696005)(66946007)(74316002)(5660300002)(76116006)(66476007)(66556008)(66446008)(64756008)(52536014)(53546011)(6506007)(478600001)(2501003)(99286004)(186003)(76176011)(86362001)(966005)(305945005)(8936002)(2906002)(81156014)(81166006)(25786009)(33656002)(6246003)(71200400001)(71190400001)(256004)(14444005)(486006)(476003)(446003)(11346002)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR20MB2269;H:MN2PR20MB2973.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: verimatrix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5fw6KQAL/oR1cJpfMjoCDmzMuHLyf/J/+5M1Hg/fHHuPqUBmFKPjteVHRH4GVKMH5OY8ncRNU79zhsPhyj0pIsONd0dj5sniCCyKJFLzQ4U1RtJ9NgANXWo12gUPvL4Ui4OPITmNZ9/x5HmRWG8bVWrlZtZ81rRLxoN9tC22f6wJ1HJwriTGO2DMqHsv9Qdbde4WuNE9StRdFyFJamsAgw4t+iHyc/lYQSuijjyjF4O0P/rPGDtxagUHetDi4W/qjcVi5KZPJmK8Li3xE8LpGIrQ8F224PGR7pxj4yAcYgvzqGmQmbMHi7cZZf9crZCYYF664YX5vFppksR3iwQKe4GmQMOfneaOWkEivnTlpo022K4w0A+C7m6wKBJKRjnfOdNYwOaDCXMdg5vyt9DoDc6EIOpMWRAQz+YrRDJaXLA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: verimatrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9d41c5-c90c-4a23-9b76-08d71caa637d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 09:17:23.3439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcb260f9-022d-4495-8602-eae51035a0d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rfu3bTgVjkxCEN47aYH/gLDV7lmfpBf84gP5N7yHULkof1p0WdiMFioaCd3vY03KUoTDGTnHPwjBWyDvkE4GFxgUiRMnkFaJFPKEKDSiQMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2269
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

PHRyaW1tZWQgdG86IGxpc3QgZHVlIHRvIGJlaW5nIHNvbWV3aGF0IG9mZi10b3BpYz4NCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Br
ZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDgsIDIwMTkgNzoxNSBQTQ0KPiBU
bzogUGFzY2FsIFZhbiBMZWV1d2VuIDxwdmFubGVldXdlbkB2ZXJpbWF0cml4LmNvbT4NCj4gQ2M6
IE1pbGFuIEJyb3ogPGdtYXp5bGFuZEBnbWFpbC5jb20+OyBBcmQgQmllc2hldXZlbCA8YXJkLmJp
ZXNoZXV2ZWxAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBjcnlwdG9Admdlci5rZXJuZWwub3JnOyBo
ZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGFna0ByZWRoYXQuY29tOyBzbml0emVyQHJlZGhh
dC5jb207DQo+IGRtLWRldmVsQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
djJdIG1kL2RtLWNyeXB0IC0gcmV1c2UgZWJvaXYgc2tjaXBoZXIgZm9yIElWIGdlbmVyYXRpb24N
Cj4gDQo+IE9uIFRodSwgQXVnIDA4LCAyMDE5IGF0IDAxOjIzOjEwUE0gKzAwMDAsIFBhc2NhbCBW
YW4gTGVldXdlbiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBNaWxhbiBCcm96IDxnbWF6eWxhbmRAZ21haWwuY29tPg0KPiA+ID4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCA4LCAyMDE5IDI6NTMgUE0NCj4gPiA+IFRvOiBQYXNjYWwgVmFuIExlZXV3
ZW4gPHB2YW5sZWV1d2VuQHZlcmltYXRyaXguY29tPjsgRXJpYyBCaWdnZXJzDQo+IDxlYmlnZ2Vy
c0BrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBs
aW5hcm8ub3JnPjsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGhlcmJlcnRA
Z29uZG9yLmFwYW5hLm9yZy5hdTsgYWdrQHJlZGhhdC5jb207IHNuaXR6ZXJAcmVkaGF0LmNvbTsg
ZG0tZGV2ZWxAcmVkaGF0LmNvbQ0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjJdIG1k
L2RtLWNyeXB0IC0gcmV1c2UgZWJvaXYgc2tjaXBoZXIgZm9yIElWIGdlbmVyYXRpb24NCj4gPiA+
DQo+ID4gPiBPbiAwOC8wOC8yMDE5IDExOjMxLCBQYXNjYWwgVmFuIExlZXV3ZW4gd3JvdGU6DQo+
ID4gPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPj4gRnJvbTogRXJpYyBC
aWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwub3JnPg0KPiA+ID4gPj4gU2VudDogVGh1cnNkYXksIEF1
Z3VzdCA4LCAyMDE5IDEwOjMxIEFNDQo+ID4gPiA+PiBUbzogUGFzY2FsIFZhbiBMZWV1d2VuIDxw
dmFubGVldXdlbkB2ZXJpbWF0cml4LmNvbT4NCj4gPiA+ID4+IENjOiBBcmQgQmllc2hldXZlbCA8
YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz47IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gPiA+PiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGFna0ByZWRoYXQuY29tOyBz
bml0emVyQHJlZGhhdC5jb207IGRtLQ0KPiBkZXZlbEByZWRoYXQuY29tOw0KPiA+ID4gPj4gZ21h
enlsYW5kQGdtYWlsLmNvbQ0KPiA+ID4gPj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjJdIG1k
L2RtLWNyeXB0IC0gcmV1c2UgZWJvaXYgc2tjaXBoZXIgZm9yIElWIGdlbmVyYXRpb24NCj4gPiA+
ID4+DQo+ID4gPiA+PiBPbiBXZWQsIEF1ZyAwNywgMjAxOSBhdCAwNDoxNDoyMlBNICswMDAwLCBQ
YXNjYWwgVmFuIExlZXV3ZW4gd3JvdGU6DQo+ID4gPiA+Pj4+Pj4gSW4geW91ciBjYXNlLCB3ZSBh
cmUgbm90IGRlYWxpbmcgd2l0aCBrbm93biBwbGFpbnRleHQgYXR0YWNrcywNCj4gPiA+ID4+Pj4+
Pg0KPiA+ID4gPj4+Pj4gU2luY2UgdGhpcyBpcyBYVFMsIHdoaWNoIGlzIHVzZWQgZm9yIGRpc2sg
ZW5jcnlwdGlvbiwgSSB3b3VsZCBhcmd1ZQ0KPiA+ID4gPj4+Pj4gd2UgZG8hIEZvciB0aGUgdHdl
YWsgZW5jcnlwdGlvbiwgdGhlIHNlY3RvciBudW1iZXIgaXMga25vd24gcGxhaW50ZXh0LA0KPiA+
ID4gPj4+Pj4gc2FtZSBhcyBmb3IgRUJPSVYuIEFsc28sIHlvdSBtYXkgYmUgYWJsZSB0byBjb250
cm9sIGRhdGEgYmVpbmcgd3JpdHRlbg0KPiA+ID4gPj4+Pj4gdG8gdGhlIGRpc2sgZW5jcnlwdGVk
LCBlaXRoZXIgZGlyZWN0bHkgb3IgaW5kaXJlY3RseS4NCj4gPiA+ID4+Pj4+IE9LLCBwYXJ0IG9m
IHRoZSBkYXRhIGludG8gdGhlIENUUyBlbmNyeXB0aW9uIHdpbGwgYmUgcHJldmlvdXMgY2lwaGVy
dGV4dCwNCj4gPiA+ID4+Pj4+IGJ1dCB0aGF0IG1heSBiZSBqdXN0IDEgYnl0ZSB3aXRoIHRoZSBy
ZXN0IGJlaW5nIHRoZSBrbm93biBwbGFpbnRleHQuDQo+ID4gPiA+Pj4+Pg0KPiA+ID4gPj4+Pg0K
PiA+ID4gPj4+PiBUaGUgdHdlYWsgZW5jcnlwdGlvbiB1c2VzIGEgZGVkaWNhdGVkIGtleSwgc28g
bGVha2luZyBpdCBkb2VzIG5vdCBoYXZlDQo+ID4gPiA+Pj4+IHRoZSBzYW1lIGltcGFjdCBhcyBp
dCBkb2VzIGluIHRoZSBFQk9JViBjYXNlLg0KPiA+ID4gPj4+Pg0KPiA+ID4gPj4+IFdlbGwgLi4u
IHllcyBhbmQgbm8uIFRoZSBzcGVjIGRlZmluZXMgdGhlbSBhcyBzZXBlcmF0ZWx5IGNvbnRyb2xs
YWJsZSAtDQo+ID4gPiA+Pj4gZGV2aWF0aW5nIGZyb20gdGhlIG9yaWdpbmFsIFhFWCBkZWZpbml0
aW9uIC0gYnV0IGluIG1vc3QgcHJhY3RpY2xlIHVzZSBjYXNlcw0KPiA+ID4gPj4+IEkndmUgc2Vl
biwgdGhlIHNhbWUga2V5IGlzIHVzZWQgZm9yIGJvdGgsIGFzIGhhdmluZyAyIGtleXMganVzdCBp
bmNyZWFzZXMNCj4gPiA+ID4+PiBrZXkgIHN0b3JhZ2UgcmVxdWlyZW1lbnRzIGFuZCBkb2VzIG5v
dCBhY3R1YWxseSBpbXByb3ZlIGVmZmVjdGl2ZSBzZWN1cml0eQ0KPiA+ID4gPj4+IChvZiB0aGUg
YWxnb3JpdGhtIGl0c2VsZiwgaW1wbGVtZW50YXRpb24gcGVjdWxpYXJpdGllcyBsaWtlIHRoaXMg
b25lIGFzaWRlDQo+ID4gPiA+Pj4gOi0pLCBhcyAgWEVYIGhhcyBiZWVuIHByb3ZlbiBzZWN1cmUg
dXNpbmcgYSBzaW5nbGUga2V5LiBBbmQgdGhlIHNlY3VyaXR5DQo+ID4gPiA+Pj4gcHJvb2YgZm9y
IFhUUyBhY3R1YWxseSBidWlsZHMgb24gdGhhdCB3aGlsZSB1c2luZyAyIGtleXMgZGV2aWF0ZXMg
ZnJvbSBpdC4NCj4gPiA+ID4+Pg0KPiA+ID4gPj4NCj4gPiA+ID4+IFRoaXMgaXMgYSBjb21tb24g
bWlzY29uY2VwdGlvbi4gIEFjdHVhbGx5LCBYVFMgbmVlZHMgMiBkaXN0aW5jdCBrZXlzIHRvIGJl
IGENCj4gPiA+ID4+IENDQS1zZWN1cmUgdHdlYWthYmxlIGJsb2NrIGNpcGhlciwgZHVlIHRvIGFu
b3RoZXIgc3VidGxlIGRpZmZlcmVuY2UgZnJvbSBYRVg6DQo+ID4gPiA+PiBYRVggKGJ5IHdoaWNo
IEkgcmVhbGx5IG1lYW4gIlhFWFtFLDJdIikgYnVpbGRzIHRoZSBzZXF1ZW5jZSBvZiBtYXNrcyBz
dGFydGluZw0KPiA+ID4gPj4gd2l0aCB4XjEsIHdoaWxlIFhUUyBzdGFydHMgd2l0aCB4XjAuICBJ
ZiBvbmx5IDEga2V5IGlzIHVzZWQsIHRoZSBpbmNsdXNpb24gb2YNCj4gPiA+ID4+IHRoZSAwdGgg
cG93ZXIgaW4gWFRTIGFsbG93cyB0aGUgYXR0YWNrIGRlc2NyaWJlZCBpbiBTZWN0aW9uIDYgb2Yg
dGhlIFhFWCBwYXBlcg0KPiA+ID4gPj4gKGh0dHBzOi8vd2ViLmNzLnVjZGF2aXMuZWR1L35yb2dh
d2F5L3BhcGVycy9vZmZzZXRzLnBkZikuDQo+ID4gPiA+Pg0KPiA+ID4gPiBJbnRlcmVzdGluZyAu
Li4gSSdtIG5vdCBhIGNyeXB0b2dyYXBoZXIsIGp1c3QgYSBodW1ibGUgSFcgZW5naW5lZXIgc3Bl
Y2lhbGl6ZWQNCj4gPiA+ID4gaW4gaW1wbGVtZW50aW5nIGNyeXB0by4gSSdtIGJhc2luZyBteSB2
aWV3cyBtb3N0bHkgb24gdGhlIExpc2tvdi9NaW5lbWF0c3UNCj4gPiA+ID4gIkNvbW1lbnRzIG9u
IFhUUyIsIHdobyBhc3NlcnQgdGhhdCB1c2luZyAyIGtleXMgaW4gWFRTIHdhcyBtaXNndWlkZWQu
DQo+ID4gPiA+IChhbmQgSSBuZXZlciBzYXcgYW55IGZvbGxvdy1vbiBjb21tZW50cyBhc3NlcnRp
bmcgdGhhdCB0aGlzIHZpZXcgd2FzIHdyb25nIC4uLikNCj4gPiA+ID4gT24gbm90IGF2b2lkaW5n
IGo9MCBpbiB0aGUgWFRTIHNwZWMgdGhleSBhY3R1YWxseSBjb21tZW50Og0KPiA+ID4gPiAiVGhp
cyBkaWZmZXJlbmNlIGlzIHNpZ25pZmljYW50IGluIHNlY3VyaXR5LCBidXQgaGFzIG5vIGltcGFj
dCBvbiBlZmZlY3RpdmVuZXNzDQo+ID4gPiA+IGZvciBwcmFjdGljYWwgYXBwbGljYXRpb25zLiIs
IHdoaWNoIEkgcmVhZCBhcyAibm90IHJlbGV2YW50IGZvciBub3JtYWwgdXNlIi4NCj4gDQo+IFNl
ZSBwYWdlIDYgb2YgIkNvbW1lbnRzIG9uIFhUUyI6DQo+IA0KPiAJTm90ZSB0aGF0IGogPSAwIG11
c3QgYmUgZXhjbHVkZWQsIGFzIGYoMCwgdikgPSB2IGZvciBhbnkgdiwgd2hpY2gNCj4gCWltcGxp
ZXMgz4EgPSAxLiBNb3Jlb3ZlciwgaWYgaiA9IDAgd2FzIGFsbG93ZWQsIGEgc2ltcGxlIGF0dGFj
ayBiYXNlZCBvbg0KPiAJdGhpcyBmYWN0IGV4aXN0ZWQsIGFzIHBvaW50ZWQgb3V0IGJ5IFs2XSBh
bmQgWzNdLiBIZW5jZSBpZiBYRVggaXMgdXNlZCwNCj4gCW9uZSBtdXN0IGJlIGNhcmVmdWwgdG8g
YXZvaWQgaiBiZWluZyAwLg0KPg0KT2ssIEkgbWlzc2VkIHRoYXQgcGFydC4gU29tZXRoaW5nIHRv
IGRvIHdpdGggYmVpbmcgc3Vycm91bmRlZCBieSBmYXIgdG9vIA0KbXVjaCBtYXRoIDotUA0KDQpJ
IGRpZCBmaWd1cmUgb3V0IGJ5IG15c2VsZiB0aGF0IGZvcmNpbmcgdGhlIGNpcGhlcnRleHQgdG8g
MCBmb3IgdGhlIGZpcnN0DQpibG9jayBhbmQgYmVpbmcgYWJsZSB0byBvYnNlcnZlIHRoZSBwbGFp
bnRleHQgY29taW5nIG91dCB3b3VsZCBnaXZlIHlvdQ0KUyBeIEUoUykgaWYgYm90aCBrZXlzIGFy
ZSBlcXVhbCBkdWUgZG8gRCgwIF4gRSh4KSkgYmVpbmcgeC4NCkkgZ3Vlc3MgdGhhdCdzIHRoZSBm
KDAsdikgPSB2IGluIHRoZSBhYm92ZS4NCldoaWNoIHdvdWxkIGdpdmUgeW91IEUoUykgYXMgUyBp
cyB1c3VhbGx5IGtub3duLiAoQnV0IHRoaXMgZG9lc24ndCBoYXZlIHRvDQpiZSB0aGUgY2FzZSEg
UyAqY2FuKiBiZSBtYWRlIGEgc2VjcmV0IHdpdGhpbiB0aGUgWFRTIHNwZWNpZmljYXRpb24hKQ0K
V2hpY2ggaW4gdHVybiB3b3VsZCBnaXZlIHlvdSBhbGwgdHdlYWtzIEUoUykgKiBhbHBoYShqKSwg
cmVkdWNpbmcgdGhlDQplbmNyeXB0aW9uIC9mb3IgdGhhdCBzZWN0b3Igb25seS8gdG8ganVzdCBi
YXNpYyBFQ0IuDQoNClN0aWxsLCB0aGF0IGRvZXMgbm90IGNvbnN0aXR1dGUgYSBmdWxsIGF0dGFj
ayBvbiB0aGUgc2VjdG9yIGF0IGhhbmQgKHdoaWNoDQppcyBub3Qgc28gcmVsZXZhbnQsIHNpbmNl
IGl0IHdhcyBsZWFraW5nIHBsYWludGV4dCwgc28geW91IGNhbiBhc3N1bWUgaXQgDQpkb2VzIG5v
dCBjb250YWluIGFueSBzZW5zaXRpdmUgZGF0YSEpLCBsZXQgYWxvbmUgYW55IG90aGVyIHNlY3Rv
ciBvbiB0aGUgDQpkaXNrIG9yIGV2ZW4gdGhlIGtleS4gQXQgbGVhc3QsIEkgaGF2ZSBub3Qgc2Vl
biB0aGF0IGRlbW9uc3RyYXRlZCB5ZXQuDQoNClNvIGl0IG1heSBiZSBiYWQgaW4gdGhlIGdlbmVy
YWwgY3J5cHRvZ3JhcGhpYyBzZW5zZSwgYnV0IEkgc3RpbGwgZG91YnQgaXQgDQpoYXMgdmVyeSBz
aWduaWZpY2FudCBwcmFjdGljbGUgaW1wbGljYXRpb25zIGlmIHlvdSBhc3N1bWUgdGhlIHN5c3Rl
bSBpcyANCm5vdCBsZWFraW5nIGFueSBwbGFpbnRleHQgZnJvbSBhbnkgc2Vuc2l0aXZlIGFyZWFz
IG9mIHRoZSBkaXNrLg0KDQpTdGlsbCwgRklQUyBzZWVtcyB0byBjb25zaWRlciBpdCBhIHJpc2sg
c28gd2hvIGFtIEkgdG8gZG91YnQgdGhhdCA7LSkNCg0KPiBUaGUgcGFydCB5b3UgcXVvdGVkIGlz
IG9ubHkgdGFsa2luZyBhYm91dCBYVFMgKmFzIHNwZWNpZmllZCosIGkuZS4gd2l0aCAyIGtleXMu
DQo+IA0KT2ssIHRoYXQgbWFrZXMgc2Vuc2UgYWN0dWFsbHkuIFdvdWxkIGhhdmUgYmVlbiBiZXR0
ZXIgaWYgdGhleSBtZW50aW9uZWQNCnRoYXQgdGhhdCBzdGF0ZW1lbnQgb25seSBvbmx5IGhvbGRz
IGlmIHRoZSBrZXlzIGFyZSBub3QgZXF1YWwgLi4uICh3aGljaCwNCkJUVywgaXMgbm90IGEgcmVx
dWlyZW1lbnQgbWVudGlvbmVkIGFueXdoZXJlIGluIHRoZSBYVFMgc3BlY2lmaWNhdGlvbikNCg0K
PiA+ID4gPg0KPiA+ID4gPiBJbiBhbnkgY2FzZSwgaXQncyBmcmVxdWVudGx5ICp1c2VkKiB3aXRo
IGJvdGgga2V5cyBiZWluZyBlcXVhbCBmb3IgcGVyZm9ybWFuY2UNCj4gPiA+ID4gYW5kIGtleSBz
dG9yYWdlIHJlYXNvbnMuDQo+IA0KPiBJdCdzIGJyb2tlbiwgc28gaXQncyBicm9rZW4uICBEb2Vz
bid0IG1hdHRlciB3aG8gaXMgdXNpbmcgaXQuDQo+IA0KV2VsbCwgaXQgZG9lcyBraW5kIG9mIG1h
dHRlciBmb3IgcGVvcGxlIHRoYXQgc3RpbGwgd2FudCB0byByZWFkIHRoZWlyIGRpc2sNCi0gYW5k
IHBvc3NpYmx5IGNvbnRpbnVlIHRvIHVzZSBpdCAtIGVuY3J5cHRlZCB3aXRoIHRoZSAiYnJva2Vu
IiB2ZXJzaW9uIDotKQ0KDQpBbmQgImJyb2tlbiIgaXMgYSByZWxhdGl2ZSB0ZXJtIGFueXdheS4g
QXMgbG9uZyBhcyB5b3UgY2FuJ3QgZ2V0IHRvIHRoZSBrZXksDQpkZWNyeXB0IHJhbmRvbSBzZWN0
b3JzIG9yIG1hbmlwdWxhdGUgcmFuZG9tIGJpdHMsIGl0IG1heSBiZSBzZWN1cmUgZW5vdWdoIA0K
Zm9yIGl0cyBwdXJwb3NlLg0KDQo+ID4gPg0KPiA+ID4gVGhlcmUgaXMgYWxyZWFkeSBjaGVjayBp
biBrZXJuZWwgZm9yIFhUUyAid2VhayIga2V5cyAodHdlYWsgYW5kIGVuY3J5cHRpb24ga2V5cyBt
dXN0DQo+IG5vdCBiZQ0KPiA+ID4gdGhlIHNhbWUpLg0KPiA+ID4NCj4gPiA+DQo+IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmVlL2luY2x1ZGUvY3J5cHRvL3h0cw0KPiAuaCMNCj4gPiA+IG4yNw0KPiA+ID4NCj4gPiA+
IEZvciBub3cgaXQgYXBwbGllcyBvbmx5IGluIEZJUFMgbW9kZS4uLiAoYW5kIGlmIEkgc2VlIGNv
cnJlY3RseSBpdCBpcyBkdXBsaWNhdGVkIGluDQo+IGFsbA0KPiA+ID4gZHJpdmVycykuDQo+ID4g
Pg0KPiA+IEkgbmV2ZXIgaGFkIGFueSBuZWVkIHRvIGxvb2sgaW50byBGSVBTIGZvciBYVFMgYmVm
b3JlLCBidXQgdGhpcyBhY3R1YWxseSBhcHBlYXJzDQo+ID4gdG8gYmUgYWNjdXJhdGUuIEZJUFMg
aW5kZWVkICpyZXF1aXJlcyB0aGlzKi4gTXVjaCB0byBteSBzdXJwcmlzZSwgSSBtaWdodCBhZGQu
DQo+ID4gU3RpbGwgbG9va2luZyBmb3Igc29tZSBhY3R1YWwgcmF0aW9uYWxlIHRoYXQgZ29lcyBi
ZXlvbmQgc3VnZ2VzdGlvbiBhbmQgaW5udWVuZG8NCj4gPiAoYW5kIGlzIG5vdCB0b28gaGVhdnkg
b24gdGhlIG1hdGggOy0pIHRob3VnaC4NCj4gDQo+IEFzIEkgc2FpZCwgdGhlIGF0dGFjayBpcyBl
eHBsYWluZWQgaW4gdGhlIG9yaWdpbmFsIFhFWCBwYXBlci4gIEJhc2ljYWxseSB0aGUNCj4gYWR2
ZXJzYXJ5IGNhbiBzdWJtaXQgYSBjaG9zZW4gY2lwaGVydGV4dCBxdWVyeSBmb3IgdGhlIGZpcnN0
IGJsb2NrIG9mIHNlY3RvciAwDQo+IHRvIGxlYWsgdGhlIGZpcnN0ICJtYXNrIiBvZiB0aGF0IHNl
Y3RvciwgdGhlbiBzdWJtaXQgYSBjaG9zZW4gcGxhaW50ZXh0IG9yDQo+IGNpcGhlcnRleHQgcXVl
cnkgZm9yIHRoZSByZW1pbmRlciBvZiB0aGUgc2VjdG9yIHN1Y2ggdGhhdCB0aGV5IGNhbiBwcmVk
aWN0IHRoZQ0KPiBvdXRwdXQgd2l0aCAxMDAlIGNlcnRhaW50eS4gIChUaGUgc3RhbmRhcmQgc2Vj
dXJpdHkgbW9kZWwgZm9yIHR3ZWFrYWJsZSBibG9jaw0KPiBjaXBoZXJzIHNheXMgdGhlIG91dHB1
dCBtdXN0IGFwcGVhciByYW5kb20uKQ0KPiANClllcywgYnV0IHRoYXQgb25seSBhZmZlY3RzIGEg
c2VjdG9yIHRoYXQgd2FzIGxlYWtpbmcgcGxhaW50ZXh0IHRvIGJlZ2luIA0Kd2l0aC4gSSdtIG5v
dCBpbXByZXNzZWQgdW50aWwgeW91IGVpdGhlciByZWNvdmVyIHRoZSBrZXkgb3IgY2FuIGRlY3J5
cHQNCm9yIG1hbmlwdWxhdGUgKm90aGVyKiBzZWN0b3JzIG9uIHRoZSBkaXNrLg0KDQo+IC0gRXJp
Yw0KDQoNCg0KUmVnYXJkcywNClBhc2NhbCB2YW4gTGVldXdlbg0KU2lsaWNvbiBJUCBBcmNoaXRl
Y3QsIE11bHRpLVByb3RvY29sIEVuZ2luZXMgQCBWZXJpbWF0cml4DQp3d3cuaW5zaWRlc2VjdXJl
LmNvbQ0KDQo=

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE4850CC
	for <lists+linux-crypto@lfdr.de>; Wed,  7 Aug 2019 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbfHGQO1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 7 Aug 2019 12:14:27 -0400
Received: from mail-eopbgr740077.outbound.protection.outlook.com ([40.107.74.77]:58640
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388257AbfHGQO1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 7 Aug 2019 12:14:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgjiqU+YwwskoJqVNK+FBxu0xLofs6AnsXsHMNruuSDuCl7izTDbbmp28Som8BEU/XUeD0CMrVs30WR2pow+AtPjXS+AJ3o4tHfR59WFZTjfQKLX1yFGrMwso7TlcDMPDBMvdfbgPolB1d5qQ/s7afqccsIdiUx0TdsO/PHAUq9JGT5O4sg/9RW2kwAwyRp93gO22AvGfoG1XQCJ0TtFdmmc16MR/1PizepDmcNHgjFEZBAwadKl0CzkBMkNuF3MXgf/k8QJj0O7/qvpjlSlQsj28tl1prBICrCSc6PXoUr8Yrr7azCngV1Gzm1Vl6uNNyZezLWuwIU78VdlsQK26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsk3Qet+WV5z3gxbXGcSG8EPsGbqfO/s3NXDlwW9TT8=;
 b=ReEmzgYfq+atAO7al8kZAJylDVlvEVWq2N4qVUXUwIcyBK6zitQSfpK4vYxVlJKY63XRG5gIFRWNRe4nzz7oR3RRikH5mQhhnX1ZHlOt4RuFKx46/qhjsxTI3dTZaJl6qdSVhff96cjS3n69OAiuhoDwoxD1S1ZQgSwXUP1DosFBk5dOn9Xr67dHYpOazOn5niLis84saXwJAQ39plhglhkiJ5dzyAmalza4SLBTAyzy3Ud3td6vgk/y5GGI5A5IiRXMTJqzCKh+fyoJeZ+ZsHTViKqmQSveecXcJWqrsrWy06/lzs281sVLf6H8OaIWa6WW7t1+cstSDWwbbh4Xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verimatrix.com; dmarc=pass action=none
 header.from=verimatrix.com; dkim=pass header.d=verimatrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verimatrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsk3Qet+WV5z3gxbXGcSG8EPsGbqfO/s3NXDlwW9TT8=;
 b=T2oRPMdCY0xcPZDCdXGJPSqUwXexXdN9YWuAzIk0K0/aebyCgqvN9Zt8QYxWu9/Wk4C4z8JIvDfvHRc76efdkHT1Kh7lyoxg00+4VgXfQpZBEYn0gcdZmxVqaKZpnALnCSx3LqOOkak+ewmHt3NzYtCP27md+BNrSRg9Rv6JDcQ=
Received: from MN2PR20MB2973.namprd20.prod.outlook.com (52.132.172.146) by
 MN2PR20MB2845.namprd20.prod.outlook.com (20.178.253.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Wed, 7 Aug 2019 16:14:23 +0000
Received: from MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::d96f:39b2:19f4:c7c1]) by MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::d96f:39b2:19f4:c7c1%7]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 16:14:23 +0000
From:   Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "gmazyland@gmail.com" <gmazyland@gmail.com>
Subject: RE: [RFC PATCH v2] md/dm-crypt - reuse eboiv skcipher for IV
 generation
Thread-Topic: [RFC PATCH v2] md/dm-crypt - reuse eboiv skcipher for IV
 generation
Thread-Index: AQHVTOQKWnTPkdATo0i/D1XZtRSIkqbvRQ3wgABmBgCAAAHhUIAAJeoAgAAASmA=
Date:   Wed, 7 Aug 2019 16:14:22 +0000
Message-ID: <MN2PR20MB29733EEF59CCD754256D5621CAD40@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <20190807055022.15551-1-ard.biesheuvel@linaro.org>
 <MN2PR20MB297336108DF89337DDEEE2F6CAD40@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu_jFW26boEhpnAZg9sjWWZf60FXSWuSqNvC5FJiL7EVSA@mail.gmail.com>
 <MN2PR20MB2973A02FC4D6F1D11BA80792CAD40@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8fgg=gt4LSnCfShnf0-PZ=B1TNwM3zdQr+V6hkozgDOA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8fgg=gt4LSnCfShnf0-PZ=B1TNwM3zdQr+V6hkozgDOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pvanleeuwen@verimatrix.com; 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e43afc10-ab0a-4c1a-5f24-08d71b524f79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR20MB2845;
x-ms-traffictypediagnostic: MN2PR20MB2845:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR20MB2845F3F18BFF93E4211D50FBCAD40@MN2PR20MB2845.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39850400004)(136003)(13464003)(189003)(199004)(305945005)(7736002)(5660300002)(6246003)(9686003)(53936002)(8676002)(55016002)(71190400001)(86362001)(71200400001)(74316002)(25786009)(52536014)(4326008)(15974865002)(66066001)(476003)(68736007)(8936002)(33656002)(486006)(54906003)(81166006)(81156014)(11346002)(446003)(186003)(7696005)(6116002)(76176011)(99286004)(316002)(3846002)(14454004)(256004)(229853002)(6916009)(478600001)(102836004)(66446008)(6506007)(76116006)(53546011)(64756008)(66556008)(66476007)(6436002)(66946007)(2906002)(14444005)(26005)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR20MB2845;H:MN2PR20MB2973.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: verimatrix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T/nIzuUwVnevcobDYNgO1pyOXhxXTkK6fE+uCE1OQAe2nUu/kWnX4bz+ObsLy2owHiJLxGTKW9J7944cxexUR+NI2LtMiyiARzomP0GmirvTq5YG/HRFo5eAvfFI0Vkb4KyGrvMMf/25KLUBEr6SDBCkDfql23VyIpuvxQBNlhtegjtEn1pNioPqDIsLu3XitZTGhBrw1moXTN2Zf34RjX0NHTGhvnn5pN16BCIjGPX2KqzqBC/UoyTdQ2JkYvq2AqOvwieb6j/1FT3UFeDNg2HXl40sY+berrfgyGdjW5VnwcNFBhAa+M2HUCy25KWOe00O9q/JTNjDJZzVE33ZxL04da63l+V6mqhGLsTx6eQTps+fUrYJaYPN7i+i//hSLq/1CguQzS11LqzzfLHL9D8O27uLSSiIxBN9eY8AekI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: verimatrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43afc10-ab0a-4c1a-5f24-08d71b524f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 16:14:22.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcb260f9-022d-4495-8602-eae51035a0d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvanleeuwen@verimatrix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2845
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJk
LmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNywgMjAx
OSA1OjQwIFBNDQo+IFRvOiBQYXNjYWwgVmFuIExlZXV3ZW4gPHB2YW5sZWV1d2VuQHZlcmltYXRy
aXguY29tPg0KPiBDYzogbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgaGVyYmVydEBnb25k
b3IuYXBhbmEub3JnLmF1OyBlYmlnZ2Vyc0BrZXJuZWwub3JnOw0KPiBhZ2tAcmVkaGF0LmNvbTsg
c25pdHplckByZWRoYXQuY29tOyBkbS1kZXZlbEByZWRoYXQuY29tOyBnbWF6eWxhbmRAZ21haWwu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyXSBtZC9kbS1jcnlwdCAtIHJldXNlIGVi
b2l2IHNrY2lwaGVyIGZvciBJViBnZW5lcmF0aW9uDQo+IA0KPiBPbiBXZWQsIDcgQXVnIDIwMTkg
YXQgMTY6NTIsIFBhc2NhbCBWYW4gTGVldXdlbg0KPiA8cHZhbmxlZXV3ZW5AdmVyaW1hdHJpeC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gQXJkLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFy
by5vcmc+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA3LCAyMDE5IDM6MTcgUE0NCj4g
PiA+IFRvOiBQYXNjYWwgVmFuIExlZXV3ZW4gPHB2YW5sZWV1d2VuQHZlcmltYXRyaXguY29tPg0K
PiA+ID4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGhlcmJlcnRAZ29uZG9yLmFw
YW5hLm9yZy5hdTsgZWJpZ2dlcnNAa2VybmVsLm9yZzsNCj4gPiA+IGFna0ByZWRoYXQuY29tOyBz
bml0emVyQHJlZGhhdC5jb207IGRtLWRldmVsQHJlZGhhdC5jb207IGdtYXp5bGFuZEBnbWFpbC5j
b20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyXSBtZC9kbS1jcnlwdCAtIHJldXNl
IGVib2l2IHNrY2lwaGVyIGZvciBJViBnZW5lcmF0aW9uDQo+ID4gPg0KPiA+ID4gT24gV2VkLCA3
IEF1ZyAyMDE5IGF0IDEwOjI4LCBQYXNjYWwgVmFuIExlZXV3ZW4NCj4gPiA+IDxwdmFubGVldXdl
bkB2ZXJpbWF0cml4LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEFyZCwNCj4gPiA+ID4N
Cj4gPiA+ID4gSSd2ZSBhY3R1YWxseSBiZWVuIGZvbGxvd2luZyB0aGlzIGRpc2N1c3Npb24gd2l0
aCBzb21lIGludGVyZXN0LCBhcyBpdCBoYXMNCj4gPiA+ID4gc29tZSByZWxldmFuY2UgZm9yIHNv
bWUgb2YgdGhlIHRoaW5ncyBJIGFtIGRvaW5nIGF0IHRoZSBtb21lbnQgYXMgd2VsbC4NCj4gPiA+
ID4NCj4gPiA+ID4gRm9yIGV4YW1wbGUsIGZvciBteSBDVFMgaW1wbGVtZW50YXRpb24gSSBuZWVk
IHRvIGNyeXB0IG9uZSBvciB0d28NCj4gPiA+ID4gc2VwZXJhdGUgYmxvY2tzIGFuZCBmb3IgdGhl
IGluc2lkZS1zZWN1cmUgZHJpdmVyIEkgc29tZXRpbWVzIG5lZWQgdG8gZG8NCj4gPiA+ID4gc29t
ZSBzaW5nbGUgY3J5cHRvIGJsb2NrIHByZWNvbXB1dGVzLiAodGhlIFhUUyBkcml2ZXIgYWRkaXRp
b25hbGx5DQo+ID4gPiA+IGFsc28gYWxyZWFkeSBkaWQgc3VjaCBhIHNpbmdsZSBibG9jayBlbmNy
eXB0IGZvciB0aGUgdHdlYWssIGFsc28gdXNpbmcNCj4gPiA+ID4gYSBzZXBlcmF0ZSAobm9uLXNr
KWNpcGhlciBpbnN0YW5jZSAtIHZlcnkgc2ltaWxhciB0byB5b3VyIElWIGNhc2UpDQo+ID4gPiA+
DQo+ID4gPiA+IExvbmcgc3Rvcnkgc2hvcnQsIHRoZSBjdXJyZW50IGFwcHJvYWNoIGlzIHRvIGFs
bG9jYXRlIGEgc2VwZXJhdGUNCj4gPiA+ID4gY2lwaGVyIGluc3RhbmNlIHNvIHlvdSBjYW4gY29u
dmVuaWVudGx5IGRvIGNyeXB0b19jaXBoZXJfZW4vZGVjcnlwdF9vbmUuDQo+ID4gPiA+IChpdCB3
b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBtYXRjaGluZyBjcnlwdG9fc2tjaXBoZXJfZW4vZGVjcnlw
dF9vbmUNCj4gPiA+ID4gZnVuY3Rpb24gYXZhaWxhYmxlIGZyb20gdGhlIGNyeXB0byBBUEkgZm9y
IHRoZXNlIHB1cnBvc2VzPykNCj4gPiA+ID4gQnV0IGlmIEkgdW5kZXJzdGFuZCB5b3UgY29ycmVj
dGx5LCB5b3UgbWF5IGVuZCB1cCB3aXRoIGFuIGluc2VjdXJlDQo+ID4gPiA+IHRhYmxlLWJhc2Vk
IGltcGxlbWVudGF0aW9uIGlmIHlvdSBkbyB0aGF0LiBOb3Qgd2hhdCBJIHdhbnQgOi0oDQo+ID4g
PiA+DQo+ID4gPg0KPiA+ID4gVGFibGUgYmFzZWQgQUVTIGlzIGtub3duIHRvIGJlIHZ1bG5lcmFi
bGUgdG8gcGxhaW50ZXh0IGF0dGFja3Mgb24gdGhlDQo+ID4gPiBrZXksIHNpbmNlIGVhY2ggYnl0
ZSBvZiB0aGUgaW5wdXQgeG9yJ2VkIHdpdGggdGhlIGtleSBpcyB1c2VkIGFzIGFuDQo+ID4gPiBp
bmRleCBmb3IgZG9pbmcgU2JveCBsb29rdXBzLCBhbmQgc28gd2l0aCBlbm91Z2ggc2FtcGxlcywg
dGhlcmUgaXMgYW4NCj4gPiA+IGV4cGxvaXRhYmxlIHN0YXRpc3RpY2FsIGNvcnJlbGF0aW9uIGJl
dHdlZW4gdGhlIHJlc3BvbnNlIHRpbWUgYW5kIHRoZQ0KPiA+ID4ga2V5Lg0KPiA+ID4NCj4gPiA+
IFNvIGluIHRoZSBjb250ZXh0IG9mIEVCT0lWLCB3aGVyZSB0aGUgdXNlciBtaWdodCBzcGVjaWZ5
IGEgU0lNRCBiYXNlZA0KPiA+ID4gdGltZSBpbnZhcmlhbnQgc2tjaXBoZXIsIGl0IHdvdWxkIGJl
IHJlYWxseSBiYWQgaWYgdGhlIGtub3duIHBsYWludGV4dA0KPiA+ID4gZW5jcnlwdGlvbnMgb2Yg
dGhlIGJ5dGUgb2Zmc2V0cyB0aGF0IG9jY3VyIHdpdGggdGhlICpzYW1lKiBrZXkgd291bGQNCj4g
PiA+IGhhcHBlbiB3aXRoIGEgZGlmZmVyZW50IGNpcGhlciB0aGF0IGlzIGFsbG9jYXRlZCBpbXBs
aWNpdGx5IGFuZCBlbmRzDQo+ID4gPiB1cCBiZWluZyBmdWxmaWxsZWQgYnksIGUuZy4sIGFlcy1n
ZW5lcmljLCBzaW5jZSBpbiB0aGF0IGNhc2UsIGVhY2gNCj4gPiA+IGJsb2NrIGVuL2RlY3J5cHRp
b24gaXMgcHJlY2VkZWQgYnkgYSBzaW5nbGUsIHRpbWUtdmFyaWFudCBBRVMNCj4gPiA+IGludm9j
YXRpb24gd2l0aCBhbiBlYXNpbHkgZ3Vlc3NhYmxlIGlucHV0Lg0KPiA+ID4NCj4gPiBObyBuZWVk
IHRvIHRlbGwgbWUsIGRvaW5nIGNyeXB0byBoYXMgYmVlbiBteSBkYXlqb2IgZm9yIG5lYXJseSAx
OC41IHllYXJzDQo+ID4gbm93IDotKQ0KPiA+DQo+IA0KPiBJIGRpZG4ndCBtZWFuIHRvIGltcGx5
IHRoYXQgeW91IGRvbid0IGtub3cgeW91ciBzdHVmZiA6LSkgSSBhbSBqdXN0DQo+IHJlaXRlcmF0
aW5nIHRoZSBFQk9JViBpc3N1ZSBzbyB3ZSBjYW4gY29tcGFyZSBpdCB0byB0aGUgaXNzdWUgeW91
IGFyZQ0KPiBicmluZ2luZyB1cA0KPiANCkZhaXIgZW5vdWdoIDotKQ0KDQo+ID4gPiBJbiB5b3Vy
IGNhc2UsIHdlIGFyZSBub3QgZGVhbGluZyB3aXRoIGtub3duIHBsYWludGV4dCBhdHRhY2tzLA0K
PiA+ID4NCj4gPiBTaW5jZSB0aGlzIGlzIFhUUywgd2hpY2ggaXMgdXNlZCBmb3IgZGlzayBlbmNy
eXB0aW9uLCBJIHdvdWxkIGFyZ3VlDQo+ID4gd2UgZG8hIEZvciB0aGUgdHdlYWsgZW5jcnlwdGlv
biwgdGhlIHNlY3RvciBudW1iZXIgaXMga25vd24gcGxhaW50ZXh0LA0KPiA+IHNhbWUgYXMgZm9y
IEVCT0lWLiBBbHNvLCB5b3UgbWF5IGJlIGFibGUgdG8gY29udHJvbCBkYXRhIGJlaW5nIHdyaXR0
ZW4NCj4gPiB0byB0aGUgZGlzayBlbmNyeXB0ZWQsIGVpdGhlciBkaXJlY3RseSBvciBpbmRpcmVj
dGx5Lg0KPiA+IE9LLCBwYXJ0IG9mIHRoZSBkYXRhIGludG8gdGhlIENUUyBlbmNyeXB0aW9uIHdp
bGwgYmUgcHJldmlvdXMgY2lwaGVydGV4dCwNCj4gPiBidXQgdGhhdCBtYXkgYmUganVzdCAxIGJ5
dGUgd2l0aCB0aGUgcmVzdCBiZWluZyB0aGUga25vd24gcGxhaW50ZXh0Lg0KPiA+DQo+IA0KPiBU
aGUgdHdlYWsgZW5jcnlwdGlvbiB1c2VzIGEgZGVkaWNhdGVkIGtleSwgc28gbGVha2luZyBpdCBk
b2VzIG5vdCBoYXZlDQo+IHRoZSBzYW1lIGltcGFjdCBhcyBpdCBkb2VzIGluIHRoZSBFQk9JViBj
YXNlLiANCj4NCldlbGwgLi4uIHllcyBhbmQgbm8uIFRoZSBzcGVjIGRlZmluZXMgdGhlbSBhcyBz
ZXBlcmF0ZWx5IGNvbnRyb2xsYWJsZSAtDQpkZXZpYXRpbmcgZnJvbSB0aGUgb3JpZ2luYWwgWEVY
IGRlZmluaXRpb24gLSBidXQgaW4gbW9zdCBwcmFjdGljbGUgdXNlIGNhc2VzIA0KSSd2ZSBzZWVu
LCB0aGUgc2FtZSBrZXkgaXMgdXNlZCBmb3IgYm90aCwgYXMgaGF2aW5nIDIga2V5cyBqdXN0IGlu
Y3JlYXNlcyANCmtleSAgc3RvcmFnZSByZXF1aXJlbWVudHMgYW5kIGRvZXMgbm90IGFjdHVhbGx5
IGltcHJvdmUgZWZmZWN0aXZlIHNlY3VyaXR5IA0KKG9mIHRoZSBhbGdvcml0aG0gaXRzZWxmLCBp
bXBsZW1lbnRhdGlvbiBwZWN1bGlhcml0aWVzIGxpa2UgdGhpcyBvbmUgYXNpZGUgDQo6LSksIGFz
ICBYRVggaGFzIGJlZW4gcHJvdmVuIHNlY3VyZSB1c2luZyBhIHNpbmdsZSBrZXkuIEFuZCB0aGUg
c2VjdXJpdHkgDQpwcm9vZiBmb3IgWFRTIGFjdHVhbGx5IGJ1aWxkcyBvbiB0aGF0IHdoaWxlIHVz
aW5nIDIga2V5cyBkZXZpYXRlcyBmcm9tIGl0Lg0KDQo+IEFuZCBhIHBsYWludGV4dCBhdHRhY2sN
Cj4gb24gdGhlIGRhdGEgZW5jcnlwdGlvbiBwYXJ0IG9mIFhUUyBpbnZvbHZlcyBrbm93aW5nIHRo
ZSB2YWx1ZSBvZiB0aGUNCj4gdHdlYWsgYXMgd2VsbCwgc28geW91J2QgaGF2ZSB0byBzdWNjZXNz
ZnVsbHkgYXR0YWNrIHRoZSB0d2VhayBiZWZvcmUNCj4geW91IGNhbiBhdHRhY2sgdGhlIGRhdGEu
IFNvIHdoaWxlIHlvdXIgcG9pbnQgaXMgdmFsaWQsIGl0J3MgZGVmaW5pdGVseQ0KPiBsZXNzIGJy
b2tlbiB0aGFuIEVCT0lWLg0KPiANCkZvciB0aGUgZGF0YSBlbmNyeXB0aW9uLCB5b3UgaGF2ZSBh
IHZlcnkgdmFsaWQgcG9pbnQgKHdoaWNoIEkgYWRtaXQgSQ0KY29tcGxldGVseSBvdmVybG9va2Vk
KS4gRm9yIHRoZSB0d2VhayBlbmNyeXB0aW9uIGl0c2VsZiwgaG93ZXZlciAuLi4NCg0KQnV0IGV2
ZW4gaWYgeW91IHdvdWxkIHVzZSAyIGluZGVwZW5kZW50IGtleXMsIGlmIHlvdSBmaXJzdCBicmVh
ayB0aGUNCnR3ZWFrIGtleSwgdGhlIHR3ZWFrIGJlY29tZXMga25vd24gcGxhaW50ZXh0IGFuZCB5
b3UgY2FuIHRoZW4gY29udGludWUNCmJyZWFraW5nIHRoZSBkYXRhIGVuY3J5cHRpb24ga2V5IDot
KSBJdCdzIGEgYml0IGhhcmRlciwgYnV0IGZhciBmcm9tDQppbXBvc3NpYmxlLg0KDQo+ID4gPiBh
bmQgdGhlDQo+ID4gPiBoaWdoZXIgbGF0ZW5jeSBvZiBoL3cgYWNjZWxlcmF0ZWQgY3J5cHRvIG1h
a2VzIG1lIGxlc3Mgd29ycmllZCB0aGF0DQo+ID4gPiB0aGUgZmluYWwsIHVzZXIgb2JzZXJ2YWJs
ZSBsYXRlbmN5IHdvdWxkIHN0cm9uZ2x5IGNvcnJlbGF0ZSB0aGUgd2F5DQo+ID4gPiBhZXMtZ2Vu
ZXJpYyBpbiBpc29sYXRpb24gZG9lcy4NCj4gPiA+DQo+ID4gSWYgdGhhdCBsYXRlbmN5IGlzIGNv
bnN0YW50IC0gd2hpY2ggaXQgdXN1YWxseSBpcyAtIHRoZW4gaXQgZG9lc24ndA0KPiA+IHJlYWxs
eSBtYXR0ZXIgZm9yIGNvcnJlbGF0aW9uLCBpdCBqdXN0IGZpbHRlcnMgb3V0Lg0KPiA+DQo+IA0K
PiBEdWUgdG8gdGhlIGFzeW5jaHJvbm91cyBuYXR1cmUgb2YgdGhlIGRyaXZlciwgd2UnbGwgdXN1
YWxseSBiZSBjYWxsaW5nDQo+IGludG8gdGhlIE9TIHNjaGVkdWxlciBhZnRlciBxdWV1aW5nIG9u
ZSBvciBwZXJoYXBzIHNldmVyYWwgYmxvY2tzIGZvcg0KPiBwcm9jZXNzaW5nIGJ5IHRoZSBoYXJk
d2FyZS4gRXZlbiBpZiB0aGUgcHJvY2Vzc2luZyB0aW1lIGlzIGZpeGVkLCB0aGUNCj4gdGltZSBp
dCB0YWtlcyBmb3IgdGhlIE9TIHRvIHJlc3BvbmQgdG8gdGhlIGNvbXBsZXRpb24gSVJRIGFuZCBw
cm9jZXNzDQo+IHRoZSBvdXRwdXQgaXMgdW5saWtlbHkgdG8gY29ycmVsYXRlIHRoZSB3YXkgYSB0
YWJsZSBiYXNlZCBzb2Z0d2FyZQ0KPiBpbXBsZW1lbnRhdGlvbiBkb2VzLCBlc3BlY2lhbGx5IGlm
IHNldmVyYWwgYmxvY2tzIGNhbiBiZSBpbiBmbGlnaHQgYXQNCj4gdGhlIHNhbWUgdGltZS4NCj4g
DQpPaywgSSBkaWRuJ3Qga25vdyB0aGUgZGV0YWlscyBvZiB0aGF0IC4uLiBzdGlsbCwgZG9uJ3Qg
dW5kZXJlc3RpbWF0ZQ0KdGhlIHBvd2VyIG9mIHN0YXRpc3RpY2FsIGFuYWx5c2lzLiBZb3UnZCB0
aGluayBhIFNvQyB3b3VsZCBnZW5lcmF0ZSANCmVub3VnaCBwb3dlciBvciBFTUkgbm9pc2UgdG8g
aGlkZSB5b3VyIHB1bnkgbGl0dGxlIGNyeXB0byBhY2NlbGVyYXRvcidzDQpjb250cmlidXRpb24g
dG8gdGhhdCAtIHdlbGwsIHRoaW5rIGFnYWluLiBZb3UnZCBiZSBzdXJwcmlzZWQgYnkgd2hhdA0K
dGhlIGd1eXMgaW4gb3VyIGF0dGFjayBsYWIgbWFuYWdlIHRvIGFjaGlldmUuDQoNCj4gQnV0IG5v
dGUgdGhhdCB3ZSBhcmUgYmFzaWNhbGx5IGluIGFncmVlbWVudCBoZXJlOiBmYWxsaW5nIGJhY2sg
dG8NCj4gdGFibGUgYmFzZWQgQUVTIGlzIHVuZGVzaXJhYmxlLCBidXQgZm9yIEVCT0lWIGl0IGlz
IGp1c3QgbXVjaCB3b3JzZQ0KPiB0aGFuIGZvciBvdGhlciBtb2Rlcy4NCj4gDQpNdWNoIHdvcnNl
IHRoYW4gKmNlcnRhaW4qIG90aGVyIG1vZGVzLiBJdCdzIGRlZmluaXRlbHkgc29tZXRoaW5nIHRo
YXQNCmFsd2F5cyBuZWVkcyB0byBiZSBpbiB0aGUgYmFjayBvZiB5b3VyIG1pbmQgYXMgbG9uZyBh
cyB0aGVyZSBpcyBzb21lDQpwb3NzaWJpbGl0eSB5b3UgZW5kIHVwIHdpdGggYSBub3Qtc28tc2Vj
dXJlIGltcGxlbWVudGF0aW9uLg0KDQo+ID4gPiA+IEhvd2V2ZXIsIGluIG1hbnkgY2FzZXMgdGhl
cmUgd291bGQgYWN0dWFsbHkgYmUgYSB2ZXJ5IGdvb2QgcmVhc29uDQo+ID4gPiA+IE5PVCB0byB3
YW50IHRvIHVzZSB0aGUgbWFpbiBza2NpcGhlciBmb3IgdGhpcy4gQXMgdGhhdCBpcyBzb21lDQo+
ID4gPiA+IGhhcmR3YXJlIGFjY2VsZXJhdG9yIHdpdGggdGVycmlibGUgbGF0ZW5jeSB0aGF0IHlv
dSB3b3VsZG4ndCB3YW50DQo+ID4gPiA+IHRvIHVzZSB0byBwcm9jZXNzIGp1c3Qgb25lIGNpcGhl
ciBibG9jay4gRm9yIHRoYXQsIHlvdSB3YW50IHRvIGhhdmUNCj4gPiA+ID4gc29tZSBTVyBpbXBs
ZW1lbnRhdGlvbiB0aGF0IGlzIGVmZmljaWVudCBvbiBhIHNpbmdsZSBibG9jayBpbnN0ZWFkLg0K
PiA+ID4gPg0KPiA+ID4NCj4gPiA+IEluZGVlZC4gTm90ZSB0aGF0IGZvciBFQk9JViwgc3VjaCBw
ZXJmb3JtYW5jZSBjb25jZXJucyBhcmUgZGVlbWVkDQo+ID4gPiBpcnJlbGV2YW50LCBidXQgaXQg
aXMgYW4gaXNzdWUgaW4gdGhlIGdlbmVyYWwgY2FzZS4NCj4gPiA+DQo+ID4gWWVzLCBteSBpbnRl
cmVzdCB3YXMgcHVyZWx5IGluIHRoZSBnZW5lcmljIGNhc2UuDQo+ID4NCj4gPiA+ID4gSW4gbXkg
aHVtYmxlIG9waW5pb24sIHN1Y2ggaW5zZWN1cmUgdGFibGUgYmFzZWQgaW1wbGVtZW50YXRpb25z
IGp1c3QNCj4gPiA+ID4gc2hvdWxkbid0IGV4aXN0IGF0IGFsbCAtIHlvdSBjYW4gYWx3YXlzIGRv
IGJldHRlciwgcG9zc2libHkgYXQgdGhlDQo+ID4gPiA+IGV4cGVuc2Ugb2Ygc29tZSBwZXJmb3Jt
YW5jZSBkZWdyYWRhdGlvbi4gT3IgeW91IHNob3VsZCBhdCBsZWFzdCBoYXZlDQo+ID4gPiA+IHNv
bWUgZmxhZyAgYXZhaWxhYmxlIHRvIHNwZWNpZnkgeW91IGhhdmUgc29tZSBzZWN1cml0eSByZXF1
aXJlbWVudHMNCj4gPiA+ID4gYW5kIHN1Y2ggYW4gaW1wbGVtZW50YXRpb24gaXMgbm90IGFuIGFj
Y2VwdGFibGUgcmVzcG9uc2UuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gV2UgZGlkIHNvbWUgd29y
ayB0byByZWR1Y2UgdGhlIHRpbWUgdmFyaWFuY2Ugb2YgQUVTOiB0aGVyZSBpcyB0aGUNCj4gPiA+
IGFlcy10aSBkcml2ZXIsIGFuZCB0aGVyZSBpcyBub3cgYWxzbyB0aGUgQUVTIGxpYnJhcnksIHdo
aWNoIGlzIGtub3duDQo+ID4gPiB0byBiZSBzbG93ZXIgdGhhbiBhZXMtZ2VuZXJpYywgYnV0IGRv
ZXMgaW5jbHVkZSBzb21lIG1pdGlnYXRpb25zIGZvcg0KPiA+ID4gY2FjaGUgdGltaW5nIGF0dGFj
a3MuDQo+ID4gPg0KPiA+ID4gT3RoZXIgdGhhbiB0aGF0LCBJIGhhdmUgbGl0dGxlIHRvIG9mZmVy
LCBnaXZlbiB0aGF0IHRoZSBwZXJmb3JtYW5jZSB2cw0KPiA+ID4gc2VjdXJpdHkgdHJhZGVvZmZz
IHdlcmUgZGVjaWRlZCBsb25nIGJlZm9yZSBzZWN1cml0eSBiZWNhbWUgYSB0aGluZw0KPiA+ID4g
bGlrZSBpdCBpcyB0b2RheSwgYW5kIHNvIHJlbW92aW5nIGFlcy1nZW5lcmljIGlzIG5vdCBhbiBv
cHRpb24sDQo+ID4gPiBlc3BlY2lhbGx5IHNpbmNlIHRoZSBzY2FsYXIgYWx0ZXJuYXRpdmVzIHdl
IGhhdmUgYXJlIG5vdCB0cnVseSB0aW1lDQo+ID4gPiBpbnZhcmlhbnQgZWl0aGVyLg0KPiA+ID4N
Cj4gPiBSZXBsYWNpbmcgYWVzLWdlbmVyaWMgd2l0aCBhIHRydWx5IHRpbWUtaW52YXJpYW50IGlt
cGxlbWVudGF0aW9uIGNvdWxkDQo+ID4gYmUgYW4gb3B0aW9uLg0KPiANCj4gSWYgeW91IGNhbiBm
aW5kIGEgdHJ1bHkgdGltZS1pbnZhcmlhbnQgQyBpbXBsZW1lbnRhdGlvbiBvZiBBRVMgdGhhdA0K
PiBpc24ndCBvcmRlcnMgb2YgbWFnbml0dWRlIHNsb3dlciB0aGFuIGFlcy1nZW5lcmljLCBJJ20g
c3VyZSB3ZSBjYW4NCj4gbWVyZ2UgaXQuDQo+IA0KSSBndWVzcyB0aGUgIm9yZGVycyBvZiBhIG1h
Z25pdHVkZSBzbG93ZXIiIHRoaW5nIGlzIHRoZSBjYXRjaCBoZXJlIDotKQ0KDQpCdXQgZnJvbSBt
eSBwZXJzcGVjdGl2ZSwgY3J5cHRvIHBlcmZvcm1hbmNlIGlzIGlycmVsZXZhbnQgaWYgaXQgaXMg
bm90IA0Kc2VjdXJlIGF0IGFsbC4gKGFmdGVyIGFsbCwgaXQncyBjcnlwdG8sIHNvIHRoZSAqaW50
ZW50KiBpcyBzZWN1cml0eSkNCk9mIGNvdXJzZSB0aGVyZSdzIGdyYWRhdGlvbiBpbiBzZWN1cml0
eSBsZXZlbHMsIGJ1dCB0aW1pbmctYXR0YWNrDQpyZXNpc3RhbmNlIHJlYWxseSBpcyB0aGUgbG93
ZXN0IG9mIHRoZSBsb3dlc3QgSU1ITy4NCg0KPiA+IE9yIHNlbGVjdGluZyBhZXMtZ2VuZXJpYyBv
bmx5IGlmIHNvbWUgKG5ldykgImFsbG93X2luc2VjdXJlIg0KPiA+IGZsYWcgaXMgc2V0IG9uIHRo
ZSBjaXBoZXIgcmVxdWVzdC4gKE9idmlvdXNseSwgeW91IHdhbnQgdG8gZGVmYXVsdCB0bw0KPiA+
IHNlY3VyZSwgbm90IGluc2VjdXJlLiBTcGVha2luZyBhcyBzb21lb25lIHdobyBlYXJucyBoaXMg
bGl2aW5nIGRvaW5nDQo+ID4gc2VjdXJpdHkgOi0pDQo+ID4NCj4gDQo+IFdlIGFsbCBkby4gQnV0
IHdlIGFsbCBoYXZlIGRpZmZlcmVudCB1c2UgY2FzZXMgdG8gd29ycnkgYWJvdXQsIGFuZA0KPiBk
aWZmZXJlbnQgZXhwZXJpZW5jZXMgYW5kIGJhY2tncm91bmRzIDotKQ0KPiANCj4gVGhlIG1haW4g
cHJvYmxlbSBpcyB0aGF0IGJhbm5pbmcgYWVzLWdlbmVyaWMgaXMgYSBiaXQgdG9vIHJpZ29yb3Vz
DQo+IGltby4gSXQgaGlnaGx5IGRlcGVuZHMgb24gd2hldGhlciB0aGVyZSBpcyBrbm93biBwbGFp
bnRleHQgYW5kIHdoZXRoZXINCj4gdGhlcmUgYXJlIG9ic2VydmFibGUgbGF0ZW5jaWVzIGluIHRo
ZSBmaXJzdCBwbGFjZS4NCj4gDQpBZ3JlZSBvbiB0aGUgYmFubmluZyBwYXJ0LCBidXQgaXQgd291
bGQgYmUgZ29vZCBpZiB5b3UgY291bGQgYmUgKmNlcnRhaW4qDQpzb21laG93IHRoYXQgeW91IGRv
bid0IGVuZCB1cCB3aXRoIGl0LiBGb3IgY2VydGFpbiB1c2UgY2FzZXMsIGEgKG11Y2gpDQpzbG93
ZXIsIGJ1dCBtb3JlLCBzZWN1cmUgaW1wbGVtZW50YXRpb24gbWF5IGJlIHRoZSBiZXR0ZXIgY2hv
aWNlLiBBcyB5b3UNCmFscmVhZHkgZGlzY292ZXJlZCBieSB5b3Vyc2VsZi4NCg0KPiA+IChEaXNj
bGFpbWVyOiBJIGRvIG5vdCBrbm93IGFueXRoaW5nIGFib3V0IHRoZSBhZXMtZ2VuZXJpYyBpbXBs
ZW1lbnRhdGlvbiwNCj4gPiBJJ20ganVzdCB0YWtpbmcgeW91ciB3b3JkIGZvciBpdCB0aGF0IGl0
IGlzIG5vdCBzZWN1cmUgKGVub3VnaCkgLi4uKQ0KPiA+DQoNClJlZ2FyZHMsDQpQYXNjYWwgdmFu
IExlZXV3ZW4NClNpbGljb24gSVAgQXJjaGl0ZWN0LCBNdWx0aS1Qcm90b2NvbCBFbmdpbmVzIEAg
VmVyaW1hdHJpeA0Kd3d3Lmluc2lkZXNlY3VyZS5jb20NCg==

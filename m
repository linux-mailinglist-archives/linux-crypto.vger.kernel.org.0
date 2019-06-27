Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C2586EE
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfF0QXt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 12:23:49 -0400
Received: from mail-eopbgr790042.outbound.protection.outlook.com ([40.107.79.42]:19872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfF0QXt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 12:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=CjUM3t6WzZHRiS0uM9NHv5EVTh/OMEepVAMLPMNtD7jMRtt6LXdy6DMa0jVe0LEPPSDkzExqephHjBs0CFZTZsXktd3sqFXMXSBO2l0DN2Kux449lBX92I3wyh6gDzBwknbcmry+AgOVUsBEprF6pPT7PM52xR6tIUdhdCaTfaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKiIz5lcY4AozxgvRP4T3x+OY3XHXu4Egn3IqCXWjLw=;
 b=xzGsg5zBHmguDViEstYcV2nbk1KCEmg1xTFakTyE/HXgC7wSKWZixSiDe/JRPUfvn9ghEfsN9RkNPpGPCQLIHQ2yrTNEeGcUmel54pXamAsgv7LiGF3hAI+FH+Q36zaYY1bRdyBEHt4LqACM4AVg/BBdc1LkevxkVbuACox1NuU=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKiIz5lcY4AozxgvRP4T3x+OY3XHXu4Egn3IqCXWjLw=;
 b=ZmPSCXY8/0gHgkj5ItkfOmNjFm087CGgXhjY+aRjmltp5/+6wPAB9FGIZWsXP3WNHrQkXtGLiJcq7fKgVz29J6fhIWE7CiCHm3rqRuMK+S9D9umLMRlW2lT8fzrUzDCna/JsC6m8inM7seGM6cKKJesZca/KCo4obd9XLlx4zFA=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5SPR00MB79.namprd12.prod.outlook.com (10.168.199.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:23:29 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::180c:ff0c:37e6:a482]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::180c:ff0c:37e6:a482%10]) with mapi id 15.20.2008.018; Thu, 27 Jun
 2019 16:23:29 +0000
From:   "Hook, Gary" <Gary.Hook@amd.com>
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: [PATCH] crypto: ccp - Switch to SPDX license identifiers
Thread-Topic: [PATCH] crypto: ccp - Switch to SPDX license identifiers
Thread-Index: AQHVLQSnXyD93uDetE6S4kAX2rHe4Q==
Date:   Thu, 27 Jun 2019 16:23:29 +0000
Message-ID: <156165260743.2771.16127676244934163227.stgit@sosrh3.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:805:2a::15) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28347fcd-dd13-4675-8f62-08d6fb1bc9d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5SPR00MB79;
x-ms-traffictypediagnostic: DM5SPR00MB79:
x-microsoft-antispam-prvs: <DM5SPR00MB797DD9D206EF74D82A8809FDFD0@DM5SPR00MB79.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:182;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(14444005)(256004)(5660300002)(486006)(52116002)(66446008)(66556008)(64756008)(66476007)(68736007)(71190400001)(73956011)(66946007)(86362001)(6506007)(2351001)(386003)(316002)(54906003)(71200400001)(476003)(2906002)(53936002)(66066001)(30864003)(99286004)(53946003)(6512007)(186003)(4326008)(8936002)(2501003)(7736002)(14454004)(305945005)(103116003)(102836004)(26005)(6486002)(6436002)(6116002)(25786009)(3846002)(6916009)(5640700003)(72206003)(8676002)(81166006)(81156014)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR00MB79;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RGm9RGiYnC95TuYm5pisNnTp75wVdkLRjOHyGjWiplVUg0zQ37UkmfP/BZrXrVdBYS+Wu6P6kM/QXfJZjaGoJDivXqx+Ml40xBoPW078HOTqFqvvuE0V9aZfqRUakaLlLNphsZ58eaoOjOriS4GEutDHTkRMFJ9iIOxF4dd/PcTk4UGfKTIOjnZvyxdCOSkYx49BRCiasLikrgT5vh8RHa9mrWh92+w4W4TePYe58H7klBz1q8ZzjxJ2kgZy71wpOyvq8rNzFTUrMfIpC5DV/TDDyuApxVYVMVHErvegRPdpWVWpBVjHQfk/3m6FiOrjQhdLJNu87kD4WO7bw0LhDude0T/Yiyi/1hvTDi1k74Yszq6fJebysEqKcqmkQUDQaszfN/KqySuXJnHtIoyD88bZEARPWiI5FaDjkKnOHDo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BA43FECDF079B45A7E74D44DC8BB84F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28347fcd-dd13-4675-8f62-08d6fb1bc9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:23:29.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghook@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB79
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

QWRkIGFuIFNQRFggaWRlbnRpZmllciBhbmQgcmVtb3ZlIGFueSBzcGVjaWZpYyBzdGF0ZW1lbnRz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBHYXJ5IFIgSG9vayA8Z2FyeS5ob29rQGFtZC5jb20+DQotLS0N
CiBkcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1hZXMtY21hYy5jICAgfCAgICA1ICstLS0t
DQogZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tYWVzLWdhbG9pcy5jIHwgICAgNSArLS0t
LQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLWFlcy14dHMuYyAgICB8ICAgIDUgKy0t
LS0NCiBkcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1hZXMuYyAgICAgICAgfCAgICA0IC0t
LS0NCiBkcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1kZXMzLmMgICAgICAgfCAgICA1ICst
LS0tDQogZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tbWFpbi5jICAgICAgIHwgICAgNSAr
LS0tLQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLXJzYS5jICAgICAgICB8ICAgIDUg
Ky0tLS0NCiBkcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1zaGEuYyAgICAgICAgfCAgICA1
ICstLS0tDQogZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8uaCAgICAgICAgICAgIHwgICAg
NSArLS0tLQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGVidWdmcy5jICAgICAgICAgICB8ICAg
IDUgKy0tLS0NCiBkcml2ZXJzL2NyeXB0by9jY3AvY2NwLWRldi12My5jICAgICAgICAgICAgfCAg
ICA1ICstLS0tDQogZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kZXYtdjUuYyAgICAgICAgICAgIHwg
ICAgNSArLS0tLQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGV2LmMgICAgICAgICAgICAgICB8
ICAgIDUgKy0tLS0NCiBkcml2ZXJzL2NyeXB0by9jY3AvY2NwLWRldi5oICAgICAgICAgICAgICAg
fCAgICA1ICstLS0tDQogZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kbWFlbmdpbmUuYyAgICAgICAg
IHwgICAgNSArLS0tLQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9jY3Atb3BzLmMgICAgICAgICAgICAg
ICB8ICAgIDQgLS0tLQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9wc3AtZGV2LmMgICAgICAgICAgICAg
ICB8ICAgIDUgKy0tLS0NCiBkcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5oICAgICAgICAgICAg
ICAgfCAgICA1ICstLS0tDQogZHJpdmVycy9jcnlwdG8vY2NwL3NwLWRldi5jICAgICAgICAgICAg
ICAgIHwgICAgNSArLS0tLQ0KIGRyaXZlcnMvY3J5cHRvL2NjcC9zcC1kZXYuaCAgICAgICAgICAg
ICAgICB8ICAgIDUgKy0tLS0NCiBkcml2ZXJzL2NyeXB0by9jY3Avc3AtcGNpLmMgICAgICAgICAg
ICAgICAgfCAgICA1ICstLS0tDQogZHJpdmVycy9jcnlwdG8vY2NwL3NwLXBsYXRmb3JtLmMgICAg
ICAgICAgIHwgICAgNSArLS0tLQ0KIDIyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyks
IDg4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1j
cnlwdG8tYWVzLWNtYWMuYyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLWFlcy1jbWFj
LmMNCmluZGV4IGY2ZTI1MmMxZDZmYi4uN2IzYWM2MWI2N2RmIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tYWVzLWNtYWMuYw0KKysrIGIvZHJpdmVycy9jcnlwdG8v
Y2NwL2NjcC1jcnlwdG8tYWVzLWNtYWMuYw0KQEAgLTEsMTMgKzEsMTAgQEANCisvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KIC8qDQogICogQU1EIENyeXB0b2dyYXBoaWMgQ29w
cm9jZXNzb3IgKENDUCkgQUVTIENNQUMgY3J5cHRvIEFQSSBzdXBwb3J0DQogICoNCiAgKiBDb3B5
cmlnaHQgKEMpIDIwMTMsMjAxOCBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuDQogICoNCiAg
KiBBdXRob3I6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQotICoNCi0g
KiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQg
YW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQotICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb24uDQogICovDQogDQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLWFlcy1nYWxvaXMuYyBi
L2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLWFlcy1nYWxvaXMuYw0KaW5kZXggY2ExZjBk
NzgwYjYxLi5kMjI2MzFjYjJiYjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NyeXB0by9jY3AvY2Nw
LWNyeXB0by1hZXMtZ2Fsb2lzLmMNCisrKyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRv
LWFlcy1nYWxvaXMuYw0KQEAgLTEsMTMgKzEsMTAgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KIC8qDQogICogQU1EIENyeXB0b2dyYXBoaWMgQ29wcm9jZXNzb3IgKEND
UCkgQUVTIEdDTSBjcnlwdG8gQVBJIHN1cHBvcnQNCiAgKg0KICAqIENvcHlyaWdodCAoQykgMjAx
NiwyMDE3IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4NCiAgKg0KICAqIEF1dGhvcjogR2Fy
eSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZy
ZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNp
b24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0K
ICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2NyeXB0by9jY3AvY2NwLWNyeXB0by1hZXMteHRzLmMgYi9kcml2ZXJzL2NyeXB0by9jY3AvY2Nw
LWNyeXB0by1hZXMteHRzLmMNCmluZGV4IGNhNDYzMGI4Mzk1Zi4uN2E3MzNlMmM0ZTkwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tYWVzLXh0cy5jDQorKysgYi9k
cml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1hZXMteHRzLmMNCkBAIC0xLDMgKzEsNCBAQA0K
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQogLyoNCiAgKiBBTUQgQ3J5cHRv
Z3JhcGhpYyBDb3Byb2Nlc3NvciAoQ0NQKSBBRVMgWFRTIGNyeXB0byBBUEkgc3VwcG9ydA0KICAq
DQpAQCAtNSwxMCArNiw2IEBADQogICoNCiAgKiBBdXRob3I6IEdhcnkgUiBIb29rIDxnYXJ5Lmhv
b2tAYW1kLmNvbT4NCiAgKiBBdXRob3I6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFt
ZC5jb20+DQotICoNCi0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQotICogcHVibGlzaGVk
IGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQogICovDQogDQogI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRv
LWFlcy5jIGIvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tYWVzLmMNCmluZGV4IDNmNzY4
Njk5MzMyYi4uMTE0ZmEwNTg3ZDcyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL2Nj
cC1jcnlwdG8tYWVzLmMNCisrKyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLWFlcy5j
DQpAQCAtNSwxMCArNSw2IEBADQogICogQ29weXJpZ2h0IChDKSAyMDEzLTIwMTkgQWR2YW5jZWQg
TWljcm8gRGV2aWNlcywgSW5jLg0KICAqDQogICogQXV0aG9yOiBUb20gTGVuZGFja3kgPHRob21h
cy5sZW5kYWNreUBhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0K
LSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAqLw0KIA0K
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9j
Y3AvY2NwLWNyeXB0by1kZXMzLmMgYi9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1kZXMz
LmMNCmluZGV4IDkxNDgyZmZjYWM1OS4uNmZmOWRlMWI0NTQ2IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tZGVzMy5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9jY3Av
Y2NwLWNyeXB0by1kZXMzLmMNCkBAIC0xLDEzICsxLDEwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCiAvKg0KICAqIEFNRCBDcnlwdG9ncmFwaGljIENvcHJvY2Vzc29y
IChDQ1ApIERFUzMgY3J5cHRvIEFQSSBzdXBwb3J0DQogICoNCiAgKiBDb3B5cmlnaHQgKEMpIDIw
MTYsMjAxNyBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuDQogICoNCiAgKiBBdXRob3I6IEdh
cnkgUiBIb29rIDxnaG9va0BhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24g
MiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAq
Lw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Ny
eXB0by9jY3AvY2NwLWNyeXB0by1tYWluLmMgYi9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0
by1tYWluLmMNCmluZGV4IGI5NWQxOTk3NGFhNi4uNDRhOTkxN2E0YTZhIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8tbWFpbi5jDQorKysgYi9kcml2ZXJzL2NyeXB0
by9jY3AvY2NwLWNyeXB0by1tYWluLmMNCkBAIC0xLDEzICsxLDEwIEBADQorLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCiAvKg0KICAqIEFNRCBDcnlwdG9ncmFwaGljIENvcHJv
Y2Vzc29yIChDQ1ApIGNyeXB0byBBUEkgc3VwcG9ydA0KICAqDQogICogQ29weXJpZ2h0IChDKSAy
MDEzLDIwMTcgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLg0KICAqDQogICogQXV0aG9yOiBU
b20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1yc2EuYyBiL2RyaXZlcnMvY3J5cHRvL2Nj
cC9jY3AtY3J5cHRvLXJzYS5jDQppbmRleCBhMjU3MGMwYzhjZGMuLmQ5ZWU4ZDM4YzdmYyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLXJzYS5jDQorKysgYi9kcml2
ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1yc2EuYw0KQEAgLTEsMTMgKzEsMTAgQEANCisvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KIC8qDQogICogQU1EIENyeXB0b2dyYXBo
aWMgQ29wcm9jZXNzb3IgKENDUCkgUlNBIGNyeXB0byBBUEkgc3VwcG9ydA0KICAqDQogICogQ29w
eXJpZ2h0IChDKSAyMDE3IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4NCiAgKg0KICAqIEF1
dGhvcjogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1zaGEuYyBiL2RyaXZlcnMvY3J5cHRvL2Nj
cC9jY3AtY3J5cHRvLXNoYS5jDQppbmRleCAzZTEwNTczZjU4OWUuLmJmMmJmYTI2OGJlYyAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtY3J5cHRvLXNoYS5jDQorKysgYi9kcml2
ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by1zaGEuYw0KQEAgLTEsMyArMSw0IEBADQorLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCiAvKg0KICAqIEFNRCBDcnlwdG9ncmFwaGlj
IENvcHJvY2Vzc29yIChDQ1ApIFNIQSBjcnlwdG8gQVBJIHN1cHBvcnQNCiAgKg0KQEAgLTUsMTAg
KzYsNiBAQA0KICAqDQogICogQXV0aG9yOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBh
bWQuY29tPg0KICAqIEF1dGhvcjogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0KLSAq
DQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRl
IGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by5oIGIvZHJpdmVy
cy9jcnlwdG8vY2NwL2NjcC1jcnlwdG8uaA0KaW5kZXggMjg4MTllMTFkYjk2Li5hNGE1OTNkZGRm
ZDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by5oDQorKysgYi9k
cml2ZXJzL2NyeXB0by9jY3AvY2NwLWNyeXB0by5oDQpAQCAtMSwxMyArMSwxMCBAQA0KKy8qIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQogLyoNCiAgKiBBTUQgQ3J5cHRvZ3Jh
cGhpYyBDb3Byb2Nlc3NvciAoQ0NQKSBjcnlwdG8gQVBJIHN1cHBvcnQNCiAgKg0KICAqIENvcHly
aWdodCAoQykgMjAxMywyMDE3IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4NCiAgKg0KICAq
IEF1dGhvcjogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCi0gKg0KLSAq
IFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQvb3IgbW9kaWZ5DQotICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbi4NCiAgKi8NCiANCiAjaWZuZGVmIF9fQ0NQX0NSWVBUT19IX18NCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWRlYnVnZnMuYyBiL2RyaXZlcnMvY3J5
cHRvL2NjcC9jY3AtZGVidWdmcy5jDQppbmRleCA0YmQyNmFmNzA5OGQuLjUxYWM3NmNiYmJjOSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGVidWdmcy5jDQorKysgYi9kcml2
ZXJzL2NyeXB0by9jY3AvY2NwLWRlYnVnZnMuYw0KQEAgLTEsMTMgKzEsMTAgQEANCisvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KIC8qDQogICogQU1EIENyeXB0b2dyYXBoaWMg
Q29wcm9jZXNzb3IgKENDUCkgZHJpdmVyDQogICoNCiAgKiBDb3B5cmlnaHQgKEMpIDIwMTcgQWR2
YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLg0KICAqDQogICogQXV0aG9yOiBHYXJ5IFIgSG9vayA8
Z2FyeS5ob29rQGFtZC5jb20+DQotICoNCi0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2Fy
ZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQot
ICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQogICovDQogDQog
I2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9j
Y3AvY2NwLWRldi12My5jIGIvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kZXYtdjMuYw0KaW5kZXgg
MjQwYmViYmNiOGFjLi4yMzM5YTgxMDFhNTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NyeXB0by9j
Y3AvY2NwLWRldi12My5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWRldi12My5jDQpA
QCAtMSwzICsxLDQgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KIC8q
DQogICogQU1EIENyeXB0b2dyYXBoaWMgQ29wcm9jZXNzb3IgKENDUCkgZHJpdmVyDQogICoNCkBA
IC01LDEwICs2LDYgQEANCiAgKg0KICAqIEF1dGhvcjogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVu
ZGFja3lAYW1kLmNvbT4NCiAgKiBBdXRob3I6IEdhcnkgUiBIb29rIDxnYXJ5Lmhvb2tAYW1kLmNv
bT4NCi0gKg0KLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQotICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCi0gKiBwdWJsaXNoZWQgYnkg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4NCiAgKi8NCiANCiAjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kZXYtdjUuYyBi
L2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGV2LXY1LmMNCmluZGV4IGM5YmZkNGY0MzljZS4uYzc2
YTlmYTExNWI4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kZXYtdjUuYw0K
KysrIGIvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kZXYtdjUuYw0KQEAgLTEsMTMgKzEsMTAgQEAN
CisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KIC8qDQogICogQU1EIENyeXB0
b2dyYXBoaWMgQ29wcm9jZXNzb3IgKENDUCkgZHJpdmVyDQogICoNCiAgKiBDb3B5cmlnaHQgKEMp
IDIwMTYsMjAxNyBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuDQogICoNCiAgKiBBdXRob3I6
IEdhcnkgUiBIb29rIDxnYXJ5Lmhvb2tAYW1kLmNvbT4NCi0gKg0KLSAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQot
ICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2
ZXJzaW9uIDIgYXMNCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bi4NCiAgKi8NCiANCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jcnlwdG8vY2NwL2NjcC1kZXYuYyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGV2LmMN
CmluZGV4IDFiNTAzNWQ1NjI4OC4uZTkwNzNjMDljOGNmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
cnlwdG8vY2NwL2NjcC1kZXYuYw0KKysrIGIvZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1kZXYuYw0K
QEAgLTEsMyArMSw0IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCiAv
Kg0KICAqIEFNRCBDcnlwdG9ncmFwaGljIENvcHJvY2Vzc29yIChDQ1ApIGRyaXZlcg0KICAqDQpA
QCAtNSwxMCArNiw2IEBADQogICoNCiAgKiBBdXRob3I6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxl
bmRhY2t5QGFtZC5jb20+DQogICogQXV0aG9yOiBHYXJ5IFIgSG9vayA8Z2FyeS5ob29rQGFtZC5j
b20+DQotICoNCi0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRp
c3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQotICogcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQogICovDQogDQogI2luY2x1ZGUgPGxpbnV4
L2tlcm5lbC5oPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGV2LmggYi9k
cml2ZXJzL2NyeXB0by9jY3AvY2NwLWRldi5oDQppbmRleCA2ODEwYjY1YzE5MzkuLmE1ZjJmNjVi
YzlmMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZGV2LmgNCisrKyBiL2Ry
aXZlcnMvY3J5cHRvL2NjcC9jY3AtZGV2LmgNCkBAIC0xLDMgKzEsNCBAQA0KKy8qIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQogLyoNCiAgKiBBTUQgQ3J5cHRvZ3JhcGhpYyBD
b3Byb2Nlc3NvciAoQ0NQKSBkcml2ZXINCiAgKg0KQEAgLTUsMTAgKzYsNiBAQA0KICAqDQogICog
QXV0aG9yOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KICAqIEF1dGhv
cjogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkN
Ci0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uLg0KICAqLw0KIA0KICNpZm5kZWYgX19DQ1BfREVWX0hfXw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3J5cHRvL2NjcC9jY3AtZG1hZW5naW5lLmMgYi9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLWRt
YWVuZ2luZS5jDQppbmRleCA2NzE1NWNiMjE2MzYuLjlhZWU2MTlkYjZlNCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvY3J5cHRvL2NjcC9jY3AtZG1hZW5naW5lLmMNCisrKyBiL2RyaXZlcnMvY3J5cHRv
L2NjcC9jY3AtZG1hZW5naW5lLmMNCkBAIC0xLDEzICsxLDEwIEBADQorLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCiAvKg0KICAqIEFNRCBDcnlwdG9ncmFwaGljIENvcHJvY2Vz
c29yIChDQ1ApIGRyaXZlcg0KICAqDQogICogQ29weXJpZ2h0IChDKSAyMDE2LDIwMTcgQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLg0KICAqDQogICogQXV0aG9yOiBHYXJ5IFIgSG9vayA8Z2Fy
eS5ob29rQGFtZC5jb20+DQotICoNCi0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsg
eW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRoZSB0
ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQotICog
cHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQogICovDQogDQogI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9j
Y3Atb3BzLmMgYi9kcml2ZXJzL2NyeXB0by9jY3AvY2NwLW9wcy5jDQppbmRleCBiMTE2ZDYyOTkx
YzYuLmE4MTdmMjc1NWM1OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3Atb3Bz
LmMNCisrKyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9jY3Atb3BzLmMNCkBAIC02LDEwICs2LDYgQEAN
CiAgKg0KICAqIEF1dGhvcjogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4N
CiAgKiBBdXRob3I6IEdhcnkgUiBIb29rIDxnYXJ5Lmhvb2tAYW1kLmNvbT4NCi0gKg0KLSAqIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IgbW9kaWZ5DQotICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbi4NCiAgKi8NCiANCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2NwL3BzcC1kZXYuYyBiL2RyaXZlcnMvY3J5cHRvL2Nj
cC9wc3AtZGV2LmMNCmluZGV4IDY1NjgzODQzM2YyZi4uM2U3MTJmMzg1YmMxIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9jcnlwdG8vY2NwL3BzcC1kZXYuYw0KKysrIGIvZHJpdmVycy9jcnlwdG8vY2Nw
L3BzcC1kZXYuYw0KQEAgLTEsMTMgKzEsMTAgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KIC8qDQogICogQU1EIFBsYXRmb3JtIFNlY3VyaXR5IFByb2Nlc3NvciAoUFNQ
KSBpbnRlcmZhY2UNCiAgKg0KICAqIENvcHlyaWdodCAoQykgMjAxNiwyMDE4IEFkdmFuY2VkIE1p
Y3JvIERldmljZXMsIEluYy4NCiAgKg0KICAqIEF1dGhvcjogQnJpamVzaCBTaW5naCA8YnJpamVz
aC5zaW5naEBhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KLSAq
IHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAqLw0KIA0KICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3Av
cHNwLWRldi5oIGIvZHJpdmVycy9jcnlwdG8vY2NwL3BzcC1kZXYuaA0KaW5kZXggZjVhZmVjY2Y0
MmExLi42YmE1OWZhYWIzYTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRl
di5oDQorKysgYi9kcml2ZXJzL2NyeXB0by9jY3AvcHNwLWRldi5oDQpAQCAtMSwxMyArMSwxMCBA
QA0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQogLyoNCiAgKiBBTUQg
UGxhdGZvcm0gU2VjdXJpdHkgUHJvY2Vzc29yIChQU1ApIGludGVyZmFjZSBkcml2ZXINCiAgKg0K
ICAqIENvcHlyaWdodCAoQykgMjAxNy0yMDE4IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4N
CiAgKg0KICAqIEF1dGhvcjogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0K
LSAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAqLw0KIA0KICNpZm5kZWYgX19QU1BfREVWX0hf
Xw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1kZXYuYyBiL2RyaXZlcnMvY3J5
cHRvL2NjcC9zcC1kZXYuYw0KaW5kZXggYjI4Nzk3NjdmYzk4Li5lYzRmM2JhYmEwNzEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2NyeXB0by9jY3Avc3AtZGV2LmMNCisrKyBiL2RyaXZlcnMvY3J5cHRv
L2NjcC9zcC1kZXYuYw0KQEAgLTEsMyArMSw0IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCiAvKg0KICAqIEFNRCBTZWN1cmUgUHJvY2Vzc29yIGRyaXZlcg0KICAqDQpA
QCAtNiwxMCArNyw2IEBADQogICogQXV0aG9yOiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNr
eUBhbWQuY29tPg0KICAqIEF1dGhvcjogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQuY29tPg0K
ICAqIEF1dGhvcjogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KLSAqDQot
ICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3Avc3AtZGV2LmggYi9kcml2ZXJzL2NyeXB0
by9jY3Avc3AtZGV2LmgNCmluZGV4IDViMDc5MDAyNWRiMy4uYTU0MzI1ZjBkNmE0IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL3NwLWRldi5oDQorKysgYi9kcml2ZXJzL2NyeXB0by9j
Y3Avc3AtZGV2LmgNCkBAIC0xLDMgKzEsNCBAQA0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wICovDQogLyoNCiAgKiBBTUQgU2VjdXJlIFByb2Nlc3NvciBkcml2ZXINCiAgKg0K
QEAgLTYsMTAgKzcsNiBAQA0KICAqIEF1dGhvcjogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFj
a3lAYW1kLmNvbT4NCiAgKiBBdXRob3I6IEdhcnkgUiBIb29rIDxnYXJ5Lmhvb2tAYW1kLmNvbT4N
CiAgKiBBdXRob3I6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCi0gKg0K
LSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5DQotICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCi0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUg
U29mdHdhcmUgRm91bmRhdGlvbi4NCiAgKi8NCiANCiAjaWZuZGVmIF9fU1BfREVWX0hfXw0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1wY2kuYyBiL2RyaXZlcnMvY3J5cHRvL2Nj
cC9zcC1wY2kuYw0KaW5kZXggNDFiY2UwYTNmNGJiLi4yZDE4OTU5NWJmYmUgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2NyeXB0by9jY3Avc3AtcGNpLmMNCisrKyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9z
cC1wY2kuYw0KQEAgLTEsMyArMSw0IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjANCiAvKg0KICAqIEFNRCBTZWN1cmUgUHJvY2Vzc29yIGRldmljZSBkcml2ZXINCiAgKg0K
QEAgLTUsMTAgKzYsNiBAQA0KICAqDQogICogQXV0aG9yOiBUb20gTGVuZGFja3kgPHRob21hcy5s
ZW5kYWNreUBhbWQuY29tPg0KICAqIEF1dGhvcjogR2FyeSBSIEhvb2sgPGdhcnkuaG9va0BhbWQu
Y29tPg0KLSAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBi
eSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by9jY3Avc3AtcGxhdGZvcm0u
YyBiL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9ybS5jDQppbmRleCBkMjQyMjhlZmJhYWEu
LjU1MjU1NDRkZjJmMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY3J5cHRvL2NjcC9zcC1wbGF0Zm9y
bS5jDQorKysgYi9kcml2ZXJzL2NyeXB0by9jY3Avc3AtcGxhdGZvcm0uYw0KQEAgLTEsMTMgKzEs
MTAgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KIC8qDQogICogQU1E
IFNlY3VyZSBQcm9jZXNzb3IgZGV2aWNlIGRyaXZlcg0KICAqDQogICogQ29weXJpZ2h0IChDKSAy
MDE0LDIwMTggQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLg0KICAqDQogICogQXV0aG9yOiBU
b20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLSAqDQotICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLg0KICAqLw0KIA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCg0K

Return-Path: <linux-crypto+bounces-3245-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5176894C15
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Apr 2024 09:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E04284159
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Apr 2024 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F53339B1;
	Tue,  2 Apr 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DePr/9dz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2118.outbound.protection.outlook.com [40.107.8.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2D175BC
	for <linux-crypto@vger.kernel.org>; Tue,  2 Apr 2024 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041393; cv=fail; b=rkLH2fQbPjW8KffrVPXsl+0wGMUydFx/x4dHApTRlJ7dUvYMpYI1HmfklXuuvyo8xY+BZvJeOWsTH+I8ITI0HERJBQ7c911wndNT2y2E2J20x6rgGCPOyQbwTPwqoDwpHvnDGbaz1KD8czdjleyo34EEWJSXiylQYj4Kk1sPGXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041393; c=relaxed/simple;
	bh=jQKtKb59S8m01UtqXiuwR8SQsADoy1rK1L44kviKFAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KoNVxZ1DkRHvHHanPgTuKWUk5oc85V/mxJWNZpmRdLW8/whX4Ux82ZZL38bpDlEPxIqNld32nr/wAi2DcgLJEiKrrIuOvN+qYUJXG+/l7HNokdIBSpGJbLYmnlI++fixHHTwsNux+ojhE5ppaHqdB8qZGuocL1i80yHMk6gAAYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DePr/9dz; arc=fail smtp.client-ip=40.107.8.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB0jTXDwgNqiAfrdgJ/1yFJvUsV0+oWqS0RA0QZnXrErut74/NxoF++jclkbA1AsticC01f2WgMvtWoFzdC5CJaHE3MWzhmaCG+3OUl2ah8NuQvs6wmBkiFX/fG6oktoBJFP+zSirhgAmY8yvRl5lfJwCQ6utsPH0vCgCoN6AeHg5Zs93JrAxtXkv4RTDjZDO0E/f3kJX5gUYTqPRnOKzot/eV0i53Z1TMnIccS/Nm4X/SfBlDHTXp5oinW4j7hPMZVPJvD2VZU38GCX0BBiafGT8BxaMK++R1YzjMIINtMaYufZdpHG/8KuxDNLcvdUt+DFGP/nSnVHPAbxPaK45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQKtKb59S8m01UtqXiuwR8SQsADoy1rK1L44kviKFAQ=;
 b=fo5LxpsBazn1K6J51RzZbTIoNDBjg+vVXQJQadVq6rra3Mw2za2zHnw0cUCkCEXMt9LTr/WuXfzwzeC32JRihrGPbeAJ36Hm7nX/cidXzXPehC5cVNXaMMOZHKG2XieiiavlEYtjwEpXhaZEYA/6x+9tPMtFNXfOBnInJnbtv0fU76On7LK7wPF4Y+5Hu/iWp9Rth2z+9T5BnrTwS6wuFQKRWhwoOmXMNmfZ71Qm6PtwxbTiV5RbYiM3SllzBixVLHuAu7a703Bv51emHnXz4UtE4C6D0D981BXKw5a7xmJiejl0FkxD1XMsBGtRZ/CshuSIOvGPzaESXdDXgmmLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQKtKb59S8m01UtqXiuwR8SQsADoy1rK1L44kviKFAQ=;
 b=DePr/9dzfy2XkJbbYTEfp0OoL4ZyUlkkQ676gyo7BTbegOpBgVIPY+Q7d8xa80W5LamivHOmGZrJI3O0swk/DZ4frqG02nVMpWbxwWM5lvHBdO0uf2SnIhU5ojB9DxcRD4Fj2tSL4GWnO1vEG1cn3qowfA4J2QUPjRKbg5EdRV0=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by DBBPR04MB7884.eurprd04.prod.outlook.com (2603:10a6:10:1f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 07:03:07 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 07:03:07 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Horia Geanta
	<horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Linux Crypto
 Mailing List <linux-crypto@vger.kernel.org>, Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] caam test failures with libkcapi
Thread-Topic: [EXT] caam test failures with libkcapi
Thread-Index: AQHaNIUs5x+vRqPNKUaISMpgxN6Xu7C1H2qwgAHHygCAESHn8IABYFoAgIu9YkA=
Date: Tue, 2 Apr 2024 07:03:06 +0000
Message-ID:
 <AM0PR04MB6004DD14719CD56D86DB32CEE73E2@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <ZYT/beBEO7dAlVO2@gondor.apana.org.au>
 <AM0PR04MB6004FDAC2B2C0B4D41A92A89E794A@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <CAFqZXNtb1hErawH30dN4vgGPD0tQv9Rd+9s26MBaT3boRYtPCA@mail.gmail.com>
 <AM0PR04MB6004F095D6800C4BC99E5C4FE760A@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <CAFqZXNs-QzXFm+cLN62LrpPjb_R3DqJHgM_yjrOkzen8LEgS9A@mail.gmail.com>
In-Reply-To:
 <CAFqZXNs-QzXFm+cLN62LrpPjb_R3DqJHgM_yjrOkzen8LEgS9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|DBBPR04MB7884:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h+KHkq3/nGMCXvNiM3EEuMNegkMnQ3i4LCtCHf4pP6orxVhFa/qyrtu6VGNafEFd5K07vg7qvmEDgGy9wbqwJfQ2blWK33bHDLBAaxcc/2iX5VdwF7Wl9RyIJGqN+9gULRtA1ZXVVIXmuHHaYuwbBzCVq5TzD3BlAQ8Z9s2kX/iIn4EBMh4Gr3qvdz4PudiOrTzue8OPZQWqpZgDo1H7S/Qpvp3HzY1+ZMD+vGEPxNVX1vy58UZ4jcwb7NnQ9ukzAaNMI/SkEMBDJ0ozzJDWUoA3jGoYvxKNg4FsAidLOxtuxqa0kwvSweibMOWZanpZqrJY6xbUp994yerUlMJSjFnB62q4ywxFMyJ5YVMhUNa0A7H8WTuwDnpDH2ucqolmfEx8KZcpXRbAGS9REUJ4jqEZ2ErWfHFSE8Zd+sNCuVLj/zQh+UJtDFAf4sI3dAFC4+NDWRMv6VXGBoWiA/UBnuiJP+/59zgtZF5kVPXHxtf1qjdRWOQJ6cEYBToWiCfOxyMOl5/a09aNgpgVnDuQpwyT8mZocSWo1H4HCf5kRD8BTJ6dAxGz934Fe4o0d/2E8JWnU66+PK5JdFtCVqkQPbqF/XCTqhocZinhe1wV2Xms0hesvodA3JBfEbkbpMj3TD29mVNYPT0T8BHNTG906XvkL0SlAPSZepWxeFX3Y8s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ei9sTW91U0N4UERERmtEQUpKTmlxMXlzQThKTjlKMlRFREtUN3NZRDFua3lG?=
 =?utf-8?B?cE1jY2NSM3RVV1NEQ29RV21LbHIrNTU4bmJYQnBTZHFVY2UwdUZkc3AyRHhX?=
 =?utf-8?B?dXYrSGUrZmR4WVVlbzZ0UlJ3VnBSa3F1ZXZnVWJYNjY1N0xUc08rcnMrUW5W?=
 =?utf-8?B?QTFmZzZLQ2pZYi9ENFM0dklWbWRLQVA1QmIvSXoyWHhiR2hMTDAvSnk5c042?=
 =?utf-8?B?cS9pUlZmZlh1OU1meFE0L3EzU2YrSEcrR3ZUb01jand1a1g4MDRzTXZCYXU1?=
 =?utf-8?B?TlIzNHczVldlSXZyazRkdWFRVWQ4ZlZ1czFDMHQrOGFqUVhiemdtTm9LUSt5?=
 =?utf-8?B?U3U0VW1uTmxMbDNLN0RCOUxNRGZLbHBmcXM0R2Vmc256ZW5YK0N1c1dZVlcx?=
 =?utf-8?B?WENuZmdOUlY4aldBQWxlUEtIOXY3a3JIYmQvbjZYZXJSd0p3VzRBNStmNFlu?=
 =?utf-8?B?R242ZjYvMUZ5d0tjVWsweVNkQWd6eTgwa3dCOHQxUXZZQ1BCU2tvZUN0YURj?=
 =?utf-8?B?QVQzd2dvb2JNQjRlQUZXTDRYQ0loTFBpQ2hYQzJ6MHdRcFBaNHlTZ1BwaW50?=
 =?utf-8?B?S3lYaythU0xWM09pclZ5Ni8zdVhkSVgwRFl0cmtGVm1BK3ZKZEltUHJoK2x5?=
 =?utf-8?B?bjRYR1pCd0VJdlB5UVVQaFh1VEdiaXZnejNHMDN6c1ZqcElmNEg1dmdpUmJR?=
 =?utf-8?B?YW5NL045dmRqeE5sekZNaWlIbk9QK0gvN0QyaGNMZmpHS3dVOTM3eFB1Unps?=
 =?utf-8?B?Q2ZJMzRqK2xxTXlGYXg2dlVOcXYrdmtqdjFqN25RcHJWbEYxTCsxRTBvQWJG?=
 =?utf-8?B?OEMvd09udTZSTVpUa1NPaXlsVDZpZXZRUnl3eUM4NHdSWUdWR0xCYnZ1MGxr?=
 =?utf-8?B?blZBajlObDdDQzdwQ0g2L0p5bTlRL1E0Zk5DeGhYemVMWW8zL0RRU0VXWlVV?=
 =?utf-8?B?WkYweUhkdFo2eUFQSzlsdEhlR3lUS2dPQWh2OEI1OTJNK2xPNXpkVVllZzZs?=
 =?utf-8?B?SEdZK09sREJEaFIxbklRL005ZldUc1RyYWZEUXNSMzBJampNQlBMakI1Rm9x?=
 =?utf-8?B?QXR3Y0dmOUtlMGZPSG00WDlJT0ZWSFlwVW9TS1pTc3RHekZkdS9iTVE4NUtz?=
 =?utf-8?B?czNVVUhzQkk3TVppTGx5UTY2dzNaNUc0TyttWE1IQ1VkS0tzNUl4b0tzb1ha?=
 =?utf-8?B?ZUpOZWU2NzlzTEd6QUgvT1AvOXJzMGVaVHVNM0p1S3JTbmhhNksyYjRoVTBQ?=
 =?utf-8?B?dmxZRnhPZmJQNEcvK0dxLzQzcnA4TGxSV0VzdVlRS0FBd1J2enZsN204aFdC?=
 =?utf-8?B?TDhmVjYxaldueENHcXVwbko1d1oyMDVnUURzblpUQjNkZG93NVVHODRqRXlO?=
 =?utf-8?B?VDh2Rkw1MkRJRFMyRUM0d3d5TXFOMGtRM2tmZkxNMVJtdzl0M2dxSUJQenZu?=
 =?utf-8?B?UERleVNRWW5wcDZiRUZEdkoxN3V1ejFRSHcwZ1F4dHdIRFUxaTI3N09ZMlNB?=
 =?utf-8?B?aDl6UUxMQVFzSnZlK3UybFFNU2dhQW4zZmpSNFVybFFiU1hTbWhaSmtFd1N6?=
 =?utf-8?B?TE8yTnNId0VjR3VZMFlxWkwzMXVaQ1dDNUErU1cyeXZLS3JUU1E3RzQyOUla?=
 =?utf-8?B?M0JTL2J0bENqZ3RhM3pJMkVSbVVhZlg5QkU3cC9hZkRDbXQydDhTazhrazNL?=
 =?utf-8?B?L00vcVFIc3dCZWZSWjRSQ25MM2RmU0lsTGRQbDY0c3ZQdTRnMXRqMXltRHp1?=
 =?utf-8?B?OUlQZXpJSmY3TUJHZjVvZkhLQ0hGZ1dHOU9xZFNZSVJpV0xtai95R1E4S3dQ?=
 =?utf-8?B?alU0ZHJKVno2UW5rVmlmd2libm1XaGJVemVFRmpGaGlsUkxVM0VZQjVCWjlT?=
 =?utf-8?B?YURjYVRtcXdiSElrZ1FCYmtUdVdvM3FqdEdSZ1l1TWhpMUYrMHVOVEU3dC9i?=
 =?utf-8?B?cmZDSGZyUUFEcnQ0OGE0dWtmMGtUVlVDYTZjSHZuVUozc0huelhTZkljaWhH?=
 =?utf-8?B?eGV5bDVKTjhRQTNxVktqS0hrNTBmY1l2bWNaWXMxUnlreFdMRVhmdXhDK0dO?=
 =?utf-8?B?RlZlTjZOa3FBcm1GUnpmSGFqSTgvaDAxWVJXZjdaaDhDM1VyeUphU0FDS2lC?=
 =?utf-8?Q?+KPTxUAj3uZHz6h3WYZPqRkzr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcac2186-6073-4c1d-1f04-08dc52e2f2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 07:03:06.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2JftM+juG7pZyRVQ49iuGKSyHbrR4Jmu6o5xD9wRJnGFo9Ae9DCREUwsbSWAEb55MPWHMDjJMsySt3/qyI71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7884

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbmRyZWogTW9zbmFj
ZWsgPG9tb3NuYWNlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDQsIDIw
MjQgMjowNyBQTQ0KPiBUbzogR2F1cmF2IEphaW4gPGdhdXJhdi5qYWluQG54cC5jb20+DQo+IENj
OiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+OyBIb3JpYSBHZWFudGEN
Cj4gPGhvcmlhLmdlYW50YUBueHAuY29tPjsgUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhw
LmNvbT47IExpbnV4IENyeXB0bw0KPiBNYWlsaW5nIExpc3QgPGxpbnV4LWNyeXB0b0B2Z2VyLmtl
cm5lbC5vcmc+OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTog
W0VYVF0gY2FhbSB0ZXN0IGZhaWx1cmVzIHdpdGggbGlia2NhcGkNCj4gDQo+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBs
aW5rcyBvciBvcGVuaW5nDQo+IGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcNCj4gYnV0dG9uDQo+IA0KPiAN
Cj4gT24gV2VkLCBKYW4gMywgMjAyNCBhdCAxMjo1MOKAr1BNIEdhdXJhdiBKYWluIDxnYXVyYXYu
amFpbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBPbmRyZWogTW9zbmFjZWsgPG9tb3NuYWNlQHJlZGhh
dC5jb20+DQo+ID4gPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMjMsIDIwMjMgNzoyOSBQTQ0K
PiA+ID4gVG86IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KPiA+ID4gQ2M6IEhl
cmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT47IEhvcmlhIEdlYW50YQ0KPiA+
ID4gPGhvcmlhLmdlYW50YUBueHAuY29tPjsgUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhw
LmNvbT47IExpbnV4DQo+ID4gPiBDcnlwdG8gTWFpbGluZyBMaXN0IDxsaW51eC1jcnlwdG9Admdl
ci5rZXJuZWwub3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IFtFWFRdIGNhYW0gdGVzdCBmYWlsdXJl
cyB3aXRoIGxpYmtjYXBpDQo+ID4gPg0KPiA+ID4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5h
bCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nDQo+ID4gPiBsaW5rcyBvciBv
cGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UNCj4g
PiA+IHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiA+ID4NCj4gPiA+DQo+
ID4gPiBPbiBGcmksIERlYyAyMiwgMjAyMyBhdCAxMTo1MOKAr0FNIEdhdXJhdiBKYWluIDxnYXVy
YXYuamFpbkBueHAuY29tPiB3cm90ZToNCj4gWy4uLl0NCj4gPiA+ID4gQ2FuIHlvdSBwbGVhc2Ug
c2hhcmUgdGhlIGxvZ3MgZm9yIGxpYmtjYXBpIHRlc3QgZmFpbHVyZXMuDQo+ID4gPg0KPiA+ID4g
QSBsb2cgZnJvbSBvdXIga2VybmVsIENJIHRlc3RpbmcgaXMgYXZhaWxhYmxlIGhlcmUgKGl0IGlz
IGZyb20NCj4gPiA+IENlbnRPUyBTdHJlYW0gOSwgYnV0IGl0IGZhaWxzIGluIHRoZSBzYW1lIHdh
eSBvbiB0aGUgRmVkb3JhJ3MNCj4gPiA+IDYuNi42LWJhc2VkDQo+ID4gPiBrZXJuZWwpOg0KPiA+
ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGczMNCj4gPiA+IC5hbWF6JTJGJmRhdGE9MDUlN0MwMiU3Q2dhdXJhdi5qYWlu
JTQwbnhwLmNvbSU3Q2IwNWRiYmY5YzBkODQ4YQ0KPiBmNWJlZg0KPiA+ID4NCj4gMDhkYzBkMDA2
YjU5JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODM5OQ0K
PiA1NDI2DQo+ID4gPg0KPiA0ODA2OTQyNiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpv
aU1DNHdMakF3TURBaUxDSlFJam9pVjJsDQo+IHVNekkNCj4gPiA+DQo+IGlMQ0pCVGlJNklrMWhh
V3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPXlrcEYlMkJNJQ0KPiAyQkRX
ag0KPiA+ID4gdzZHSE42MTY1a0xlN2M4V0ZSSlNTTFRmV2QlMkZxTHhJOXclM0QmcmVzZXJ2ZWQ9
MA0KPiA+ID4gb25hd3MuY29tJTJGYXJyLWNraS1wcm9kLXRydXN0ZWQtYXJ0aWZhY3RzJTJGdHJ1
c3RlZC0NCj4gPiA+DQo+IGFydGlmYWN0cyUyRjExMDkxODA4NzQlMkZ0ZXN0X2FhcmNoNjQlMkY1
NzY2NDE0NzI0JTJGYXJ0aWZhY3RzJTJGcnVuDQo+ID4gPiAuZA0KPiA+ID4NCj4gb25lLjAzJTJG
am9iLjAxJTJGcmVjaXBlcyUyRjE1MTk0NzMzJTJGdGFza3MlMkYzMSUyRmxvZ3MlMkZ0YXNrb3V0
LmwNCj4gPiA+DQo+IG9nJmRhdGE9MDUlN0MwMiU3Q2dhdXJhdi5qYWluJTQwbnhwLmNvbSU3QzNi
NTJhODM0NDliZjRiM2ZmZmUyMDhkYw0KPiA+ID4NCj4gMDNiZjRiNjYlN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4Mzg5MzY3Mw0KPiA+ID4NCj4gMzgwNzI3
MDklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bA0KPiA+ID4NCj4gdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdD
JTdDJTdDJnNkYXRhPTlTQ0ZpVA0KPiA+ID4gMW5Oc1RaZzRiaDZuNzVDZWljREM1MUp3M3dhY1FD
YUw3dzR2USUzRCZyZXNlcnZlZD0wDQo+ID4NCj4gPiBJbiB0aGlzIGxvZyBJIGNhbm5vdCBzZWUg
Q0FBTSBmYWlsdXJlcy4gY2FuIHlvdSB0ZWxsIHdoaWNoIENBQU0gdGZtIGZhaWxlZD8NCj4gDQo+
IFRoZSB0ZXN0IGV4ZXJjaXNlcyB0aGUga2VybmVsIGNyeXB0byBBUEkgdmlhIHRoZSBBRl9BTEcg
aW50ZXJmYWNlLiBUaGUgZmFpbHVyZXMNCj4gYmFzaWNhbGx5IGRldGVjdCB0aGF0IGZvciBjZXJ0
YWluIGlucHV0cyB0aGUgY3J5cHRvIEFQSSByZXR1cm5zIGRpZmZlcmVudCByZXN1bHRzDQo+IHRo
YW4gZXhwZWN0ZWQgd2hlbiB0aGUgQ0FBTSBkcml2ZXIgaXMgdXNlZCAodGhlIG1hY2hpbmUgaW4g
cXVlc3Rpb24gaGFzIHRoZQ0KPiByZWxldmFudCBoYXJkd2FyZSwgc28gdGhlIGNhYW1fanIgY3J5
cHRvIGRyaXZlcnMgYXJlIHJlZ2lzdGVyZWQgZm9yIGNlcnRhaW4NCj4gYWxnb3JpdGhtcyBhbmQg
dGhleSB0YWtlIHByaW9yaXR5KS4NCj4gDQo+IEZvciBleGFtcGxlLCB3aGVuIHlvdSBpbnN0YWxs
IGxpYmtjYXBpLXRvb2xzIGFuZCBydW46DQo+IA0KPiBrY2FwaSAteCAyIC1zICAtZSAtYyAiZ2Nt
KGFlcykiIC1pIDE2YzRiNGJkMTE5OGYzOWY0YWU4MTdiNyBcDQo+ICAgICAtayA4N2M5MWE4YjYz
ZjY2OTM0ZGQzNzAzNDE1YjI1Mzg0NjFmYmZlZjU1Y2U3YTljYTliYjk0MjU0OTlmNGNkMWQ2DQo+
IFwNCj4gICAgIC1hDQo+ICIzMDNiYjU3ZTQ1MzRiMDhhNGQ1ZjAwMWE4NGIzMDUyYzlkMGQ1OGVl
MDNlZGE1MjExYTU0MDk1MGU4MTlkYyIgXA0KPiAgICAgLXAgImIwNWZiZDQwM2MyZmE0MWE4Y2M3
MDJhNzQ3NGVkOWJhNmM1MGZjYzZjMTk3MzJhN2QzMDBmMTExMzg2MmJjIg0KPiAtbCA0DQo+IA0K
PiAuLi50aGUgY2FhbV9qciBpbXBsZW1lbnRhdGlvbiByZXN1bHRzIGluDQo+IGIwNWZiZDQwM2My
ZmE0MWE4Y2M3MDJhNzQ3NGVkOWJhNmM1MGZjYzZjMTk3MzJhN2QzMDBmMTExMzg2MmJjNmQyNzUN
Cj4gNmQ2LA0KPiB3aGlsZSB0aGUgZXhwZWN0ZWQgb3V0cHV0IGlzDQo+IDliZWE1MjYzZTdiMzY1
ZDVhMDZjYjNjY2FiMGQ0M2NiOWExY2E5NjdkZmI3YjFhNjk1NWIzYzQ5MzAxOGFmNmQyNzUNCj4g
NmQ2Lg0KPiBZb3UgY2FuIHNlYXJjaCB0aGUgdGVzdCBsb2cgZm9yICJGQUlMRUQiIHRvIGZpbmQg
dGhlIG90aGVyIGZhaWxpbmcgY29tbWFuZHMgKG5vdGUNCj4gdGhhdCBpbiBzb21lIGNhc2VzIHlv
dSBuZWVkIHRvIGVzY2FwZSB0aGUgLWMgYXJndW1lbnQgYXMgaXQgY29udGFpbnMNCj4gcGFyZW50
aGVzZXMpLg0KDQpXZSBoYXZlIGRldmVsb3BlZCBhbiBhcHBsaWNhdGlvbiB0byBydW4gdGhlIGdj
bShhZXMpIGFsZ29yaXRobSB3aGljaCBpcyBvZmZsb2FkZWQgdG8gY2FhbV9qciBkcml2ZXIgdmlh
IEFGX0FMRyBpbnRlcmZhY2UuDQp3ZSBoYXZlIHVzZWQgdGhlIGJlbG93IHRlc3QgdmVjdG9yDQpQ
bGFpbnRleHQgaXMgImIwNWZiZDQwM2MyZmE0MWE4Y2M3MDJhNzQ3NGVkOWJhNmM1MGZjYzZjMTk3
MzJhN2QzMDBmMTExMzg2MmJjIiAtPiAzMSBieXRlDQpLZXkgaXMgIjg3YzkxYThiNjNmNjY5MzRk
ZDM3MDM0MTViMjUzODQ2MWZiZmVmNTVjZTdhOWNhOWJiOTQyNTQ5OWY0Y2QxZDYiIC0+IDMyIGJ5
dGUNCkl2IGlzICIxNmM0YjRiZDExOThmMzlmNGFlODE3YjciIC0+IDEyIGJ5dGUNCkFhZCBpcyAi
MzAzYmI1N2U0NTM0YjA4YTRkNWYwMDFhODRiMzA1MmM5ZDBkNThlZTAzZWRhNTIxMWE1NDA5NTBl
ODE5ZGMiIC0+IDMxIGJ5dGUNCg0KT3VyIGFwcGxpY2F0aW9uIHJlc3VsdHMgbWF0Y2hlcyB0aGUg
ZXhwZWN0ZWQgY2lwaGVydGV4dCB3aGljaCBpcyAiOWJlYTUyNjNlN2IzNjVkNWEwNmNiM2NjYWIw
ZDQzY2I5YTFjYTk2N2RmYjdiMWE2OTU1YjNjNDkzMDE4YWY2ZDI3NTZkNiIuDQpJIGNhbiBzZWUg
dGhlIGV4cGVjdGVkIG91dHB1dCBhdCB5b3VyIGVuZCBpcyBiYXNpY2FsbHkgdGhlIHBsYWludGV4
dCBhcHBlbmRlZCBieSBhdXRoZW50aWNhdGlvbiB0YWcgb2YgNCBieXRlcyAiNmQyNzU2ZDYiLg0K
Y2FhbV9qciBkcml2ZXIgYWVzLWdjbSBpbXBsZW1lbnRhdGlvbiBpcyBwcm92aWRpbmcgdGhlIGNv
cnJlY3Qgb3V0cHV0Lg0KDQpSZWdhcmRzDQpHYXVyYXYgSmFpbg0KPiANCj4gLS0NCj4gT25kcmVq
IE1vc25hY2VrDQo+IFNlbmlvciBTb2Z0d2FyZSBFbmdpbmVlciwgTGludXggU2VjdXJpdHkgLSBT
RUxpbnV4IGtlcm5lbCBSZWQgSGF0LCBJbmMuDQoNCg==


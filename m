Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2712806B4
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Oct 2020 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgJASgo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 1 Oct 2020 14:36:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40644 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729047AbgJASgi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 1 Oct 2020 14:36:38 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091IYSEh012937;
        Thu, 1 Oct 2020 11:36:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DqOpXEqGe+yFhlHsirVc94kbUCGMzmzAbdLR+o7VRFU=;
 b=XHOticLI41/4R81qsMItETIq+1Ey8oWZbyroN+uTMRqxuLFwt9UP3QAWnza1BJShrAko
 YtRY6q9NbWWz8lmsPwuDMRKLNqq2PwhYS383pcpCos+pnkQ/SVQBSJJNjIhIAWzh2jlt
 gJHGIdmE8DZPmcMD7KqWlECgQuj26uMx46Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33wmda81rc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 11:36:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 11:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5jftX9n4kMOG8848NUvfqwk9KwXEULxxE7EreJSaT1mTmtT7YGb7MaNIeEqGeDUxgB0N75OezArHDbPwxXaagkRkJHbnGOmkD9wZAnFkxHPBkgY5XMHKOftrnHk6PhQpHgmyERZoP0SFE1TYMk5XQ2Up1YE54kIMS5Vs2NQtGFJLlMa5wFBlBhBSxiY8oYryKsvMmDdrUF3uu4XtPzzrldxLHLJrEr9mBRMviZeMROlHr+lMabrQ1KYOo7oyau6jdG7Pha9HttSLQFvYeuj+/9RijUsLuYwMtvQhfq+3t85u9D1wDxJw1TOQ03VGL42qz3Wr1zNOUzeeKE6jo2CJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqOpXEqGe+yFhlHsirVc94kbUCGMzmzAbdLR+o7VRFU=;
 b=emSdPH198i1XPJwpb3YDy1lZYP/0fazW4311K7cKWu/5j+s13NJiFsRNNQeclDQeRx++9unqXXviqp0p0DiAuTvUQRfsQL0JHOLRX2mX6ph3wJheUxL9feQDBWW4ATdadxeowwEm8VO4So1VQyqja5e0mvzmZ0zVRJROQtyBr2csjnjmJsJwFVvPB7ftjwN7dMmFqmQR+da0jCGdew/Oap1+CKWdbKpEsBEiwZwNL1k2NTz9M3KNoPn1Ql34X1966sXEnocUa/Gg6dpKMQdYkryIINGFBDNF18nhJ+pXhYktYXvjecE/uYurlzu/lzZGdoX9lnoT+xPryD50AmHxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqOpXEqGe+yFhlHsirVc94kbUCGMzmzAbdLR+o7VRFU=;
 b=FF1vCJ9HcSUgaKGdIsxOppsmUndLTOfa7/z1oEAuHQ4v0PXyoNvPLyIrf//E48tayERQz1W1zF2Q5wapj8sdwD1pPwLi7skv2WeZhPgYzQmyTp4g95Nt56tHaM5FiEn+/srXAGZ+kIZYYNFWdbY5wCe1vd1GTwy9WX6xbdLMRuc=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 1 Oct
 2020 18:35:34 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c%7]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 18:35:34 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL][PATCH v4 0/9] Update to zstd-1.4.6
Thread-Topic: [GIT PULL][PATCH v4 0/9] Update to zstd-1.4.6
Thread-Index: AQHWlvXiaMJXVTfuy0uJI/ZnL66KB6mBqI2AgADh9YCAAIrcgA==
Date:   Thu, 1 Oct 2020 18:35:34 +0000
Message-ID: <D369584C-5BA4-4C08-BFE9-8DB79A05CC31@fb.com>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
 <293CD1BC-DBED-4344-AC84-C85E0DD7914D@fb.com>
 <20201001101833.GT6756@twin.jikos.cz>
In-Reply-To: <20201001101833.GT6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91216c9a-e225-4cc3-f7b7-08d86638c8cf
x-ms-traffictypediagnostic: BY5PR15MB3668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3668C6F6C191228C5D79E8A1AB300@BY5PR15MB3668.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+GeBGg02XMwel+NTztyNHwBQ1u6j+dUp1U+FrTsSJllbfkSOOAA+yWFn0KuyV2DfaLLCQM5Djx1wix1fWTu48lTAPF+7Qn/tlM4slbpGeOC6TfH6DuMdAVNe5pXFEBFNKhJjjomgMBPVd9n/UkZUS7Ooe/j5IpXqTRb1xcWWmVLDJ0EjpjMutOD+wjVpfk0QGol62Gphy2o5AmATR1G92nk5DXnqMw52YD7ee4dikhqwniDxIph1whxOC5HDpiQ7KIddNowuBC6XIQGYU14oLP+xwl+4ewFDtN/DKvfK9WBsuLovgNaZS2PCX4dNaNMfYNNdcfN/phmvHxaCIqPiSzvkfJeR6lxthEnnUkpfdsN+WXfykFrPBYluRNiJvSnixX0ZVzpkIS1xJG+78Jvin21cAbiYncqqzjJc7aWWM93rFj7ZXH1oTOoe/RyRrSd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(478600001)(6506007)(2616005)(83380400001)(186003)(71200400001)(15650500001)(26005)(54906003)(5660300002)(36756003)(316002)(8936002)(53546011)(6486002)(6916009)(66556008)(86362001)(2906002)(66946007)(4326008)(6512007)(7416002)(966005)(66476007)(66446008)(64756008)(8676002)(33656002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7yBEjiBrvfImHo1wwga3356hbeeb0SeNK9zZrJ2bWCQH6jYNtbgPFd55HmP5swER5BlwPGXeKEOTy+f9Oy5xBNCjTCjbGtgO2SuFdamnsip3iOawhWEnMifLdjHK2hGlL3NZSa9jteVbslqYxe+RcGZ73qQTe/MR5ab7murfT+yX1OvqMRQWmTWeVm0p5h/HzIBG2PX8uu1T+VrmZ0pffBIAZMxw68e1dFPBXXWuKDfAMsyLpqMQEPzD2tBa94WTce3gkOFnZhjkoKLWauxrsDUmL6gtZJNSfB2awZoaGS7YRSiV8STfS9jZPOms90akJnmnl/I/++kUJj3zK4vW79/ZkMuR6C3bsDuaZyIrZgtR/3FtvHH32kk0ZVATTwO9lLnFzhcXVLXzB14vmhJIjobvwL1qU0ye0CeqUCD5IGOQYM8r5uw8bNm9kZ3CAD8FyIgus2ii6DgVqgveWZj5OSFM2hgpIir7neOJVjPAzkZLEDi+QxMdURBqqg/2nac+/GA6bg7Q5z6WZNG26sXN9u+ojNC9/i482sf1Fk0sBBUyzcg7SXoOYhc/WAC/9Y/h1fGYaHu3DXrGUVtJvZUOfKjav84sZQcuQ0vI7jw7ZyMLChnssOna6/Vckw/Wvp9E6aGjGlI0h/RDB2DV3cy4tA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <31F0E435D595A945843E43CEED4595C7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91216c9a-e225-4cc3-f7b7-08d86638c8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 18:35:34.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rpv+FWqNdlgdXwv94eobvcrRNyS7LkHj7iyAQQ0+Y13yHDkD92Yqnf4nVv5raa+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_07:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

DQoNCj4gT24gT2N0IDEsIDIwMjAsIGF0IDM6MTggQU0sIERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBz
dXNlLmN6PiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDA4OjQ5OjQ5UE0g
KzAwMDAsIE5pY2sgVGVycmVsbCB3cm90ZToNCj4+PiBPbiBTZXAgMjksIDIwMjAsIGF0IDExOjUz
IFBNLCBOaWNrIFRlcnJlbGwgPG5pY2tydGVycmVsbEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IEZyb206IE5pY2sgVGVycmVsbCA8dGVycmVsbG5AZmIuY29tPg0KPj4gDQo+PiBJdCBoYXMg
YmVlbiBicm91Z2h0IHRvIG15IGF0dGVudGlvbiB0aGF0IHBhdGNoIDMgaGFzbuKAmXQgbWFkZSBp
dCB0byBwYXRjaHdvcmssDQo+PiBsaWtlbHkgYmVjYXVzZSBpdCBpcyB0b28gbGFyZ2UuIEnigJls
bCBpbmNsdWRlIGEgcHVsbCByZXF1ZXN0IGluIHRoZSBuZXh0IGNvdmVyIGxldHRlciwNCj4+IHRv
Z2V0aGVyIHdpdGggdGhlIHBhdGNoZXMgKGlmIG5lZWRlZCkuDQo+IA0KPiBUaGUgcGF0Y2ggMy85
IHNhdmVkIHRvIGEgZmlsZSBpcyAxLjZNLCBvdmVyIDM1MDAwIGxpbmVzLCB0aGUgZGlmZnN0YXQN
Cj4gc2F5czoNCj4gDQo+IDY2IGZpbGVzIGNoYW5nZWQsIDI0MjY4IGluc2VydGlvbnMoKyksIDEy
ODg5IGRlbGV0aW9ucygtKQ0KPiANCj4gU2VyaW91c2x5LCB0aGlzIGlzIHdyb25nIGluIHNvIG1h
bnkgd2F5cy4gVGhlcmUncyB0aGUgcmF0aW9uYWxlIGZvcg0KPiBvbmUtdGltZSBjaGFuZ2UgZXRj
LCBidXQgdGhlIGFjdHVhbCByZXN1bHQgaXMgYmV5b25kIHdoYXQgSSB3b3VsZCBhY2NlcHQNCj4g
YW5kIHdvdWxkIG5vdCBlbmNvdXJhZ2UgYW55b25lIHRvIG1lcmdlIGFzLWlzLg0KDQpJ4oCZbSBv
cGVuIHRvIHN1Z2dlc3Rpb25zIG9uIGhvdyB0byBnZXQgYSB6c3RkIHVwZGF0ZSBkb25lIGJldHRl
ci4gSSBkb27igJl0DQprbm93IG9mIGFueSB3YXkgdG8gYnJlYWsgdGhpcyBwYXRjaCB1cCBpbnRv
IHNtYWxsZXIgcGF0Y2hlcyB0aGF0IGFsbCBjb21waWxlLg0KVGhlIGNvZGUgaXMgYWxsIGdlbmVy
YXRlZCBkaXJlY3RseSBmcm9tIHVwc3RyZWFtIGFuZCBtb2RpZmllZCB0byB3b3JrIGluIHRoZQ0K
a2VybmVsIGJ5IGF1dG9tYXRlZCBzY3JpcHRzLg0KDQpJIHRoaW5rIHRoZSBiZW5lZml0cyBvZiB1
cGRhdGluZyB6c3RkIGFyZSBwcmV0dHkgY2xlYXI6IGJ1ZyBmaXhlcywgMyB5ZWFycyBvZiB0ZXN0
aW5nLA0KZmVhdHVyZXMsIGRlYnVnZ2FiaWxpdHksIHN1cHBvcnQgZnJvbSB6c3RkIHVwc3RyZWFt
LCBhbmQgc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UNCmltcHJvdmVtZW50cy4NCg0KU28gSSBob3Bl
IHdlIGNhbiBjb21lIHVwIHdpdGggYSB3YXkgZm9yd2FyZCB0byBnZXQgdGhpcyBtZXJnZWQuDQoN
ClRoaXMgbGFyZ2Ugb2YgYSBwYXRjaCBpcyBhIG9uZS10aW1lIGNoYW5nZS4gQnV0LCB0aGUgenN0
ZCB1cGRhdGVzIGluIGdlbmVyYWwNCndpbGwgYmUgbGFyZ2UsIGNvbnRhaW5pbmcgMTAwcyBvZiBj
b21taXRzIHdvcnRoIG9mIGNoYW5nZXMgKGFzIG9wcG9zZWQgdG8NCn4zNTAwIGFuZCBhIHN0cnVj
dHVyZSBjaGFuZ2UgaW4gdGhpcyBkaWZmKS4gRS5nLiB0aGUgdXBzdHJlYW0gZGlmZiBiZXR3ZWVu
DQp0d28gdXBzdHJlYW0gdmVyc2lvbnMgcmFuZ2UgZnJvbSA1MEtCIC0gNTAwS0IuIFpzdGQgaXMg
YW4gYWN0aXZlbHkNCm1haW50YWluZWQgcHJvamVjdCwgc28gdGhlcmUgaXMgZ29pbmcgdG8gYmUg
Y2h1cm4gd2hlbiBjb25zdW1pbmcgaXQuIEJ1dCBpdA0KYWxzbyBtZWFucyB0aGF0IHdl4oCZcmUg
YWN0aXZlbHkgc3VwcG9ydGluZyB0aGUgcHJvamVjdCBpZiBhbnkgcHJvYmxlbXMgb2NjdXIuDQoN
Ck15IHZpZXcgaXMgdGhhdCBrZXJuZWwgZGV2ZWxvcGVycyBkb27igJl0IG5lZWQgdG8gcmV2aWV3
IHVwc3RyZWFtcyB6c3Rk4oCZcyBjb2RlLiBXZQ0Kc2hvdWxkIGZvY3VzIG9uIHRoZSBkaWZmIGZy
b20gdXBzdHJlYW0sIGFuZCBlbnN1cmluZyB0aGF0IGV2ZXJ5dGhpbmcgd29ya3MgaW4gdGhlDQpr
ZXJuZWwgZW52aXJvbm1lbnQuIFRoZSBpbXBvcnRlZCBjb2RlIGZyb20gdXBzdHJlYW0genN0ZCBp
cyB+MzBLIExPQywgd2hpY2ggaXMNCnRvbyBsYXJnZSBmb3IgYW55b25lIHRvIHJlYXNvbmFibHkg
cmV2aWV3Lg0KDQpBcyBtZW50aW9uZWQgaW4gdGhlIHBhdGNoLCB0aGlzIGNvbW1pdCBzaG93cyB0
aGUgZGlmZiBmcm9tIHVwc3RyZWFtIHpzdGQsIHdoaWNoDQppcyBtdWNoIG1vcmUgbWFuYWdlYWJs
ZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL3RlcnJlbGxuL2xpbnV4L2NvbW1pdC80NjdjOWVhMWRm
MTEwMGRiNDhjMDIwYzNjOGIyODJhMmEzMGY1MTE2DQoNCknigJl2ZSBnZW5lcmF0ZWQgaXQgYnkg
aW1wb3J0aW5nIHVwc3RyZWFtIHpzdGQgYXMtaXMgaW50byB0aGUga2VybmVsIGZpbGUgc3RydWN0
dXJlLiBUaGVuDQpydW5uaW5nIHRoZSBhdXRvbWF0aW9uIHRvIGdlbmVyYXRlIHRoZSBrZXJuZWwg
cGF0Y2ggZnJvbSB1cHN0cmVhbSBhbmQgaW1wb3J0aW5nDQppdCBpbnRvIHRoZSBrZXJuZWwgb24g
dG9wIG9mIHRoZSB1cHN0cmVhbSBwYXRjaC4NCg0KQmVzdCwNCk5pY2s=

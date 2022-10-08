Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFC85F873D
	for <lists+linux-crypto@lfdr.de>; Sat,  8 Oct 2022 21:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJHTtK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 8 Oct 2022 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJHTtJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 8 Oct 2022 15:49:09 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EAA32D9D
        for <linux-crypto@vger.kernel.org>; Sat,  8 Oct 2022 12:49:07 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 298FCMlw002323;
        Sat, 8 Oct 2022 19:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=5uEnmUsuS6NAH1NKh35UiX9vOYbZvUYMog4Vej9gn1g=;
 b=kSVLdM+vvW/IdrFFyVOORV0977Zc2QDKz9pxv30V58istJS5h1r35WAO7AlOUyEnUAqt
 QxSztfyNXkl6CQp15yuRpxWnBI9ho2S+kRiOfeopgCHjjxpRVpRUJWud5G0ufSXBYpqx
 kUM2q+MMLkW2EfrcDcA78Dmp802ebjkDwCPwUwbVGa5vnpJeaV/cnqcZyRBCDLSpObEe
 3qtKsT0MutLZI5mt5oVxYsTDB0EpJZTWMv97eirQ5q/990UPSkazaWq0YGoOeaHxWQ8x
 peDyaxQ0z0lTgvdvE4CL5daRrMYzySp9v+aa/a4YG+bKGQhA+6JCdZfadS2JoEt+sKfq Eg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k35btadv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Oct 2022 19:48:12 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 43126801AD3;
        Sat,  8 Oct 2022 19:48:10 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 8 Oct 2022 07:48:09 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Sat, 8 Oct 2022 07:48:09 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 8 Oct 2022 19:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Noa44ePplH2E8FD7uMxoNwjdZaFzXYTMcd6O5EEqO4kivaNgzHUeIJt0bn7TgYma8Fw3+A18miNjbTZ1vYzC1EIpEsIn/AHKzL0+lF4G0yob7eaSjJxzOkD+kmL1wEFpM4/4XgakUSHa0gwsaRyBtSBqH+tTOknQY9Ft7Fo8Wzr4tkvEja06p86d1X+UuPsGVfhPm/iWUYxqG5fkDvpy6ymQo6WqnBRHewHSCmZWyGOyHFrfnpD8mH2w3pEDQykwK4J6NBfOzp77UtETpo7IWEgSw/ymShNyUuhsbcWqGVfLr3XF1WvDZjX35Rzl7Y/E9DhmeJs/UNWZrp7QrVGFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uEnmUsuS6NAH1NKh35UiX9vOYbZvUYMog4Vej9gn1g=;
 b=GKx28ubgtbLXBO+5WkdlwKs5meBUVasq3sUL9HxAlW3ZfXI6wfBwWKu7/UAF+0P2+GBGW26x0M2V9EkApxmv+T5l9UQb6f3p4dOuseyIJdL2L+PO3Z7K3Sn0whdNSAivCQKDmFu1n/XQattQ38Uop3f17P8uN7XvBsZnaTnZNrg98twSe0QZ8pSUOxOd50ufywt3v+ZvnkSTF4gV+D7gbSaXZVGTkOj7WjgrueoalBKTZYTBNSoOy4AAKBqV5r0/+PjROlEX6WncmIbk0t4Et5iElqQwGL/t9plDrtVYQ9IAgGVc0zQgEyF6+3BnMUIcoU19eux5wrw88kKEdDLHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1404.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sat, 8 Oct
 2022 19:48:07 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5676.032; Sat, 8 Oct 2022
 19:48:07 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Taehee Yoo <ap420073@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "ebiggers@google.com" <ebiggers@google.com>
Subject: RE: [PATCH] crypto: x86: Do not acquire fpu context for too long
Thread-Topic: [PATCH] crypto: x86: Do not acquire fpu context for too long
Thread-Index: AQHY16zBFmM7SwmJd0SQI42PUTup5q39qv2AgAATNYCAAJL7sIAFLlCAgAFSKxA=
Date:   Sat, 8 Oct 2022 19:48:07 +0000
Message-ID: <MW5PR84MB1842762F8B2ABC27A1A13614AB5E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221004044912.24770-1-ap420073@gmail.com>
 <Yzu8Kd2botr3eegj@gondor.apana.org.au>
 <f7c52ed1-8061-8147-f676-86190118cc56@gmail.com>
 <MW5PR84MB18420D6E1A31D9C765EF6ED4AB5A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <CAMj1kXGmKunh-OCvGFf8T6KJJXSHRYzacjSojBD3__u0o-3D1w@mail.gmail.com>
In-Reply-To: <CAMj1kXGmKunh-OCvGFf8T6KJJXSHRYzacjSojBD3__u0o-3D1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1404:EE_
x-ms-office365-filtering-correlation-id: 1452286b-db63-47eb-5b0e-08daa96605d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hfjVeWjqPtn15GK//sSla2Hottw37s3m8h2mAn4CycPiz8d8EjRKepmmQVG9NmfZ7zFz5mYBvANwTf9/9okRUf0bk64CCkWGlONK+6Rxn8rMPB9Wh9aFKuki1JfX8ew9oLUdbPsi70eMtljgsada8Z1rMQz1plTqdbm1riwGua7FeAMdLqwN3zLWrl6BWAZmMpNJWjoxBncvt2dmamODbrwmJALtHS6LplWnAQN/Hiz27HPyfBg6TK+aaVa3HipXcnNNC9R2CSsN88zM6vTmqrNSGbFvLADq959nafpSk25ikxi23Taz0/a7Vpl1CDXQYVrQKrneu81yg770zXg2ljnDLixgnDr7rm+UnEQOrhv8gJOUoQaOs1/oYu6SjT/mOK1FzuFaVD4Ry2fsmuTr7VEcLDI4AjjePNk1t9dhZK9Um67g75JAJxR7x1lYiueho7kvOFSh+XdjSoq3gj73rSrzNcY+28KxJumBMMvgM671qc69f7ae79e639IIcigT8AkFLeu4KYkQELizwge6K2hDGOO61gkMJMjfjf5CqzGviuSkd0Edv1VFansoW1b1dv27Cp/DX6gUin4kqVknJpSr5PiD4WsL1cJ1XWvOfvEdVfgOHkYJPlPQRKWst8mSxS8X/wnUY/R9HAZ6tAHiUrn8aQlcTGHWaNL9+PGKHMiGtE9FId6UeF5MluVvY6MvgfPjehMMF+0JJPd8ubLGHWVxQR4MWL8xTLJ69aRxM23tIVoUkKHDpvAY7+jR78Em8s+DYgEKWnzfzrUIaLQg9aaNS3BNmDSuX/IsZhTAjh8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(52536014)(66476007)(66946007)(8676002)(66446008)(76116006)(9686003)(86362001)(966005)(64756008)(45080400002)(478600001)(26005)(6506007)(53546011)(7696005)(66556008)(71200400001)(83380400001)(54906003)(316002)(186003)(6916009)(122000001)(38100700002)(82960400001)(38070700005)(5660300002)(33656002)(2906002)(55016003)(7416002)(41300700001)(30864003)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZpbUFVNnV5L3l6YnQzQlozdi9LVUdIZEpoWEJmNFJiSlZ3YzMyOE5Ya1Ft?=
 =?utf-8?B?MnNWYjVndVpYVWZiZVdJcFFVbVh1ajVpQzRrVkxNM0NNOWdTQjVqTFduaDdt?=
 =?utf-8?B?ZDE5MXNjNzBXQUkwUGg0ZDRweXJUN2lsUERseDdaUlZ5cVJxRWd6QS9ibDZN?=
 =?utf-8?B?UjE3dXFCNU5LMmhVdi8wT1VlM2ZLa2hiZEVlOGY2aVpQYlBnc3R0Z1FLcWVy?=
 =?utf-8?B?bklnV1VRWDJvOGozQjkrWnI4djhRTTBJWWF3Sm5lMjJUc0JOd0p2QjIyV3Qv?=
 =?utf-8?B?VW9jUUt6dkwzUkNYN2pSUWFpakxqMHQyWGhjdGw3UlEzbEtCa0RHSkZnWjZh?=
 =?utf-8?B?SkZaY2J2Z21KeTk2eXdzWUtKcGpUOUR4Z2ZDQXF3akJOLzFSYTllNTlZeVQ4?=
 =?utf-8?B?S1hjRC81Wk5ya2JSbHIzeGV5UWVMeksyczVITkU3Qk1tMlM5cDgra0xpL1I2?=
 =?utf-8?B?SGZHQmRkR3ZTWk9UdzVjamQ2TzlwMjkxZWtZSis5UVRheTE1Z1lSUHhmU0hM?=
 =?utf-8?B?SWRhRjh0M3N2Q0FiSXlEa2grayt0V3JXMXVIMlhxcVpmYmQwQWp0YlRvUFdY?=
 =?utf-8?B?SW1PRlZ2UGdjZlRwUm15cHJzbFNtK0grWmJGSGE5clZUb0thbjJBMFFUTnEz?=
 =?utf-8?B?K2ZTcmhxTVBtdVlsVGpES25BeHFWMzBVckI1NzlkeDZiUG13OUdPeVVYNFdq?=
 =?utf-8?B?NUxtdDlYNjBKSVo2L01HREswQ0VYWVRMZTdud2QrVEtJMmlvamx0c3FpRU9P?=
 =?utf-8?B?TnR2bXdpcWw2V1JmaEFaMjhReHhTbkVldFpQVllaM0tQckJwSi9ndzZXYUoy?=
 =?utf-8?B?TVE3ME5wMHJYSFdNd0FGaXFMWWpzaldOZVhBVk5QZjRpQWVsd24wdnh6bW5B?=
 =?utf-8?B?WE4vdmVReEJXMDFMRVBJd3FlVDNncFBrVDkzMW9LM2tUeUxYbURYYTBLS0hT?=
 =?utf-8?B?T3hEdjB2SlZrb1hudDhaL2dlcFBSRDNKSVpCdHRsUDROTzdVcTBOcHJPUnNB?=
 =?utf-8?B?N1hIZEpnYzJtemZOTDhlMll2QkxYd2h4eFl5Y0tRMVRRM3F3UEVGeW44S0l2?=
 =?utf-8?B?dFI3Nitjc1VLS1BTUmJSSWtCZWJPMmEvbzVHMTE4Tml6UEZVWGlZZzFYRmcy?=
 =?utf-8?B?cnRaVXV2bnBuNzBSQkVtMWF0b2hKWUZYbW1ab1NCTGFmM0lFVFNLMHVqdkJv?=
 =?utf-8?B?S2RQRkhkNmY0Mm5oM002MjBaV2N5TEo4bk5nQzBRNVhDMmhreGtybVhKQVk2?=
 =?utf-8?B?QTc2em5Sb3ZaZThjWXVicHVvVDRRRTlwTllMZXJiNlJZTGliQlAvZFNmMWho?=
 =?utf-8?B?SW9MUXljNXEzOEFoTllNOFIrR0FReGtBN3RCa0p0VTNpTUQzNERWVGF3YjNG?=
 =?utf-8?B?VkdtUkJyclgyK3daelVaL3FYQVg3clYvRWlvK29FS3FROUhPbWw0K3Jic2NU?=
 =?utf-8?B?NHUrck1ZcS8yUFc0ZVVVeEszMG5UakdXYVBnMDl2K20wNkZEcmNSY2RndzdV?=
 =?utf-8?B?ZGlKbENjMy92MC9QRzVXd2VuYW1iQ2lZVGdqWlVDNGpoaW1RWkJ0NzlwS3ZR?=
 =?utf-8?B?OWFYR0tCRkg4a21LKzdybERXTnNlZHE5YURnZDFxRTI5KzNHRXVJZko2NnB2?=
 =?utf-8?B?R0x4dDI5cFpydmRtcG13Y2VDU0ZnNy9oTnhtZkN0L2FCSWhWUE5yVllaVFR2?=
 =?utf-8?B?cEtOTHB4aFhqVWYrc3NISWVVYUZYellvclFHRm1vK0JVQjVqbnpKeStSNXZ0?=
 =?utf-8?B?b0hXVXNiUE1GK3JXYnJMdWE5ZkJsUnlQRC9vMnBZWDZrVk9FOVBRR1UwRzc5?=
 =?utf-8?B?NTdhRVk4L3hIRjFLZ25rWFIxNHEwQTY0YWNDb0paMjdsbDFjZk5CQUdpc0xa?=
 =?utf-8?B?THkyRzhzVjFsZkx5aUVkeDMyOFozVmcwNnlEZTZsSmxJVDNna3NxTXJ3ejFK?=
 =?utf-8?B?QjlvZDdnZVFMelFRQU5TT2ZwdXZaWFpRb2RTUFY1THF1TEN6YlIwWmQ1S3BP?=
 =?utf-8?B?NUNDQ1hVczliNFZnUWJ5a0tnblFqSDd5Q0RvbnMyU1ZnS0FPaHRscFhJZFRG?=
 =?utf-8?B?ZkdCTHdKSHhtdStJUXBYMndoSUEycVhIWFZtMXdMamFxUFI0dDZxc2VMcHhm?=
 =?utf-8?Q?EQSg=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1452286b-db63-47eb-5b0e-08daa96605d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 19:48:07.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqJjP8GRObQTSvY0K5JFh20gcQkiDe58RQ5EczAH4E0giogW5cb5ABRL7PVOIQoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1404
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: TrnLSNsEdesxqDlcDN-XU8jPgsOun3Ei
X-Proofpoint-ORIG-GUID: TrnLSNsEdesxqDlcDN-XU8jPgsOun3Ei
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080128
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJkIEJpZXNoZXV2ZWwg
PGFyZGJAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDcsIDIwMjIgNDo1NSBQ
TQ0KPiBUbzogRWxsaW90dCwgUm9iZXJ0IChTZXJ2ZXJzKSA8ZWxsaW90dEBocGUuY29tPg0KPiBD
YzogVGFlaGVlIFlvbyA8YXA0MjAwNzNAZ21haWwuY29tPjsgSGVyYmVydCBYdSA8aGVyYmVydEBn
b25kb3IuYXBhbmEub3JnLmF1PjsNCj4gbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBtaW5nb0ByZWRoYXQuY29t
OyBicEBhbGllbjguZGU7IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5v
cmc7DQo+IGhwYUB6eXRvci5jb207IGViaWdnZXJzQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gY3J5cHRvOiB4ODY6IERvIG5vdCBhY3F1aXJlIGZwdSBjb250ZXh0IGZvciB0b28g
bG9uZw0KPiANCj4gT24gVHVlLCA0IE9jdCAyMDIyIGF0IDE3OjE3LCBFbGxpb3R0LCBSb2JlcnQg
KFNlcnZlcnMpIDxlbGxpb3R0QGhwZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFRhZWhlZSBZb28gPGFw
NDIwMDczQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgNCwgMjAyMiAx
OjAyIEFNDQo+ID4gPiBUbzogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1
Pg0KPiA+ID4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IHRnbHhAbGludXRyb25peC5kZTsNCj4gPiA+IG1pbmdvQHJlZGhhdC5jb207IGJwQGFs
aWVuOC5kZTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPiB4ODZAa2VybmVsLm9yZzsN
Cj4gPiA+IGhwYUB6eXRvci5jb207IGFyZGJAa2VybmVsLm9yZzsgZWJpZ2dlcnNAZ29vZ2xlLmNv
bQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gY3J5cHRvOiB4ODY6IERvIG5vdCBhY3F1aXJl
IGZwdSBjb250ZXh0IGZvciB0b28gbG9uZw0KPiA+ID4NCj4gPiA+IEhpIEhlcmJlcnQsDQo+ID4g
PiBUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KPiA+ID4NCj4gPiA+IE9uIDEwLzQvMjIg
MTM6NTIsIEhlcmJlcnQgWHUgd3JvdGU6DQo+ID4gPiAgPiBPbiBUdWUsIE9jdCAwNCwgMjAyMiBh
dCAwNDo0OToxMkFNICswMDAwLCBUYWVoZWUgWW9vIHdyb3RlOg0KPiA+ID4gID4+DQo+ID4gPiAg
Pj4gICAjZGVmaW5lIEVDQl9XQUxLX1NUQVJUKHJlcSwgYnNpemUsIGZwdV9ibG9ja3MpIGRvIHsN
Cj4gXA0KPiA+ID4gID4+ICAgICAgICAgICB2b2lkICpjdHggPQ0KPiBjcnlwdG9fc2tjaXBoZXJf
Y3R4KGNyeXB0b19za2NpcGhlcl9yZXF0Zm0ocmVxKSk7ICAgXA0KPiA+ID4gID4+ICsgdW5zaWdu
ZWQgaW50IHdhbGtlZF9ieXRlcyA9IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gPiA+ICA+PiAgICAgICAgICAgY29uc3QgaW50IF9fYnNpemUgPSAoYnNpemUpOw0KPiBc
DQo+ID4gPiAgPj4gICAgICAgICAgIHN0cnVjdCBza2NpcGhlcl93YWxrIHdhbGs7DQo+IFwNCj4g
PiA+ICA+PiAtIGludCBlcnIgPSBza2NpcGhlcl93YWxrX3ZpcnQoJndhbGssIChyZXEpLCBmYWxz
ZSk7ICAgICAgICAgICAgICBcDQo+ID4gPiAgPj4gKyBpbnQgZXJyOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4gPiA+ICA+PiArIGVyciA9IHNrY2lwaGVyX3dhbGtfdmlydCgmd2FsaywgKHJlcSks
IGZhbHNlKTsgICAgICAgICAgICAgICAgICBcDQo+ID4gPiAgPj4gICAgICAgICAgIHdoaWxlICh3
YWxrLm5ieXRlcyA+IDApIHsNCj4gXA0KPiA+ID4gID4+IC0gICAgICAgICB1bnNpZ25lZCBpbnQg
bmJ5dGVzID0gd2Fsay5uYnl0ZXM7ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICA+PiAt
ICAgICAgICAgYm9vbCBkb19mcHUgPSAoZnB1X2Jsb2NrcykgIT0gLTEgJiYgICAgICAgICAgICAg
ICAgICAgICBcDQo+ID4gPiAgPj4gLSAgICAgICAgICAgICAgICAgICAgICAgbmJ5dGVzID49IChm
cHVfYmxvY2tzKSAqIF9fYnNpemU7ICAgICAgICAgXA0KPiA+ID4gID4+ICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHU4ICpzcmMgPSB3YWxrLnNyYy52aXJ0LmFkZHI7DQo+IFwNCj4gPiA+ICA+PiAt
ICAgICAgICAgdTggKmRzdCA9IHdhbGsuZHN0LnZpcnQuYWRkcjsgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQo+ID4gPiAgPj4gICAgICAgICAgICAgICAgICAgdTggX19tYXliZV91bnVzZWQg
YnVmWyhic2l6ZSldOw0KPiBcDQo+ID4gPiAgPj4gLSAgICAgICAgIGlmIChkb19mcHUpIGtlcm5l
bF9mcHVfYmVnaW4oKQ0KPiA+ID4gID4+ICsgICAgICAgICB1OCAqZHN0ID0gd2Fsay5kc3Qudmly
dC5hZGRyOyAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICA+PiArICAgICAgICAg
dW5zaWduZWQgaW50IG5ieXRlczsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+ID4gPiAgPj4gKyAgICAgICAgIGJvb2wgZG9fZnB1OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gID4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICA+PiAr
ICAgICAgICAgaWYgKHdhbGsubmJ5dGVzIC0gd2Fsa2VkX2J5dGVzID4gRUNCX0NCQ19XQUxLX01B
WCkgeyAgICBcDQo+ID4gPiAgPj4gKyAgICAgICAgICAgICAgICAgbmJ5dGVzID0gRUNCX0NCQ19X
QUxLX01BWDsgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gID4+ICsgICAgICAgICAgICAg
ICAgIHdhbGtlZF9ieXRlcyArPSBFQ0JfQ0JDX1dBTEtfTUFYOyAgICAgICAgICAgICAgIFwNCj4g
PiA+ICA+PiArICAgICAgICAgfSBlbHNlIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ID4gPiAgPj4gKyAgICAgICAgICAgICAgICAgbmJ5dGVzID0g
d2Fsay5uYnl0ZXMgLSB3YWxrZWRfYnl0ZXM7ICAgICAgICAgICAgXA0KPiA+ID4gID4+ICsgICAg
ICAgICAgICAgICAgIHdhbGtlZF9ieXRlcyA9IHdhbGsubmJ5dGVzOyAgICAgICAgICAgICAgICAg
ICAgIFwNCj4gPiA+ICA+PiArICAgICAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gPiAgPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4g
ID4+ICsgICAgICAgICBkb19mcHUgPSAoZnB1X2Jsb2NrcykgIT0gLTEgJiYgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gPiA+ICA+PiArICAgICAgICAgICAgICAgICAgbmJ5dGVzID49IChm
cHVfYmxvY2tzKSAqIF9fYnNpemU7ICAgICAgICAgICAgICBcDQo+ID4gPiAgPj4gKyAgICAgICAg
IGlmIChkb19mcHUpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KPiA+ID4gID4+ICsgICAgICAgICAgICAgICAgIGtlcm5lbF9mcHVfYmVnaW4oKQ0KPiA+ID4g
ID4+DQo+ID4gPiAgPj4gICAjZGVmaW5lIENCQ19XQUxLX1NUQVJUKHJlcSwgYnNpemUsIGZwdV9i
bG9ja3MpDQo+IFwNCj4gPiA+ICA+PiAgICAgICAgICAgRUNCX1dBTEtfU1RBUlQocmVxLCBic2l6
ZSwgZnB1X2Jsb2NrcykNCj4gPiA+ICA+PiBAQCAtNjUsOCArODEsMTIgQEANCj4gPiA+ICA+PiAg
IH0gd2hpbGUgKDApDQo+ID4gPiAgPj4NCj4gPiA+ICA+PiAgICNkZWZpbmUgRUNCX1dBTEtfRU5E
KCkNCj4gXA0KPiA+ID4gID4+IC0gICAgICAgICBpZiAoZG9fZnB1KSBrZXJuZWxfZnB1X2VuZCgp
OyAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICA+PiArICAgICAgICAgaWYgKGRv
X2ZwdSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4g
PiAgPj4gKyAgICAgICAgICAgICAgICAga2VybmVsX2ZwdV9lbmQoKTsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPiA+ID4gID4+ICsgICAgICAgICBpZiAod2Fsa2VkX2J5dGVzIDwg
d2Fsay5uYnl0ZXMpICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ICA+PiArICAgICAg
ICAgICAgICAgICBjb250aW51ZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQo+ID4gPiAgPj4gICAgICAgICAgICAgICAgICAgZXJyID0gc2tjaXBoZXJfd2Fsa19kb25l
KCZ3YWxrLCBuYnl0ZXMpOw0KPiBcDQo+ID4gPiAgPj4gKyAgICAgICAgIHdhbGtlZF9ieXRlcyA9
IDA7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gID4+ICAg
ICAgICAgICB9DQo+IFwNCj4gPiA+ICA+PiAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gXA0KPiA+
ID4gID4+ICAgfSB3aGlsZSAoMCkNCj4gPiA+ICA+DQo+ID4gPiAgPiBza2NpcGhlcl93YWxrXyog
aXMgc3VwcG9zZWQgdG8gcmV0dXJuIGF0IG1vc3QgYSBwYWdlLiAgV2h5IGlzIHRoaXMNCj4gPiA+
ICA+IG5lY2Vzc2FyeT8NCj4gPiA+ICA+DQo+ID4gPiAgPiBDaGVlcnMsDQo+ID4gPg0KPiA+ID4g
SSByZWZlcnJlZCB0byBiZWxvdyBsaW5rLg0KPiA+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL01XNVBSODRNQjE4NDI2RUJCQTMzMDM3NzBBOEJDMEJERkFCNzU5QE1XNVBSODRNQjE4
DQo+ID4gPiA0Mi5OQU1QUkQ4NC5QUk9ELk9VVExPT0suQ09NLw0KPiA+ID4NCj4gPiA+IFNvcnJ5
IGZvciB0aGF0IEkgZGlkbid0IGNoZWNrIHRoYXQgc2tjaXBoZXJfd2Fsa18qIHJldHVybnMgb25s
eSB1bmRlciA0Sw0KPiA+ID4gc2l6ZXMuDQo+ID4gPiBTbywgSSB0aG91Z2h0IGZwdSBjb250ZXh0
IHdvdWxkIGJlIHRvbyBsb25nLg0KPiA+ID4gQnV0LCBJIGp1c3QgY2hlY2tlZCB0aGUgc2tjaXBo
ZXJfd2Fsa18qLCBhbmQgaXQncyByaWdodCwgaXQgcmV0dXJucw0KPiA+ID4gdW5kZXIgNEsgc2l6
ZXMuDQo+ID4gPiBTbywgdGhlcmUgYXJlIG5vIHByb2JsZW1zIGFzIHlvdSBtZW50aW9uZWQuDQo+
ID4gPg0KPiA+ID4gVGhhbmsgeW91IHNvIG11Y2ghDQo+ID4gPiBUYWVoZWUgWW9vDQo+ID4NCj4g
PiBJIHRoaW5rIGZ1bmN0aW9ucyB1c2luZyB0aGUgRUNCIGFuZCBDQkMgbWFjcm9zIChhbmQNCj4g
PiB0aG9zZSBoZWxwZXIgZnVuY3Rpb25zKSBhcmUgc2FmZSAgLSBub3RpY2UgdGhlIHRoaXJkDQo+
ID4gYXJndW1lbnQgaXMgY2FsbGVkIGZwdV9ibG9ja3MuIFNvLCBBcmlhJ3MgRUNCIG1vZGUgaXMN
Cj4gPiBwcm9iYWJseSBzYWZlLiBUaGVyZSBhcmUgbm8gQ1RSIG1hY3Jvcywgc28gdGhhdCBuZWVk
cw0KPiA+IHRvIGJlIGNoZWNrZWQgbW9yZSBjYXJlZnVsbHkuDQo+ID4NCj4gPiBXZSBuZWVkIHRv
IGNoZWNrIGFsbCB0aGUgZnVuY3Rpb25zIHRoYXQgZG9uJ3QgdXNlIHRoZQ0KPiA+IG1hY3JvcyBh
bmQgZnVuY3Rpb25zLiBUaGUgU0hBIGZ1bmN0aW9ucyAoSSd2ZSBzdGFydGVkDQo+ID4gd29ya2lu
ZyBvbiBhIHBhdGNoIGZvciB0aG9zZSkuDQo+ID4NCj4gPiBSdW5uaW5nIG1vZHByb2JlIHRjcnlw
dCBtb2RlPTAsIEkgZW5jb3VudGVyZWQgUkNVIHN0YWxscw0KPiA+IG9uIHRoZXNlOg0KPiA+ICAg
ICAgICAgdGNyeXB0OiB0ZXN0aW5nIGVuY3J5cHRpb24gc3BlZWQgb2Ygc3luYyBza2NpcGhlciBj
dHMoY2JjKGFlcykpDQo+IHVzaW5nIGN0cyhjYmMoYWVzLWFlc25pKSkNCj4gPiAgICAgICAgIHRj
cnlwdDogdGVzdGluZyBlbmNyeXB0aW9uIHNwZWVkIG9mIHN5bmMgc2tjaXBoZXIgY2ZiKGFlcykg
dXNpbmcNCj4gY2ZiKGFlcy1hZXNuaSkNCj4gPg0KPiA+IGFlc25pLWludGVsX2dsdWUuYyByZWdp
c3RlcnMgIl9fY3RzKGNicyhhZXMpKSIsIG5vdCAiY3RzKGNiYyhhZXMtYWVzbmkpIiwNCj4gPiBh
bmQgZG9lc24ndCByZWdpc3RlciBhbnkgY2ZiIGFsZ29yaXRobXMsIHNvIHRob3NlIHRlc3RzIGFy
ZSB1c2luZyB0aGUNCj4gPiBnZW5lcmljIHRlbXBsYXRlcywgd2hpY2ggbXVzdCBub3QgYmUgYnJl
YWtpbmcgdXAgdGhlIGxvb3BzIGFzIG5lZWRlZC4NCj4gPg0KPiANCj4gVGhlc2UgYWxsIHVzZSB0
aGUgYWVzLWFlc25pIGNpcGhlciB3cmFwcGVkIGluIHZhcmlvdXMgbGF5ZXJzIG9mDQo+IGdlbmVy
aWMgY29kZS4gVGhlIGNvcmUgY2lwaGVyIHB1dHMga2VybmVsX2ZwdV9iZWdpbi9lbmQgYXJvdW5k
IGV2ZXJ5DQo+IEFFUyBibG9jayB7MTYgYnl0ZXMpIGl0IHByb2Nlc3Nlcywgc28gSSBkb3VidCB0
aGF0IHRoZSBjcnlwdG8gY29kZSBpcw0KPiBhdCBmYXVsdCBoZXJlLCB1bmxlc3MgdGhlIGlzc3Vl
cyBpcyBpbiB0Y3J5cHQgaXRzZWxmLg0KDQpJbiAyMDE4LCBjb21taXQgMmFmNjMyOTk2Yjg5ICgi
Y3J5cHRvOiB0Y3J5cHQgLSByZXNjaGVkdWxlIGR1cmluZw0Kc3BlZWQgdGVzdHMiKSBhZGRlZCBj
b25kX3Jlc2NoZWQoKSBjYWxscyB0byAiQXZvaWQgUkNVIHN0YWxscyBpbg0KdGhlIGNhc2Ugb2Yg
bm9uLXByZWVtcHRpYmxlIGtlcm5lbCBhbmQgbGVuZ3RoeSBzcGVlZCB0ZXN0cyBieQ0KcmVzY2hl
ZHVsaW5nIHdoZW4gYWR2YW5jaW5nIGZyb20gb25lIGJsb2NrIHNpemUgdG8gYW5vdGhlci4iDQoN
Ckl0IG9ubHkgbWFrZXMgdGhvc2UgY2FsbHMgaWYgdGhlIHNlYyBtb2R1bGUgcGFyYW1ldGVyIGlz
IHVzZWQNCihydW4gdGhlIHNwZWVkIHRlc3QgZm9yIGEgY2VydGFpbiBudW1iZXIgb2Ygc2Vjb25k
cyksIG5vdCB0aGUNCmRlZmF1bHQgImN5Y2xlcyIgbW9kZS4NCg0KICAgIGlmIChzZWNzKSB7DQog
ICAgICAgIHJldCA9IHRlc3RfbWJfYWNpcGhlcl9qaWZmaWVzKGRhdGEsIGVuYywgYnMsIHNlY3Ms
IG51bV9tYik7DQogICAgICAgIGNvbmRfcmVzY2hlZCgpOw0KICAgIH0gZWxzZSB7DQogICAgICAg
IHJldCA9IHRlc3RfbWJfYWNpcGhlcl9jeWNsZXMoZGF0YSwgZW5jLCBicywgbnVtX21iKTsNCiAg
ICB9DQoNCkluIHRoZSBvcmlnaW5hbCBzaWdodGluZywgYWxsIHRocmVlIG9jY3VycmVkIGR1cmlu
ZyBtb2RlIDIwMC4NCg0KVGhlIGN5Y2xlIGNvdW50cyByYW5nZSBmcm9tIDE1MSB0byAyMjE4NDAg
Y2xvY2sgY3ljbGVzLiBUaGUNCnN0YWxscyBkbyBub3QgY29ycmVsYXRlIHRvIHRoZSBsb25nZXIg
Y3ljbGUgY291bnRzLg0KDQpUaGUgZmlyc3QgOCB0ZXN0cyB3ZXJlIGZpbmU6DQoNCkF1ZyAxMSAx
ODo1NTowNiBhZGV2eHAwMzMtc3lzIHVua25vd246IFJ1bm5pbmcgbW9kcHJvYmUgdGNyeXB0IG1v
ZGU9MjAwDQp0Y3J5cHQ6IHRlc3RpbmcgZW5jcnlwdGlvbiBzcGVlZCBvZiBzeW5jIHNrY2lwaGVy
IGVjYihhZXMpIHVzaW5nIGVjYihhZXMtYWVzbmkpDQp0Y3J5cHQ6IHRlc3RpbmcgZGVjcnlwdGlv
biBzcGVlZCBvZiBzeW5jIHNrY2lwaGVyIGVjYihhZXMpIHVzaW5nIGVjYihhZXMtYWVzbmkpDQp0
Y3J5cHQ6IHRlc3RpbmcgZW5jcnlwdGlvbiBzcGVlZCBvZiBzeW5jIHNrY2lwaGVyIGNiYyhhZXMp
IHVzaW5nIGNiYyhhZXMtYWVzbmkpDQp0Y3J5cHQ6IHRlc3RpbmcgZGVjcnlwdGlvbiBzcGVlZCBv
ZiBzeW5jIHNrY2lwaGVyIGNiYyhhZXMpIHVzaW5nIGNiYyhhZXMtYWVzbmkpDQp0Y3J5cHQ6IHRl
c3RpbmcgZW5jcnlwdGlvbiBzcGVlZCBvZiBzeW5jIHNrY2lwaGVyIGxydyhhZXMpIHVzaW5nIGxy
dyhlY2IoYWVzLWFlc25pKSkNCnRjcnlwdDogdGVzdGluZyBkZWNyeXB0aW9uIHNwZWVkIG9mIHN5
bmMgc2tjaXBoZXIgbHJ3KGFlcykgdXNpbmcgbHJ3KGVjYihhZXMtYWVzbmkpKQ0KdGNyeXB0OiB0
ZXN0aW5nIGVuY3J5cHRpb24gc3BlZWQgb2Ygc3luYyBza2NpcGhlciB4dHMoYWVzKSB1c2luZyB4
dHMoZWNiKGFlcy1hZXNuaSkpDQp0Y3J5cHQ6IHRlc3RpbmcgZGVjcnlwdGlvbiBzcGVlZCBvZiBz
eW5jIHNrY2lwaGVyIHh0cyhhZXMpIHVzaW5nIHh0cyhlY2IoYWVzLWFlc25pKSkNCg0KYnV0IHRo
ZSA5dGggdHJpZ2dlcmVkIHRoZSBmaXJzdCBzdGFsbCB3YXJuaW5nOg0KdGNyeXB0OiB0ZXN0aW5n
IGVuY3J5cHRpb24gc3BlZWQgb2Ygc3luYyBza2NpcGhlciBjdHMoY2JjKGFlcykpIHVzaW5nIGN0
cyhjYmMoYWVzLWFlc25pKSkNCnRjcnlwdDogdGVzdCAwICgxMjggYml0IGtleSwgMTYgYnl0ZSBi
bG9ja3MpOiAxIG9wZXJhdGlvbiBpbiAyNDMgY3ljbGVzICgxNiBieXRlcykNCnRjcnlwdDogdGVz
dCAxICgxMjggYml0IGtleSwgNjQgYnl0ZSBibG9ja3MpOiAxIG9wZXJhdGlvbiBpbiA3MjggY3lj
bGVzICg2NCBieXRlcykNCnRjcnlwdDogdGVzdCAyICgxMjggYml0IGtleSwgMTI4IGJ5dGUgYmxv
Y2tzKTogMSBvcGVyYXRpb24gaW4gOTM5IGN5Y2xlcyAoMTI4IGJ5dGVzKQ0KdGNyeXB0OiB0ZXN0
IDMgKDEyOCBiaXQga2V5LCAyNTYgYnl0ZSBibG9ja3MpOiAxIG9wZXJhdGlvbiBpbiAxMzQxIGN5
Y2xlcyAoMjU2IGJ5dGVzKQ0KdGNyeXB0OiB0ZXN0IDQgKDEyOCBiaXQga2V5LCAxMDI0IGJ5dGUg
YmxvY2tzKTogMSBvcGVyYXRpb24gaW4gMzc4NiBjeWNsZXMgKDEwMjQgYnl0ZXMpDQp0Y3J5cHQ6
IHRlc3QgNSAoMTI4IGJpdCBrZXksIDE0MjQgYnl0ZSBibG9ja3MpOiAxIG9wZXJhdGlvbiBpbiA1
MDY0IGN5Y2xlcyAoMTQyNCBieXRlcykNCnRjcnlwdDogdGVzdCA2ICgxMjggYml0IGtleSwgNDA5
NiBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9uIGluIDEzODg5IGN5Y2xlcyAoNDA5NiBieXRlcykN
CnRjcnlwdDogdGVzdCA3ICgxOTIgYml0IGtleSwgMTYgYnl0ZSBibG9ja3MpOiAxIG9wZXJhdGlv
biBpbiAyMzYgY3ljbGVzICgxNiBieXRlcykNCnJjdTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0
ZWQgZXhwZWRpdGVkIHN0YWxscyBvbiBDUFVzL3Rhc2tzOiB7DQoxIG9wZXJhdGlvbiBpbiA3NDUg
Y3ljbGVzICg2NCBieXRlcykNCg0KVGhlIHN0YWNrIHRyYWNlIHByaW50cyBpbnRlcnNwZXJzZWQg
d2l0aCB0aGUgbmV4dCAyNiB0ZXN0IHByaW50cywNCmFzIGl0IG1vdmVkIGludG86DQp0Y3J5cHQ6
IHRlc3RpbmcgZGVjcnlwdGlvbiBzcGVlZCBvZiBzeW5jIHNrY2lwaGVyIGN0cyhjYmMoYWVzKSkg
dXNpbmcgY3RzKGNiYyhhZXMtYWVzbmkpKQ0KDQpJdCBwcm9jZWVkZWQgdGhyb3VnaCB0aGUgbmV4
dCB0d28gd2l0aCBubyBwcm9ibGVtOg0KdGNyeXB0OiB0ZXN0aW5nIGVuY3J5cHRpb24gc3BlZWQg
b2Ygc3luYyBza2NpcGhlciBjdHIoYWVzKSB1c2luZyBjdHIoYWVzLWFlc25pKQ0KdGNyeXB0OiB0
ZXN0aW5nIGRlY3J5cHRpb24gc3BlZWQgb2Ygc3luYyBza2NpcGhlciBjdHIoYWVzKSB1c2luZyBj
dHIoYWVzLWFlc25pKQ0KDQphbmQgdGhlbiByZXBvcnRlZCB0d28gc3RhbGxzIGR1cmluZyBjZmIg
ZW5jcnlwdGlvbiBhbmQgY2ZiIGRlY3J5cHRpb246DQp0Y3J5cHQ6IHRlc3RpbmcgZW5jcnlwdGlv
biBzcGVlZCBvZiBzeW5jIHNrY2lwaGVyIGNmYihhZXMpIHVzaW5nIGNmYihhZXMtYWVzbmkpDQp0
Y3J5cHQ6IHRlc3QgMCAoMTI4IGJpdCBrZXksIDE2IGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24g
aW4gMTgyIGN5Y2xlcyAoMTYgYnl0ZXMpDQp0Y3J5cHQ6IHRlc3QgMSAoMTI4IGJpdCBrZXksIDY0
IGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24gaW4gMzQ3IGN5Y2xlcyAoNjQgYnl0ZXMpDQp0Y3J5
cHQ6IHRlc3QgMiAoMTI4IGJpdCBrZXksIDEyOCBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9uIGlu
IDU0MiBjeWNsZXMgKDEyOCBieXRlcykNCnRjcnlwdDogdGVzdCAzICgxMjggYml0IGtleSwgMjU2
IGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24gaW4gOTYzIGN5Y2xlcyAoMjU2IGJ5dGVzKQ0KcmN1
OiBJTkZPOiByY3VfcHJlZW1wdCBkZXRlY3RlZCBleHBlZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFz
a3M6IHsNCjEgb3BlcmF0aW9uIGluIDM0NjUgY3ljbGVzICgxMDI0IGJ5dGVzKQ0KdGNyeXB0OiB0
ZXN0IDUgKDEyOCBiaXQga2V5LCAxNDIwIGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24gaW4gNDgw
OCBjeWNsZXMgKDE0MjAgYnl0ZXMpDQp0Y3J5cHQ6IHRlc3QgNiAoMTI4IGJpdCBrZXksIDQwOTYg
Ynl0ZSBibG9ja3MpOiAxIG9wZXJhdGlvbiBpbiAxMzYzMSBjeWNsZXMgKDQwOTYgYnl0ZXMpDQp0
Y3J5cHQ6IHRlc3QgNyAoMTkyIGJpdCBrZXksIDE2IGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24g
aW4gMTkwIGN5Y2xlcyAoMTYgYnl0ZXMpDQp0Y3J5cHQ6IHRlc3QgOCAoMTkyIGJpdCBrZXksIDY0
IGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24gaW4gMzYwIGN5Y2xlcyAoNjQgYnl0ZXMpDQp0Y3J5
cHQ6IHRlc3QgOSAoMTkyIGJpdCBrZXksIDEyOCBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9uIGlu
IDU3MCBjeWNsZXMgKDEyOCBieXRlcykNCnRjcnlwdDogdGVzdCAxMCAoMTkyIGJpdCBrZXksIDI1
NiBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9uIGluIDEwMTAgY3ljbGVzICgyNTYgYnl0ZXMpDQp0
Y3J5cHQ6IHRlc3QgMTEgKDE5MiBiaXQga2V5LCAxMDI0IGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRp
b24gaW4gMzY2MCBjeWNsZXMgKDEwMjQgYnl0ZXMpDQp0Y3J5cHQ6IHRlc3QgMTIgKDE5MiBiaXQg
a2V5LCAxNDIwIGJ5dGUgYmxvY2tzKTogMSBvcGVyYXRpb24gaW4gNTA4OCBjeWNsZXMgKDE0MjAg
Ynl0ZXMpDQp0Y3J5cHQ6IHRlc3QgMTMgKDE5MiBiaXQga2V5LCA0MDk2IGJ5dGUgYmxvY2tzKTog
MSBvcGVyYXRpb24gaW4gMTQ3ODEgY3ljbGVzICg0MDk2IGJ5dGVzKQ0KdGNyeXB0OiB0ZXN0IDE0
ICgyNTYgYml0IGtleSwgMTYgYnl0ZSBibG9ja3MpOiAxIG9wZXJhdGlvbiBpbiAxOTUgY3ljbGVz
ICgxNiBieXRlcykNCnRjcnlwdDogdGVzdCAxNSAoMjU2IGJpdCBrZXksIDY0IGJ5dGUgYmxvY2tz
KTogMSBvcGVyYXRpb24gaW4gMzYzIGN5Y2xlcyAoNjQgYnl0ZXMpDQp0Y3J5cHQ6IHRlc3QgMTYg
KDI1NiBiaXQga2V5LCAxMjggYnl0ZSBibG9ja3MpOiAxIG9wZXJhdGlvbiBpbiA1OTIgY3ljbGVz
ICgxMjggYnl0ZXMpDQoxIG9wZXJhdGlvbiBpbiAxMDQ2IGN5Y2xlcyAoMjU2IGJ5dGVzKQ0KdGNy
eXB0OiB0ZXN0IDE4ICgyNTYgYml0IGtleSwgMTAyNCBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9u
IGluIDM3OTYgY3ljbGVzICgxMDI0IGJ5dGVzKQ0KdGNyeXB0OiB0ZXN0IDE5ICgyNTYgYml0IGtl
eSwgMTQyMCBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9uIGluIDUyODMgY3ljbGVzICgxNDIwIGJ5
dGVzKQ0KdGNyeXB0OiB0ZXN0IDIwICgyNTYgYml0IGtleSwgNDA5NiBieXRlIGJsb2Nrcyk6IDEg
b3BlcmF0aW9uIGluIDE0OTI1IGN5Y2xlcyAoNDA5NiBieXRlcykNCnRjcnlwdDogdGVzdGluZyBk
ZWNyeXB0aW9uIHNwZWVkIG9mIHN5bmMgc2tjaXBoZXIgY2ZiKGFlcykgdXNpbmcgY2ZiKGFlcy1h
ZXNuaSkNCjEgb3BlcmF0aW9uIGluIDE4NCBjeWNsZXMgKDE2IGJ5dGVzKQ0KMSBvcGVyYXRpb24g
aW4gNDE1IGN5Y2xlcyAoNjQgYnl0ZXMpDQp0Y3J5cHQ6IHRlc3QgMiAoMTI4IGJpdCBrZXksIDEy
OCBieXRlIGJsb2Nrcyk6IDEgb3BlcmF0aW9uIGluIDY2MSBjeWNsZXMgKDEyOCBieXRlcykNCnJj
dTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgZXhwZWRpdGVkIHN0YWxscyBvbiBDUFVzL3Rh
c2tzOiB7DQoxIG9wZXJhdGlvbiBpbiAxMjE1IGN5Y2xlcyAoMjU2IGJ5dGVzKQ0KDQpOb25lIG9m
IHRoZSBvdGhlciBtb2RlcyAoZnJvbSAwIHRvIDk5OSkgaGFkIHByb2JsZW1zLg0KDQptb2RlPTIw
MCByYW4gZnJvbSAxODo1NTowNiB0byAxODo1NTowOSwgb25lIG9mIHRoZSBsb25nZXIgZHVyYXRp
b25zLA0KYnV0IG5vdCB1bmlxdWUgKGUuZy4sIG1vZGUgMzAwIHRvb2sgNCBzZWMsIG1vZGUgNDAw
IHRvb2sgNSBzZWMpLg0KDQpQZXJoYXBzIHRoZSBjeWNsZXMgbW9kZSBuZWVkcyB0byBjYWxsIGNv
bmRfcmVzY2hlZCgpIHRvbz8NCg0KDQo=

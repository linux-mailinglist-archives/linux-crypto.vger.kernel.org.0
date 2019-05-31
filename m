Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089F631029
	for <lists+linux-crypto@lfdr.de>; Fri, 31 May 2019 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEaO1x (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 May 2019 10:27:53 -0400
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:29187
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEaO1w (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 May 2019 10:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DaOTHPwWxFGu5pFSFNw74JHIu+6LpxvcwpSaDxOi8Y=;
 b=rqMkatPxMLicE6X4D9J4ema92D2GAwY/ArORX8akzxYkknLgCWORecd5mH00IDhYeJ9oshwtXf1vxPI/bQno0Fwe6UP7oRT4sClgXa0JBDVmOIYSkc2g2nJ92ByIgiyTMSRRvqJIiqBU3yvqY79doLNuePsAInBgNnt6xlG8+Y4=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3645.eurprd04.prod.outlook.com (52.134.14.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 31 May 2019 14:27:46 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745%4]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 14:27:46 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: caam - disable some clock checks for iMX7ULP
Thread-Topic: [PATCH] crypto: caam - disable some clock checks for iMX7ULP
Thread-Index: AQHVF6DscUjseuTf80KtUeNJyp6zSQ==
Date:   Fri, 31 May 2019 14:27:46 +0000
Message-ID: <VI1PR0402MB3485BC76A33F8A81C73184E398190@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20190531110634.2967-1-iuliana.prodan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c12826dc-12fa-4aa6-8d68-08d6e5d426e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3645;
x-ms-traffictypediagnostic: VI1PR0402MB3645:
x-microsoft-antispam-prvs: <VI1PR0402MB3645A1CD4B1383C90E7B77A398190@VI1PR0402MB3645.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(14444005)(256004)(7736002)(6116002)(53936002)(74316002)(66556008)(3846002)(6436002)(71200400001)(66066001)(64756008)(186003)(76116006)(305945005)(71190400001)(66476007)(558084003)(4326008)(478600001)(5660300002)(66946007)(73956011)(66446008)(8676002)(76176011)(54906003)(8936002)(86362001)(446003)(6246003)(25786009)(33656002)(2906002)(68736007)(55016002)(110136005)(9686003)(102836004)(99286004)(6636002)(52536014)(81166006)(26005)(14454004)(44832011)(7696005)(476003)(6506007)(229853002)(486006)(316002)(53546011)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3645;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WVUFRfyYMl6tXBmNjd1fESH2KGSDEGeNui7i2dvjCDr1lfDDHUmZUDlNCzAHzN/dD9+ldmGv79dUMLQgtLd4T8ZvzGZsgOJRGCHrsKH1OjnmJvpKTygI/KVi8ZC48Om/B1Tiq7RW1ryt7p61eDXOotnh7kgil7Ryhd3Bt/FOv2U4uOBXWkCFCOGSWRcp9EZhgkTyVotmcsUQAZS/xxRar/vIyxbQ5zM/VbGX/QmEgCcXd3GsGV22v6Nc2AgtCP9ICCh5KB3wl2PZfkLQHn+KCW+TA9fV3rzo+Q77+J1w3xU4fQAZvp5/Caec6VBRp+hXKW3tqZMdRTTz50oxXVglaGf+RkkKev2tC10mmtbR5awOYE4kTIprAeuRqP15Ca3T6RECi4yee/WpPiQeG842LnIxMW9Tn+y5OCvawpzsYV0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12826dc-12fa-4aa6-8d68-08d6e5d426e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:27:46.7008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horia.geanta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3645
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 5/31/2019 2:06 PM, Iuliana Prodan wrote:=0A=
> Disabled the check and set of 'mem' and 'emi_slow'=0A=
> clocks, since these are not available for iMX7ULP.=0A=
> =0A=
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF43CAB9
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Jun 2019 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbfFKMJE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Jun 2019 08:09:04 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:59362
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404372AbfFKMJE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Jun 2019 08:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nkCMlyKo3b55Ogy6E62bnSFHT86nMrEF8Qvq9yreLo=;
 b=jML3hjYSG80fR2ODfruswGH7QnR4QMRVMkTdBwNfcGrLmIVpheVk2og5NWNkJxCFcW73WzzADOch1o9s1Au2eAVI+rjkoSXhURm3tPVj546AMiNDGDiNPOYuYBrK0UjXLGxxw8zpxeZdgxusyfh65YjOZLCZ0P8IcMsYb/aAGfo=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (52.134.17.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 11 Jun 2019 12:09:01 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 12:09:01 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1 0/5] Additional fixes on Talitos driver
Thread-Topic: [PATCH v1 0/5] Additional fixes on Talitos driver
Thread-Index: AQHVHFtn4C4BXEoEK02U37UKYcQLNA==
Date:   Tue, 11 Jun 2019 12:09:01 +0000
Message-ID: <VI1PR0402MB34852D74119140ADDD4F4DF198ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <cover.1559819372.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1d95a0c-1ccd-4f36-2a9d-08d6ee659708
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3918;
x-ms-traffictypediagnostic: VI1PR0402MB3918:
x-microsoft-antispam-prvs: <VI1PR0402MB3918217BA9EBE0716729F13098ED0@VI1PR0402MB3918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(44832011)(316002)(99286004)(52536014)(6246003)(33656002)(478600001)(53936002)(14454004)(4326008)(74316002)(55016002)(86362001)(71190400001)(81166006)(6436002)(9686003)(2906002)(229853002)(54906003)(486006)(4744005)(81156014)(110136005)(8676002)(71200400001)(5660300002)(68736007)(7736002)(476003)(64756008)(66066001)(305945005)(8936002)(66476007)(66946007)(66446008)(3846002)(25786009)(26005)(66556008)(53546011)(6506007)(6116002)(256004)(446003)(76176011)(7696005)(186003)(76116006)(102836004)(73956011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6Xk5VxfME+muF3MNbCpOkKYI/I7IW9dFjhRzWKUyDyOHBX75yBfeoCdfIVpaprnA6ExYHx+TPw3qhU9EUGsiEAnbyz9N5OOSDXMDtF1zyDnZrRsL49WtGQhBQsDVB5dgAmeIP0MY9qpsTLkN7YK4B4DyfIfHzIik/H5dj3ODfC7vQMlATMCmWzOm7jjbc+6W45YmA+a5BrJdW4J4tSa8wkS4hEPNUVWheKqq1AypKMg0oJl6cjmFcPJTP+Rn8j6z+Mmhq87wYlGlCQX4F7IZcAiJ+v1Ug/NRMzzEL2WbgyJLUE/U5iJs3tdvGY2KK3RcUjJf3ZIWPcJLq4zRXhsMme20VRqwLsBBk7FxAxreL4ppyJ7sHvni2NUJlALc86C/fNUOnmgk+nh2nyMOcG6dSbKQw3Xoh9G6/rlCdgJEyWs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d95a0c-1ccd-4f36-2a9d-08d6ee659708
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 12:09:01.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horia.geanta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 6/6/2019 2:31 PM, Christophe Leroy wrote:=0A=
> This series is the last set of fixes for the Talitos driver.=0A=
> =0A=
> We now get a fully clean boot on both SEC1 (SEC1.2 on mpc885) and=0A=
> SEC2 (SEC2.2 on mpc8321E) with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS:=0A=
> =0A=
I get failures, probably due to patch 1/5:=0A=
=0A=
alg: skcipher: cbc-aes-talitos encryption test failed (wrong result) on tes=
t vector 0, cfg=3D"in-place"=0A=
alg: skcipher: cbc-des-talitos encryption test failed (wrong result) on tes=
t vector 0, cfg=3D"in-place"=0A=
alg: skcipher: cbc-3des-talitos encryption test failed (wrong result) on te=
st vector 0, cfg=3D"in-place"=0A=
=0A=
Horia=0A=

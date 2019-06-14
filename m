Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2445B7D
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Jun 2019 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfFNLcf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Jun 2019 07:32:35 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:30438
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbfFNLce (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Jun 2019 07:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8fb3bJeZuVjmnFNb8No/0pPhO7hT4QzZSieGtZBDrA=;
 b=YxYlAoR06DejnMeEFeYyWbfX1LNN1fBLl0ANo4uN3F+vTapuBfThtrdNd0hlVfFYctzn8j7r5KlyHrcVgx/z6KB6GTkeyJBWna6D/J+UKJcvPjsI3ye1safZNFEHifAtE2u3XcoB34gdYIY3N80iYXAUw4pfxTSW6xNKmotmUpc=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3853.eurprd04.prod.outlook.com (52.134.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 11:32:32 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745%4]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 11:32:31 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 2/4] crypto: talitos - fix hash on SEC1.
Thread-Topic: [PATCH v3 2/4] crypto: talitos - fix hash on SEC1.
Thread-Index: AQHVIeZZjrISGczaNEaQ63Pip1dkoQ==
Date:   Fri, 14 Jun 2019 11:32:31 +0000
Message-ID: <VI1PR0402MB34855C37F53DC1012DAF670798EE0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <cover.1560429844.git.christophe.leroy@c-s.fr>
 <732ca0ff440bf4cd589d844cfda71d96efd500f5.1560429844.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58372b73-6d99-40b6-7d67-08d6f0bbfd59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3853;
x-ms-traffictypediagnostic: VI1PR0402MB3853:
x-microsoft-antispam-prvs: <VI1PR0402MB3853FE478ADAD9714EB90B3C98EE0@VI1PR0402MB3853.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(305945005)(99286004)(14454004)(316002)(66446008)(7736002)(7696005)(110136005)(71200400001)(66556008)(2906002)(76176011)(66476007)(446003)(66066001)(66946007)(71190400001)(73956011)(55016002)(102836004)(3846002)(74316002)(6116002)(76116006)(54906003)(86362001)(6436002)(229853002)(478600001)(64756008)(14444005)(81156014)(81166006)(6246003)(8936002)(33656002)(4326008)(52536014)(9686003)(486006)(25786009)(8676002)(53936002)(186003)(5660300002)(53546011)(6506007)(44832011)(26005)(256004)(68736007)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3853;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xCpkA+4QuZX9q0Eoy+DJOpnFpJBGwzdMHn2buG6bL/pNKwrvwEQRpJcAwSIQNuM1nTcZHPQlC3FyL6o5/ABQIJDPHXUgKJUWbNQ7iAYv44/HH1Ty5jhaxUVH+TkbfzAhOgN7h5CwSQWlgZHQJoKiN53PlAlyQ6lb3XaZe8EZBOpHuTAnrLDAVKOyPyf70Go7Z5wgndlU0JjBKVO44ApYB8ZeJ8+j3CTtg8NYMgAZvfP9mTk2G5YLke50RanwDB6xJSky+1gBZm5MpbJdHTgbQ3tTcV+3wmXvc8bkYYgjCqDqPp8qWJdYKnWisXIJi+3D/N1YdS0QIfnYNthFcqD8+EarLlOP9SIkCon7TatkPb1SrYRNbc93SVgMsSq2hR+fZxETezIfKWlqRLouKX59pykE0fJD7A1Df0leHPTJkUA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58372b73-6d99-40b6-7d67-08d6f0bbfd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 11:32:31.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horia.geanta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3853
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 6/13/2019 3:48 PM, Christophe Leroy wrote:=0A=
> @@ -336,15 +336,18 @@ static void flush_channel(struct device *dev, int c=
h, int error, int reset_ch)=0A=
>  	tail =3D priv->chan[ch].tail;=0A=
>  	while (priv->chan[ch].fifo[tail].desc) {=0A=
>  		__be32 hdr;=0A=
> +		struct talitos_edesc *edesc;=0A=
>  =0A=
>  		request =3D &priv->chan[ch].fifo[tail];=0A=
> +		edesc =3D container_of(request->desc, struct talitos_edesc, desc);=0A=
Not needed for all cases, should be moved to the block that uses it.=0A=
=0A=
>  =0A=
>  		/* descriptors with their done bits set don't get the error */=0A=
>  		rmb();=0A=
>  		if (!is_sec1)=0A=
>  			hdr =3D request->desc->hdr;=0A=
>  		else if (request->desc->next_desc)=0A=
> -			hdr =3D (request->desc + 1)->hdr1;=0A=
> +			hdr =3D ((struct talitos_desc *)=0A=
> +			       (edesc->buf + edesc->dma_len))->hdr1;=0A=
>  		else=0A=
>  			hdr =3D request->desc->hdr1;=0A=
>  =0A=
[snip]=0A=
> @@ -2058,7 +2065,18 @@ static int ahash_process_req(struct ahash_request =
*areq, unsigned int nbytes)=0A=
>  		sg_copy_to_buffer(areq->src, nents,=0A=
>  				  ctx_buf + req_ctx->nbuf, offset);=0A=
>  		req_ctx->nbuf +=3D offset;=0A=
> -		req_ctx->psrc =3D areq->src;=0A=
> +		for (sg =3D areq->src; sg && offset >=3D sg->length;=0A=
> +		     offset -=3D sg->length, sg =3D sg_next(sg))=0A=
> +			;=0A=
> +		if (offset) {=0A=
> +			sg_init_table(req_ctx->bufsl, 2);=0A=
> +			sg_set_buf(req_ctx->bufsl, sg_virt(sg) + offset,=0A=
> +				   sg->length - offset);=0A=
> +			sg_chain(req_ctx->bufsl, 2, sg_next(sg));=0A=
> +			req_ctx->psrc =3D req_ctx->bufsl;=0A=
Isn't this what scatterwalk_ffwd() does?=0A=
=0A=
Horia=0A=

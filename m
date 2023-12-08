Return-Path: <linux-crypto+bounces-649-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00C80A375
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 13:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F081F21367
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 12:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27D1C6B4
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 12:38:02 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFBAD;
	Fri,  8 Dec 2023 04:18:14 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Smqss6lqGzsRwD;
	Fri,  8 Dec 2023 20:18:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 20:18:11 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Fri, 8 Dec 2023 20:18:10 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, wangyangxin <wangyangxin1@huawei.com>, "Halil
 Pasic" <pasic@linux.ibm.com>
Subject: RE: [PATCH v2] crypto: virtio-crypto: Handle dataq logic  with
 tasklet
Thread-Topic: [PATCH v2] crypto: virtio-crypto: Handle dataq logic  with
 tasklet
Thread-Index: AdooOneOWI65hKIST2yjTeZdqptiyQBCQ+6AACMBjtA=
Date: Fri, 8 Dec 2023 12:18:10 +0000
Message-ID: <70ea58a0776e4ba2a38658047d188688@huawei.com>
References: <ad8c946eb2294a7bb9eef26066c06b72@huawei.com>
 <ZXKNUdXNV7G3ED3P@gondor.apana.org.au>
In-Reply-To: <ZXKNUdXNV7G3ED3P@gondor.apana.org.au>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected



> -----Original Message-----
> From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
> Sent: Friday, December 8, 2023 11:28 AM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: linux-crypto@vger.kernel.org; Michael S. Tsirkin <mst@redhat.com>; Ja=
son
> Wang <jasowang@redhat.com>; virtualization@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; wangyangxin <wangyangxin1@huawei.com>;
> Halil Pasic <pasic@linux.ibm.com>
> Subject: Re: [PATCH v2] crypto: virtio-crypto: Handle dataq logic with ta=
sklet
>=20
> On Wed, Dec 06, 2023 at 11:52:51AM +0000, Gonglei (Arei) wrote:
> > Doing ipsec produces a spinlock recursion warning.
> > This is due to crypto_finalize_request() being called in the upper half=
.
> > Move virtual data queue processing of virtio-crypto driver to tasklet.
> >
> > Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
> > Reported-by: Halil Pasic <pasic@linux.ibm.com>
> > Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  v2: calling tasklet_kill() in virtcrypto_remove(), thanks for MST.
> >
> >  drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
> >  drivers/crypto/virtio/virtio_crypto_core.c   | 26
> ++++++++++++++++----------
> >  2 files changed, 18 insertions(+), 10 deletions(-)
>=20
> Your patch has already been merged.  So please send this as an incrementa=
l
> patch.
>=20

OK. No problem.=20

Regards,
-Gonglei

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt



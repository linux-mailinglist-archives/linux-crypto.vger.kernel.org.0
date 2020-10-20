Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0D2935F5
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Oct 2020 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgJTHli convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-crypto@lfdr.de>); Tue, 20 Oct 2020 03:41:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24317 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731571AbgJTHli (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Oct 2020 03:41:38 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-19-Ws7YY1epMoqWjkynPZLMpQ-1; Tue, 20 Oct 2020 08:41:34 +0100
X-MC-Unique: Ws7YY1epMoqWjkynPZLMpQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 20 Oct 2020 08:41:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 20 Oct 2020 08:41:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] crypto: lib/sha256 - Unroll SHA256 loop 8 times
 intead of 64
Thread-Topic: [PATCH 4/5] crypto: lib/sha256 - Unroll SHA256 loop 8 times
 intead of 64
Thread-Index: AQHWpizLtR2ktKloi0KILMfFeYMjdqmgGc8g
Date:   Tue, 20 Oct 2020 07:41:33 +0000
Message-ID: <1324eb3519d54ddd9469d30a94c11823@AcuMS.aculab.com>
References: <20201019153016.2698303-1-nivedita@alum.mit.edu>
 <20201019153016.2698303-5-nivedita@alum.mit.edu>
In-Reply-To: <20201019153016.2698303-5-nivedita@alum.mit.edu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Arvind Sankar> Sent: 19 October 2020 16:30
> To: Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>; linux-
> crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH 4/5] crypto: lib/sha256 - Unroll SHA256 loop 8 times intead of 64
> 
> This reduces code size substantially (on x86_64 with gcc-10 the size of
> sha256_update() goes from 7593 bytes to 1952 bytes including the new
> SHA256_K array), and on x86 is slightly faster than the full unroll.

The speed will depend on exactly which cpu type is used.
It is even possible that the 'not unrolled at all' loop
(with the all the extra register moves) is faster on some x86-64 cpu.

> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  lib/crypto/sha256.c | 164 ++++++++------------------------------------
>  1 file changed, 28 insertions(+), 136 deletions(-)
> 
> diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
> index c6bfeacc5b81..9f0b71d41ea0 100644
> --- a/lib/crypto/sha256.c
> +++ b/lib/crypto/sha256.c
> @@ -18,6 +18,17 @@
>  #include <crypto/sha.h>
>  #include <asm/unaligned.h>
...
> 
> +#define SHA256_ROUND(i, a, b, c, d, e, f, g, h) do {		\
> +	u32 t1, t2;						\
> +	t1 = h + e1(e) + Ch(e, f, g) + SHA256_K[i] + W[i];	\
> +	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;	\

Split to 3 lines.

If you can put SHA256_K[] and W[] into a struct then the
compiler can use the same register to address into both
arrays (using an offset of 64*4 for the second one).
(ie keep the two arrays, not an array of struct).
This should reduce the register pressure slightly.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


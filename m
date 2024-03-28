Return-Path: <linux-crypto+bounces-2793-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016528858B8
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Mar 2024 13:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6BF1F2129E
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Mar 2024 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D86762F9;
	Thu, 21 Mar 2024 12:01:20 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5D762C7;
	Thu, 21 Mar 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022480; cv=none; b=tMyrHFKjWTVkR/QlNqj9Mdtouc3ij4fVqcHavLApaWBuDPubO1J17oM4U04OMMZC2y61dW/Dw3k4iAnL3N7Eq+tejNzDM5eZVYz3hahFBTGOqKQ+8FS70mhR+rAR/p+HMzdDfbrYyyuXurZUSJm8bQyAK0Sj5B2Zrp5jcomhvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022480; c=relaxed/simple;
	bh=TdeHwXHZLnolNP4pruQ3Emm6FQMzC7xzcbxQhC6EuSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObBvh8CTD66GQ/9DlALV1zzkjQXxaLRlUHMpsEgqH66+lJamdON+EGCRluAXnTQOYvO9RR0JxirSah6OgVgiCTkMHIUOBiPmxcBfVoy9dDYfacH3Jm1PHVot/ISrr0EZn+0afPqWEw2rMErUFDc9aEliJuLiLFc8nG19TnPI1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch02.omp.ru (10.188.4.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 21 Mar
 2024 15:01:03 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Thu, 21 Mar 2024 15:01:03 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] crypto: ecc: fix NULL pointer dereferencing in
 ecc_gen_privkey()
Thread-Topic: [PATCH] crypto: ecc: fix NULL pointer dereferencing in
 ecc_gen_privkey()
Thread-Index: AQHacF8ItH6zDpkXIUCmX8XUSBZ4lbFB2JEAgABVggk=
Date: Thu, 21 Mar 2024 12:01:02 +0000
Message-ID: <e5a3f28ec5cf426998f00083ec4f1f58@omp.ru>
References: <20240307071318.5206-1-r.smirnov@omp.ru>,<ZfwD5EojMLYqBaid@gondor.apana.org.au>
In-Reply-To: <ZfwD5EojMLYqBaid@gondor.apana.org.au>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch02.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/21/2024 9:59:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 21 Mar 2024 17:54:44 +0800, Herbert Xu wrote:
> On Thu, Mar 07, 2024 at 10:13:18AM +0300, Roman Smirnov wrote:
> > ecc_get_curve() can return NULL. It is necessary to check
> > for NULL before dereferencing.
> >=20
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> >=20
> > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > ---
> >  crypto/ecc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> Please point me to the exact code path where this can happen.

I didn't find a specific path. Several places in the file have this
check:

ecc_make_pub_key()
crypto_ecdh_shared_secret()

I thought it was needed in this place too.


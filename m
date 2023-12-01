Return-Path: <linux-crypto+bounces-436-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22768800295
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 05:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66774280A12
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29927BE73
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 04:34:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4567512B
	for <linux-crypto@vger.kernel.org>; Thu, 30 Nov 2023 19:40:00 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8uNe-005b4z-KQ; Fri, 01 Dec 2023 11:39:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 11:40:03 +0800
Date: Fri, 1 Dec 2023 11:40:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: liulongfang <liulongfang@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 10/19] crypto: hisilicon/sec2 - Remove cfb and ofb
Message-ID: <ZWlVk773O087ToqB@gondor.apana.org.au>
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
 <E1r8g9A-005ILj-Sb@formenos.hmeau.com>
 <2f75977b-1383-908d-bf32-5084ef260c53@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f75977b-1383-908d-bf32-5084ef260c53@huawei.com>

On Fri, Dec 01, 2023 at 11:37:59AM +0800, liulongfang wrote:
>
> Removed OFB and CFB modes. There are still some codes that need to be deleted.
> I wrote the complete patch content below:

Thanks, I will fold this into the patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


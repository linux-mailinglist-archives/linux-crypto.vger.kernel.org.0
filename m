Return-Path: <linux-crypto+bounces-962-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A681C3FB
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 05:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C861C21DA3
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Dec 2023 04:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CF6D6FD;
	Fri, 22 Dec 2023 04:35:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD52115;
	Fri, 22 Dec 2023 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGXFb-00DhNz-P6; Fri, 22 Dec 2023 12:35:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 12:35:18 +0800
Date: Fri, 22 Dec 2023 12:35:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gonglei <arei.gonglei@huawei.com>
Cc: linux-crypto@vger.kernel.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, lixiao91@huawei.com,
	wangyangxin <wangyangxin1@huawei.com>
Subject: Re: [PATCH 1/2] crypto: virtio-crypto: Wait for tasklet to complete
 on device remove
Message-ID: <ZYUSBpje8m9Grse6@gondor.apana.org.au>
References: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
 <1702294936-61080-2-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702294936-61080-2-git-send-email-arei.gonglei@huawei.com>

On Mon, Dec 11, 2023 at 07:42:15PM +0800, Gonglei wrote:
> From: wangyangxin <wangyangxin1@huawei.com>
> 
> The scheduled tasklet needs to be executed on device remove.
> 
> Fixes: fed93fb62e05 ("crypto: virtio - Handle dataq logic with tasklet")
> Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


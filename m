Return-Path: <linux-crypto+bounces-455-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786FD800B23
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C47D2818F8
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DFC25545
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 12:39:41 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD9F1729;
	Fri,  1 Dec 2023 03:16:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r91VJ-005jUY-CW; Fri, 01 Dec 2023 19:16:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 19:16:26 +0800
Date: Fri, 1 Dec 2023 19:16:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, t-kristo@ti.com, j-keerthy@ti.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: sa2ul - Return crypto_aead_setkey to transfer
 the error
Message-ID: <ZWnAigmdiFIweUjW@gondor.apana.org.au>
References: <20231127020301.2307177-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127020301.2307177-1-nichen@iscas.ac.cn>

On Mon, Nov 27, 2023 at 02:03:01AM +0000, Chen Ni wrote:
> Return crypto_aead_setkey() in order to transfer the error if
> it fails.
> 
> Fixes: d2c8ac187fc9 ("crypto: sa2ul - Add AEAD algorithm support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 1. Simplify code
> 2. Update commit message
> ---
>  drivers/crypto/sa2ul.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


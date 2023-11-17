Return-Path: <linux-crypto+bounces-157-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D07EF2C2
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 13:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1291C20361
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001CB30349
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD7B3;
	Fri, 17 Nov 2023 03:20:35 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3wti-000dDK-Nx; Fri, 17 Nov 2023 19:20:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 19:20:38 +0800
Date: Fri, 17 Nov 2023 19:20:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sagar Vashnav <sagarvashnav72427@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/crypto/aesgcm.c:add kernel docs for aesgcm_mac
Message-ID: <ZVdMhiilu/Xj3LdP@gondor.apana.org.au>
References: <20231025125708.20645-1-sagarvashnav72427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025125708.20645-1-sagarvashnav72427@gmail.com>

On Wed, Oct 25, 2023 at 08:57:07AM -0400, Sagar Vashnav wrote:
> Add kernel documentation for the aesgcm_mac.
> This function generates the authentication tag using the AES-GCM algorithm.
> 
> Signed-off-by: Sagar Vashnav <sagarvashnav72427@gmail.com>
> ---
>  lib/crypto/aesgcm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-630-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB6809AFE
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 05:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859361C20C7D
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A41569F
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:03 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394EB1712;
	Thu,  7 Dec 2023 20:04:29 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBS66-008Ias-LB; Fri, 08 Dec 2023 12:04:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:04:28 +0800
Date: Fri, 8 Dec 2023 12:04:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] crypto: ccp - fix memleak in ccp_init_dm_workarea
Message-ID: <ZXKVzGnviCY5Hb6+@gondor.apana.org.au>
References: <20231127034710.23413-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127034710.23413-1-dinghao.liu@zju.edu.cn>

On Mon, Nov 27, 2023 at 11:47:10AM +0800, Dinghao Liu wrote:
> When dma_map_single() fails, wa->address is supposed to be freed
> by the callers of ccp_init_dm_workarea() through ccp_dm_free().
> However, many of the call spots don't expect to have to call
> ccp_dm_free() on failure of ccp_init_dm_workarea(), which may
> lead to a memleak. Let's free wa->address in ccp_init_dm_workarea()
> when dma_map_single() fails.
> 
> Fixes: 63b945091a07 ("crypto: ccp - CCP device driver and interface support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: -Improve the commit message.
>     -Set wa->address to NULL after kfree() to prevent double-free.
> ---
>  drivers/crypto/ccp/ccp-ops.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-632-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113F809B01
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 05:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9991C20CEA
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627B6121
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:13 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F881716;
	Thu,  7 Dec 2023 20:05:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBS7D-008Id6-3j; Fri, 08 Dec 2023 12:05:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:05:36 +0800
Date: Fri, 8 Dec 2023 12:05:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Longfang Liu <liulongfang@huawei.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	songzhiqi1@huawei.com
Subject: Re: [PATCH] MAINTAINERS: update SEC2/HPRE driver maintainers list
Message-ID: <ZXKWEB010mY8Uehd@gondor.apana.org.au>
References: <20231127112449.50756-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127112449.50756-1-liulongfang@huawei.com>

On Mon, Nov 27, 2023 at 07:24:49PM +0800, Longfang Liu wrote:
> Kai Ye is no longer participates in the Linux community.
> Zhiqi Song will be responsible for the code maintenance of the
> HPRE module.
> Therefore, the maintainers list needs to be updated.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


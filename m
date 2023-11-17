Return-Path: <linux-crypto+bounces-160-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5017EF2C9
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 13:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC821C2081B
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036830FA0
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53C3D51;
	Fri, 17 Nov 2023 03:21:06 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3wuE-000dER-AS; Fri, 17 Nov 2023 19:21:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 19:21:10 +0800
Date: Fri, 17 Nov 2023 19:21:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Weili Qian <qianweili@huawei.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulongfang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/qm - remove incorrect type cast
Message-ID: <ZVdMpgYJAJt+NLPj@gondor.apana.org.au>
References: <20231028104012.8648-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028104012.8648-1-qianweili@huawei.com>

On Sat, Oct 28, 2023 at 06:40:11PM +0800, Weili Qian wrote:
> The 'offset' type is unsigned long in 'struct debugfs_reg32',
> so type of values casts to unsigned long long is incorrect, and the
> values do not require type cast, remove them.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/crypto/hisilicon/debugfs.c      | 50 +++++++++++------------
>  drivers/crypto/hisilicon/zip/zip_main.c | 54 ++++++++++++-------------
>  2 files changed, 52 insertions(+), 52 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


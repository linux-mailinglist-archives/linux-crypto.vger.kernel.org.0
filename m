Return-Path: <linux-crypto+bounces-634-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3D809B05
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 05:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C743281DA5
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8A4A1E
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:23 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C309B1715
	for <linux-crypto@vger.kernel.org>; Thu,  7 Dec 2023 20:07:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBS92-008IiG-1K; Fri, 08 Dec 2023 12:07:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:07:29 +0800
Date: Fri, 8 Dec 2023 12:07:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Damian Muszynski <damian.muszynski@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - fix error path in add_update_sla()
Message-ID: <ZXKWgd1bTpbq1Daq@gondor.apana.org.au>
References: <20231128173828.84083-1-damian.muszynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128173828.84083-1-damian.muszynski@intel.com>

On Tue, Nov 28, 2023 at 06:37:32PM +0100, Damian Muszynski wrote:
> The input argument `sla_in` is a pointer to a structure that contains
> the parameters of the SLA which is being added or updated.
> If this pointer is NULL, the function should return an error as
> the data required for the algorithm is not available.
> By mistake, the logic jumps to the error path which dereferences
> the pointer.
> 
> This results in a warnings reported by the static analyzer Smatch when
> executed without a database:
> 
>     drivers/crypto/intel/qat/qat_common/adf_rl.c:871 add_update_sla()
>     error: we previously assumed 'sla_in' could be null (see line 812)
> 
> This issue was not found in internal testing as the pointer cannot be
> NULL. The function add_update_sla() is only called (indirectly) by
> the rate limiting sysfs interface implementation in adf_sysfs_rl.c
> which ensures that the data structure is allocated and valid. This is
> also proven by the fact that Smatch executed with a database does not
> report such error.
> 
> Fix it by returning with error if the pointer `sla_in` is NULL.
> 
> Fixes: d9fb8408376e ("crypto: qat - add rate limiting feature to qat_4xxx")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_rl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


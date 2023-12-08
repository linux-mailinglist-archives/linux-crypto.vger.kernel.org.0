Return-Path: <linux-crypto+bounces-636-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CE5809B07
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 05:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385411C20C32
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAEDDB1
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:32 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA41712
	for <linux-crypto@vger.kernel.org>; Thu,  7 Dec 2023 20:07:37 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBS9E-008IiT-Tu; Fri, 08 Dec 2023 12:07:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:07:42 +0800
Date: Fri, 8 Dec 2023 12:07:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Ahsan Atta <ahsan.atta@intel.com>,
	David Guckian <david.guckian@intel.com>
Subject: Re: [PATCH] crypto: qat - add NULL pointer check
Message-ID: <ZXKWjjOvzD7pzDKv@gondor.apana.org.au>
References: <20231128191731.10575-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128191731.10575-1-giovanni.cabiddu@intel.com>

On Tue, Nov 28, 2023 at 07:17:25PM +0000, Giovanni Cabiddu wrote:
> There is a possibility that the function adf_devmgr_pci_to_accel_dev()
> might return a NULL pointer.
> Add a NULL pointer check in the function rp2srv_show().
> 
> Fixes: dbc8876dd873 ("crypto: qat - add rp2svc sysfs attribute")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> Reviewed-by: David Guckian <david.guckian@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


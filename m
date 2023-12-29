Return-Path: <linux-crypto+bounces-1082-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBF81FCCF
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Dec 2023 04:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6571F214EC
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Dec 2023 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9C17E2;
	Fri, 29 Dec 2023 03:29:45 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8CBA26
	for <linux-crypto@vger.kernel.org>; Fri, 29 Dec 2023 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rJ3Z5-00FG9Q-Rp; Fri, 29 Dec 2023 11:29:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Dec 2023 11:29:50 +0800
Date: Fri, 29 Dec 2023 11:29:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Damian Muszynski <damian.muszynski@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - generate dynamically arbiter mappings
Message-ID: <ZY49LhGOGYK1Wi4P@gondor.apana.org.au>
References: <20231222131804.8765-1-damian.muszynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222131804.8765-1-damian.muszynski@intel.com>

On Fri, Dec 22, 2023 at 02:15:35PM +0100, Damian Muszynski wrote:
> The thread-to-arbiter mapping describes which arbiter can assign jobs
> to an acceleration engine thread.
> The existing mappings are functionally correct, but hardcoded and not
> optimized.
> 
> Replace the static mappings with an algorithm that generates optimal
> mappings, based on the loaded configuration.
> 
> The logic has been made common so that it can be shared between all
> QAT GEN4 devices.
> 
> Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  .../intel/qat/qat_420xx/adf_420xx_hw_data.c   | 131 +++++++-----------
>  .../intel/qat/qat_4xxx/adf_4xxx_hw_data.c     | 110 ++++++++++-----
>  .../intel/qat/qat_common/adf_accel_devices.h  |   4 +
>  .../intel/qat/qat_common/adf_gen4_hw_data.c   |  90 ++++++++++++
>  .../intel/qat/qat_common/adf_gen4_hw_data.h   |  12 ++
>  5 files changed, 235 insertions(+), 112 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


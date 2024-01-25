Return-Path: <linux-crypto+bounces-1599-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567EE83BDAC
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jan 2024 10:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2DF1F30903
	for <lists+linux-crypto@lfdr.de>; Thu, 25 Jan 2024 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F628E09;
	Thu, 25 Jan 2024 09:42:50 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A4286A6
	for <linux-crypto@vger.kernel.org>; Thu, 25 Jan 2024 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175770; cv=none; b=Vex9DegYHf1Lxz7sLOCf64jVW2iAQ54RC95gvpVyZfDqdqfp7ruYYfEWLW8aHgUpDJPp+f9rIx2+PMDSnuHbNmazn1c5miInQNEF7gto7tsaifJR+UGXPZAxk5Yslan9JZUHxiEGbwoj41ghydNtAnZ+6TxCzAn+u3yqwwFAsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175770; c=relaxed/simple;
	bh=Cn18gzXDm9G/ulEdtJDQQ95A/BUjsvQMzPG1fPA1Vos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV3EFXQBnwuQKgSgyXTEkJ8OQkEgAEGFyA8T4TILmX2/jTBXiuz4IRKcbVp8HcubqTcZF+S4tpOK08KCwUlH9zgbngx5zzwYRRuDqaQOLutVDKylPSPJjOMY69gZYUeiynuZu70tnRSwDu3mFOpEN1HQL+WeMMoe9+n2/nFtReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rSwFv-005sUW-31; Thu, 25 Jan 2024 17:42:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 25 Jan 2024 17:42:55 +0800
Date: Thu, 25 Jan 2024 17:42:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mun Chun Yep <mun.chun.yep@intel.com>
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Markas Rapoportas <markas.rapoportas@intel.com>
Subject: Re: [PATCH 1/9] crypto: qat - add heartbeat error simulator
Message-ID: <ZbItH1hIRLMmsKwU@gondor.apana.org.au>
References: <20240103040722.14467-1-mun.chun.yep@intel.com>
 <20240103040722.14467-2-mun.chun.yep@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103040722.14467-2-mun.chun.yep@intel.com>

On Wed, Jan 03, 2024 at 12:07:14PM +0800, Mun Chun Yep wrote:
>
> +config CRYPTO_DEV_QAT_ERROR_INJECTION
> +	bool "Support for Intel(R) QAT Devices Heartbeat Error Injection"
> +	default n

This is redundant as n is the default.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


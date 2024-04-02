Return-Path: <linux-crypto+bounces-3242-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC48949A4
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Apr 2024 04:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E21F21F40
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Apr 2024 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73AD12E7C;
	Tue,  2 Apr 2024 02:52:11 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FD111A3;
	Tue,  2 Apr 2024 02:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026331; cv=none; b=YzHgKj89kXxL92shwFZZStLygjMdx6YR260tQregOkvJxP8tXt4ptj92i4edP/SHLdLzT+y6KLk8GWpuCwaebOSZHSa+3hFQxCuPhO8WWl5Z7eUz6DbUyY9wIBOv8ul5okfj3CTvE3Ep//07eylkJFdF4grk2x000UJrZInMNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026331; c=relaxed/simple;
	bh=f59qjvEgfCclh8yKY4I1GoY+t3DwAemlHnf7PbFpXr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwMF5oX45Jt9/4p9SwokGeM5SRDoBYRrrGlu6b4DWtZDsY1t50hlETCWaXOkac4GdcouKHzylvwPrkeA43bGb8gzPR6LlBC8VxkbpfKQkW7GbAkH0DDsqbJPmgIc3oFe6AS4D5uloWc/FPGkiQwZvQZ0yHXW4uBZmAB+6lM9f/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rrUFZ-00DvAu-Lq; Tue, 02 Apr 2024 10:51:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Apr 2024 10:52:06 +0800
Date: Tue, 2 Apr 2024 10:52:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Xin Zeng <xin.zeng@intel.com>, jgg@nvidia.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org,
	qat-linux@intel.com
Subject: Re: [PATCH v5 00/10] crypto: qat - enable QAT GEN4 SRIOV VF live
 migration for QAT GEN4
Message-ID: <Zgty1rGVX+u6RRQf@gondor.apana.org.au>
References: <20240306135855.4123535-1-xin.zeng@intel.com>
 <ZgVLvdhhU6o7sJwF@gondor.apana.org.au>
 <20240328090349.4f18cb36.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328090349.4f18cb36.alex.williamson@redhat.com>

On Thu, Mar 28, 2024 at 09:03:49AM -0600, Alex Williamson wrote:
>
> Would you mind making a branch available for those in anticipation of
> the qat vfio variant driver itself being merged through the vfio tree?
> Thanks,

OK, I've just pushed out a vfio branch.  Please take a look to
see if I messed anything up.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


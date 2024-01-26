Return-Path: <linux-crypto+bounces-1652-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1183D6F3
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jan 2024 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39D2296FF3
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jan 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DB858115;
	Fri, 26 Jan 2024 09:01:40 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624E50A9B;
	Fri, 26 Jan 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259700; cv=none; b=HdueQpHWPaWCXjNgFupIHOU8ChbYJII0Huf+Fzpu5xFCaONuMd5eNduxCKtMfcGtoLEo/L2GRIPi6s4M13MO7iTvinCX02yYTur0CFZdL3WTQr3NJa/ltFWgWXhR99foEXvwwfQQ883WouraZiAvJRd9GC6EleWGHw3YpHM2Q+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259700; c=relaxed/simple;
	bh=sKM/41HryWt595lTmEPgb4uhOFyFmSxYhYtBtvNjnwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaIpgV57kOxQs2r5P4ghOX15r5kf/QmS4JfQc7tFLXnsYdFX9n6xTyo3d4oJO+TcIz6ALmWQ2HjsOl9yXCIJ5j1jhf37g+60In87eGIIxgCnbzPL/VzM5QhVCsmlTibEYxVO+ZY5NqbiKagD7j3ivOD4adolfNqAnSggyHSAS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI5d-006Ege-RA; Fri, 26 Jan 2024 17:01:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:01:46 +0800
Date: Fri, 26 Jan 2024 17:01:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Weili Qian <qianweili@huawei.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulongfang@huawei.com
Subject: Re: [PATCH 0/2] crypto: hisilicon/qm - add debugfs qm_state for
 hisilicon driver
Message-ID: <ZbN0+nyYyRxAsH5u@gondor.apana.org.au>
References: <20240112102546.2213-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112102546.2213-1-qianweili@huawei.com>

On Fri, Jan 12, 2024 at 06:25:44PM +0800, Weili Qian wrote:
> Read some device register values for error analysis.
> Patch #1, the debug file 'qm_state' is added to obtain
> the current device state.
> Patch #2, read device register value before resetting
> to help analyze the cause of the device exception.
> 
> Weili Qian (2):
>   crypto: hisilicon/qm - support get device state
>   crypto: hisilicon/qm - dump important registers values before
>     resetting
> 
>  Documentation/ABI/testing/debugfs-hisi-hpre |  7 +++
>  Documentation/ABI/testing/debugfs-hisi-sec  |  7 +++
>  Documentation/ABI/testing/debugfs-hisi-zip  |  7 +++
>  drivers/crypto/hisilicon/debugfs.c          | 53 +++++++++++++++++++++
>  4 files changed, 74 insertions(+)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


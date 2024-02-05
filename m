Return-Path: <linux-crypto+bounces-1834-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FB384982A
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Feb 2024 11:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FBBB234BC
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Feb 2024 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F017588;
	Mon,  5 Feb 2024 10:57:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469691759C
	for <linux-crypto@vger.kernel.org>; Mon,  5 Feb 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130636; cv=none; b=aRHNTzpYGIgx2jWfSp0rjCfKgPy6vl2Od2Hd0FFX+vPNFsV8lsK0moX+AEstE7/BUDLIVx03fnAj4oOwTtIGSWGIjc+mcjHanX5rGA4Ct9N02DBxHFz13BQtREF4mG4g1q5oUp0NgCgNKhrS/4+medAmd1zWyb76SZj1FKn7p18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130636; c=relaxed/simple;
	bh=A/JBG60iUAYOsvqnBHyDFd8jT2G/vKHakLPI6CqNzuo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=II+iBh/mFPz0IL7pNYGrn0XNmrJ3x+mJPa2JmjezgiZ/yA9su/oEmJ0tHNJZrfJ0BX3iJfrcm/jM+0zGOkxcThdMO7TF9+2xXD0Efsf4zp8lGzaqcWJOgnXfywlrLxYkomqrBVOovm3lDuRba+Jnf+hHe8/hissdrESp5jjh73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rWwes-00A1zk-9N; Mon, 05 Feb 2024 18:57:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 05 Feb 2024 18:57:15 +0800
Date: Mon, 5 Feb 2024 18:57:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org
Subject: Failed self-test on ffdhe6144(qat-dh)
Message-ID: <ZcC/C/kpcKaoVPp4@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

I received a report that ffdhe6144(dh-qat) fails its self-test:

alg: ffdhe6144(dh): test failed on vector 1, err=-22
alg: self-tests for ffdhe6144(qat-dh) (ffdhe6144(dh)) failed (rc=-22)

Could you please take a look at this and see if it's
reproducible for you?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-14185-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CFAE39F8
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Jun 2025 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C45F1720FB
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Jun 2025 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0A235065;
	Mon, 23 Jun 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="R0ywTP8C"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA922F77F;
	Mon, 23 Jun 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670746; cv=none; b=Lu+Vk13ApZHP49yJJmfb13ZiMidYIcj2qlAWMGRwMTHhGIrFVEnUimnvmMEb1BcbE8pd3KgWLumNWxYIazuu+xvD9p+xEC/1v9hJ9ElpQQTp2DTYN3t5RaTnNYF/hh06IauUJqNH0tFbwF7fTcQBvvODa9fhca6kHiYYYBiBqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670746; c=relaxed/simple;
	bh=00+EPK/21VC/b5I1UKB9YxpTEx5YrMG3tegNbrFYB0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAc3lSwhshjCm5KDb4UmF0hJ+I7liM1jvNZvvG9WKi0bRFnzIX608zoBUMqIhQ4zhLTkWPg5+P2hoWlnemBdIh1mylU0mH76L/rjthHjREpbIxWm08d5wqPNR8dX6HUmPVRZUQBKZZLtuLNglG+21Co4rgKEl0gbLkTPstQ3oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=R0ywTP8C; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FwhGMJIQjz0Ym8X605mJeEQjWYHuRofwwZtU1OiUGLQ=; b=R0ywTP8CPqnY1rJXtZ+nl1BEm+
	ZGbFzq284tH1+AoxbWSiiQY0ZugRWLxx1oBeVT4OcfKszQqI5Ia6kUdVR/An5sthz0kjB7wZ1bZE8
	7ZqBEyqDyq7TbhPXR/ff5rDVgS9YzG69jbpwutZwme/AATvCULg+Q7TTAau+hQLgc27qc4sh2NGiB
	CsnlJsgiLQ/VYoRDOdkpUWTLTOQ5EomjGwSkqznXIbKC4ibf8Aes7YjZ5lOcqc32iCcXcAuaJxhRE
	rG9iLk1eS3lq1VKAjyVO7HnrdwaasXk3dKPkekRDtpU1MZJ+yrBXBGdr1hagHUbL73c+EzIkvuleE
	P5K5QSYg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uTdBI-000Ffu-3A;
	Mon, 23 Jun 2025 17:25:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 23 Jun 2025 17:25:33 +0800
Date: Mon, 23 Jun 2025 17:25:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree - Don't use %pK through printk
Message-ID: <aFkdjTsui7BZE5Kt@gondor.apana.org.au>
References: <20250618-restricted-pointers-crypto-v1-1-e354644aa381@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618-restricted-pointers-crypto-v1-1-e354644aa381@linutronix.de>

On Wed, Jun 18, 2025 at 09:10:18AM +0200, Thomas Weiﬂschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  drivers/crypto/ccree/cc_buffer_mgr.c | 54 ++++++++++++++++++------------------
>  drivers/crypto/ccree/cc_cipher.c     |  4 +--
>  drivers/crypto/ccree/cc_hash.c       | 30 ++++++++++----------
>  3 files changed, 44 insertions(+), 44 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


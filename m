Return-Path: <linux-crypto+bounces-22203-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFEMDVxcvmmYNQMAu9opvQ
	(envelope-from <linux-crypto+bounces-22203-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:52:44 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F72E440D
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E227302452E
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A73009D4;
	Sat, 21 Mar 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="BDv3KI8V"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D02C3261;
	Sat, 21 Mar 2026 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774083136; cv=none; b=Xu3AAaSVf71UTIEZyh0QBGgRPg5g1CgxWoC5HR7i7kN6ElvMGoJ2Yw413FFNV2UdhtgB0SXUeyFDujg0e7GdYozzQfA/LL7bZbrvrGZaV7q43KLQTXCqZkdxJeB/6wm6vvv3vcYFYKZCyNRauf/RcrIAtyPz9YEA5b9wtEZbO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774083136; c=relaxed/simple;
	bh=Ua/XbLTIyo4VRsBmMFsh+g/PPVeZ0ZMJQIZhnXyLP7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfRG6ro+tu6uiG/eDaqWeqRP/QesNNbyJutYGInxNHQIDoh6Ll41/qDdN7bmvm6jHnExRPlU58LzvZnmkZvogl4V4TgdWJgCKjp5iecxtUKrp84fDyuvwR/0IXqgIWnYYpA9tXMbzM923Wrk/HnKc8Yc+kjqXBLG34ZfnITmKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=BDv3KI8V; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=LlFR318gJ1gMU0Qfn/2NoRJ8JYXXHQ5UFBwLMC105ow=; 
	b=BDv3KI8VSOLFIXnZz1kfA2irarToFdeGdtWjdrMlyaX0zNX7NDpXpGlHp7l6C0SYUvVw9pCetG5
	lm/AryZQKO40bsvEHrcS/+cw9tzgVSK7zPZB0igWmimDuVp2QP4q0YqrGUx7Y/ZJBCoI+uEwLQ1du
	RPNPsKI4RxckhNb/4HwVDhkjr/A9N61WhJOJztIFJn3suBUW9S3CwDx4Tv5c9+6KjbFlTy1Pdv3pa
	yKB1OAAltR2JpFqAWH+Z7gLAcy2XRBXr3mo+61wyMS7axKyTzB4eQnH0ZvaCLwPEp4w8jy+Uxcpk8
	3CdqMaGC/k8Rtrh1UwgA5zjbJ/cbAncwgoPQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3s43-00GJFr-37;
	Sat, 21 Mar 2026 16:52:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:52:11 +0900
Date: Sat, 21 Mar 2026 17:52:11 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: simd - Remove unused skcipher support
Message-ID: <ab5cO9G4vtCA44G6@gondor.apana.org.au>
References: <20260314213720.91525-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314213720.91525-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-22203-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 8E6F72E440D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 02:37:20PM -0700, Eric Biggers wrote:
> Remove the skcipher algorithm support from crypto/simd.c.  It is no
> longer used, and it is unlikely to gain any new user in the future,
> given the performance issues with this code.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting cryptodev/master
> 
>  crypto/simd.c                  | 231 +--------------------------------
>  include/crypto/internal/simd.h |  19 ---
>  2 files changed, 5 insertions(+), 245 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


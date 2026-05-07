Return-Path: <linux-crypto+bounces-23805-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JK0yHYQU/GnuLAAAu9opvQ
	(envelope-from <linux-crypto+bounces-23805-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 07 May 2026 06:26:44 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B814E2DD5
	for <lists+linux-crypto@lfdr.de>; Thu, 07 May 2026 06:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DFA6301D4E2
	for <lists+linux-crypto@lfdr.de>; Thu,  7 May 2026 04:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDA31AF24;
	Thu,  7 May 2026 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="UQYv+lu4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577FB2877F6;
	Thu,  7 May 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778127997; cv=none; b=JfWwYou4LAwLWvZc2VQBlbd68In0r3zcQtOlstUBfUB+pj/1uwq3rFehyIrSf18y0zjZ3/pMYDE4SBs4uZJlPnlv8IOCA8Mjj2jRL9xa7LwGJIJZOGVHFYgPTYBU6RRtMjvEvpSLdpjpVrNYRrjeYfywCvExJHX85cWvoZ1eCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778127997; c=relaxed/simple;
	bh=2ZU09yoIoeCOjqOtJbUSCJYDA1Z0M2qXXcDYU3w3YQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY8bO8GSfMkTEeKBi6GbFOECaSCgDoHfwkGK6tJCXg/nQdGDZHHXZ8nrXPWr2rtc8A+//g34c9V4jdDcw0y6S/VLLqMV8M8R0+iKEgQT7X6D3QHvG1ALLNCPCwY+YPEs2K3dV+RTi5On7HPPth6BppOJyU2JXFwW9WwIIe97diY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=UQYv+lu4; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=MvPzzsvHctHnMtYRG2OKSFYZZHjdxckNh62GwVYaH0g=; 
	b=UQYv+lu4IUSZsaIQ7A77oSV41DQAhleQpfOACrswFTdKGtYqAJXZI8JWhpJhlvtCauWG4bI+df9
	qiiBnqDG4cxMHSRK9Xx4b4kpaDVV68XDZeh6llvHBq0yC44r1kr9W5TxPB016DuvQatBoWdpmp8U/
	EKxtoxQvhgZINeTpYqFRXOOuivxY7ORqdRO6Bb4FWz+IDEE1ELek6ftV8DmJQqklEzRmEZphHXm36
	VO5/JSdOQ5hTpPU5mS6dPSFaaXmy3C6IawTQehq7AS2mUjPwHT5rfU4Tufm1zn8+505ibtN4yp4cx
	rr3Z6renCgqgMUtRONddRRPGS9IKA+h4dJrg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKqJO-00Bycj-0Y;
	Thu, 07 May 2026 12:26:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 May 2026 12:26:10 +0800
Date: Thu, 7 May 2026 12:26:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lukas Wunner <lukas@wunner.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ignat Korchagin <ignat@linux.win>,
	Stefan Berger <stefanb@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] crypto: ecc - Unbreak the build on arm with
 CONFIG_KASAN_STACK=y
Message-ID: <afwUYlGYZH5cSbg3@gondor.apana.org.au>
References: <7e3d64a53efb28740b32d1f934e78c10086208ab.1778073318.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e3d64a53efb28740b32d1f934e78c10086208ab.1778073318.git.lukas@wunner.de>
X-Rspamd-Queue-Id: 00B814E2DD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,linux-foundation.org,arndb.de,gmail.com,linux.win,linux.ibm.com,vger.kernel.org,googlegroups.com,google.com,arm.com,linux.intel.com,kernel.org,zx2c4.com];
	TAGGED_FROM(0.00)[bounces-23805-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 03:27:49PM +0200, Lukas Wunner wrote:
>
> Changes v1 -> v2:
> * s/ARCH/CONFIG_ARM/, s/LLVM/CONFIG_CC_IS_GCC/ (Nathan)
> * Add link to gcc bugzilla entry
> * Rewrite commit message to include feedback provided by gcc maintainers
>   and explain high stack usage with algorithm choice
> 
> Link to v1:
> https://lore.kernel.org/r/abfaede9ab2e963d784fb70598ed74935f7f8d93.1775628469.git.lukas@wunner.de/
> 
>  crypto/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)

Sorry but v1 has already been applied.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


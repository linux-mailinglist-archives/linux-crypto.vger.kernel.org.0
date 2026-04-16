Return-Path: <linux-crypto+bounces-23038-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BwcDJen4GlZkgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23038-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 11:10:47 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D840C051
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D244300B62E
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2026 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC33815DC;
	Thu, 16 Apr 2026 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="m8rWVK+P"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595138911B;
	Thu, 16 Apr 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330411; cv=none; b=SZZT1I3BEUthYQbxmqTQHFCvFSkgW9vBEcdCVMl5mElgKF9+ATHGP4yvTkh4LRX8nSzhZIMykUfVsuuIZNILWP1LnoXj5iPf9PutEL+yo1fN21gF9KcmxYlt+QEsH0ZfWDGAkukqw7mDBzFa6nVIHn2nhnXGC7HgUWVxU72Ke6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330411; c=relaxed/simple;
	bh=sd4l45J7JVR41fkLv7/opVSX++as0aGrrgxz+JYAvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp0YhvVRM3EohzVCpPAvNtGHImOe+o9J+70cm9pt+5U8JpJvmW4TmT3jaSRCEu45IdBSuzoS4aR77aqLGgNLLTDaI+N1xMmAKwlcmmrn2cunpE6k0ymNiJ8Edfc74t39B0znTbqf26ryhVTJD6pgfrhjgiHA/AWVIufGJqtlxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=m8rWVK+P; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=OkhT0SJSXNUabO8sjsvBTtSy3/Xnqv7M3gz/N6ysxEk=; 
	b=m8rWVK+PwBbAdMiq6WjvcnjUrVYIDVYXKcOy6mTtCJlAEJtwJkBCJdxz5RIU3kMXpU3ZhfEUcZb
	wn4/cNzbPVSr//Y2ZQrtBGlimJj9XABAoSoXVJQzosGBT4Ngh8R+D8hMqPZjdTboLmXAYrkGiPZXA
	QXK91HiP8IEkJg6THPulcf+ph0ylUPrW0iKa3F2X0Jc63OR7XgppS0SX/MJNpqimYsqkqr6jhULuc
	5A5OQxZZY3HDdl/n1n8Lgkf92BnXyNzZw8Cd2Ssan69gOQX8TdWxDSWreNQfMkIEn0L5R64Dw0BDv
	ZtbD1uAdACjTfvGsLTgAXT1HLotOKDT/eQOg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wDIg7-006VCE-2a;
	Thu, 16 Apr 2026 17:06:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2026 17:06:27 +0800
Date: Thu, 16 Apr 2026 17:06:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	Paul Monson <paul.monson@capgemini.com>
Subject: Re: [PATCH] crypto: tstmgr - guard xxhash tests
Message-ID: <aeCmk6LbLFT4Keo2@gondor.apana.org.au>
References: <20260407192859.270745-1-hamzamahfooz@linux.microsoft.com>
 <adYNClYB6RY820Xl@gondor.apana.org.au>
 <adffSYxKIuaDLZit@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adffSYxKIuaDLZit@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,linux.microsoft.com,capgemini.com];
	TAGGED_FROM(0.00)[bounces-23038-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:url,apana.org.au:email,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 368D840C051
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 10:18:01AM -0700, Hamza Mahfooz wrote:
> 
> alg: hash: failed to allocate transform for xxhash64: -2
> Kernel panic - not syncing: alg: self-tests for xxhash64 (xxhash64) failed in fips mode!
> CPU: 0 PID: 425 Comm: modprobe Not tainted 6.6.130.2-2.azl3 #1
> Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 01/08/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x4c/0x70
>  dump_stack+0x14/0x20
>  panic+0x179/0x330
>  alg_test+0x678/0x680
>  ? __alloc_pages+0x1e2/0x340
>  do_test+0x26f8/0x7670 [tcrypt]

So the error is coming from tcrypt.  I think that's where the ifdef
should be added.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-22707-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDvOGcp9zWnqeAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22707-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 22:19:22 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20903380133
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 22:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E19F0306A8BA
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B93644BB;
	Wed,  1 Apr 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvkmYeXx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62D3630B9;
	Wed,  1 Apr 2026 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074729; cv=none; b=KnRD5BCLDtcbYCx3abuYn527oK6iOKlauP5ZKpkFwvFfLsHBtsBwpXRoBlKZmQ2EJEkrwmEqCQpw9xzk+1kN2omdMNrIEDuc13It1SwGQQvlT8PeVpuAz5my91Syvcs2whmJ4+yRQVll0+S0Ubb8cl9rN8zyTdu1LekVxurd+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074729; c=relaxed/simple;
	bh=QuFRnM3S5kd6qPOKy5HubX7OVOmossUj5JDjFTFx+Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSSrKN2nAr1mlJE2RIwIAwk5D5At3POXTFTafitnVtQeh10JUbX5pgHriZV75mpsPtqb0EsRh2pIWfM0cURsQ57seR2SccwaNeQHOqS5RA48w73wpH27oOTOOWapPHuVWTp+yaofqR5pHe4u+8Op0n5V1VVdx8zVFVLkMjHkODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvkmYeXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A1AC116C6;
	Wed,  1 Apr 2026 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775074728;
	bh=QuFRnM3S5kd6qPOKy5HubX7OVOmossUj5JDjFTFx+Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvkmYeXxF0QgMqshyCDLkNzXA/pUmC4ubmso8EWA8Zps6J+qSktZrcUYx09MKkzCX
	 ZYe5a1tNbrccGFW/95Qqyxi4ugsCejCrn7cdGHsSjomxHC4nOrdol+EKZp6+niTHLi
	 l33iMQneIK+IxygjNn32WnwJ+YY6xxrCjJJWlbORM2Nmd1jMSm5j+udxlBGTrF6hLB
	 EoZH3jNO/4MAS+Gw7Gapl4Mg+4V54Ud9opqxKPStaLxeG8kX9zcqB/yQ3KuhjJY3Zh
	 D0+oDbJqLLA5a/MYMpTZIDQI1ToHc3umDcmbEbbwVqWncnO7JZN6+BkxO+TBwyGhXP
	 ORCI3nfP2I5Ig==
Date: Wed, 1 Apr 2026 13:18:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] lib/crypto: aesgcm: Don't disable IRQs during AES block
 encryption
Message-ID: <20260401201846.GB2466@quark>
References: <20260331024430.51755-1-ebiggers@kernel.org>
 <20260331050234.GA4451@sol>
 <1e04994d-4d82-48f4-8022-ea488d203653@app.fastmail.com>
 <20260331205511.GA2452@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331205511.GA2452@quark>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22707-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20903380133
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 01:55:11PM -0700, Eric Biggers wrote:
> > AIUI, if we drop the IRQ dis/enable from this code, the generic path
> > will be taken during early boot, but later invocations will use the
> > accelerated implementations once they become available, right?
> 
> Yes, that's correct.  The optimized code gets enabled by a
> subsys_initcall.

Also just to clarify, once the optimized crypto library code has been
enabled by the initcalls, it applies to all later function calls.  So
the library (e.g. the aesgcm_*() functions) doesn't have the problem
that the traditional crypto API (e.g. crypto_aead) has where unoptimized
code may continue to be used for an arbitrarily long time.

Anyway, I'll plan to apply this patch.  But it would be interesting to
hear from the x86 and SEV folks whether there is interest in making the
early AES-GCM operations in snp_secure_tsc_prepare() use the AES-NI and
PCLMULQDQ optimized code for better performance and side-channel
resistance.

- Eric


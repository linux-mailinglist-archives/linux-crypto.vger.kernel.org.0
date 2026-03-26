Return-Path: <linux-crypto+bounces-22447-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MH8Bhe7xWkeBAUAu9opvQ
	(envelope-from <linux-crypto+bounces-22447-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 00:02:47 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B70733CDEE
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 00:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94A4530304B0
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 23:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547A349AE1;
	Thu, 26 Mar 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfzPDzzY"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CF348895;
	Thu, 26 Mar 2026 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566154; cv=none; b=niuoJxuGlPu+GeijyCiNYWTVA29D6cwIpgZGJ7CCu3iCo5eVFSoP+ZnNyE/ZiYCFpVcB/xwHnpNV3TW74EctRuU+S+Esqp0zpySWx7LlVRk0ury9HrESVy9fVvmeIgtxXL6UYxadDknzPwprY7Oqlkzg7Js1M/jnt4oq4BDl0Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566154; c=relaxed/simple;
	bh=+Gaq4pHwzIyQrpjALRkMbCW4mgVtwEeLvMwgKOXH1Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqsyY9p30Uafx6pQokCGDfKyNLbJrP/SI6SpbjP/skcOBVio4mgLmP5jIOoAIZ6SXzm1pe80VCATB5UJLTmPaM2brOWRt8XXlnbYGYmRBZ8ntCxQNaL0Z09I75WVOCSGKsKphRRhElTPmqh1gpQZ2ltYiwd/2yMl68lqUBIbJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfzPDzzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA9EC19424;
	Thu, 26 Mar 2026 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774566154;
	bh=+Gaq4pHwzIyQrpjALRkMbCW4mgVtwEeLvMwgKOXH1Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfzPDzzYl5ryLE4epgtOQRmb0TNQfTZ6YskDruWMcItyi8OR1w28Xpl4QoXlkv62F
	 JqspJIrw9FzCru1gKX8Vz4DhrTcR5KVd0VX6Y4dIqN9HUjCxrQAd6KNyCsZOzksNzx
	 HATHlE4CjZ2Up/vnvqp0kNh3RAuh23cchmhpV/9RYNF4g9pZyAnh/gLnE4+xS+QJ6n
	 WHpJWh58dC8CUSKC8edKB+BS+FgpyqhHkQAvU1sWFmzYyQ5r3ZNRiCW8Z3kBjghxYO
	 Yof9eYBSOCUYOHcbEZMUm/11N3tO2BODKP/uqsEGPHaTAtvegnt97lYYq+5JKH8NiY
	 mohha2OUwFxkg==
Date: Thu, 26 Mar 2026 16:02:32 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH] lib/crypto: sparc: Drop optimized MD5 code
Message-ID: <20260326230232.GA67831@quark>
References: <20260326203341.60393-1-ebiggers@kernel.org>
 <fc5a80f3579d642a9f792a33b0f7ef6101838f83.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5a80f3579d642a9f792a33b0f7ef6101838f83.camel@physik.fu-berlin.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22447-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B70733CDEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:51:01PM +0100, John Paul Adrian Glaubitz wrote:
> On Thu, 2026-03-26 at 13:33 -0700, Eric Biggers wrote:
> > MD5 is obsolete.  Continuing to maintain architecture-optimized
> > implementations of MD5 is unnecessary and risky.  It diverts resources
> > from the modern algorithms that are actually important.
> 
> Why is it risky? That makes no sense.

Because there can be issues in architecture-optimized algorithm
implementations that don't exist in the generic implementations.  That's
a very common class of issue that has repeated over time.

> I also don't see how it diverts resources as no one is forced to work
> on the code.
> 
> SPARC is an architecture used by hobbyists and in space these days (in
> the form of Leon). I don't think any other kernel developer will have
> to take a look at it.

Huh?  We've been refactoring how the various crypto and CRC algorithms
are integrated, for all architectures.

So people outside the SPARC community, especially myself, been having to
spend quite a bit of time updating the SPARC code so that it can still
be used.

And this isn't new.  I've had to patch arch/sparc/crypto/ many times
over the years as things change in the crypto subsystem.  Many other
people, again outside the SPARC community, have as well.

The fact that you're denying that we've had to do this is really
frustrating.  There is a significant maintenance cost to keeping this
code working, which is being paid by people outside the SPARC community.

It seems best to at least focus that effort on modern algorithms like
AES and SHA-256, and not obsolete ones like MD5 and DES.  Note that
dropping those eliminates the need to add them to QEMU, as well.

I think that makes things easier for everyone.

- Eric


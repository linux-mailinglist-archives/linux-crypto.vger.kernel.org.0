Return-Path: <linux-crypto+bounces-23268-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHCjEkFj5mmavgEAu9opvQ
	(envelope-from <linux-crypto+bounces-23268-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 19:32:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B39DD43165E
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 19:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6896C3060215
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC43A1E6C;
	Mon, 20 Apr 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFyq+4tm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D139F18A;
	Mon, 20 Apr 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706009; cv=none; b=eKWL589hmvbiCHxHD+zZ9f3oGcErhMEOvDMGcwuD5VEcdcw6LoQjcWyUQ6oFpfX1pWcR+n4TCU6xHjHlP4qpNiLT4Cse4SE5BNTx3K9pXUkJEaekpuUA/ydx7WDU4ltCnyDNGVvyv5QJVMs0uNB0ba6nEpa+g/Eo356F/uMd0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706009; c=relaxed/simple;
	bh=1TJ7659gBIjljfsN5vIbDUBqCTI+XQzZvR9/ICt9cG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnsCcAM7sK9/uOUdmb3zwFMTXbqdUtT7XM4yHkShJ5OyQ2iC6paiPjcwpD9T6BrA3LtevmmyCuo3eZniBaA2Mrlyb7C0AE1mmQt5iiVEkU71HTmUvnijZxgx0mVVYq7GTGGpmzbRsmxtqRIDj4ORY+9OyI76G6bslVIQsWU5iUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFyq+4tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2956BC19425;
	Mon, 20 Apr 2026 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776706009;
	bh=1TJ7659gBIjljfsN5vIbDUBqCTI+XQzZvR9/ICt9cG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFyq+4tm/gWpTapa3NwnYClwpNxx9LsS9gVxmfnPNwfMSndWm1GjNAfSzRTSPVd8d
	 rwpW3OJUDtiyQNOF6xQeP6X3bLR/XNwUtocPMcFqMlW3a26igYX3stvA8YagCh4bgG
	 35nUJ5ncGrvoFczXTUvE3Exo5uXwLAjAs2Y2iQcDhN97sYCd7Zry6j3FI6g77wr7O9
	 lFAKL7CB3jhimm/WlLdQn9sZCdBKABg2HYvy3k6F9EVs8Q+2qmdD+Bd29Bjp6SNP21
	 CLj5u2F3BILv5GzaSIwkcqGYMDfrqnuaHndHtr9duKsOn9tBeZdkpsKAEaLsEp4Q79
	 Cm98Zm4uo1e3g==
Date: Mon, 20 Apr 2026 10:25:34 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Joachim Vandersmissen <joachim@jvdsn.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 36/38] crypto: drbg - Remove redundant reseeding based on
 random.c state
Message-ID: <20260420172534.GB2221@sol>
References: <20260420063422.324906-1-ebiggers@kernel.org>
 <20260420063422.324906-37-ebiggers@kernel.org>
 <9e13b506-576f-4753-96e4-9e12085627bc@jvdsn.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e13b506-576f-4753-96e4-9e12085627bc@jvdsn.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23268-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B39DD43165E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:48:47AM -0500, Joachim Vandersmissen wrote:
> Hi Eric,
> 
> On 4/20/26 1:34 AM, Eric Biggers wrote:
> > We're now incorporating 32 bytes from get_random_bytes() in the
> > additional input string on every request.  The additional input string
> > is processed with a call to drbg_hmac_update(), which is exactly how the
> > seed is processed.  Thus, in reality this is as good as a reseed.
> > 
> >  From the perspective of FIPS 140-3, it isn't as good as a reseed.  But
> > it doesn't actually matter, because from FIPS's point of view
> > get_random_bytes() provides zero entropy anyway.
> > 
> > Thus, neither the reseed with more get_random_bytes() every 300s, nor
> > the logic that reseeds more frequently before rng_is_initialized(), is
> > actually needed anymore.  Remove it to simplify the code significantly.
> > 
> > (Technically the use of get_random_bytes() in drbg_seed() itself could
> > be removed too.  But it's safer to keep it there for now.)
> It's fair to say that the additional input is as good as a reseed (if FIPS
> is not considered), but then is there any reason to keep get_random_bytes()
> in drbg_seed()? You say it could be removed but it's safer to keep it there
> for now? In what way is it safer? The additional input is mixed into the
> HMAC_DRBG state prior to generating random bits, so should already provide
> sufficient assurance that the generated bits incorporate the output of
> get_random_bytes()?

I do agree that patch 34 makes the get_random_bytes() in drbg_seed()
redundant too.  I'm just not yet sure that removing it would strike the
right balance between defense in depth and eliminating redundancy.

Keeping it there also keeps it very clear that whenever jitterentropy
entropy is used, we're also using an equal number of bytes from
get_random_bytes() alongside it.  (Remember, not everyone "trusts"
jitterentropy.  People auditing this code might *really* want to see the
get_random_bytes().)  The additional input does achieve the
get_random_bytes() integration anyway, just it's a bit more subtle.

- Eric


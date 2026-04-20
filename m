Return-Path: <linux-crypto+bounces-23265-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFn0J/tw5mlgwgEAu9opvQ
	(envelope-from <linux-crypto+bounces-23265-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 20:31:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF27432DE1
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827A1302D11F
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Apr 2026 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBCA37FF5F;
	Mon, 20 Apr 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/S2Hbol"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73B3803D6;
	Mon, 20 Apr 2026 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704895; cv=none; b=AvimkDTS9/QWBNpQZKQJ3Wgd2sZts2GloD1PxaCG+JQf+/nyFYBvh/wEJcJVZqwLkFfkp/7A4gIoQMeiXwerOyby93A1veggUnTRKkIRj10CeHJ8i4BzH2p7SUZCofWSjzzp2Zvb+dUa1JkhtExJ9P2vIeVuiZHq7LDC2T9TMDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704895; c=relaxed/simple;
	bh=FYz1VZf9g1I0c8ARFnRWkjvki2i5TzMf8qhqF9I2Dnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owfwK9WfwYRe90oT27TF3OyzAAxyTzw1rWJA66985gRyABuUvWUBOwEqV3eKrl11x18iH+NA9sCBL/nHg3+FzbIFnwoIPt37EquzLXTzxmi7PQF4uvBoO7XxFDEtq4ysu3z1ZZEUVEieKMgfq2kvYlTrZjr+DOsc4gO0uITrxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/S2Hbol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956EAC19425;
	Mon, 20 Apr 2026 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776704894;
	bh=FYz1VZf9g1I0c8ARFnRWkjvki2i5TzMf8qhqF9I2Dnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/S2HbolvSurupNG0KnXP1vEJg26J+pFYECKum1YKR7xiekNikaQTJ5MnQL5kgU7f
	 eUgbSs1z0HZeB+arhTyAcIcTpfcRg06F0mMbqL1m+BP8uaBMtRywjtA2ptwUEb0HXc
	 0ngIw1yXQ7iUwh41rPbhTxG2XhIw3RjMtbihE5KTVWCWB5uUhX874aKI8PzE4Aewll
	 Iuc3RWHA5F3W4191LjrpKAE+MOj9egl0USraaa9ZxSu+i0bh/JReEL2y+e8e3daBrB
	 EtUIhIBaWm8253/Tioz7sieFWyrteejl/GJKxyh8DSCJwTAL9lpUHMHF7Zn0ntTsh1
	 9vqjb0REvc4oQ==
Date: Mon, 20 Apr 2026 10:06:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Joachim Vandersmissen <joachim@jvdsn.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 15/38] crypto: testmgr - Add test for drbg_pr_hmac_sha512
Message-ID: <20260420170659.GA2221@sol>
References: <20260420063422.324906-1-ebiggers@kernel.org>
 <20260420063422.324906-16-ebiggers@kernel.org>
 <7fcf8910-ccbc-4bf5-a0f0-d2d206726e52@jvdsn.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fcf8910-ccbc-4bf5-a0f0-d2d206726e52@jvdsn.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23265-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DF27432DE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:04:51AM -0500, Joachim Vandersmissen wrote:
> Hi Eric,
> 
> Was there any particular reason for adding this test? I don't think there's
> any _explicit_ requirement for having tests for both non-PR and PR DRBG
> variants.

Well, *if* predictionResistance=true continues to supported, then this
test is needed, considering that drbg_pr_hmac_sha256 and its test was
removed.  Code always should be tested.  (Also, considering FIPS, the
guidance I've gotten from a FIPS lab in the past is that
predictionResistance=true has to be tested if it's supported.)

> In fact, as part of this very comprehensive cleanup, maybe the PR variants
> of the DRBGs should be removed as well? Is anyone actually using those? PR
> variants are (were) registered before the non-PR variants, so non-PR was
> always used by default.

But yes, I think you're right that we should just go ahead and remove
support for predictionResistance=true too.  I was a bit on the fence
about removing something that's "more" secure and also has a relatively
straightforward implementation.  But since it's not the default, it
doesn't make much sense to use it, this test would have to be added, and
it's not required for FIPS certifications either (in fact it seems to
just make them a bit harder), it does seem like the right choice.

- Eric


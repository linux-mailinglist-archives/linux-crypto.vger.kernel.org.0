Return-Path: <linux-crypto+bounces-22613-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN+HHmrRymmsAQYAu9opvQ
	(envelope-from <linux-crypto+bounces-22613-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 21:39:22 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D6360866
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE145301909A
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963239A807;
	Mon, 30 Mar 2026 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6jSIlna"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E939A070;
	Mon, 30 Mar 2026 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899551; cv=none; b=JLLnXnBwJ/tkyg2HrcMZO28Rhviz9fu8gI144CDrnW3GzS/GbLuEHNdnm99APmayw5ztYg0MYzUP0Xyf2W62VUneVCaV+0LwxO97pL8yKX8jsYpHkKLBpQTYSR84ApcrkGwloN4lgbGr9TDM3zdGu0yn6FXBxHQ6deBMJoVjnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899551; c=relaxed/simple;
	bh=2WLRMjI/pCjrMWMBwQlQsxYU5dS7dWF3LUHYmdKUf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ0CJmOfWL8/SPJAeqCr8/Q03EGhAF+WH4fBLr4qRGiJSrKf8Qp/ger+jgrS9VmMFC7bWBamCfWZzjYMf5354yvw2mOI4d9TqE35qGFajBYzK5QDVbbh4Jp+A6gdQglAzZl8giC5RoR4kd+tzhIrRbaaZuYdcG7rUP0+zn3vXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6jSIlna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC5AC4CEF7;
	Mon, 30 Mar 2026 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774899551;
	bh=2WLRMjI/pCjrMWMBwQlQsxYU5dS7dWF3LUHYmdKUf6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6jSIlnabrp3dcewkAEWhrWYgKPb9BLJalHgUMg+G4GKQvR/f+Jt++PvPYwl+Gvda
	 k6B6NKJglC5ZpOOAI6xgvPKycOrPBCfzHbt/ckuU0d6x+UHcYTnvOz6YRFHmKu6qoO
	 zwgrsRkLlaRgugKmdfhN2NZCoA5uCPRCh+RFODk/XH0gOqAmukJPiWlgFXT2FhKX4t
	 E+mf2Lx3K4D9H00z35ptlLD8c2plnITwKgAs4ZXuOJ8O+vRROIzasGaKJ3bVRAoJtH
	 O6Nkc+awc+aARU2PLGh3Oph1iZCzHcmxdEWJTfIZEac1KsaeTWAQj0KGdch4Z9Pp5p
	 jPcjP00wmgj2A==
Date: Mon, 30 Mar 2026 12:38:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: tests: Migrate ChaCha20Poly1305 self-test to
 KUnit
Message-ID: <20260330193802.GC4303@sol>
References: <20260327224229.137532-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327224229.137532-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22613-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 586D6360866
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 03:42:29PM -0700, Eric Biggers wrote:
> Move the ChaCha20Poly1305 test from an ad-hoc self-test to a KUnit test.
> 
> Keep the same test logic for now, just translated to KUnit.
> 
> Moving to KUnit has multiple benefits, such as:
> 
> - Consistency with the rest of the lib/crypto/ tests.
> 
> - Kernel developers familiar with KUnit, which is used kernel-wide, can
>   quickly understand the test and how to enable and run it.
> 
> - The test will be automatically run by anyone using
>   lib/crypto/.kunitconfig or KUnit's all_tests.config.
> 
> - Results are reported using the standard KUnit mechanism.
> 
> - It eliminates one of the few remaining back-references to crypto/ from
>   lib/crypto/, specifically a reference to CONFIG_CRYPTO_SELFTESTS.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  include/crypto/chacha20poly1305.h             |    2 -
>  lib/crypto/.kunitconfig                       |    1 +
>  lib/crypto/Makefile                           |    1 -
>  lib/crypto/chacha20poly1305.c                 |   14 -
>  lib/crypto/tests/Kconfig                      |   10 +
>  lib/crypto/tests/Makefile                     |    1 +
>  .../chacha20poly1305_kunit.c}                 | 1493 +++++++++--------
>  7 files changed, 760 insertions(+), 762 deletions(-)
>  rename lib/crypto/{chacha20poly1305-selftest.c => tests/chacha20poly1305_kunit.c} (91%)

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric


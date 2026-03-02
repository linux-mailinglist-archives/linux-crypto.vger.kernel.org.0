Return-Path: <linux-crypto+bounces-21464-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hh0N0QgpmkuKwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21464-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:41:56 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A441F1E6C05
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DB72301670A
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 23:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699933E356;
	Mon,  2 Mar 2026 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC0hpR+S"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59974282F01;
	Mon,  2 Mar 2026 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494914; cv=none; b=Ltxb+NJIabT8MiCbz+7V8mkVTfh1KhIveDeMOaC7yoXVJ9IXAIUmt8/UtS9TZwYQErhwOFub6d9NbB9j3wRYTcF4VrCaTb22R8FIc4YwvPmXBuJsVcCgwVGo1h8tXWcywFTkkDcFW0VTcjIrO5nXKR2rjVEsM52kxgNTRsPeCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494914; c=relaxed/simple;
	bh=1LxuzaBs1KjEcjfNJq1K+KBvh1Y3reR7Da1++7iZ0do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhiJ39ooJFTa+JXH67RJy5o7VLxgL7a1y1Mw+EHc+YFjOwh9oB6L1uJ0n1pQkudmHPfaKSSiUkSfQsc+o90ffer4a0xydk1wpp1gg9L/6UepG2Ap+4JzsiJHK8SgyiUx4K1Mh63gNrBtwfzKNPhliYiM/PTn9fhk3p36oDFUo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC0hpR+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A02BC19423;
	Mon,  2 Mar 2026 23:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772494913;
	bh=1LxuzaBs1KjEcjfNJq1K+KBvh1Y3reR7Da1++7iZ0do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC0hpR+Sg7ncrBtFqmRdtF0WNYo5MufvJ3kkUxuAMy897roCo1zW7EoMGPNzgSfVd
	 kItTk3iZQI3N59JnPRwQlgt5nrK2RJwCp6pGFLtI5PuK869ZU2hbf6UxfDGKRwQV8W
	 0b5zTQEJutAuBEblgNQxHpU/RqPSQn5mLCTt1ThBz1f/2AV3wl+wD/KqD1xWbGv5A2
	 jjfMz6vBxORfC45PyGlQe/rjFRDuGGXg7cZRZCp2vjFNcep2egIS05sTEmNyzgK8/Y
	 hv67uPCyBF5/Yv9aniqt4+9sCFsou/O+GE2GZqn5mWipcEj8z2zAQINY+rRfljX+u/
	 fq4Im+JLMRsBA==
Date: Mon, 2 Mar 2026 15:41:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] crypto: Drop stale usages in various help texts
Message-ID: <20260302234149.GB20209@quark>
References: <cover.1772116160.git.geert+renesas@glider.be>
 <20260226195440.GH2251@sol>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226195440.GH2251@sol>
X-Rspamd-Queue-Id: A441F1E6C05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21464-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:54:40AM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 03:46:04PM +0100, Geert Uytterhoeven wrote:
> > 	Hi all,
> > 
> > This patch series drops stale references to subsystems that are using
> > various crypto algoritms.  It was triggered by "make oldconfig" in
> > v7.0-rc1 showing new prompts about BLAKE2b, SHA-256, xxHash, and CRC32c
> > algorithms.  When querying these symbols, the corresponding help texts
> > incorrectly claim they are used by btrfs.
> > 
> > Notw that even if correct, there is no need for such references, as all
> > users should select the needed symbols anyway.
> > 
> > Geert Uytterhoeven (5):
> >   crypto: Drop stale CRYPTO_BLAKE2B usage
> >   crypto: Drop stale CRYPTO_SHA256 usage
> >   crypto: Drop stale CRYPTO_XXHASH usage
> >   crypto: Drop stale CRYPTO_CRC32C usage
> >   crypto: Drop stale CRYPTO_CRC32 usage
> > 
> >  crypto/Kconfig | 9 ---------
> >  1 file changed, 9 deletions(-)
> 
> Thanks for cleaning this up!
> 
> If there are no objections I'd like take these through libcrypto-fixes,
> given that they are related to the library conversions.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

I adjusted the commit titles to make it clear that the changes are to
the help text, not e.g. to selections of the symbols.

    crypto: Clean up help text for CRYPTO_CRC32

- Eric


Return-Path: <linux-crypto+bounces-22734-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pl9HC77zmn7sAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22734-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 01:26:38 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622138F33A
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 01:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9199330A3B73
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Apr 2026 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D563ED10D;
	Thu,  2 Apr 2026 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/+wRZdu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCE35F8B9;
	Thu,  2 Apr 2026 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171504; cv=none; b=LJF6//oTa/xoX5EwAXCbqr+l1spXeEA8LIaBT8b2xCf5wuK1StnO96qOZrE8iaZfrh8kzpSxF1j2niYsi21QXdUQbnch5zSnVGbvR/wKdCrMiEurVl5ahwOA9m8lHU2gtvd8FwwCPiRfERHvvrnyP9tzt+RpDM7VV3jbm6nCuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171504; c=relaxed/simple;
	bh=8h1E32kMKguX58cLP/livqlA8gHZ69QIjreTlzb5fFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux2IUVynMi7mmm9vQbIYf+rMa+2m4jMJFQLu5su14wvMN6M1JbeerX6AMjQAiea5pnsIjgxuyjIjgT5pAtFTwM2yBNPbpY+icuEeCdQijy6ZzK6+IKKW2eoyJ/hNL8MDzV2neKB6REIkNHUrhJMORKtMdu1X+kPrP4uXoTpKo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/+wRZdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D60C19424;
	Thu,  2 Apr 2026 23:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775171504;
	bh=8h1E32kMKguX58cLP/livqlA8gHZ69QIjreTlzb5fFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/+wRZduzum0NKhqehvBwXCxp7xlMFYgTBnO0ARAsmDxHGnvbl1PuNn/QYkBBvupK
	 KKBU/OY6ezFcRscp9gs62egVkBZbCN10ZuvxYCd+/KqeTCTL+LY1YmejEkS3kLd7bh
	 X4eJT64frt9dBpfasxT+78KmTo32LnzZ0tzATqxlHolNrGuwNuC61Hq2JNHk8hiRWZ
	 7aha093hvNoHO8AKxgM6eqJEslzxPxN08TzH0UnOe/1rKtOw30H2O6ubFsZwfeTYmH
	 SZBmtfxTmq+ffn99nQxuZ871k6LUWoosjoJzNXbp3vH+HuKKKsCTrD8eAFc0/S+AuV
	 EgO316NT6BDAQ==
Date: Thu, 2 Apr 2026 16:11:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: Include <crypto/utils.h> instead of
 <crypto/algapi.h>
Message-ID: <20260402231139.GC2910@quark>
References: <20260331024438.51783-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331024438.51783-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22734-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 7622138F33A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:44:38PM -0700, Eric Biggers wrote:
> Since the lib/crypto/ files that include <crypto/algapi.h> need it only
> for the transitive inclusion of <crypto/utils.h> (and not all the
> traditional crypto API stuff that the rest of <crypto/algapi.h> is
> filled with), replace these inclusions with direct inclusions of
> <crypto/utils.h>.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/aescfb.c | 2 +-
>  lib/crypto/chacha.c | 2 +-
>  lib/crypto/memneq.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric


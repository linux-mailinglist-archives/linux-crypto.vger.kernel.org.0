Return-Path: <linux-crypto+bounces-22062-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULbaHgaFuWlyIgIAu9opvQ
	(envelope-from <linux-crypto+bounces-22062-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:44:54 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 127EE2AE54D
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F37F30048E5
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF43EBF33;
	Tue, 17 Mar 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II5lqHNM"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE08313272;
	Tue, 17 Mar 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765626; cv=none; b=hb7Tpns7gwuBdOup2AZueqUVUETh9zAxyVTDQzCEucUH5ILuCw+3xNY6HapPQVHDnwEloEOSLUeDlkscJvvB8ZtLxPlOcz54Yvdeu3KH0xoYRvHhbXUTHQ9GutDFNDABl7tb31jsKqRWO8RfYJgN6fPIS5Tlkx9s8pDQSCc8Lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765626; c=relaxed/simple;
	bh=6jdBVv2fFJXhOemZwP4Vsk/ocl2vrrXIK5eLHZJz560=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgek94ja9bNbMt4gw0JR0YBnXReyJzuWe7wnZAvTDFdRbRyV/oUJNpuvqVtwaZzgRFau8PgXw2qnqxRCcnmALJ821iBwnklASB7BaL8yLY0/xw6V5dbcOi3LZrnhoYr8oGsDDBS4nNrUtIaEyDUNjrmnqyPDdnuu8EmX4rcm/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II5lqHNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C8C4CEF7;
	Tue, 17 Mar 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765626;
	bh=6jdBVv2fFJXhOemZwP4Vsk/ocl2vrrXIK5eLHZJz560=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=II5lqHNMJLa+aO52etk/FuWHq96J7HMuJMSKwMgdYoLiuxRi21ujZgSAKinbuamI6
	 NqWMeSHEuyzmmz4qjx7Npje2DqVVkTQsP9posKwkLwx54bkaWcaaEXRjKKNjrmHi6l
	 uc7H6LOYsgrxqvzavTQ4VMolJrcLatNCqtVLOWD4RzfnqXRNPG75UJGCRqL+gCgcs7
	 oViIpnT055owNB9CvRa1uGvZkDV+symUeZIz661nNVTLGZe8DQnT/Lzcn1kUqt3ABn
	 OhdKS7cHIq2X/9s3qSmN8uPzsi7uplfd8KEsHKreVc5fakrs1URco02TpiglX5BQPL
	 fvIZxKm4Xa+Xg==
Date: Tue, 17 Mar 2026 09:39:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH] lib/crypto: tests: Drop the default to CRYPTO_SELFTESTS
Message-ID: <20260317163926.GB6226@sol>
References: <20260317040626.5697-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317040626.5697-1-ebiggers@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22062-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 127EE2AE54D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 09:06:26PM -0700, Eric Biggers wrote:
> Defaulting the crypto KUnit tests to KUNIT_ALL_TESTS || CRYPTO_SELFTESTS
> instead of simply KUNIT_ALL_TESTS was originally intended to make it
> easy to enable all the crypto KUnit tests.  This additional default is
> nonstandard for KUnit tests, though, and it can cause all the KUnit
> tests to be built-in unexpectedly if CRYPTO_SELFTESTS is set.  It also
> constitutes a back-reference to crypto/ from lib/crypto/, which is
> something that we should be avoiding in order to get clean layering.
> 
> Now that we provide a lib/crypto/.kunitconfig file that enables all
> crypto KUnit tests, let's consider that to be the supported way to
> enable all these tests, and drop the default of CRYPTO_SELFTESTS.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting libcrypto-next

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric


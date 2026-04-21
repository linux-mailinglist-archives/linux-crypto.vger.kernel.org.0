Return-Path: <linux-crypto+bounces-23298-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKr6CznH52mCAgIAu9opvQ
	(envelope-from <linux-crypto+bounces-23298-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 20:51:37 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A842643ECF9
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 20:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82E8302B524
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076D372EF7;
	Tue, 21 Apr 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujRXaX55"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EB34250D
	for <linux-crypto@vger.kernel.org>; Tue, 21 Apr 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797418; cv=none; b=jrJHGOL7pRRttLuQFA+vaoQIQyitaZFrSplLSacbhCU24hGIFDUAQw/0HvnduDG0NZPuSGj11X0rDA6JWm6Pq3QSlecWNoTe5ECk6MZR9gAecphrS6Sra7cd+lO1T3iCXqLLXfNYpt/yytQ/nxowAtEsYNCs1KcZVjnTj+LeWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797418; c=relaxed/simple;
	bh=EPo6FNNjcWhdG4KhP6UIdw5E5GxlSmAr1AfY3wZx2FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agI7DS3o1jDjBQX+9V803AwT77G6zjyQhU7ZaI8rafR2/9ElbhZDn7VXCw6uy80KkkeE81wY15FAt6Vr91MHqdtBXwz+pk4HJpPqqs9QMZ5eAo+44//WeVTWyPClohqKjz/OQZgUpYj/EoskiCYOkDOmnvq0KDJjSvdv1bBlock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujRXaX55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A2AC2BCB0;
	Tue, 21 Apr 2026 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776797417;
	bh=EPo6FNNjcWhdG4KhP6UIdw5E5GxlSmAr1AfY3wZx2FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujRXaX55h+MMxB91Emu4iztTsXp8cUOUgmizRCyGw5mTdo0vOqlRUWFrxaBd0Dh8k
	 PfnqXXV0bTVVemQJ6AFQ3ulkslcVYsU7tICnLNROqyN6Nbs+4LnpkWPHZkjy7sZ+X/
	 j9a6SoZUUHZSyOEfYn+VUTg5vp1RgvlMUzjVYEhfhVQvhOGccCpEz3UyPH9u9QLFLN
	 ZQQIRcMoRrEd/R+NI1HXveAbr15JzUdZQfQceVa0IDhegWqmNlCJfEIkI+NZkLFGVK
	 46nXYnpBh9FXu73ok8ytTRHY7lRxfiidObBpwLeVNmLa+FG6f5JM57NbHHZ5Ay3jEP
	 rhpLtzi73nq5Q==
Date: Tue, 21 Apr 2026 11:50:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto: Drop unused cipher_null crypto_alg
Message-ID: <20260421185015.GB2202@quark>
References: <20260420094120.5167-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420094120.5167-1-ardb@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23298-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A842643ECF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:41:20AM +0200, Ard Biesheuvel wrote:
> The cipher_null crypto_alg cipher is never used in a meaningful way,
> given that it is always wrapped in ecb(), which has its own dedicated
> implementation. IOW, the cipher_null crypto_alg should never be used to
> implement the ecb(cipher_null) skcipher, and using it for other things
> is bogus.
> 
> However, it is accessible from user space, and due to the nature of the
> AF_ALG interface, it may be wrapped in arbitrary ways, exposing issues
> in template code that wasn't written with block ciphers with a block
> size of '1' in mind.
> 
> So drop this code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/crypto_null.c | 35 ++------------------
>  1 file changed, 2 insertions(+), 33 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric


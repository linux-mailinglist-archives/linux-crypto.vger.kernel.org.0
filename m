Return-Path: <linux-crypto+bounces-21463-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK8lFAYgpmkuKwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21463-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:40:54 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B761E6BB7
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 00:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A61F3099823
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 23:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493433D6F7;
	Mon,  2 Mar 2026 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIWjkNy+"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2333CE9A;
	Mon,  2 Mar 2026 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494730; cv=none; b=EHCtdsNxLVoh6tk+Mck5IynkPtvnhUxNqr9mXyFboNjfBd4x0iP+HSrIKlRjzx1E4YvtjX+ja7PudTImfUg8XGEKOWyHPhW6DcIDqRazqM/o0BTbamSUvCDfx2S8qhPy1Z0qj0kMdEqe1Ch4BNi0ZvGVh0SRSuvQXQO6yhqNyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494730; c=relaxed/simple;
	bh=Ro8E+hc7C8VoOj49hQUQ7Xh0hyc7qH+SkExmWOVCP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKYocz/DeRcuaK+IeRScXNHv/rCl/C4AvEGTn/k00SC81ZaXGS2vAN4uq/XFj/HB+tHhXwYXcNGHuxtrbcly0AskNQrf9h6nyI6j+BRzBlP7pCiZVPwR/TWtVHb7hBDm7iVziogidqx+9nRHBs9Cn8q5wzgvSVvcfM9OzmyIzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIWjkNy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAFEC19423;
	Mon,  2 Mar 2026 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772494729;
	bh=Ro8E+hc7C8VoOj49hQUQ7Xh0hyc7qH+SkExmWOVCP20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIWjkNy+yqugdWaP5zPilFg/TMa8BB92SSUp7guY3iPUOVf7NwVACzC9ozzXVGgWB
	 YHSy9MuC+qCPQvBlhANzEhOTN9n50bD1CFRYfBNVdn9rouYi5KbOAjKKa3BSKkBKJC
	 1OCF/VR2B+sVACGzHUOvH/Mn7/6HPCX9wDvAvRsL2WSVLqz9mtzMZdsPfi7UaXw5a/
	 grq3C15+uU/jIhWy3jUUabAUID0OSvZX9YfY6cD5Ets96Oe14eOHxqv/Ava8uZ6/Zm
	 KKCoGYbxZ+1zwaD2zU2lyyTkCj/Ryrk/4CAqRXv9L+O8VkLkB5z9EHdMdbPevQ3Puv
	 IUSDZXdYUoaIA==
Date: Mon, 2 Mar 2026 15:38:46 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	kunit-dev@googlegroups.com,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Subject: Re: [PATCH] lib/crypto: tests: Add a .kunitconfig file
Message-ID: <20260302233846.GA20209@quark>
References: <20260301040140.490310-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301040140.490310-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: 88B761E6BB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,googlegroups.com,linux.dev,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-21463-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kunit.py:url]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 08:01:40PM -0800, Eric Biggers wrote:
> Add a .kunitconfig file to the lib/crypto/ directory so that the crypto
> library tests can be run more easily using kunit.py.  Example with UML:
> 
>     tools/testing/kunit/kunit.py run --kunitconfig=lib/crypto
> 
> Example with QEMU:
> 
>     tools/testing/kunit/kunit.py run --kunitconfig=lib/crypto --arch=arm64 --make_options LLVM=1
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This is targeting libcrypto-fixes
> 
>  lib/crypto/.kunitconfig | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 lib/crypto/.kunitconfig
> 

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric


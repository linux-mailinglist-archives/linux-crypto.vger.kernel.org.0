Return-Path: <linux-crypto+bounces-21741-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNfqNRAyr2kYPgIAu9opvQ
	(envelope-from <linux-crypto+bounces-21741-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 21:48:16 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD124112B
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 21:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17655304225E
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Mar 2026 20:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327C346781;
	Mon,  9 Mar 2026 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz6HJi1I"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640D284663;
	Mon,  9 Mar 2026 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089292; cv=none; b=lqgZyqpaSryqH4KBWVPechxbjWwBQzamSn68ybvbwGF+DWa6ddWx8R1jxl8+bcpEwaRY/+ygUlA9I169MZNYd18/T6JpiEdMqKV/wHktrzNaGx0ErjWH60tGybmCEslpx9aiP9L84jhfnoP1hWoIfo6DC21mlaNmLkLChWy03bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089292; c=relaxed/simple;
	bh=Wz+3F7vwckC5eQhXk6NG/xcIuOMnL5SG2fVjLNGfWYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMW2UFV2OSjbJ6c2Uh+uys4BdQaTVBH19OWvWxQJBYoWL82ZTAgHgyBF3DfeeppscKJraAcVi7/j8FOOSWl05P8mXYC8f+UVYcjeK2cuKwTdLntVGc1PJNJcpGtpaFf7IvxRY8s5qrv1bnAWLXqG/e9shnjWEtlogtmuBSltIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz6HJi1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3538BC4CEF7;
	Mon,  9 Mar 2026 20:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773089291;
	bh=Wz+3F7vwckC5eQhXk6NG/xcIuOMnL5SG2fVjLNGfWYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz6HJi1Iha92kWoNbh368nUftSmTGsT2Kxlq/8McxQFC0PSr1+vnN5Y6+7slwVGim
	 XFUDoaG+s1i2qWfgg+EGV/llVjgan2E/xGb+Ly9fBUMdYZA0ZNChGEgHqz4VuBs2Jk
	 sIJQutfiId5/0JMcIIJwl6xGPAKphOi2T7CFYe4ax5SQKnFZRB9364bD5Ck9/7V0Sb
	 m6aQbjYXU192Bua+u5GFKaVHc8bkzMKH13S5htChImc35yRDP22l5qaB4c7sOPTqec
	 mCs+fMtbmdqhAJQeDa1ZcN4uB18Ynq6ELpYLlxSX/Ilc9wrZ9PQWC96YuYY5xRBkpl
	 Gl7Nc6alcnvEA==
Date: Mon, 9 Mar 2026 13:48:08 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, herbert@gondor.apana.org.au
Cc: davem@davemloft.net, catalin.marinas@arm.com, will@kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2] crypto: arm64/aes-neonbs - Move key expansion off the
 stack
Message-ID: <20260309204808.GC2048@quark>
References: <20260306064254.2079274-1-yphbchou0911@gmail.com>
 <20260306213502.GB9593@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306213502.GB9593@quark>
X-Rspamd-Queue-Id: 2ECD124112B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21741-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:35:02PM -0800, Eric Biggers wrote:
> On Fri, Mar 06, 2026 at 02:42:54PM +0800, Cheng-Yang Chou wrote:
> > aesbs_setkey() and aesbs_cbc_ctr_setkey() allocate struct crypto_aes_ctx
> > on the stack. On arm64, the kernel-mode NEON context is also stored on
> > the stack, causing the combined frame size to exceed 1024 bytes and
> > triggering -Wframe-larger-than= warnings.
> > 
> > Allocate struct crypto_aes_ctx on the heap instead and use
> > kfree_sensitive() to ensure the key material is zeroed on free.
> > Use a goto-based cleanup path to ensure kfree_sensitive() is always
> > called.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > ---
> > Changes in v1:
> > - Replace memzero_explicit() + kfree() with kfree_sensitive()
> >   (Eric Biggers)
> > - Link to v1: https://lore.kernel.org/all/20260305183229.150599-1-yphbchou0911@gmail.com/
> > 
> >  arch/arm64/crypto/aes-neonbs-glue.c | 37 ++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> Looks okay for now, though as I mentioned I'd like to eventually
> refactor this code to not need so much temporary space.
> 
> I'll plan to take this through the libcrypto-fixes tree.  Herbert, let
> me know if you prefer to take it instead.
> 
> I'll plan to add:
> 
>     Fixes: 4fa617cc6851 ("arm64/fpsimd: Allocate kernel mode FP/SIMD buffers on the stack")
> 
> ... since that is the change that put the stack usage over the "limit".

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-fixes

- Eric


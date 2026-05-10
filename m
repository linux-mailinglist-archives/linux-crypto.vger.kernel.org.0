Return-Path: <linux-crypto+bounces-23897-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id thFmC58VAWpIQgEAu9opvQ
	(envelope-from <linux-crypto+bounces-23897-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 11 May 2026 01:32:47 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C4506D1C
	for <lists+linux-crypto@lfdr.de>; Mon, 11 May 2026 01:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2FB9300DDCB
	for <lists+linux-crypto@lfdr.de>; Sun, 10 May 2026 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1443254B0;
	Sun, 10 May 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJwffKnu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF092F8E99;
	Sun, 10 May 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455959; cv=none; b=ncX7gMcU0PAGH/Vf9lr3DOz5wpskOX0O/m+MGKYud/CKN0/OzJViWPYg3SIB3yKTWZYEGQ9A24Sls7FqdYntWf/VyF5R5lBqLW/Br0vAppyARg5lPK5IePvXUdW5zBLLjEZ70vvCcReN1nErktrTyGCcBwSKVKWcCMYB+UM+Dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455959; c=relaxed/simple;
	bh=a68Kr/AMewu0vcd+FDKmbWfD+xwXrDPN2WU4lJN9+WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktMGfjC7mLZT21YY75w/4MXrZrGie4mKl4fVNAg6qXYBG2mZaTDeRGibxA54TtPYLdvYPlRYpyfymILbv/qs7WEYRaHuMpuglz/ozCGX+U9hjpbS3eqNtzZidhmsZLozrg6CeENAnwCE3W0jX3WSeuLgml6L0ya2b9DOsTZc6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJwffKnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCAEC2BCB8;
	Sun, 10 May 2026 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778455959;
	bh=a68Kr/AMewu0vcd+FDKmbWfD+xwXrDPN2WU4lJN9+WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJwffKnu+P10MuheJAJ3W1qHUKc1zsfFmxPvkqkK3M3X0g4EGJO2GnNijakF2T5yu
	 Gx+UEDFrKZ1Bysk8P2H/hIsk0dyB2pc3V1dEOLcICHh2a6GDxbZoslUdyHUCoEDnvK
	 8lMBAUYVeGJco0HmCPZxcie5IHpugSJGjY0DJXup5otxElJR8Zl5RP+jPm9hWNI55X
	 1CathkIhCdjZ9sriXu+YLysaZQ7z7SbsQYEveqqJ02ArTseUs4Dk8V8q7RMxTDI94J
	 wTnBBbTj3L9yIJiz0jLh4Om7gRkY/MYAMr+pT2gyn+WqkNcgyO7HdRoHroZ8sObtyr
	 A4lnHBL3eeGFg==
Date: Sun, 10 May 2026 16:32:37 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexandre Knecht <knecht.alexandre@gmail.com>
Cc: herbert@gondor.apana.org.au, "David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] crypto: ctr - Convert from skcipher to lskcipher
Message-ID: <20260510233237.GA60510@quark>
References: <20260510230901.1772949-1-knecht.alexandre@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510230901.1772949-1-knecht.alexandre@gmail.com>
X-Rspamd-Queue-Id: A95C4506D1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23897-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 01:09:01AM +0200, Alexandre Knecht wrote:
> Replace the existing skcipher CTR template with an lskcipher version,
> following the pattern established by the CBC conversion (705b52fef3c7).
> 
> This enables BPF programs using the bpf_crypto kfuncs to use CTR mode
> ciphers like ctr(aes), which previously failed because
> crypto_alloc_lskcipher() could not find an lskcipher implementation.
> ECB and CBC already have lskcipher support; CTR was the missing piece.
> 
> The rfc3686 template remains as an skcipher and continues to work
> through the automatic lskcipher-to-skcipher bridge.
> 
> Tested with NIST SP 800-38A test vectors (AES-128/192/256-CTR),
> partial block handling, and rfc3686 compatibility. Kernel self-tests
> pass on instantiation (selftest: passed in /proc/crypto).
> 
> Signed-off-by: Alexandre Knecht <knecht.alexandre@gmail.com>
> Assisted-by: Claude:claude-opus-4-6 checkpatch

I'm confused.  Why was that BPF crypto feature even added with ECB mode
as the only supported encryption mode?  Who is using that, and why?

CTR isn't necessarily much better, either.

What is the use case for the BPF crypto?  The first step should be to
decide what *specific* algorithm(s) it needs.  It doesn't seem like that
has ever happened, and I'm not sure this patch helps much.

That needs to be done anyway.  But that would also be helpful for a
potential future switch to lib/crypto/, which would avoid all the weird
issues with lskcipher etc.

- Eric


Return-Path: <linux-crypto+bounces-21740-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF4OK4otr2kgPQIAu9opvQ
	(envelope-from <linux-crypto+bounces-21740-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 21:28:58 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B303240D1D
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 21:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5B3E301707D
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Mar 2026 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63B3ED12F;
	Mon,  9 Mar 2026 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz1t21Yc"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCF33C1AD;
	Mon,  9 Mar 2026 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088134; cv=none; b=MIt46+NiGgDd59ToIkI86ARiuAAiwqIoOmlJ0I4POjg4zO6cVPSJLP9XZ9PL0Hr3B1cAm16VqTS+e5M5jRywN8wlOYA+C6uevRJe1jvKK+EjBkbAABQUcyqN1zF1XZ4utfPLAArAlXlB0FlOjzvVLDqwcq2kypeWhZMESFh1PLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088134; c=relaxed/simple;
	bh=2ADTOeDzMyU/IdqDwS4kW7ACQAAk1gTeS2bm36vP3gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/6BpyPr/c7dP3vwbmb0jOxqnwUAdf7ZdBJCgWT1+XZaSOUhCmXNbg9A5tohzSohAepBq06aXwJoxp4+WUPjircXpL9DLUGlk+rmQHtjJ/c8KaS+2n/Qhc7mOmtgYcohLPReNDOJjdr1tJ/Qq55KCY+dBaI/kyGQExb4VCvCTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz1t21Yc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FDDC4CEF7;
	Mon,  9 Mar 2026 20:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773088133;
	bh=2ADTOeDzMyU/IdqDwS4kW7ACQAAk1gTeS2bm36vP3gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sz1t21YcHfdErcnWDign6akX+9+rZjuAbPqmj8FWwLZXciUDQpXhjkhaGWY2Xv9dn
	 +1o/3xpORjti5aAGfUEtN+7xsVHqS6HvC8Tlof74dpVMpo+e0hjhiKyblCRkWQUdP4
	 KdWBU+YgBytAjpYe47oQPjf/HdKbcGFtTNonRHcUk+weVHWfYSv8kjmRPBYiC8IRAM
	 nbd8TdMCHqyRhj4rpDoaY2332484KxVEgi5G0tG0jPCXRr2OLEsUzsqtJQVEbOhabt
	 u5HkhxynErL0usBRDItp6CWu0uohI3MU4bHanZKnG9zp4roVpOphvCL6K5IUCmAZGt
	 Q1BrP8TTg1w8A==
Date: Mon, 9 Mar 2026 13:28:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: tests: Fix aes_cbc_macs dependency and add
 to kunitconfig
Message-ID: <20260309202851.GA2048@quark>
References: <20260306001917.24105-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306001917.24105-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: 1B303240D1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21740-lists,linux-crypto=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 04:19:17PM -0800, Eric Biggers wrote:
> Update the dependency of CRYPTO_LIB_AES_CBC_MACS_KUNIT_TEST to match the
> new convention established by commit 4478e8eeb871 ("lib/crypto: tests:
> Depend on library options rather than selecting them"), and add this
> test to the kunitconfig file added by commit 20d6f07004d6 ("lib/crypto:
> tests: Add a .kunitconfig file").
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This is targeting libcrypto-next.  This patch is needed because the
> aes_cbc_macs test is queued for 7.1 and wasn't handled by the commits
> mentioned above which were merged into 7.0.
>  
>  lib/crypto/.kunitconfig  | 3 +++
>  lib/crypto/tests/Kconfig | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)

I folded this into "lib/crypto: tests: Add KUnit tests for CBC-based
MACs", since it's a fix for that commit.

- Eric


Return-Path: <linux-crypto+bounces-17715-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89142C2DA11
	for <lists+linux-crypto@lfdr.de>; Mon, 03 Nov 2025 19:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06113189B4B0
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Nov 2025 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC607239085;
	Mon,  3 Nov 2025 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdoEo0xV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56021A9F94;
	Mon,  3 Nov 2025 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193897; cv=none; b=lJ834oFJyFRttEN7a1+Tkie03fPG3Xsfx7loexXWeSoGB8oryuk6cnizNeSpCuPD5tzkQEEjxs0Li8U7Btq0cB5ALx/NP4mdTgVNuT/R5y/dOEm0/FvBi/Wsl4GAQiYaXBNgcTc7g6QTXNN3ng8p4wYWg/hKI5SZ+b/DpPfRN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193897; c=relaxed/simple;
	bh=W8UcJ+hMzlXHY3DoYN+mX157ll89i1894Dhm89wTNJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf9tFXivsugWY0mZV0E6yZaslLNdFrtGjup/MQjnUK0joHRTjh3gB1HIb/27JO3o9S/qJ1IvVs7MaKmdJhBVb/13bwoEG7tAMqpuBw6NWTlu0rYNhFWbxZga5Khd9VzzAee7fjO88NTR/zFNQ5aaYKAxCPBzDVuFQ1O5D48K+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdoEo0xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F95C4CEE7;
	Mon,  3 Nov 2025 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193897;
	bh=W8UcJ+hMzlXHY3DoYN+mX157ll89i1894Dhm89wTNJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdoEo0xV5ArukTxYqyDAPcFAFlVy8+fgC6U9U5FJFRPV6/Iq+FDKZejgRL8+yvPPs
	 dKkgMkh1M3OXk1hH6qaqWq2Wyn/WeSFAeaQuw1eiDKc/+oz9tDAoj6YkJpqhNcSGHm
	 aNeQyi25h8HSTC1Grb369xM/dMOoSDvEcoThTDbAAtukWzCI1bCtQB2CUC8LX/M5MR
	 +FYrxSqkagDP8+/uy+1/1TRefh4cAJaNIE5j/tXDOaOmVkUnt3ZLgMwl+nyT/u/pq3
	 1KjIhFFCohI0WF6+5ExaQhUPRX40hoRCI2tsLnleD4I0iQxwUamXLismhTq/wmku0X
	 bDs/SZMDnx1IA==
Date: Mon, 3 Nov 2025 10:16:36 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: arm, arm64: Drop filenames from file comments
Message-ID: <20251103181636.GJ1735@sol>
References: <20251102014809.170713-1-ebiggers@kernel.org>
 <20251103173509.GG1735@sol>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103173509.GG1735@sol>

On Mon, Nov 03, 2025 at 09:35:11AM -0800, Eric Biggers wrote:
> On Sat, Nov 01, 2025 at 06:48:06PM -0700, Eric Biggers wrote:
> > Remove self-references to filenames from assembly files in
> > lib/crypto/arm/ and lib/crypto/arm64/.  This follows the recommended
> > practice and eliminates an outdated reference to sha2-ce-core.S.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> > 
> > This patch is targeting libcrypto-next
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next
> 
> - Eric

Since I applied it after the SHA-3 series which moved sha3-ce-core.S
into lib/crypto/, I also folded in the same change to sha3-ce-core.S:

diff --git a/lib/crypto/arm64/sha3-ce-core.S b/lib/crypto/arm64/sha3-ce-core.S
index b62bd714839b..ace90b506490 100644
--- a/lib/crypto/arm64/sha3-ce-core.S
+++ b/lib/crypto/arm64/sha3-ce-core.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * sha3-ce-core.S - core SHA-3 transform using v8.2 Crypto Extensions
+ * Core SHA-3 transform using v8.2 Crypto Extensions
  *
  * Copyright (C) 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
  *


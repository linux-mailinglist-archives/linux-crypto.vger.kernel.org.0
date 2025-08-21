Return-Path: <linux-crypto+bounces-15490-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE65B2ECA4
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Aug 2025 06:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CF583C44
	for <lists+linux-crypto@lfdr.de>; Thu, 21 Aug 2025 04:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC21DFCE;
	Thu, 21 Aug 2025 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDtBK0OA"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56922A4CC;
	Thu, 21 Aug 2025 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749687; cv=none; b=cujerLYmlG/e5WxNPDajReUjWFhT94+Wcy1IdRLO+LyeykfAMDWx/7rYtRTyme4iTflNMZdFLkj2Ku9mBCc9gdIfIwufXpluPLmDUUikidWRlrFdcf+2HBMprbdyQqDroMAcXnkOWxRQQQ1xOfPSQf0ehqWN2hyDKvZCNfXY5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749687; c=relaxed/simple;
	bh=hDZ1R2E7fbfif2kjuuzEAtl7LiGxOezeEPUlLY8P5eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWzmX4B6udEyGu0Jea05TlHjLI9q+33/5Sk1TJKd6/yx6KgF+wn4JDU7nBBMXW/3d82QNJA/OZK1XYOGF3bINRhgX1ikDvV/7iwotbe2gGpNAnDKnVkW3oU5qIDTX4Hyypeaj85A732CJ0HJiZ+EJHN+t0+e8rbKFLAnpX/SDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDtBK0OA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D2C4CEF4;
	Thu, 21 Aug 2025 04:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755749687;
	bh=hDZ1R2E7fbfif2kjuuzEAtl7LiGxOezeEPUlLY8P5eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDtBK0OA2hidz+zRDp+Lzd7q+vsvGhiDhCOTEl6FVGZ5Sjc+ArDwwvy78jLeQVxqQ
	 Wn9gNueIyH1E6lckoWVStJmRdMNjJlyBV/3lNW6NVcRJHHpxVmYadg2BBiSqjqlS3q
	 YOVOjAyscT0CW/VHx/NZrUQsVYGay3sFeRzYBf+FMM5cQxQF8mwND8p34aCP81GVfU
	 EGWXPq38PhcfhW66mnx+IlJiE9eaLg0lrKVxxoWFOOv8NrpVztrWU4sYoOtRYyq0jO
	 YyPN+MJczKxVMYyyHb5H9HJjr50WxEQs7bMaoog/ODM/VIDHZtG9ngBZEsovco+Bo3
	 M8/LehzcRDgWQ==
Date: Thu, 21 Aug 2025 00:14:45 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>
Subject: Re: [PATCH 2/3] lib/crypto: poly1305: Consolidate into single module
Message-ID: <20250821041445.GH185832@quark>
References: <20250816194353.562491-1-ebiggers@kernel.org>
 <20250816194353.562491-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816194353.562491-3-ebiggers@kernel.org>

On Sat, Aug 16, 2025 at 12:43:52PM -0700, Eric Biggers wrote:
> -perlasm-flavour-$(CONFIG_32BIT) := o32
> -perlasm-flavour-$(CONFIG_64BIT) := 64
> -
> -quiet_cmd_perlasm = PERLASM $@
> -      cmd_perlasm = $(PERL) $(<) $(perlasm-flavour-y) $(@)
> -
> -$(obj)/poly1305-core.S: $(src)/poly1305-mips.pl FORCE
> -	$(call if_changed,perlasm)
[...]
> +ifeq ($(CONFIG_MIPS),y)
> +libpoly1305-y += mips/poly1305-core.o
> +poly1305-perlasm-flavour-$(CONFIG_32BIT) := o32
> +poly1305-perlasm-flavour-$(CONFIG_64BIT) := 64
> +quiet_cmd_perlasm_poly1305 = PERLASM $@
> +      cmd_perlasm_poly1305 = $(PERL) $< $(poly1305-perlasm-flavour-y) $@
> +$(obj)/mips/poly1305-core.S: $(src)/mips/poly1305-mips.pl
> +	$(call if_changed,perlasm_poly1305)
> +endif

Small issue that I noticed: I removed the "FORCE" from the rule for
poly1305-core.S since none of the other perlasm rules had it.  But it's
actually needed because, unlike the other perlasm rules, this one uses
'if_changed' instead of 'cmd'.  'if_changed' requires FORCE.  And I
believe it does need to use 'if_changed', since the contents of the
generated .S file depends on the perlasm-flavour passed as an argument
to the perl script.  That can change when the kernel config changes.

So, TLDR: I'll restore the FORCE to the rule, and add a comment.

The RISC-V optimized Poly1305 code added by the third patch will need
if_changed and FORCE for the same reason.

Of course, it's unfortunate that these are written in Perl at all.  But
that is the convention used by Andy / CRYPTOGAMS, so that is what we'll
use unless someone wants to rewrite it...

- Eric


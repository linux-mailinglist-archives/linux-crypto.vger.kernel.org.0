Return-Path: <linux-crypto+bounces-3421-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A589D8F1
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Apr 2024 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8D1F21CB6
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Apr 2024 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108BE12AAC8;
	Tue,  9 Apr 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKb8gmM1"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261B80043;
	Tue,  9 Apr 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664704; cv=none; b=OUGrZxN9mPOWZuKPkAgD5KHmWZslHJl2op+EDJNJQlI13YJkwPid6tPnAd7WRAR4DSGLqtMZwoTOYeGanrudvB8TfI64Y7nCSHeTVs2vEuBCULLoBWEEbyBRDHyUdqOtALQ6lkDz56KdBiE4UEYz2ypv/Sc58ou7S0zC4zqlOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664704; c=relaxed/simple;
	bh=BVOgIna6UH5Fe8n7tYM9YU/VXuuxjddECrXcSWyZ7o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJc4jtjX2nh4bDY+5UilMcVkRBgD+aqmLgXPpP2Zh9BbWzjUXlN0XdZXtW23HWbYQ8mXEAm1XCn1kErcQO4wxKhza4YOXM/hl5izjxRwx6l5sv8csj457FXqlVCqbNa5RygWFGUzvQyaRSZHXe5jVIbjp2s/TnHVPcwP9G8xvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKb8gmM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98ECC433C7;
	Tue,  9 Apr 2024 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664704;
	bh=BVOgIna6UH5Fe8n7tYM9YU/VXuuxjddECrXcSWyZ7o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKb8gmM1SkcPviIvDzzDRveN1RMXmKptiNLqx9jwXfonJ3yB6Ka1G6UANgBrEWbXO
	 1UdU7vx3HTF5/t3c1vEsJMKeGLGTWRpY8PFtBjDBZ5AhVjoyW82ta8HkFay3RrTOKV
	 VQ2e1SUdWIiJFDYOH61EEpXcZGhb3mjo5zxucB33i2JkBvCqllTCs9yP8Lc8hhwapC
	 Yg2OYl+NL4eI9QY2XE9aGgO/BGQupNpJqgM/t5wjnCNXo7CRDfV5yvNEiM5meRh8iD
	 DW+71Fuy2cgloaC/YgW7j99vfMMQaY7qLx2zUhwSDmzEZgfTEEHhzRokvlWOV2azNT
	 Fdn9WMTLyH8rQ==
Date: Tue, 9 Apr 2024 08:11:41 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Stefan Kanthak <stefan.kanthak@nexgo.de>
Subject: Re: [PATCH] crypto: x86/aes-xts - access round keys using
 single-byte offsets
Message-ID: <20240409121141.GA717@quark.localdomain>
References: <20240409000154.29799-1-ebiggers@kernel.org>
 <CAMj1kXEhrPo18dwAuzpn7R7ZGpOxr2pwuoAfGRtWwzgSF+mTsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEhrPo18dwAuzpn7R7ZGpOxr2pwuoAfGRtWwzgSF+mTsA@mail.gmail.com>

On Tue, Apr 09, 2024 at 11:12:11AM +0200, Ard Biesheuvel wrote:
> On Tue, 9 Apr 2024 at 02:02, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Access the AES round keys using offsets -7*16 through 7*16, instead of
> > 0*16 through 14*16.  This allows VEX-encoded instructions to address all
> > round keys using 1-byte offsets, whereas before some needed 4-byte
> > offsets.  This decreases the code size of aes-xts-avx-x86_64.o by 4.2%.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Nice optimization!
> 
> Do you think we might be able to macrofy this a bit so we can use zero
> based indexing for the round keys, and hide the arithmetic?
> 
> 

There are two alternatives I considered: defining variables KEYOFF0 through
KEYOFF14 and writing the offsets as KEYOFF\i(KEY), or defining one variable
KEYOFF and writing the offsets as \i*16-KEYOFF(KEY).  I think I slightly prefer
the current patch where it's less abstracted out, though.  It makes it clear the
offsets really are single-byte, and also index 7 is the exact mid-point so going
from -7 to 7 still feels fairly natural.  If we wanted to do something more
complex like use different offsets for AVX vs. AVX512, then we'd need the
abstraction to handle that, but it doesn't seem useful to do that.

- Eric


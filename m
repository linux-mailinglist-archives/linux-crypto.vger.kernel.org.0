Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0131B4C58
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Apr 2020 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDVSAc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Apr 2020 14:00:32 -0400
Received: from foss.arm.com ([217.140.110.172]:53468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgDVSAc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Apr 2020 14:00:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF72A1FB;
        Wed, 22 Apr 2020 11:00:31 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7EB83F6CF;
        Wed, 22 Apr 2020 11:00:30 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:00:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 0/3] arm64: Open code .arch_extension
Message-ID: <20200422180027.GH3585@gaia>
References: <20200325114110.23491-1-broonie@kernel.org>
 <CAMj1kXH=g5N4ZtnZeX5N8hf9cnWVam4Htnov6qAmQwD58Wp73Q@mail.gmail.com>
 <20200325115038.GD4346@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325115038.GD4346@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 25, 2020 at 11:50:38AM +0000, Mark Brown wrote:
> On Wed, Mar 25, 2020 at 12:45:11PM +0100, Ard Biesheuvel wrote:
> > I don't think this is the right fix. What is wrong with keeping these
> > .cpu and .arch directives in the .S files, and simply make
> > SYM_FUNC_START() expand to something that includes .arch_extension pac
> > or .arch_extension bti when needed? That way, we only use
> > .arch_extension when we know the assembler supports it (given that
> > .arch_extension support itself should predate BTI or PAC support in
> > GAS or Clang)
> 
> Since BTI is a mandatory feature of v8.5 there is no BTI arch_extension,
> you can only enable it by moving the base architecture to v8.5.  You'd
> need to use .arch and that feels likely to find us sharp edges to run
> into.

For MTE, .arch armv8-a+memtag won't work since this is only available
with armv8.5-a. My preference would be to have the highest arch version
supported by the kernel in the assembler.h file, i.e. ".arch armv8.5-a"
followed by .arch_extension in each .S file, as needed.

Forcing .S files to armv8.5 would not cause any problems with
the base armv8.0 that the kernel image support since it shouldn't change
the opcodes gas generates. The .S files would use alternatives anyway
(or simply have code not called).

The inline asm is slightly more problematic, especially with the clang
builtin assembler which goes in a single pass. But we could do something
similar to what we did with the LSE atomics and raising the base of the
inline asm to armv8.5 (or 8.6 etc., whatever we need in the future).

-- 
Catalin

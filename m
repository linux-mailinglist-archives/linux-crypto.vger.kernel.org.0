Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7038F192877
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCYMcF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 08:32:05 -0400
Received: from foss.arm.com ([217.140.110.172]:47786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMcF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 08:32:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C79DC31B;
        Wed, 25 Mar 2020 05:32:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C71F43F71F;
        Wed, 25 Mar 2020 05:32:03 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:31:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: Open code .arch_extension
Message-ID: <20200325123157.GA12236@lakrids.cambridge.arm.com>
References: <20200325114110.23491-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325114110.23491-1-broonie@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 25, 2020 at 11:41:07AM +0000, Mark Brown wrote:
> Since inserting BTI landing pads into assembler functions will require
> us to change the default architecture we need a way to enable
> extensions without hard coding the architecture.

Assuming we'll poke the toolchain folk, let's consider alternative ways
around this in the mean time.

Is there anything akin to push/pop versions of .arch directitves that we
can use around the BTI instructions specifically?

... or could we encode the BTI instructions with a .inst, and wrap those
in macros so that GAS won't complain (like we do for mrs_s and friends)?

... does asking GCC to use BTI for C code make the default arch v8.5 for
inline asm, or does it do something special to allow BTI instructions in
specific locations?

Thanks,
Mark.

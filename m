Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BA192827
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCYMY5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 08:24:57 -0400
Received: from foss.arm.com ([217.140.110.172]:47652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgCYMY4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 08:24:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1188731B;
        Wed, 25 Mar 2020 05:24:56 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C816F3F71F;
        Wed, 25 Mar 2020 05:24:54 -0700 (PDT)
Subject: Re: [PATCH 0/3] arm64: Open code .arch_extension
To:     Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-crypto@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200325114110.23491-1-broonie@kernel.org>
 <CAMj1kXH=g5N4ZtnZeX5N8hf9cnWVam4Htnov6qAmQwD58Wp73Q@mail.gmail.com>
 <20200325115038.GD4346@sirena.org.uk>
 <CAMj1kXEogCrLS1o9sQyiXsKZhykfc2kuOssCeME8HyhSnMEFvA@mail.gmail.com>
 <20200325120224.GA34330@C02TD0UTHF1T.local>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ea521053-1f55-dbab-2d34-0773fd4dcac5@arm.com>
Date:   Wed, 25 Mar 2020 12:24:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325120224.GA34330@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 2020-03-25 12:03 pm, Mark Rutland wrote:
> On Wed, Mar 25, 2020 at 12:54:10PM +0100, Ard Biesheuvel wrote:
>> On Wed, 25 Mar 2020 at 12:50, Mark Brown <broonie@kernel.org> wrote:
>>> Since BTI is a mandatory feature of v8.5 there is no BTI arch_extension,
>>> you can only enable it by moving the base architecture to v8.5.  You'd
>>> need to use .arch and that feels likely to find us sharp edges to run
>>> into.
>>
>> I think we should talk to the toolchain folks about this. Even if
>> .arch_extension today does not support the 'bti' argument, it *is*
>> most definitely an architecture extension, even it it is mandatory in
>> v8.5 (given that v8.5 is itself an architecture extension).
> 
> It certianly seems unfortunate, as it goes against the premise of having
> HINT space instructions. Most software will want to enable HINT space
> instructions from ARMv8.x but nothing else to ensure binary
> compatibility with existing hardware.
> 
> I see the same is true for pointer authentication judging by:
> 
> https://sourceware.org/binutils/docs/as/AArch64-Extensions.html#AArch64-Extensions
> 
> ... so worth raising with toolchain folk as a general principle even if
> we have to bodge around it for now.

Indeed, in general, just because a feature is mandatory in v8.n doesn't 
necessarily mean it can't be included in a v8.(n-1) implementation which 
may not have the *other* mandatory parts of v8.n which ".arch 
armv8.<n>-a" would let through.

Robin.

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6328B124E38
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Dec 2019 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRQp6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 18 Dec 2019 11:45:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48168 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLRQp5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 18 Dec 2019 11:45:57 -0500
Received: from zn.tnic (p200300EC2F0B8B009D1D67E59157F47A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8b00:9d1d:67e5:9157:f47a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79A931EC09F1;
        Wed, 18 Dec 2019 17:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576687556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=veM79yV+cFFmEZLqNeH8K6a+RQqwXlPU3rmWJpTwMAc=;
        b=fBUPT53IBka5z+KEVntYJcp7wP7qQ54cuPs5kQAraLooNx6fq5wjTyKSH0eiAUSHdDQ1+G
        fpdc81ctMpM6X7VTsRs8eitVE/G7pe4KbfRLNC4VSx/2MN3Nx5BUFW7T1KT/ThFYRm+sCa
        0TJ3xDKmODWlqfF7szBdTWqtsny89pw=
Date:   Wed, 18 Dec 2019 17:45:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 01/11] x86/crypto: Adapt assembly for PIE support
Message-ID: <20191218164543.GH24886@zn.tnic>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-2-thgarnie@chromium.org>
 <20191218124604.GE24886@zn.tnic>
 <CAJcbSZE56E_JqWpxvpHd194SAVn0fGJRiJWmLy=zfOyTthsGCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJcbSZE56E_JqWpxvpHd194SAVn0fGJRiJWmLy=zfOyTthsGCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 18, 2019 at 08:35:32AM -0800, Thomas Garnier wrote:
> In the last discussion, we mentioned Ingo (and other people) asked us

The last discussion ended up with:

https://lkml.kernel.org/r/CAJcbSZEnPeCnkpc%2BuHmBWRJeaaw4TPy9HPkSGeriDb6mN6HR1g@mail.gmail.com

which I read as, you'll remove that silly sentence from every commit
message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

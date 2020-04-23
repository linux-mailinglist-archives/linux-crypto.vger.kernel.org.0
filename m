Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E371B63E5
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Apr 2020 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgDWSmW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Apr 2020 14:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgDWSmV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Apr 2020 14:42:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2539620767;
        Thu, 23 Apr 2020 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587667341;
        bh=KTRpfyPod8ejKBCyWiqd7QJfSaijbGNvBmsswJMm/aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lveQQ7gD0dQ/MhOmjoshXFCS858WXugSCMY6l4GddrgQZiVxr3OL5ROkape22+k30
         CgTEclyNwiD4ZkKzVLUzUCju6vyiI0t0hKU8AGs9s/S/dIn1wAXtlWA4WHl0stzKqW
         UZcQSq9NLKF01lI0xEDGphDk+/3hYwo8jK5+tJ6s=
Date:   Thu, 23 Apr 2020 20:42:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH crypto-stable v3 1/2] crypto: arch/lib - limit simd usage
 to 4k chunks
Message-ID: <20200423184219.GA80650@kroah.com>
References: <20200422200344.239462-1-Jason@zx2c4.com>
 <20200422231854.675965-1-Jason@zx2c4.com>
 <CAMj1kXHV=ryaFmj0jhQVGBd31nfHs7q5RtSyu7dY6GdEJJsr7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHV=ryaFmj0jhQVGBd31nfHs7q5RtSyu7dY6GdEJJsr7A@mail.gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 23, 2020 at 09:18:15AM +0200, Ard Biesheuvel wrote:
> FYI: you shouldn't cc stable@vger.kernel.org directly on your patches,
> or add the cc: line. Only patches that are already in Linus' tree
> should be sent there.

Not true at all, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.  Please do not spread incorrect
information.

And Jason did this properly, he put cc: stable@ in the s-o-b area and
all is good, I will pick up this patch once it hits Linus's tree.

And there is no problem actually sending the patch to stable@vger while
under development like this, as it gives me a heads-up that something is
coming, and is trivial to filter out.

If you really want to be nice, you can just do:
	cc: stable@kernel.org
which goes to /dev/null on kernel.org, so no email will be sent to any
list, but my scripts still pick it up.  But no real need to do that,
it's fine.

> Also, the fixes tags are really quite sufficient.

No it is not, I have had to dig out patches more and more because people
do NOT put the cc: stable and only put Fixes:, which is not a good thing
as I then have to "guess" what the maintainer/developer ment.

Be explicit if you know it, cc: stable please.

> In fact, it is
> actually rather difficult these days to prevent something from being
> taken into -stable if the bots notice that it applies cleanly.

Those "bots" are still driven by a lot of human work, please make it
easy on us whenever possible.

thanks,

greg k-h

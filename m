Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655FD5807FA
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Jul 2022 01:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiGYXHF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 25 Jul 2022 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGYXHE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 25 Jul 2022 19:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D92559E
        for <linux-crypto@vger.kernel.org>; Mon, 25 Jul 2022 16:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DEC6142E
        for <linux-crypto@vger.kernel.org>; Mon, 25 Jul 2022 23:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BE0C341C6
        for <linux-crypto@vger.kernel.org>; Mon, 25 Jul 2022 23:07:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="key not found in DNS" (0-bit key) header.d=libc.org header.i=@libc.org header.b="eNHmWvHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libc.org; s=20210105;
        t=1658790421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SB4KTdSkXPi/bTr8S5rSUPOkMtDOp8QOMJ8QIRrQICw=;
        b=eNHmWvHYR43Q4gJ7GgYHhyrgTDeKTcl9bJ+Ap7t/gJdPqpI42LYNbXU462cjeSKrzVlJAO
        TFgSBA8cXC7i5dK+ylESoYvPWTD9uZFIJysZe5hbkBeOG/b3aP/9clEUYUb63crOPmIpMd
        +QhCK+y7bPMja4uikFpk1LKY8cJVj8Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d63679e4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-crypto@vger.kernel.org>;
        Mon, 25 Jul 2022 23:07:01 +0000 (UTC)
Date:   Mon, 25 Jul 2022 13:44:30 -0400
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, libc-alpha@sourceware.org,
        Michael@phoronix.com, jann@thejh.net, linux-crypto@vger.kernel.org
Subject: Re: arc4random - are you sure we want these?
Message-ID: <20220725174430.GI7074@brightrain.aerifal.cx>
References: <YtwgTySJyky0OcgG@zx2c4.com>
 <Ytwg8YEJn+76h5g9@zx2c4.com>
 <6bf352e9-1312-40de-4733-3219721b343c@linaro.org>
 <20220725153303.GF7074@brightrain.aerifal.cx>
 <878rohp2ll.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rohp2ll.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 25, 2022 at 06:40:54PM +0200, Florian Weimer via Libc-alpha wrote:
> * Rich Felker:
> 
> > On Sat, Jul 23, 2022 at 02:39:29PM -0300, Adhemerval Zanella Netto via Libc-alpha wrote:
> >> On 23/07/22 13:25, Jason A. Donenfeld wrote:
> >> > Firstly, for what use cases does this actually help? As of recent
> >> > changes to the Linux kernels -- now backported all the way to 4.9! --
> >> > getrandom() and /dev/urandom are extremely fast and operate over per-cpu
> >> > states locklessly. Sure you avoid a syscall by doing that in userspace,
> >> > but does it really matter? Who exactly benefits from this?
> >> 
> >> Mainly performance, since glibc both export getrandom and getentropy. 
> >> There were some discussion on maillist and we also decided to explicit
> >> state this is not a CSRNG on our documentation.
> >
> > This is an extreme documentation/specification bug that *hurts*
> > portability and security. The core contract of the historical
> > arc4random function is that it *is* a CSPRNG. Having a function by
> > that name that's allowed not to be one means now all software using it
> > has to add detection for the broken glibc variant.
> >
> > If the glibc implementation has flaws that actually make it not a
> > CSPRNG, this absolutely needs to be fixed. Not doing so is
> > irresponsible and will set everyone back a long ways.
> 
> The core issue is that on some kernels/architectures, reading from
> /dev/urandom can degrade to GRND_INSECURE (approximately), and while the
> result is likely still unpredictable, not everyone would label that as a
> CSPRNG.

Then don't fallback to /dev/urandom. It's not even a failsafe fallback
anyway (ENFILE, EMFILE, sandboxes, etc.) so it can't safely be used
here. Instead use SYS_sysctl and poll for entropy_avail, looping until
it's ready. AFAICT this works reliably on all kernels as far back as
glibc supports (assuming nothing idiotic like intentionally patching
or configuring out random support, but then it's PEBKAC error, as no
distros did this).

Rich

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184D62AD269
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Nov 2020 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgKJJZs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Nov 2020 04:25:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:8570 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgKJJZr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Nov 2020 04:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605000345;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Muj+NMY/EMMLy32xXtOumpx5dkBS25Z8v7DfG0sequM=;
        b=G1L6d83hHPg8Hi49yUxT/RyknXV71nZynuEon/erBwmHMowpoAUMmtfJbBOX1sjFrm
        3RMtHgKAri8ZIfQDQsx+Vr+JiJdoqDpZO1Iub1ktY5EZpeKglTygMjq/sCgQCcwXdTlJ
        oFOYRDrG6zY0ErT2g2Xd+Esp9KmsQYU1f3mN7Fke1otOgqENxC6XDLy2uDS34//EK0Pe
        dB2E/9PX2cl9ONjrkVM7W+B+9GqqXOuZuhuX50sxGex6lHd+m+4Dn23YPunMAcdv/yFP
        fJ9OsNqVID8CPf44b3M9uw01/+HyC2did9UkA82dD+Qq1mSJP74tM2P5cA0xzqU68x+8
        Gzcg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSfEhGW"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 47.3.3 DYNA|AUTH)
        with ESMTPSA id Y03aecwAA9PhFDG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 10 Nov 2020 10:25:43 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: jitterentropy: `jent_mod_init()` takes 17 ms
Date:   Tue, 10 Nov 2020 10:25:42 +0100
Message-ID: <4825077.WBkqHH8m98@tauon.chronox.de>
In-Reply-To: <02fa159f-4f94-cfb7-1f88-bed91c6542a1@molgen.mpg.de>
References: <02fa159f-4f94-cfb7-1f88-bed91c6542a1@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Montag, 9. November 2020, 20:31:02 CET schrieb Paul Menzel:

Hi Paul,

> Dear Linux folks,
> 
> 
> By mistake I built `XFRM_ESP` into the Linux kernel, resulting in
> 
>      CONFIG_CRYPTO_SEQIV=y
>      CONFIG_CRYPTO_ECHAINIV=y
> 
> and also the Jitterentropy RNG to be built in.
> 
>      CRYPTO_JITTERENTROPY=y
> 
> So, on the Asus F2A85-M PRO starting Linux 4.10-rc3 with
> `initcall_debug`, the init method is run unconditionally, and it takes
> 17.5 ms, which is over ten percent of the overall 900 ms the Linux

Hm, 17.5 / 900 = 2%, or am I missing something?

> kernel needs until loading the init process.
> 
>      [    0.300544] calling  jent_mod_init+0x0/0x2c @ 1
>      [    0.318438] initcall jent_mod_init+0x0/0x2c returned 0 after
> 17471 usecs
> 
> Looking at the output of systemd-bootchart, it looks like, that this
> indeed delayed the boot a little, as the other init methods seem to be
> ordered after it.
> 
> I am now building it as a module, but am wondering if the time can be
> reduced to below ten milliseconds.

What you see is the test whether the Jitter RNG has a proper noise source. The 
function jent_entropy_init() is the cause of the operation. It performs 1024 
times a test to validate the appropriateness of the noise source. You can 
adjust that with the TESTLOOPCOUNT in this function. But I am not sure 
adjusting is a wise course of action.

Ciao
Stephan



Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA91CAA69
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 14:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHMRf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 08:17:35 -0400
Received: from mail.thorsis.com ([92.198.35.195]:60190 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgEHMRf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 08:17:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 125A71FC7
        for <linux-crypto@vger.kernel.org>; Fri,  8 May 2020 14:17:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7o0xgFGndeQp for <linux-crypto@vger.kernel.org>;
        Fri,  8 May 2020 14:17:28 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id D2DFD2A4F; Fri,  8 May 2020 14:17:28 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable autolearn_force=no version=3.4.2
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-crypto@vger.kernel.org
Cc:     Stephan Mueller <smueller@chronox.de>
Subject: Re: jitterentropy_rng on armv5 embedded target
Date:   Fri, 08 May 2020 14:17:25 +0200
Message-ID: <2049720.SxWqT2AVQ6@ada>
In-Reply-To: <6309135.Bj5FvMsAKG@tauon.chronox.de>
References: <2567555.LKkejuagh6@ada> <6309135.Bj5FvMsAKG@tauon.chronox.de>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello, Stephan,

Am Freitag, 8. Mai 2020, 13:58:14 CEST schrieb Stephan Mueller:
> > (Although those daemons would solve my problem, I currently try
> > to avoid them, because memory on my platform is very restricted and every
> > additional running userspace process costs at least around 1 MB.)
> 
> If you compile it and you also have AF_ALG for RNGs compiled, you can use it
> through the AF_ALG interface (see [1] for a library). But IMHO if you are
> space-constrained, you do not want that code.
> 
> Rather use the jitterentropy-library from [2] and link it straight from your
> application.

That would be dropbear or openssl (and applications using libssl). While that 
would certainly be nice, I fear it's out of my scope. ;-)

> > If so, then how is it supposed to be set up?
> 
> It is intended for in-kernel purposes (namely to seed its DRBG).

Okay and DRBG has nothing to do with /dev/random ? Then where do the random 
numbers for that come from (in the current or previous kernels without your 
new lrng)?

Curious
Alex




Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7451CAA8F
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHM0u (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 08:26:50 -0400
Received: from mail.thorsis.com ([92.198.35.195]:60383 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHM0u (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 08:26:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 474D42A4F
        for <linux-crypto@vger.kernel.org>; Fri,  8 May 2020 14:26:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0LUapmlvCnia for <linux-crypto@vger.kernel.org>;
        Fri,  8 May 2020 14:26:49 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 1A7EC4B41; Fri,  8 May 2020 14:26:45 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable autolearn_force=no version=3.4.2
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-crypto@vger.kernel.org
Cc:     Stephan Mueller <smueller@chronox.de>
Subject: Re: jitterentropy_rng on armv5 embedded target
Date:   Fri, 08 May 2020 14:26:41 +0200
Message-ID: <2904279.2zIEgBPu8l@ada>
In-Reply-To: <8028774.qcRHhbuxM6@tauon.chronox.de>
References: <2567555.LKkejuagh6@ada> <2049720.SxWqT2AVQ6@ada> <8028774.qcRHhbuxM6@tauon.chronox.de>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello,

Am Freitag, 8. Mai 2020, 14:22:02 CEST schrieb Stephan Mueller:
> Am Freitag, 8. Mai 2020, 14:17:25 CEST schrieb Alexander Dahl:
> > Okay and DRBG has nothing to do with /dev/random ?
> 
> Nope, it is used as part of the kernel crypto API and its use cases.
> 
> > Then where do the random
> > numbers for that come from (in the current or previous kernels without
> > your
> > new lrng)?
> 
> The DRBG is seeded from get_random_bytes and the Jitter RNG.

Oh, I was not precise enough. I wanted to know where /dev/random gets its 
numbers from. As far as I understood now: not from DRBG? (Which is sufficient 
knowledge for my current problem.)

Greets
Alex




Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B96D4D3E
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Oct 2019 07:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfJLFZ5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Oct 2019 01:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfJLFZ5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Oct 2019 01:25:57 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3028D20650;
        Sat, 12 Oct 2019 05:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570857956;
        bh=g9CgJPOuPURp0RtbHe/8f5ksQ9OG8jQbLuicKUYLa+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wix+rYIG5bJE/msxJK2i4/rRGsUZGDdIqYMVIVp7V4SlVzJNGsOmLzOu9xlyoafDy
         YrT0c7IyOCkyJqs9TjqcydO0h6ETdftWTa4d7nvSqLYVvanQF+pUNAy8OQRpuvVXTr
         L9JvFIh/qnf2M1qJyto10499C8ZIfbr4XszFOack=
Date:   Fri, 11 Oct 2019 22:25:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [RFT PATCH 0/3] crypto: sparc - convert to skcipher API
Message-ID: <20191012052554.GA1118@sol.localdomain>
Mail-Followup-To: Anatoly Pugachev <matorola@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sparc kernel list <sparclinux@vger.kernel.org>, davem@davemloft.net,
        linux-crypto@vger.kernel.org
References: <20191012043850.340957-1-ebiggers@kernel.org>
 <CADxRZqw5PkW0_9s822UeaDO7UEG_rOQ=-c0bnhDOuuYLmLD_+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqw5PkW0_9s822UeaDO7UEG_rOQ=-c0bnhDOuuYLmLD_+w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Oct 12, 2019 at 08:16:41AM +0300, Anatoly Pugachev wrote:
> On Sat, Oct 12, 2019, 07:47 Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > This series converts the glue code for the SPARC64 crypto opcodes
> > implementations of AES, Camellia, DES, and 3DES modes from the
> > deprecated "blkcipher" API to the "skcipher" API.  This is needed in
> > order for the blkcipher API to be removed.
> >
> > I've compiled this patchset, and the conversion is very similar to that
> > which has been done for many other crypto drivers.  But I don't have the
> > hardware to test it, nor are SPARC64 crypto opcodes supported by QEMU.
> > So I really need someone with the hardware to test it.  You can do so by
> > setting:
> >
> > CONFIG_CRYPTO_AES_SPARC64=y
> > CONFIG_CRYPTO_CAMELLIA_SPARC64=y
> > CONFIG_CRYPTO_DES_SPARC64=y
> > # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> > CONFIG_CRYPTO_AES=y
> > CONFIG_CRYPTO_CAMELLIA=y
> > CONFIG_CRYPTO_DES=y
> > CONFIG_CRYPTO_CBC=y
> > CONFIG_CRYPTO_CTR=y
> > CONFIG_CRYPTO_ECB=y
> >
> > Then boot and check for crypto self-test failures by running
> > 'dmesg | grep alg'.
> >
> > If there are test failures, please also check whether they were already
> > failing prior to this patchset.
> >
> > Eric Biggers (3):
> >   crypto: sparc/aes - convert to skcipher API
> >   crypto: sparc/camellia - convert to skcipher API
> >   crypto: sparc/des - convert to skcipher API
> >
> >  arch/sparc/crypto/aes_glue.c      | 310 +++++++++----------
> >  arch/sparc/crypto/camellia_glue.c | 217 ++++++-------
> >  arch/sparc/crypto/des_glue.c      | 499 ++++++++++++++----------------
> >  crypto/Kconfig                    |   5 +-
> >  4 files changed, 468 insertions(+), 563 deletions(-)
> >
> 
> Eric, I could provide you with sparc hardware access or test (as compile
> and boot) this patch set , but not earlier than the begining of next week.
> 
> Would it be possible to implement test suite for for this crypto opcodes
> somewhere under tools/testing/selftests/ ?!
> 

Looks like David was the first volunteer :-)  But feel free to test it too.

The crypto subsystem already has self-tests for all these algorithms which run
at boot time (or at module load time if they're built as loadable modules).
They just need to be enabled in the kconfig; see above.  Self-test failures are
reported in dmesg and in /proc/crypto.

- Eric

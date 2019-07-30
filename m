Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5F7AD2B
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfG3QDj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jul 2019 12:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG3QDj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jul 2019 12:03:39 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CE020693;
        Tue, 30 Jul 2019 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564502618;
        bh=E/QLwOHSrCJv/VZx7Tdwjb8mnedP4aAYlWyjuNIVvC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lU5gSOcivOas2ppwAadqaOKo3WDKRRp3s5NPY0zmq8itxgPaazKHkP7v9xRjkUpX3
         7aLUNj8Cey9XcG96Q2OYLA9mSlA4SAEzdiCd85X3TwWiJtr0JBmOuEhGan0T+48AML
         w0X8KrbP1XLRSedZimmJEkRXhLqKdvbCvaNK45qc=
Date:   Tue, 30 Jul 2019 09:03:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC 3/3] crypto/sha256: Build the SHA256 core separately from
 the crypto module
Message-ID: <20190730160335.GA27287@gmail.com>
Mail-Followup-To: Stephan Mueller <smueller@chronox.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20190730123835.10283-1-hdegoede@redhat.com>
 <20190730123835.10283-4-hdegoede@redhat.com>
 <4384403.bebDo606LH@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384403.bebDo606LH@tauon.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 30, 2019 at 03:15:35PM +0200, Stephan Mueller wrote:
> Am Dienstag, 30. Juli 2019, 14:38:35 CEST schrieb Hans de Goede:
> 
> Hi Hans,
> 
> > From: Andy Lutomirski <luto@kernel.org>
> > 
> > This just moves code around -- no code changes in this patch.  This
> > wil let BPF-based tracing link against the SHA256 core code without
> > depending on the crypto core.
> > 
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  crypto/Kconfig                               |   8 +
> >  crypto/Makefile                              |   1 +
> >  crypto/{sha256_generic.c => sha256_direct.c} | 103 +--------
> 
> There is a similar standalone code present for SHA-1 or ChaCha20. However, 
> this code lives in lib/.
> 
> Thus, shouldn't the SHA-256 core code be moved to lib/ as well?
> 
> Ciao
> Stephan
> 
> 

What's wrong with lib/sha256.c?  It's already there.

- Eric

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857023B934
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Jun 2019 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbfFJQRk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Jun 2019 12:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbfFJQRk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Jun 2019 12:17:40 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0D9206C3;
        Mon, 10 Jun 2019 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560183459;
        bh=QGhJuN0HuWoeta0i22g4yniTwp+mXdkpwXH55YL+A8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2kuKZMXgAV6p4G0Dd1JARxrq/HgBj/mivIp1MeUXVUkuu67b96pKp55TLlH0k7OXT
         oai27dLaLAonV3JIxhecGCqaJlX/CGWVFFPPg44SksMAfaFAxdk5JtUGJeAjEPl8iv
         KOhvSHpDKvbNfsXFrVmLYDiHZNokE8lIjiUA3TZ8=
Date:   Mon, 10 Jun 2019 09:17:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH v2 7/7] fs: cifs: switch to RC4 library interface
Message-ID: <20190610161736.GB63833@gmail.com>
References: <20190609115509.26260-1-ard.biesheuvel@linaro.org>
 <20190609115509.26260-8-ard.biesheuvel@linaro.org>
 <CAH2r5mvQmY8onx6y2Y1aJOuWP9AsK52EJ=cXiJ7hdYPWrLp6uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvQmY8onx6y2Y1aJOuWP9AsK52EJ=cXiJ7hdYPWrLp6uA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Steve,

On Sun, Jun 09, 2019 at 05:03:25PM -0500, Steve French wrote:
> Probably harmless to change this code path (build_ntlmssp_auth_blob is
> called at session negotiation time so shouldn't have much of a
> performance impact).
> 
> On the other hand if we can find optimizations in the encryption and
> signing paths, that would be really helpful.   There was a lot of
> focus on encryption performance at SambaXP last week.
> 
> Andreas from Redhat gave a talk on the improvements in Samba with TLS
> implementation of AES-GCM.   I added the cifs client implementation of
> AES-GCM and notice it is now faster to encrypt packets than sign them
> (performance is about 2 to 3 times faster now with GCM).
> 
> On Sun, Jun 9, 2019 at 6:57 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > The CIFS code uses the sync skcipher API to invoke the ecb(arc4) skcipher,
> > of which only a single generic C code implementation exists. This means
> > that going through all the trouble of using scatterlists etc buys us
> > very little, and we're better off just invoking the arc4 library directly.

This patch only changes RC4 encryption, and to be clear it actually *improves*
the performance of the RC4 encryption, since it removes unnecessary
abstractions.  I'd really hope that people wouldn't care either way, though,
since RC4 is insecure and should not be used.

Also it seems that fs/cifs/ supports AES-CCM but not AES-GCM?

/* pneg_ctxt->Ciphers[0] = SMB2_ENCRYPTION_AES128_GCM;*/ /* not supported yet */
        pneg_ctxt->Ciphers[0] = SMB2_ENCRYPTION_AES128_CCM;

AES-GCM is usually faster than AES-CCM, so if you want to improve performance,
switching from CCM to GCM would do that.

- Eric

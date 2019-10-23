Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2430E1087
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Oct 2019 05:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfJWD0C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Oct 2019 23:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731772AbfJWD0B (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Oct 2019 23:26:01 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A914A2053B;
        Wed, 23 Oct 2019 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571801161;
        bh=mZKVCHUM4RV7iZ3IZF7KTa/Oq4JdH8NzggZCbnAf3Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oipg+kPUrkiQV6KrbEHI+/NSvF2mstR8Cm7wfYzhjeedQ7c0mGGlQx7Eh6QdW7/p5
         Brbpsb0DJREH+0X5+dBIpPXyXzgTIno6CR6RiE+0YnCf+SHU8oUwXpFHB9FBzkM4US
         wuNct1wN14FxRYWBRwdjaxbKmbNYESCVUHUM8svI=
Date:   Tue, 22 Oct 2019 20:25:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 24/35] crypto: blake2s - implement generic shash driver
Message-ID: <20191023032559.GG4278@sol.localdomain>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
References: <20191017190932.1947-1-ard.biesheuvel@linaro.org>
 <20191017190932.1947-25-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017190932.1947-25-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 17, 2019 at 09:09:21PM +0200, Ard Biesheuvel wrote:
> Wire up our newly added Blake2s implementation via the shash API.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  crypto/Kconfig                    |   4 +
>  crypto/Makefile                   |   1 +
>  crypto/blake2s-generic.c          | 171 ++++++++++++++++++++
>  include/crypto/internal/blake2s.h |   5 +

Nit: the blake2b patch from David Sterba, and most of the existing files in
crypto/, use the filename suffix "_generic.c" instead of "-generic.c".  So for
consistency it might be better to use "_generic.c".

- Eric

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF9CBB8C
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfJDNV1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 09:21:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:47015 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388393AbfJDNVZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 09:21:25 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id de9def0d;
        Fri, 4 Oct 2019 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=6XfAux8GapWPe/AoEu/Dh2tX5BI=; b=HsM1i/j
        KK+5e+qKSydagNLOhs00fnm4L7eqBYEMjmZEXbUSRq/fR0biea6UG4vzPLLyZlGh
        /mSmJ63j3zMu4nfkzePNG/srv0rJPhG0ZRPOoAtl2whGiLDoRcjPpzWlnyy5OC09
        sjGHLDTM4AB0wOopAJ+OjTskyB6b70QFWdaW0PPBImkosEGWd3mdUKlSSe+Gu4NK
        xSi7J3tNMMahBf4xzfsRnFZ12wi7wxkuhHksvITlA4m3Y473/ovMLq5HsWTBQF3q
        i1dJSn/oKv5y1Q/msHbBO2KqWS3oOQx/1+faWHMHbwbncafgyk84+BlrpBzOutEv
        P/bMfTUCYfRMO9Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff86fe27 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 4 Oct 2019 12:34:29 +0000 (UTC)
Date:   Fri, 4 Oct 2019 15:21:17 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Willi <martin@strongswan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 01/20] crypto: chacha - move existing library code
 into lib/crypto
Message-ID: <20191004132117.GB112631@zx2c4.com>
References: <20191002141713.31189-1-ard.biesheuvel@linaro.org>
 <20191002141713.31189-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002141713.31189-2-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 02, 2019 at 04:16:54PM +0200, Ard Biesheuvel wrote:
>  
>  	chacha_permute(x, nrounds);

Interested in porting my single-statement unrolled implementation from
Zinc to this? I did see performance improvements on various platforms.

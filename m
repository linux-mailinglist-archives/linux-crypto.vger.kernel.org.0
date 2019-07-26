Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90433765C2
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jul 2019 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGZMbB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jul 2019 08:31:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46368 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfGZMbB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jul 2019 08:31:01 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzNC-0003gT-F0; Fri, 26 Jul 2019 22:30:58 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzNA-00026h-A0; Fri, 26 Jul 2019 22:30:56 +1000
Date:   Fri, 26 Jul 2019 22:30:56 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net, pvanleeuwen@verimatrix.com
Subject: Re: [PATCH 0/9] crypto: inside-secure - fix cryptomgr extratests
 issues
Message-ID: <20190726123056.GA8092@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562078400-969-1-git-send-email-pvanleeuwen@verimatrix.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> This patch set fixes all remaining issues with the cryptomgr extra tests
> when run on a Marvell A7K or A8K device (i.e Macchiatobin), resulting in
> a clean boot with the extra tests enabled.
> 
> Pascal van Leeuwen (9):
>  crypto: inside-secure - keep ivsize for DES ECB modes at 0
>  crypto: inside-secure - silently return -EINVAL for input error cases
>  crypto: inside-secure - fix incorrect skcipher output IV
>  crypto: inside-secure - fix scatter/gather list to descriptor
>    conversion
>  crypto: inside-secure - fix EINVAL error (buf overflow) for AEAD
>    decrypt
>  crypto: inside-secure: back out parts of earlier HMAC update
>    workaround
>  crypto: inside-secure - let HW deal with initial hash digest
>  crypto: inside-secure - add support for arbitrary size hash/HMAC
>    updates
>  crypto: inside-secure - add support for 0 length HMAC messages
> 
> drivers/crypto/inside-secure/safexcel.c        |  25 +-
> drivers/crypto/inside-secure/safexcel.h        |   6 +-
> drivers/crypto/inside-secure/safexcel_cipher.c | 265 ++++++++----
> drivers/crypto/inside-secure/safexcel_hash.c   | 553 ++++++++++++++-----------
> 4 files changed, 520 insertions(+), 329 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

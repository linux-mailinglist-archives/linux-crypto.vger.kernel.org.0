Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B71955E2
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2020 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgC0LDf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Mar 2020 07:03:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58958 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0LDf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Mar 2020 07:03:35 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jHmlr-0006Bb-Ph; Fri, 27 Mar 2020 22:03:28 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2020 22:03:27 +1100
Date:   Fri, 27 Mar 2020 22:03:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH crypto] crypto: arm[64]/poly1305 - add artifact to
 .gitignore files
Message-ID: <20200327110327.GA21003@gondor.apana.org.au>
References: <20200319180114.6437-1-Jason@zx2c4.com>
 <20200327045543.GA19982@gondor.apana.org.au>
 <CAHmME9osVGrkjkUWaveQX1L3S+0dTtUQNFmFJmv89oHsjkR3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9osVGrkjkUWaveQX1L3S+0dTtUQNFmFJmv89oHsjkR3-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 26, 2020 at 10:57:50PM -0600, Jason A. Donenfeld wrote:
>
> I had sent this with [PATCH crypto] in the subject line, meant for
> crypto-2.6.git for 5.6, since it's a bug fix for the things there. I
> didn't realize you were queuing these changes for 5.7 instead.

Sorry about that.  However, as a general rule I don't take trivial
fixes such as these for the crypto tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

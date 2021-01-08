Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959802EEC0B
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Jan 2021 04:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbhAHDzj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 7 Jan 2021 22:55:39 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39732 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbhAHDzj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 7 Jan 2021 22:55:39 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kxirS-000688-Cv; Fri, 08 Jan 2021 14:54:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jan 2021 14:54:50 +1100
Date:   Fri, 8 Jan 2021 14:54:50 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.11
Message-ID: <20210108035450.GA6191@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227113221.GA28744@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Linus:

This push fixes a functional bug in arm/chacha-neon as well as a
potential buffer overflow in ecdh.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to 0aa171e9b267ce7c52d3a3df7bc9c1fc0203dec5:

  crypto: ecdh - avoid buffer overflow in ecdh_set_secret() (2021-01-03 08:35:35 +1100)

----------------------------------------------------------------
Ard Biesheuvel (2):
      crypto: arm/chacha-neon - add missing counter increment
      crypto: ecdh - avoid buffer overflow in ecdh_set_secret()

 arch/arm/crypto/chacha-glue.c | 1 +
 crypto/ecdh.c                 | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2DD29AD
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Oct 2019 14:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfJJMjB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Oct 2019 08:39:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37568 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfJJMjB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Oct 2019 08:39:01 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iIXiX-0001FH-7c; Thu, 10 Oct 2019 23:38:54 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Oct 2019 23:38:49 +1100
Date:   Thu, 10 Oct 2019 23:38:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.4
Message-ID: <20191010123849.GA30001@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923050515.GA6980@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Linus:

This push fixes build issues in arm/aes-ce.

The following changes since commit bf6a7a5ad6fa69e48b735be75eeb90569d9584bb:

  crypto: hisilicon - avoid unused function warning (2019-09-20 23:05:33 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

for you to fetch changes up to f703964fc66804e6049f2670fc11045aa8359b1a:

  crypto: arm/aes-ce - add dependency on AES library (2019-10-01 23:06:43 +1000)

----------------------------------------------------------------
Ard Biesheuvel (2):
      crypto: arm/aes-ce - build for v8 architecture explicitly
      crypto: arm/aes-ce - add dependency on AES library

 arch/arm/crypto/Kconfig       | 1 +
 arch/arm/crypto/aes-ce-core.S | 1 +
 2 files changed, 2 insertions(+)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2C244A4E
	for <lists+linux-crypto@lfdr.de>; Fri, 14 Aug 2020 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNNSe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 Aug 2020 09:18:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59326 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgHNNSe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 Aug 2020 09:18:34 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k6Zb8-0000zF-4P; Fri, 14 Aug 2020 23:18:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Aug 2020 23:18:18 +1000
Date:   Fri, 14 Aug 2020 23:18:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.9
Message-ID: <20200814131817.GA8147@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200408061513.GA23636@gondor.apana.org.au>
 <20200611040544.GA27603@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611040544.GA27603@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Linus:

This push fixes a regression in af_alg.

The following changes since commit 3cbfe80737c18ac6e635421ab676716a393d3074:

  crypto: sa2ul - Fix inconsistent IS_ERR and PTR_ERR (2020-07-31 18:25:29 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to 21dfbcd1f5cbff9cf2f9e7e43475aed8d072b0dd:

  crypto: algif_aead - fix uninitialized ctx->init (2020-08-13 17:09:32 +1000)

----------------------------------------------------------------
Ondrej Mosnacek (1):
      crypto: algif_aead - fix uninitialized ctx->init

 crypto/algif_aead.c     | 6 ------
 crypto/algif_skcipher.c | 7 +------
 2 files changed, 1 insertion(+), 12 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

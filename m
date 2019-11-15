Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6153FD5CD
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfKOGIU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:08:20 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58044 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfKOGIU (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:08:20 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUmJ-0004rT-EU; Fri, 15 Nov 2019 14:08:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUmI-00068h-SG; Fri, 15 Nov 2019 14:08:18 +0800
Date:   Fri, 15 Nov 2019 14:08:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 00/29] crypto: convert h/w accelerator drivers to
 skcipher API
Message-ID: <20191115060818.twsxw56nohb2yiue@gondor.apana.org.au>
References: <20191109170954.756-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109170954.756-1-ardb@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Nov 09, 2019 at 06:09:25PM +0100, Ard Biesheuvel wrote:
> This series converts all drivers for h/w accelerators that produce the
> ablkcipher API to the skcipher API, so that we can finally retire the
> long deprecated ablkcipher code.
> 
> Changes since v3:
> - add acks from Tudor, Gilad and Eric
> - incorporate updated version of the QAT patch from Giovanni
> - rebased onto latest cryptodev/master
> - updated wording in commit logs to refer to ablkcipher not blkcipher [which
>   has already been removed]
> 
> Changes since v2:
> - added a patch that removes the ablkcipher support code itself
> - fix an issue in the talitos code
> - add tero's ack to patch #5
> - add stanimir's ack to patch #20
> 
> Changes since v1:
> - remove some more [cosmetic] references to [a]blkcipher (#26-#27)
> - add back missing IV for cbc(aes) in the omap driver, fixing a crash
> - add Gary's ack to #4
> - add Linus's ack to #6 and #15
> - add Kamil's and Krzysztof's acks to #7
> - fixed a bug in the Atmel patch (#8)
> - add Horia's tested-by to #16
> - add Dave's ack to #22
> 
> Patches #1, #2 are fixes for the virtio driver, which need to be applied
> first so that they can be backported
> 
> Patches #3 and #4 have been tested by me on actual 'hardware' (given the
> virtual nature of the virtio driver). Patch #5 was tested by Tero. Patch #7
> was tested successfully in kernelci. Patches #8 and #9 were tested by Tudor.
> Patch #16 was tested by Horia. Patch #25 was updated with changes proposed
> by Giovanni, so I assume he tested them as well. Patch #24 was fixed in v2
> in response to a test failure report.
> 
> All other patches have been build tested *only*, and should preferably be
> tested on actual hardware before being merged. Note that patches can be
> merged piecemeal (with the exception of #1 .. #3 which should be taken as a
> set, and #28 which removes the ablkcipher support code) since there are no
> dependencies between them. However, deferring this series indefinitely until
> everyone has chimed in doesn't seem like a useful approach either, so I am
> leaving it up to the maintainers to decide when we have reached critical
> mass and the whole series can be taken.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Ard Biesheuvel (29):
>   crypto: virtio - implement missing support for output IVs
>   crypto: virtio - deal with unsupported input sizes
>   crypto: virtio - switch to skcipher API
>   crypto: ccp - switch from ablkcipher to skcipher
>   crypto: omap - switch to skcipher API
>   crypto: ux500 - switch to skcipher API
>   crypto: s5p - switch to skcipher API
>   crypto: atmel-aes - switch to skcipher API
>   crypto: atmel-tdes - switch to skcipher API
>   crypto: bcm-spu - switch to skcipher API
>   crypto: nitrox - remove cra_type reference to ablkcipher
>   crypto: cavium/cpt - switch to skcipher API
>   crypto: chelsio - switch to skcipher API
>   crypto: hifn - switch to skcipher API
>   crypto: ixp4xx - switch to skcipher API
>   crypto: mxs - switch to skcipher API
>   crypto: mediatek - switch to skcipher API
>   crypto: sahara - switch to skcipher API
>   crypto: picoxcell - switch to skcipher API
>   crypto: qce - switch to skcipher API
>   crypto: stm32 - switch to skcipher API
>   crypto: niagara2 - switch to skcipher API
>   crypto: rockchip - switch to skcipher API
>   crypto: talitos - switch to skcipher API
>   crypto: qat - switch to skcipher API
>   crypto: marvell/cesa - rename blkcipher to skcipher
>   crypto: nx - remove stale comment referring to the blkcipher walk API
>   crypto: remove deprecated and unused ablkcipher support
>   crypto: ccree - update a stale reference to ablkcipher
> 
>  Documentation/crypto/api-skcipher.rst         |  20 +-
>  Documentation/crypto/architecture.rst         |   2 -
>  Documentation/crypto/crypto_engine.rst        |   4 -
>  crypto/Makefile                               |   4 +-
>  crypto/ablkcipher.c                           | 407 -------------
>  crypto/algapi.c                               |  26 -
>  crypto/crypto_engine.c                        |  29 -
>  crypto/skcipher.c                             | 106 ----
>  drivers/crypto/Kconfig                        |   2 +-
>  drivers/crypto/atmel-aes.c                    | 509 ++++++++--------
>  drivers/crypto/atmel-tdes.c                   | 433 +++++++-------
>  drivers/crypto/bcm/cipher.c                   | 373 ++++++------
>  drivers/crypto/bcm/cipher.h                   |  10 +-
>  drivers/crypto/bcm/spu2.c                     |   6 +-
>  drivers/crypto/cavium/cpt/cptvf_algs.c        | 292 +++++----
>  .../crypto/cavium/nitrox/nitrox_skcipher.c    |   1 -
>  drivers/crypto/ccp/ccp-crypto-aes-galois.c    |   7 +-
>  drivers/crypto/ccp/ccp-crypto-aes-xts.c       |  94 +--
>  drivers/crypto/ccp/ccp-crypto-aes.c           | 169 +++---
>  drivers/crypto/ccp/ccp-crypto-des3.c          | 100 ++--
>  drivers/crypto/ccp/ccp-crypto-main.c          |  14 +-
>  drivers/crypto/ccp/ccp-crypto.h               |  13 +-
>  drivers/crypto/ccree/cc_cipher.c              |   4 +-
>  drivers/crypto/chelsio/chcr_algo.c            | 334 ++++++-----
>  drivers/crypto/chelsio/chcr_algo.h            |   2 +-
>  drivers/crypto/chelsio/chcr_crypto.h          |  16 +-
>  drivers/crypto/hifn_795x.c                    | 183 +++---
>  drivers/crypto/ixp4xx_crypto.c                | 228 ++++---
>  drivers/crypto/marvell/cesa.h                 |   6 +-
>  drivers/crypto/marvell/cipher.c               |  14 +-
>  drivers/crypto/mediatek/mtk-aes.c             | 248 ++++----
>  drivers/crypto/mxs-dcp.c                      | 140 ++---
>  drivers/crypto/n2_core.c                      | 194 +++---
>  drivers/crypto/nx/nx-aes-ccm.c                |   5 -
>  drivers/crypto/nx/nx-aes-gcm.c                |   5 -
>  drivers/crypto/omap-aes.c                     | 209 ++++---
>  drivers/crypto/omap-aes.h                     |   4 +-
>  drivers/crypto/omap-des.c                     | 232 ++++----
>  drivers/crypto/picoxcell_crypto.c             | 386 ++++++------
>  drivers/crypto/qat/qat_common/qat_algs.c      | 304 +++++-----
>  drivers/crypto/qat/qat_common/qat_crypto.h    |   4 +-
>  drivers/crypto/qce/Makefile                   |   2 +-
>  drivers/crypto/qce/cipher.h                   |   8 +-
>  drivers/crypto/qce/common.c                   |  12 +-
>  drivers/crypto/qce/common.h                   |   3 +-
>  drivers/crypto/qce/core.c                     |   2 +-
>  .../crypto/qce/{ablkcipher.c => skcipher.c}   | 172 +++---
>  drivers/crypto/rockchip/Makefile              |   2 +-
>  drivers/crypto/rockchip/rk3288_crypto.c       |   8 +-
>  drivers/crypto/rockchip/rk3288_crypto.h       |   3 +-
>  .../rockchip/rk3288_crypto_ablkcipher.c       | 556 ------------------
>  .../crypto/rockchip/rk3288_crypto_skcipher.c  | 538 +++++++++++++++++
>  drivers/crypto/s5p-sss.c                      | 187 +++---
>  drivers/crypto/sahara.c                       | 156 +++--
>  drivers/crypto/stm32/stm32-cryp.c             | 338 +++++------
>  drivers/crypto/talitos.c                      | 308 +++++-----
>  drivers/crypto/ux500/cryp/cryp_core.c         | 371 +++++-------
>  drivers/crypto/virtio/virtio_crypto_algs.c    | 192 +++---
>  drivers/crypto/virtio/virtio_crypto_common.h  |   2 +-
>  include/crypto/aead.h                         |   2 +-
>  include/crypto/algapi.h                       |  75 ---
>  include/crypto/engine.h                       |   4 -
>  include/crypto/hash.h                         |   2 +-
>  include/crypto/internal/des.h                 |  12 -
>  include/crypto/internal/skcipher.h            |  20 -
>  include/crypto/skcipher.h                     |   6 -
>  include/linux/crypto.h                        | 435 --------------
>  67 files changed, 3531 insertions(+), 5024 deletions(-)
>  delete mode 100644 crypto/ablkcipher.c
>  rename drivers/crypto/qce/{ablkcipher.c => skcipher.c} (61%)
>  delete mode 100644 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
>  create mode 100644 drivers/crypto/rockchip/rk3288_crypto_skcipher.c

All applied with addition of the changes suggested by Tudor.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

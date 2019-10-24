Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A38E33E7
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Oct 2019 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502547AbfJXNX6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Oct 2019 09:23:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38679 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502541AbfJXNX5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Oct 2019 09:23:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so2599818wmi.3
        for <linux-crypto@vger.kernel.org>; Thu, 24 Oct 2019 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoNY5nhcqsMX/VQdm/2dcVh9uYGHVkxgyi2II9TO5gA=;
        b=Nwg9+/NhdSEA6IEeKNiYDBZDjsX3VE5Ct0kBDiFDIVw6kdN2IX29d3JRNVeH4liTbB
         9Fp375ux6S8PS0l5OxAt4qY6kS9+p9PAuzeGdPN/1y3V+Uv/7MWVoR+lbLVX+u8BOl6x
         Xv8QJrYzwGmb2ZjNuCPDWEiAA7IWrOAL1d0K0nsb9XYn/eVULEMWn+oPM91HlG0Dqvho
         q+HG5yraQqN+hrPmdyzs1XknB4rM6z2Jfe7kcqJ4OR9rH76nMSzvznwcd/QVQW2QOxEZ
         d4Y+OIRyNnsv3AIhhfRqUiWWtS0SalqsmpJC92Hb7a7k/byQMF23jNXFV3x7VleDOImm
         Ay/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoNY5nhcqsMX/VQdm/2dcVh9uYGHVkxgyi2II9TO5gA=;
        b=txOXXWTl6QtAXK9/VfY2oGd4E7DjKpnFXk3fajLddg5lwn4HTSrUBb8M282w87ZA7c
         fu7IpW7WHb08EG4r9INIj2bLq8sWDT79jfiPz82CGhxkAR0hVRi7Sm4kj6mp39BHc18H
         Srx0UzphQl5W1rhFsc+PTydVPjFsFHTtxKp0ONtXtklhQmMOj+YbdE95OYOdaqV+zQjP
         z/Qll0tUGD7s6Vpnm2E4B18xXQL/wHS6SverqdNztgghAC90YK5Af/7iRM3rvj8vYf40
         syUQo7CDjgStq10ebW6isviAqreFF0+3BpFDvj+gVXWgCUWlXhTh6Qq8C0X6QzNz9siB
         Wr/Q==
X-Gm-Message-State: APjAAAUUi4gEsd51f88nM4RpCahpWbEMsDG4f5V6Gfwe0NqirOv5J513
        FOTkX2n8bOY0hOG7OXFk8GqZweN9AsK4oLun
X-Google-Smtp-Source: APXvYqz6lRExPxrZzq/HzNoGfVZ8/pwXegBhHlmrc4aa8vUCi3bYeW4zFsBDvQowv77K8bpN8RpCGQ==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr4873589wmc.12.1571923434148;
        Thu, 24 Oct 2019 06:23:54 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id e3sm2346310wme.36.2019.10.24.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:23:53 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/27] crypto: convert h/w accelerator drivers to skcipher API
Date:   Thu, 24 Oct 2019 15:23:18 +0200
Message-Id: <20191024132345.5236-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series converts all drivers for h/w accelerators that produce the
ablkcipher API to the skcipher API, so that we can finally retire the
long deprecated [a]blkcipher code.

Changes since v1:
- remove some more [cosmetic] references to [a]blkcipher (#26-#27)
- add back missing IV for cbc(aes) in the omap driver, fixing a crash
- add Gary's ack to #4
- add Linus's ack to #6 and #15
- add Kamil's and Krzysztof's acks to #7
- fixed a bug in the Atmel patch (#8)
- add Horia's tested-by to #16
- add Dave's ack to #22

Patches #1, #2 are fixes for the virtio driver, which need to be applied
first so that they can be backported

Patches #3 and #4 have been tested on actual 'hardware' (given the virtual
nature of the virtio driver). Patch #7 was tested successfully in kernelci.
Patch #16 was tested by Horia.

All other patches have been build tested *only*, and should be tested on
actual hardware before being merged. Note that patches can be merged
piecemeal (with the exception of #1 .. #3) since there are no dependencies
between them.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: linux-arm-kernel@lists.infradead.org

Ard Biesheuvel (27):
  crypto: virtio - implement missing support for output IVs
  crypto: virtio - deal with unsupported input sizes
  crypto: virtio - switch to skcipher API
  crypto: ccp - switch from ablkcipher to skcipher
  crypto: omap - switch to skcipher API
  crypto: ux500 - switch to skcipher API
  crypto: s5p - switch to skcipher API
  crypto: atmel-aes - switch to skcipher API
  crypto: atmel-tdes - switch to skcipher API
  crypto: bcm-spu - switch to skcipher API
  crypto: nitrox - remove cra_type reference to ablkcipher
  crypto: cavium/cpt - switch to skcipher API
  crypto: chelsio - switch to skcipher API
  crypto: hifn - switch to skcipher API
  crypto: ixp4xx - switch to skcipher API
  crypto: mxs - switch to skcipher API
  crypto: mediatek - switch to skcipher API
  crypto: sahara - switch to skcipher API
  crypto: picoxcell - switch to skcipher API
  crypto: qce - switch to skcipher API
  crypto: stm32 - switch to skcipher API
  crypto: niagara2 - switch to skcipher API
  crypto: rockchip - switch to skcipher API
  crypto: talitos - switch to skcipher API
  crypto: qat - switch to skcipher API
  crypto: marvell/cesa - rename blkcipher to skcipher
  crypto: nx - remove stale comment referring to the blkcipher walk API

 drivers/crypto/Kconfig                             |   2 +-
 drivers/crypto/atmel-aes.c                         | 509 +++++++++---------
 drivers/crypto/atmel-tdes.c                        | 433 ++++++++-------
 drivers/crypto/bcm/cipher.c                        | 373 +++++++------
 drivers/crypto/bcm/cipher.h                        |  10 +-
 drivers/crypto/bcm/spu2.c                          |   6 +-
 drivers/crypto/cavium/cpt/cptvf_algs.c             | 292 +++++-----
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c     |   1 -
 drivers/crypto/ccp/ccp-crypto-aes-galois.c         |   7 +-
 drivers/crypto/ccp/ccp-crypto-aes-xts.c            |  94 ++--
 drivers/crypto/ccp/ccp-crypto-aes.c                | 169 +++---
 drivers/crypto/ccp/ccp-crypto-des3.c               | 100 ++--
 drivers/crypto/ccp/ccp-crypto-main.c               |  14 +-
 drivers/crypto/ccp/ccp-crypto.h                    |  13 +-
 drivers/crypto/chelsio/chcr_algo.c                 | 334 ++++++------
 drivers/crypto/chelsio/chcr_algo.h                 |   2 +-
 drivers/crypto/chelsio/chcr_crypto.h               |  16 +-
 drivers/crypto/hifn_795x.c                         | 183 +++----
 drivers/crypto/ixp4xx_crypto.c                     | 228 ++++----
 drivers/crypto/marvell/cesa.h                      |   6 +-
 drivers/crypto/marvell/cipher.c                    |  14 +-
 drivers/crypto/mediatek/mtk-aes.c                  | 248 ++++-----
 drivers/crypto/mxs-dcp.c                           | 140 +++--
 drivers/crypto/n2_core.c                           | 194 ++++---
 drivers/crypto/nx/nx-aes-ccm.c                     |   5 -
 drivers/crypto/nx/nx-aes-gcm.c                     |   5 -
 drivers/crypto/omap-aes.c                          | 209 ++++----
 drivers/crypto/omap-aes.h                          |   4 +-
 drivers/crypto/omap-des.c                          | 232 ++++----
 drivers/crypto/picoxcell_crypto.c                  | 386 +++++++-------
 drivers/crypto/qat/qat_common/qat_algs.c           | 255 +++++----
 drivers/crypto/qat/qat_common/qat_crypto.h         |   4 +-
 drivers/crypto/qce/Makefile                        |   2 +-
 drivers/crypto/qce/cipher.h                        |   8 +-
 drivers/crypto/qce/common.c                        |  12 +-
 drivers/crypto/qce/common.h                        |   3 +-
 drivers/crypto/qce/core.c                          |   2 +-
 drivers/crypto/qce/{ablkcipher.c => skcipher.c}    | 172 +++---
 drivers/crypto/rockchip/Makefile                   |   2 +-
 drivers/crypto/rockchip/rk3288_crypto.c            |   8 +-
 drivers/crypto/rockchip/rk3288_crypto.h            |   3 +-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c | 556 --------------------
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   | 538 +++++++++++++++++++
 drivers/crypto/s5p-sss.c                           | 187 ++++---
 drivers/crypto/sahara.c                            | 156 +++---
 drivers/crypto/stm32/stm32-cryp.c                  | 338 ++++++------
 drivers/crypto/talitos.c                           | 306 +++++------
 drivers/crypto/ux500/cryp/cryp_core.c              | 371 ++++++-------
 drivers/crypto/virtio/virtio_crypto_algs.c         | 192 +++----
 drivers/crypto/virtio/virtio_crypto_common.h       |   2 +-
 50 files changed, 3499 insertions(+), 3847 deletions(-)
 rename drivers/crypto/qce/{ablkcipher.c => skcipher.c} (61%)
 delete mode 100644 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c
 create mode 100644 drivers/crypto/rockchip/rk3288_crypto_skcipher.c

-- 
2.20.1


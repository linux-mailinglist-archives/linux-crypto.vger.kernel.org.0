Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235512D562C
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Dec 2020 10:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbgLJJI7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Dec 2020 04:08:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387489AbgLJJI5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Dec 2020 04:08:57 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 0/2] crypto: remove bare cipher from public API
Date:   Thu, 10 Dec 2020 10:05:22 +0100
Message-Id: <20201210090524.18880-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Patch #2 puts the cipher API (which should not be used outside of the
crypto API implementation) into an internal header file and module
namespace

Patch #1 is a prerequisite for this, to avoid having to make the chelsio
driver import the crypto internal namespace.

Cc: Eric Biggers <ebiggers@google.com>

Ard Biesheuvel (2):
  chcr_ktls: use AES library for single use cipher
  crypto: remove cipher routines from public crypto API

 Documentation/crypto/api-skcipher.rst         |   4 +-
 arch/arm/crypto/aes-neonbs-glue.c             |   3 +
 arch/s390/crypto/aes_s390.c                   |   2 +
 crypto/adiantum.c                             |   2 +
 crypto/ansi_cprng.c                           |   2 +
 crypto/cbc.c                                  |   1 +
 crypto/ccm.c                                  |   2 +
 crypto/cfb.c                                  |   2 +
 crypto/cipher.c                               |   7 +-
 crypto/cmac.c                                 |   2 +
 crypto/ctr.c                                  |   2 +
 crypto/drbg.c                                 |   2 +
 crypto/ecb.c                                  |   1 +
 crypto/essiv.c                                |   2 +
 crypto/keywrap.c                              |   2 +
 crypto/ofb.c                                  |   2 +
 crypto/pcbc.c                                 |   2 +
 crypto/skcipher.c                             |   1 +
 crypto/testmgr.c                              |   3 +
 crypto/vmac.c                                 |   2 +
 crypto/xcbc.c                                 |   2 +
 crypto/xts.c                                  |   2 +
 drivers/crypto/geode-aes.c                    |   2 +
 drivers/crypto/inside-secure/safexcel.c       |   1 +
 drivers/crypto/inside-secure/safexcel_hash.c  |   1 +
 drivers/crypto/vmx/aes.c                      |   1 +
 drivers/crypto/vmx/vmx.c                      |   1 +
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  19 +-
 include/crypto/algapi.h                       |  39 ----
 include/crypto/internal/cipher.h              | 218 ++++++++++++++++++
 include/crypto/internal/skcipher.h            |   1 +
 include/linux/crypto.h                        | 163 -------------
 32 files changed, 277 insertions(+), 219 deletions(-)
 create mode 100644 include/crypto/internal/cipher.h

-- 
2.17.1


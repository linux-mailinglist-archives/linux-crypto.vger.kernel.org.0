Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0010E3B2
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Dec 2019 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLAVyU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 1 Dec 2019 16:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfLAVyU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 1 Dec 2019 16:54:20 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DCC20865
        for <linux-crypto@vger.kernel.org>; Sun,  1 Dec 2019 21:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575237259;
        bh=DGD+bXIVq1MquOwPGTAe9KKmMpZyatPBZimtqWwXnzo=;
        h=From:To:Subject:Date:From;
        b=L9QCoTeOeSpFCHBCJLXlpo6dYZh15ZldeXZqPwyyfykjmiHjTZPO/KvmvKuzCZ7dU
         sJniEBgBOUTHRMtQGuxPWhGiRUi8JeEcr3AKudBO3jKY6hsyEbVQV4BO+/0RRAuNy7
         HkxbKl6ZNQu/nprPgje+/dT9pwJ+BabAugmguEm0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 0/7] crypto: more self-test improvements
Date:   Sun,  1 Dec 2019 13:53:23 -0800
Message-Id: <20191201215330.171990-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series makes some more improvements to the crypto self-tests, the
largest of which is making the AEAD fuzz tests test inauthentic inputs,
i.e. cases where decryption is expected to fail due to the (ciphertext,
AAD) pair not being the correct result of an encryption with the key.

It also updates the self-tests to test passing misaligned buffers to the
various setkey() functions, and to check that skciphers have the same
min_keysize as the corresponding generic implementation.

I haven't seen any test failures from this on x86_64, arm64, or arm32.
But as usual I haven't tested drivers for crypto accelerators.

For this series to apply this cleanly, my other series
"crypto: skcipher - simplifications due to {,a}blkcipher removal"
needs to be applied first, due to a conflict in skcipher.h.

This can also be retrieved from git at 
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
tag "crypto-self-tests_2019-12-01".

Eric Biggers (7):
  crypto: aead - move crypto_aead_maxauthsize() to <crypto/aead.h>
  crypto: skcipher - add crypto_skcipher_min_keysize()
  crypto: testmgr - don't try to decrypt uninitialized buffers
  crypto: testmgr - check skcipher min_keysize
  crypto: testmgr - test setting misaligned keys
  crypto: testmgr - create struct aead_extra_tests_ctx
  crypto: testmgr - generate inauthentic AEAD test vectors

 crypto/testmgr.c               | 574 +++++++++++++++++++++++++--------
 crypto/testmgr.h               |  14 +-
 include/crypto/aead.h          |  10 +
 include/crypto/internal/aead.h |  10 -
 include/crypto/skcipher.h      |   6 +
 5 files changed, 461 insertions(+), 153 deletions(-)

-- 
2.24.0


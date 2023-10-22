Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2A7D21CC
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Oct 2023 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJVISq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 22 Oct 2023 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJVISp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 22 Oct 2023 04:18:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064C93
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 01:18:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF0DC433C9
        for <linux-crypto@vger.kernel.org>; Sun, 22 Oct 2023 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697962723;
        bh=oDnN/wmLUJ+f+NKy/XCt5updJC0Xaqri/y9bJ7Gzbh8=;
        h=From:To:Subject:Date:From;
        b=b5RGxRWKFffEV9s1y3VIQ+tEc8P6AuaQs05qVeDRh04Ryi0tTW4CW+jmelb0Ws8Vs
         7/q+prdnqnD9tRCmWQYS+QUxTAZy3xXtqiGvzO6b8rADRGhP98vXpiRU0+fZyRMKXm
         xH6pFMp8q8er34Ab0BM8+DrSc+NjzLa0PCrRottfa23YXEXfHoiH5uMWYi9JUDJWL/
         c7lKlGxSIuVhvsFe2EpaNY4x+/4BQzWr9wkl3dTyHAljdT7BEo5+63gdMSQTcdSPm0
         fKw/ZczphlSbdWf59eY4rbHfwlrxX9QaEFMj8qFLmamWIW4Oj9f26h9y+wdcyzW1lR
         VjRt8EnHt42IQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH 00/30] crypto: reduce ahash API overhead
Date:   Sun, 22 Oct 2023 01:10:30 -0700
Message-ID: <20231022081100.123613-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch series first removes the alignmask support from ahash.  As is
the case with shash, the alignmask support of ahash has no real point.
Removing it reduces API overhead and complexity.

Second, this patch series optimizes the common case where the ahash API
uses an shash algorithm, by eliminating unnecessary indirect calls.

This series can be retrieved from git at
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
tag "crypto-ahash-2023-10-22".  Note that it depends on my other series
"crypto: stop supporting alignmask in shash"
(https://lore.kernel.org/r/20231019055343.588846-1-ebiggers@kernel.org).

Patch 1 cleans up after removal of alignmask support from shash.

Patches 2-12 make drivers stop setting an alignmask for ahashes.

Patch 13 removes alignmask support from ahash.

Patches 14-23 remove checks of ahash alignmasks that became unnecessary.

Patches 24-25 are other ahash related cleanups.

Patches 26-29 prepare for optimizing the ahash-using-shash case.

Patches 30 optimizes the ahash-using-shash case.

Eric Biggers (30):
  crypto: shash - remove crypto_shash_ctx_aligned()
  crypto: sun4i-ss - remove unnecessary alignmask for ahashes
  crypto: sun8i-ce - remove unnecessary alignmask for ahashes
  crypto: sun8i-ss - remove unnecessary alignmask for ahashes
  crypto: atmel - remove unnecessary alignmask for ahashes
  crypto: artpec6 - stop setting alignmask for ahashes
  crypto: mxs-dcp - remove unnecessary alignmask for ahashes
  crypto: s5p-sss - remove unnecessary alignmask for ahashes
  crypto: talitos - remove unnecessary alignmask for ahashes
  crypto: omap-sham - stop setting alignmask for ahashes
  crypto: rockchip - remove unnecessary alignmask for ahashes
  crypto: starfive - remove unnecessary alignmask for ahashes
  crypto: stm32 - remove unnecessary alignmask for ahashes
  crypto: ahash - remove support for nonzero alignmask
  crypto: authenc - stop using alignmask of ahash
  crypto: authencesn - stop using alignmask of ahash
  crypto: testmgr - stop checking crypto_ahash_alignmask
  net: ipv4: stop checking crypto_ahash_alignmask
  net: ipv6: stop checking crypto_ahash_alignmask
  crypto: ccm - stop using alignmask of ahash
  crypto: chacha20poly1305 - stop using alignmask of ahash
  crypto: gcm - stop using alignmask of ahash
  crypto: ahash - remove crypto_ahash_alignmask
  crypto: ahash - remove struct ahash_request_priv
  crypto: ahash - improve file comment
  crypto: chelsio - stop using crypto_ahash::init
  crypto: talitos - stop using crypto_ahash::init
  crypto: hash - move "ahash wrapping shash" functions to ahash.c
  crypto: ahash - check for shash type instead of not ahash type
  crypto: ahash - optimize performance when wrapping shash

 Documentation/crypto/devel-algos.rst          |   4 +-
 crypto/ahash.c                                | 406 +++++++++++-------
 crypto/authenc.c                              |  12 +-
 crypto/authencesn.c                           |  20 +-
 crypto/ccm.c                                  |   3 +-
 crypto/chacha20poly1305.c                     |   3 +-
 crypto/gcm.c                                  |   3 +-
 crypto/hash.h                                 |  14 +-
 crypto/shash.c                                | 205 +--------
 crypto/testmgr.c                              |   9 +-
 .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c |   2 -
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   6 -
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |   5 -
 drivers/crypto/atmel-sha.c                    |   2 -
 drivers/crypto/axis/artpec6_crypto.c          |   3 -
 drivers/crypto/chelsio/chcr_algo.c            |   9 +-
 drivers/crypto/mxs-dcp.c                      |   2 -
 drivers/crypto/omap-sham.c                    |  16 +-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c |   3 -
 drivers/crypto/s5p-sss.c                      |   6 -
 drivers/crypto/starfive/jh7110-hash.c         |  13 +-
 drivers/crypto/stm32/stm32-hash.c             |  20 -
 drivers/crypto/talitos.c                      |  17 +-
 include/crypto/algapi.h                       |   5 -
 include/crypto/hash.h                         |  74 +---
 include/crypto/internal/hash.h                |   9 +-
 include/linux/crypto.h                        |  27 +-
 net/ipv4/ah4.c                                |  17 +-
 net/ipv6/ah6.c                                |  17 +-
 29 files changed, 339 insertions(+), 593 deletions(-)


base-commit: a2786e8bdd0242d7f00abf452a572de7464d177b
prerequisite-patch-id: e447f81a392f2f3955206357d72032cf691c7e11
prerequisite-patch-id: 71947e05e23fb176da3ca898720b9e3332e891d7
prerequisite-patch-id: 98d070bdaf3cfaf88553ab707cc3bfe85371c006
prerequisite-patch-id: 9e4287b71c1129edb1ba162e2a1f641a9ac4385f
prerequisite-patch-id: 22a4cda4ae529854e55627c55d3f35b035871f3b
prerequisite-patch-id: f67b194e37338a4715850686b2f02bbf0a47cbe1
prerequisite-patch-id: bcb547f4c9be4b022b824f9bff6b919b2d37d60f
prerequisite-patch-id: 20a8c2663a94c2d49217c5158a6bc588881fb9ad
prerequisite-patch-id: e45e43c487d75c87fd713a5ef57a584cf947950e
prerequisite-patch-id: bb211c1b59f73b22319aee6fafd14b07bc5d1460
prerequisite-patch-id: 5f033ce643ba7d1f219dee490abd21e1e0958a51
prerequisite-patch-id: 2173122570085246d5f4e5d3c4a920f7b7c528f9
prerequisite-patch-id: 3fe1bc3b93e9502f874c485c5f2e39eec4899222
prerequisite-patch-id: 982ed5e31a6616f9788d4641c3757342e9f15576
prerequisite-patch-id: 6a207af4a7044cc47ab3f797e9c865fdbdb5d20c
prerequisite-patch-id: f34ad579025354af65a73c1497dc967e2e834a55
prerequisite-patch-id: 5ad384179da558ff3359baabda588731ed2e90a4
prerequisite-patch-id: d3d243977afb4f574fb289eddf0e71becda1ae2b
-- 
2.42.0


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA42F2570DE
	for <lists+linux-crypto@lfdr.de>; Mon, 31 Aug 2020 00:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgH3WdR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 30 Aug 2020 18:33:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37624 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgH3WdO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 30 Aug 2020 18:33:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kCVsm-0000Lm-KD; Mon, 31 Aug 2020 08:33:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 31 Aug 2020 08:33:04 +1000
Date:   Mon, 31 Aug 2020 08:33:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 5.9
Message-ID: <20200830223304.GA16882@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803044024.GA6429@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Linus:

This push fixes the following issues:

- Regression in af_alg that affects iwd.
- Restore polling delay in qat.
- Double free in ingenic on error path.
- Potential build failure in sa2ul due to missing Kconfig dependency.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus 

for you to fetch changes up to c195d66a8a75c60515819b101975f38b7ec6577f:

  crypto: af_alg - Work around empty control messages without MSG_MORE (2020-08-27 23:20:36 +1000)

----------------------------------------------------------------
Giovanni Cabiddu (1):
      crypto: qat - add delay before polling mailbox

Herbert Xu (1):
      crypto: af_alg - Work around empty control messages without MSG_MORE

Randy Dunlap (1):
      crypto: sa2ul - add Kconfig selects to fix build error

Wei Yongjun (1):
      crypto: ingenic - Drop kfree for memory allocated with devm_kzalloc

 crypto/af_alg.c                           | 13 ++++++++++---
 drivers/char/hw_random/ingenic-rng.c      |  9 ++-------
 drivers/crypto/Kconfig                    |  3 +++
 drivers/crypto/qat/qat_common/adf_admin.c |  7 ++++---
 4 files changed, 19 insertions(+), 13 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

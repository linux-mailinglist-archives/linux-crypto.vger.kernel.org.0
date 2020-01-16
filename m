Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9413F13DFD7
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgAPQVK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 11:21:10 -0500
Received: from inva020.nxp.com ([92.121.34.13]:42214 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgAPQVJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 11:21:09 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 39EEA1A0942;
        Thu, 16 Jan 2020 17:21:08 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D29B1A06B0;
        Thu, 16 Jan 2020 17:21:08 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9589820567;
        Thu, 16 Jan 2020 17:21:07 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH v3 0/9] crypto: caam - backlogging support
Date:   Thu, 16 Jan 2020 18:20:44 +0200
Message-Id: <1579191653-400-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Integrate crypto_engine framework into CAAM, to make use of
the engine queue.
Added support for SKCIPHER, HASH, RSA and AEAD algorithms.
This is intended to be used for CAAM backlogging support.
The requests, with backlog flag (e.g. from dm-crypt) will be
listed into crypto-engine queue and processed by CAAM when free.

While here, I've also made some refactorization.
Patches #1 - #4 include some refactorizations on caamalg, caamhash
and caampkc.
Patch #5 changes the return code of caam_jr_enqueue function
to -EINPROGRESS, in case of success, -ENOSPC in case the CAAM is
busy, -EIO if it cannot map the caller's descriptor.
Patches #6 - #9 integrate crypto_engine into CAAM, for
SKCIPHER/AEAD/RSA/HASH algorithms.

---
Changes since V2:
	- remove patch ("crypto: caam - refactor caam_jr_enqueue"),
	  that added some structures not needed anymore;
	- use _done_ callback function directly for skcipher and aead;
	- handle resource leak in case of transfer request to crypto-engine;
	- update commit messages.

Changes since V1:
	- remove helper function - akcipher_request_cast;
	- remove any references to crypto_async_request,
	  use specific request type;
	- remove bypass crypto-engine queue, in case is empty;
	- update some commit messages;
	- remove unrelated changes, like whitespaces;
	- squash some changes from patch #9 to patch #6;
	- added Reviewed-by.
---

Iuliana Prodan (9):
  crypto: caam - refactor skcipher/aead/gcm/chachapoly {en,de}crypt
    functions
  crypto: caam - refactor ahash_done callbacks
  crypto: caam - refactor ahash_edesc_alloc
  crypto: caam - refactor RSA private key _done callbacks
  crypto: caam - change return code in caam_jr_enqueue function
  crypto: caam - support crypto_engine framework for SKCIPHER algorithms
  crypto: caam - add crypto_engine support for AEAD algorithms
  crypto: caam - add crypto_engine support for RSA algorithms
  crypto: caam - add crypto_engine support for HASH algorithms

 drivers/crypto/caam/Kconfig    |   1 +
 drivers/crypto/caam/caamalg.c  | 416 ++++++++++++++++++-----------------------
 drivers/crypto/caam/caamhash.c | 341 ++++++++++++++++-----------------
 drivers/crypto/caam/caampkc.c  | 187 +++++++++++-------
 drivers/crypto/caam/caampkc.h  |  10 +
 drivers/crypto/caam/caamrng.c  |   4 +-
 drivers/crypto/caam/intern.h   |   2 +
 drivers/crypto/caam/jr.c       |  37 +++-
 drivers/crypto/caam/key_gen.c  |   2 +-
 9 files changed, 523 insertions(+), 477 deletions(-)

-- 
2.1.0


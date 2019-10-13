Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37875D5460
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Oct 2019 06:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfJMEka (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Oct 2019 00:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMEka (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Oct 2019 00:40:30 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4786206B7;
        Sun, 13 Oct 2019 04:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570941629;
        bh=ZVhkIrmxXnrRsJcnZxoqY4+X6GfigGDjV27s6D0emN0=;
        h=From:To:Cc:Subject:Date:From;
        b=CrcL2S8DNCDtIoFVClM52IGRgZRSm7iZphRBFlwM7T3Sn7veeq/8mGY/dm006V4Td
         paA0dxVOuQzwYpQ4prFUP08KzqKo5CqOKhn73/hEaZOrSVV7B36EkiOvFI5F2k2Y5i
         jOqTQDqQV0XUwdfokljNPhz3bUEERRlTw0AOg1dw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Subject: [PATCH 0/4] crypto: nx - convert to skcipher API
Date:   Sat, 12 Oct 2019 21:39:14 -0700
Message-Id: <20191013043918.337113-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series converts the PowerPC Nest (NX) implementations of AES modes
from the deprecated "blkcipher" API to the "skcipher" API.  This is
needed in order for the blkcipher API to be removed.

This patchset is compile-tested only, as I don't have this hardware.
If anyone has this hardware, please test this patchset with
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.

Eric Biggers (4):
  crypto: nx - don't abuse blkcipher_desc to pass iv around
  crypto: nx - convert AES-ECB to skcipher API
  crypto: nx - convert AES-CBC to skcipher API
  crypto: nx - convert AES-CTR to skcipher API

 drivers/crypto/nx/nx-aes-cbc.c | 81 ++++++++++++++-----------------
 drivers/crypto/nx/nx-aes-ccm.c | 40 ++++++----------
 drivers/crypto/nx/nx-aes-ctr.c | 87 +++++++++++++++-------------------
 drivers/crypto/nx/nx-aes-ecb.c | 76 +++++++++++++----------------
 drivers/crypto/nx/nx-aes-gcm.c | 24 ++++------
 drivers/crypto/nx/nx.c         | 64 ++++++++++++++-----------
 drivers/crypto/nx/nx.h         | 19 ++++----
 7 files changed, 176 insertions(+), 215 deletions(-)

-- 
2.23.0


Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86444242F19
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Aug 2020 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLTWR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Aug 2020 15:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgHLTWR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Aug 2020 15:22:17 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDDD206DA;
        Wed, 12 Aug 2020 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597260137;
        bh=ULs7jEwnqQuxMp4HU07afJ9qMcGLu5Ptq884Lsc5JTI=;
        h=From:To:Cc:Subject:Date:From;
        b=JmZ+1WBdQleMeZvO7KJk4hs19EqKPecVlSI05GmRQoYQ0dGtHJPS08MILXJaF2U14
         dAPzUcur55qDOWpAmQSM0SpGbaO1uc2Y9lLuVDf8L0YX8LW8zHIfntVhutMjCFj4oi
         6K9DLgZHMJLwhe42jhNoq58a3JrK+rb2fSnkeWHQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gonglei <arei.gonglei@huawei.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-crypto@vger.kernel.org, Ram Muthiah <rammuthiah@google.com>
Subject: [PATCH] crypto: virtio - don't use 'default m'
Date:   Wed, 12 Aug 2020 12:20:53 -0700
Message-Id: <20200812192053.1769235-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Ram Muthiah <rammuthiah@google.com>

Drivers shouldn't be enabled by default unless there is a very good
reason to do so.  There doesn't seem to be any such reason for the
virtio crypto driver, so change it to the default of 'n'.

Signed-off-by: Ram Muthiah <rammuthiah@google.com>
[EB: adjusted commit message]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/crypto/virtio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconfig
index fb294174e408..b894e3a8be4f 100644
--- a/drivers/crypto/virtio/Kconfig
+++ b/drivers/crypto/virtio/Kconfig
@@ -5,7 +5,6 @@ config CRYPTO_DEV_VIRTIO
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
-	default m
 	help
 	  This driver provides support for virtio crypto device. If you
 	  choose 'M' here, this module will be called virtio_crypto.
-- 
2.28.0.236.gb10cc79966-goog


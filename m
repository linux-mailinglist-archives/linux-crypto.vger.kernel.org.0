Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F532D85A6
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Dec 2020 11:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438554AbgLLKFZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Dec 2020 05:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407218AbgLLJy1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Dec 2020 04:54:27 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/4] crypto: gcm-aes-ni cleanups
Date:   Sat, 12 Dec 2020 10:16:56 +0100
Message-Id: <20201212091700.11776-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Clean up some issues and peculiarities in the gcm(aes-ni) driver.

Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>

Ard Biesheuvel (4):
  crypto: x86/gcm-aes-ni - prevent misaligned IV buffers on the stack
  crypto: x86/gcm-aes-ni - drop unused asm prototypes
  crypto: x86/gcm-aes-ni - clean up mapping of associated data
  crypto: x86/gcm-aes-ni - refactor scatterlist processing

 arch/x86/crypto/aesni-intel_glue.c | 238 ++++++--------------
 1 file changed, 74 insertions(+), 164 deletions(-)

-- 
2.17.1


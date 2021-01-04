Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D762E9948
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Jan 2021 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbhADP4o (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Jan 2021 10:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbhADP4n (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Jan 2021 10:56:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04E2220757;
        Mon,  4 Jan 2021 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609775763;
        bh=ycYNzQKmxDCQaBO4UjcNpcmpGLPKzE0hFsZmGwf7qOU=;
        h=From:To:Cc:Subject:Date:From;
        b=tksJea7i3pWewH7OAj3KnU52YYEWWD4PAl6Uo2SkjWTJ1+ls9ltQPfHCCzmq8JE34
         Kcq0jwYsMOj1kcBM7RyVrd18tCO3CWJHrlOxChdU1Lx0r7r/LggFGoImWXicyP6d0h
         R7X/6YvJMWhZARSnMq8MuM3qtR8nz1j6VpcfvdmohmAOq4tuzupwbI4mZeSVAZQUDS
         rGcWnCgEe+2SAAyq9ZebtOyGHRHfLAyB59hl+XP6CyBcLXIKBablcurdX1r317aZBG
         V2ru5+5s0NpqkBdl7rHwgUd7ZxGTbok26X4zC3e4S7UQmruafkOiv5RVyS9fUJGUsW
         HyZakn80vo4Zw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 0/5] crypto: gcm-aes-ni cleanups
Date:   Mon,  4 Jan 2021 16:55:45 +0100
Message-Id: <20210104155550.6359-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Clean up some issues and peculiarities in the gcm(aes-ni) driver.

Changes since v1:
- fix sleep while atomic issue reported by Eric
- add patch to get rid of indirect calls, to avoid taking the retpoline
  performance hit

Cc: Megha Dey <megha.dey@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>

Ard Biesheuvel (5):
  crypto: x86/gcm-aes-ni - prevent misaligned buffers on the stack
  crypto: x86/gcm-aes-ni - drop unused asm prototypes
  crypto: x86/gcm-aes-ni - clean up mapping of associated data
  crypto: x86/gcm-aes-ni - refactor scatterlist processing
  crypto: x86/gcm-aes-ni - replace function pointers with static
    branches

 arch/x86/crypto/aesni-intel_glue.c | 321 ++++++++------------
 1 file changed, 121 insertions(+), 200 deletions(-)


base-commit: 858e88e2e54cd50cd43f3a8b490b64c22ae8267b
-- 
2.17.1


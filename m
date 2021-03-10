Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3103339C1
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Mar 2021 11:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCJKO7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Mar 2021 05:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhCJKO2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Mar 2021 05:14:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDC564FC8;
        Wed, 10 Mar 2021 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615371268;
        bh=5PW+08K35cb+7GryVcsU3ctNJqinyGFBHsq+NGHnqck=;
        h=From:To:Cc:Subject:Date:From;
        b=IXF8LgeJdBit4URxTk1osM0eLTOtscR8IqaMAN7DXmvTezbaAmsdPjk4Xu0aH6PCu
         arxhfl3jNUcfRt2RnPdmHE8JRNVCt+LdHwSlQ0hfeG+w+Ue1Szp4El358FB2+IEsGV
         FNFhXSNTGd5qzuA+cRD70QirLaUZTdneqtIvLXKAs0rx0Ja+/9z4Eh2QVQSy9a65yY
         fACIaeq9d+GYJanF+4bemg5F8MrxVcpOuWtBONm1qQgXQBMyu9//0aHayIiOF/crlL
         PoHI78g1LzJ+HcacrKZjsXrBWi3IrC6t5eAzW5/Yc3/ihqlOLpGsARbwLjNM/MopJ7
         RSeIudZkf99dQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Eric Biggers <ebiggers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/2] crypto: arm - clean up redundant helper macros
Date:   Wed, 10 Mar 2021 11:14:19 +0100
Message-Id: <20210310101421.173689-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now that ARM's asm/assembler.h provides mov_l and rev_l macros, let's get
rid of the locally defined ones that live in the ChaCha and AES crypto code.

Changes since v2:
- fix rev_32->rev_l in the patch subject lines
- add Eric's ack

Changes since v1:
- drop the patch that introduces rev_l, it has been merged in v5.12-rc
- rev_32 was renamed to rev_l, so both patches were updated to reflect that
- add acks from Nico, Geert and Linus

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

Ard Biesheuvel (2):
  crypto: arm/aes-scalar - switch to common rev_l/mov_l macros
  crypto: arm/chacha-scalar - switch to common rev_l macro

 arch/arm/crypto/aes-cipher-core.S    | 42 +++++--------------
 arch/arm/crypto/chacha-scalar-core.S | 43 ++++++--------------
 2 files changed, 23 insertions(+), 62 deletions(-)

-- 
2.30.1


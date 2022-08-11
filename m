Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B952959049C
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Aug 2022 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiHKQhT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Aug 2022 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiHKQea (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Aug 2022 12:34:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F04BC819;
        Thu, 11 Aug 2022 09:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906126145A;
        Thu, 11 Aug 2022 16:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A14C433D6;
        Thu, 11 Aug 2022 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660234272;
        bh=/7Tt3mGLNqFqtvouJi8sZZB+COG859/xulJOuh6HOsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2ZzmNjToOEUqfOOn/8/jg6AFu1iEUTLGaXar8kWUf84yqSMFoOFQk24E271yglZX
         LliMGwhR5lzGY3m1YGy9DyJ/uG6sqag6ClksGwfvgsLd7qKCD4dvSAHMJeCn6Xt33h
         wufHdDrvVDZnj5bh7WxRDitVIKUKzBtU+L0WoyQUUgMFddNj92FFsBT911gjc4nuXu
         pdo5MztZGBE/QGDVPoAGxMC3O6aPe1Ls8RFf7m6YRGZMulp213cSs0/R1WlQGphxGy
         jkqhClG2OKNn52a565h825erEyDGMeCBNR/6HEmYYxfdo2ZGHvBPKabhFO1Pz8BRy0
         gZQH2BGdN/xRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Breno Leitao <leitao@debian.org>,
        Sasha Levin <sashal@kernel.org>, nayna@linux.ibm.com,
        pfsmorigo@gmail.com, mpe@ellerman.id.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 08/14] crypto: vmx - Fix warning on p8_ghash_alg
Date:   Thu, 11 Aug 2022 12:10:37 -0400
Message-Id: <20220811161050.1543183-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811161050.1543183-1-sashal@kernel.org>
References: <20220811161050.1543183-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit cc8166bfc829043020b5cc3b7cdba02a17d03b6d ]

The compiler complains that p8_ghash_alg isn't declared which is
because the header file aesp8-ppc.h isn't included in ghash.c.
This patch fixes the warning.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/vmx/ghash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/vmx/ghash.c b/drivers/crypto/vmx/ghash.c
index 1bfe867c0b7b..84a293d45cc5 100644
--- a/drivers/crypto/vmx/ghash.c
+++ b/drivers/crypto/vmx/ghash.c
@@ -22,6 +22,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/hash.h>
 #include <crypto/b128ops.h>
+#include "aesp8-ppc.h"
 
 #define IN_INTERRUPT in_interrupt()
 
-- 
2.35.1


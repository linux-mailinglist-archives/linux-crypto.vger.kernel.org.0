Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB9413CF2
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Sep 2021 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhIUVud (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Sep 2021 17:50:33 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:34190 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhIUVub (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Sep 2021 17:50:31 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 6E105F40B6C; Tue, 21 Sep 2021 23:39:51 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 4/4] powerpc: wii_defconfig: Enable AES by default
Date:   Tue, 21 Sep 2021 23:39:30 +0200
Message-Id: <20210921213930.10366-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921213930.10366-1-linkmauve@linkmauve.fr>
References: <20210921213930.10366-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This selects the nintendo-aes module when building for this platform.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/configs/wii_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 379c171f3ddd..752e081d28d0 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -123,4 +123,6 @@ CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_DMA_API_DEBUG=y
 CONFIG_PPC_EARLY_DEBUG=y
-# CONFIG_CRYPTO_HW is not set
+CONFIG_CRYPTO_HW=y
+CONFIG_CRYPTO_DEV_NINTENDO=y
+CONFIG_CRYPTO_USER_API_SKCIPHER=y
-- 
2.33.0


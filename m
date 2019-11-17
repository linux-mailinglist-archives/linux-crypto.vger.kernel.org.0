Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A26FF638
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Nov 2019 01:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKQAns (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 16 Nov 2019 19:43:48 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57192 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbfKQAns (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Sat, 16 Nov 2019 19:43:48 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iW8fJ-0003Jw-1p; Sun, 17 Nov 2019 08:43:45 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iW8fI-0002YX-Dv; Sun, 17 Nov 2019 08:43:44 +0800
Date:   Sun, 17 Nov 2019 08:43:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Vitaly Andrianov <vitalya@ti.com>
Subject: [PATCH] hwrng: ks-sa - Enable COMPILE_TEST
Message-ID: <20191117004344.w4f2k4xcf73ti2z6@gondor.apana.org.au>
References: <20191106093019.117233-1-alexander.sverdlin@nokia.com>
 <20191115060610.2sjw7stopxr73jhn@gondor.apana.org.au>
 <20191116073229.GA161720@sol.localdomain>
 <20191117004229.xrkvij6vcd3aodnx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117004229.xrkvij6vcd3aodnx@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch enables COMPILE_TEST on the ks-sa-rng driver.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 7c7fecfa2fb2..2f3d55fedc49 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -484,7 +484,7 @@ config UML_RANDOM
 	  /dev/hwrng and injects the entropy into /dev/random.
 
 config HW_RANDOM_KEYSTONE
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || COMPILE_TEST
 	default HW_RANDOM
 	tristate "TI Keystone NETCP SA Hardware random number generator"
 	help
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

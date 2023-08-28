Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF578A87A
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Aug 2023 11:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjH1JIE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Aug 2023 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjH1JHz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Aug 2023 05:07:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14597EC
        for <linux-crypto@vger.kernel.org>; Mon, 28 Aug 2023 02:07:48 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qaYDl-008S2d-8i; Mon, 28 Aug 2023 17:07:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Aug 2023 17:07:42 +0800
Date:   Mon, 28 Aug 2023 17:07:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Danny Tsen <dtsen@linux.ibm.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: crypto: powerpc/chacha20,poly1305-p10 - Add dependency on VSX
Message-ID: <ZOxj3rFGVcRUzgwb@gondor.apana.org.au>
References: <202308251906.SYawej6g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308251906.SYawej6g-lkp@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 25, 2023 at 07:44:32PM +0800, kernel test robot wrote:
>
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/crypto/poly1305-p10-glue.c:19:

...

> ae3a197e3d0bfe3 David Howells    2012-03-28  75  
> ae3a197e3d0bfe3 David Howells    2012-03-28  76  #ifdef CONFIG_VSX
> d1e1cf2e38def30 Anton Blanchard  2015-10-29  77  extern void enable_kernel_vsx(void);
> ae3a197e3d0bfe3 David Howells    2012-03-28  78  extern void flush_vsx_to_thread(struct task_struct *);
> 3eb5d5888dc68c9 Anton Blanchard  2015-10-29  79  static inline void disable_kernel_vsx(void)
> 3eb5d5888dc68c9 Anton Blanchard  2015-10-29  80  {
> 3eb5d5888dc68c9 Anton Blanchard  2015-10-29  81  	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
> 3eb5d5888dc68c9 Anton Blanchard  2015-10-29  82  }
> bd73758803c2eed Christophe Leroy 2021-03-09  83  #else
> bd73758803c2eed Christophe Leroy 2021-03-09  84  static inline void enable_kernel_vsx(void)
> bd73758803c2eed Christophe Leroy 2021-03-09  85  {
> bd73758803c2eed Christophe Leroy 2021-03-09 @86  	BUILD_BUG();
> bd73758803c2eed Christophe Leroy 2021-03-09  87  }
> bd73758803c2eed Christophe Leroy 2021-03-09  88  

---8<---
Add dependency on VSX as otherwise the build will fail without
it.

Fixes: 161fca7e3e90 ("crypto: powerpc - Add chacha20/poly1305-p10 to Kconfig and Makefile")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308251906.SYawej6g-lkp@intel.com/
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index f25024afdda5..7a66d7c0e6a2 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -113,7 +113,7 @@ config CRYPTO_AES_GCM_P10
 
 config CRYPTO_CHACHA20_P10
 	tristate "Ciphers: ChaCha20, XChacha20, XChacha12 (P10 or later)"
-	depends on PPC64 && CPU_LITTLE_ENDIAN
+	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
@@ -127,7 +127,7 @@ config CRYPTO_CHACHA20_P10
 
 config CRYPTO_POLY1305_P10
 	tristate "Hash functions: Poly1305 (P10 or later)"
-	depends on PPC64 && CPU_LITTLE_ENDIAN
+	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	help
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

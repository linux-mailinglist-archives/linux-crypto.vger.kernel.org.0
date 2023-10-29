Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB677DAC15
	for <lists+linux-crypto@lfdr.de>; Sun, 29 Oct 2023 12:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjJ2LMZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 29 Oct 2023 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJ2LMY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 29 Oct 2023 07:12:24 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51ED3
        for <linux-crypto@vger.kernel.org>; Sun, 29 Oct 2023 04:12:20 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qx3iE-00CDCL-5X; Sun, 29 Oct 2023 19:12:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 29 Oct 2023 19:12:16 +0800
Date:   Sun, 29 Oct 2023 19:12:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, christoph.muellner@vrull.eu,
        heiko.stuebner@vrull.eu
Subject: Re: [PATCH] crypto: riscv/aes - Implement scalar Zkn version for RV32
Message-ID: <ZT4+EDcsYgBN+wot@gondor.apana.org.au>
References: <CAMj1kXF0e+MKyDJPS7r=LWusEBCaw=t03JC=+Dz0Qk+GmY+uXw@mail.gmail.com>
 <mhng-ff1fe914-36e9-42e8-88ac-44c7f6976e3d@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-ff1fe914-36e9-42e8-88ac-44c7f6976e3d@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 27, 2023 at 06:11:40AM -0700, Palmer Dabbelt wrote:
>
> I don't really know much about the crypto stuff, but looks like there's
> still a "struct crypto_cipher" in my trees.  Am I still supposed to be
> waiting on something?

Yes lskcipher has now been added.  Please don't add any new code
through the old crypto_cipher interface.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

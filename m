Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF417A584B
	for <lists+linux-crypto@lfdr.de>; Tue, 19 Sep 2023 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjISEDK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Sep 2023 00:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjISEDJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 Sep 2023 00:03:09 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB68F
        for <linux-crypto@vger.kernel.org>; Mon, 18 Sep 2023 21:03:02 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qiRwv-00FnYm-JU; Tue, 19 Sep 2023 12:02:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Sep 2023 12:03:00 +0800
Date:   Tue, 19 Sep 2023 12:03:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 0/8] crypto: Add lskcipher API type
Message-ID: <ZQkddKkiPAoLB8zc@gondor.apana.org.au>
References: <20230914082828.895403-1-herbert@gondor.apana.org.au>
 <CAMj1kXHLZ8kZWL3npQRavdzjRtv_uiRKmKDeXaQhhy3m4LvK+w@mail.gmail.com>
 <ZQLK0injXi7K3X1b@gondor.apana.org.au>
 <CAMj1kXHvhrUyShdSNCJeOh8WVXFqPPu+KLh16V6fJJdQKhPv1A@mail.gmail.com>
 <ZQLSlqJs///qoGCY@gondor.apana.org.au>
 <CAMj1kXE6mo2F7KgGmpygEs5cHf=mvUs2k3TT-xJ1wKP_YNGzFg@mail.gmail.com>
 <ZQLTl26H8TLFEP7r@gondor.apana.org.au>
 <CAMj1kXFnZKABMdBntS3=ARJz-8BV7oG1VHnO7iiSj=5BbpJPDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFnZKABMdBntS3=ARJz-8BV7oG1VHnO7iiSj=5BbpJPDg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Sep 17, 2023 at 06:24:32PM +0200, Ard Biesheuvel wrote:
>
> Ported my RISC-V AES implementation here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=riscv-scalar-aes

Looks good to me.

> I will get back to this after mu holidays, early October.

Have a great time!

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

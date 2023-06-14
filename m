Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036DB70F3E0
	for <lists+linux-crypto@lfdr.de>; Wed, 24 May 2023 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjEXKPB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 24 May 2023 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjEXKO0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 24 May 2023 06:14:26 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB9A10C3
        for <linux-crypto@vger.kernel.org>; Wed, 24 May 2023 03:13:49 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q1lV2-00Ckzi-A3; Wed, 24 May 2023 18:13:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 May 2023 18:13:44 +0800
Date:   Wed, 24 May 2023 18:13:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com
Subject: Re: [PATCH] crypto: x86/aria - Use 16 byte alignment for GFNI
 constant vectors
Message-ID: <ZG3jWHFZXGUqKmUt@gondor.apana.org.au>
References: <20230516181419.3633842-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516181419.3633842-1-ardb@kernel.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, May 16, 2023 at 08:14:19PM +0200, Ard Biesheuvel wrote:
> The GFNI routines in the AVX version of the ARIA implementation now use
> explicit VMOVDQA instructions to load the constant input vectors, which
> means they must be 16 byte aligned. So ensure that this is the case, by
> dropping the section split and the incorrect .align 8 directive, and
> emitting the constants into the 16-byte aligned section instead.
> 
> Note that the AVX2 version of this code deviates from this pattern, and
> does not require a similar fix, given that it loads these contants as
> 8-byte memory operands, for which AVX2 permits any alignment.
> 
> Cc: Taehee Yoo <ap420073@gmail.com>
> Fixes: 8b84475318641c2b ("crypto: x86/aria-avx - Do not use avx2 instructions")
> Reported-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com
> Tested-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/crypto/aria-aesni-avx-asm_64.S | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

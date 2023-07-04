Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F912746CB5
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Jul 2023 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjGDJEi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Jul 2023 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGDJEg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Jul 2023 05:04:36 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA136127;
        Tue,  4 Jul 2023 02:04:29 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qGbxR-000RVO-1q; Tue, 04 Jul 2023 19:04:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Jul 2023 17:04:18 +0800
Date:   Tue, 4 Jul 2023 17:04:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Ondrej Mosnacek <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: Regression bisected to "crypto: af_alg: Convert
 af_alg_sendpage() to use MSG_SPLICE_PAGES"
Message-ID: <ZKPgkgiddAl9qddT@gondor.apana.org.au>
References: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
 <1357760.1688460637@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1357760.1688460637@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 04, 2023 at 09:50:37AM +0100, David Howells wrote:
> One problem with libkcapi is that it's abusing vmsplice().  It must not use
> vmsplice(SPLICE_F_GIFT) on a buffer that's in the heap.  To quote the manual
> page:
> 
> 	      The user pages are a gift to the kernel.   The  application  may
>               not  modify  this  memory ever, otherwise the page cache and on-
>               disk data may differ.  Gifting pages to the kernel means that  a
>               subsequent  splice(2)  SPLICE_F_MOVE  can  successfully move the
>               pages;  if  this  flag  is  not  specified,  then  a  subsequent
>               splice(2)  SPLICE_F_MOVE must copy the pages.  Data must also be
>               properly page aligned, both in memory and length.
> 
> Basically, this can destroy the integrity of the process's heap as the
> allocator may have metadata there that then gets excised.

All it's saying is that if you modify the data after sending it off
via splice then the data that will be on the wire is undefined.

There is no reason why this should crash.

> If I remove the flag, it still crashes, so that's not the only problem.

If we can't fix this the patches should be reverted.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

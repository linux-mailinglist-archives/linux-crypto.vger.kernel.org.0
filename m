Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0184772952F
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Jun 2023 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbjFIJaz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Jun 2023 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241629AbjFIJao (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Jun 2023 05:30:44 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F54EC2
        for <linux-crypto@vger.kernel.org>; Fri,  9 Jun 2023 02:25:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q7YMr-000wbF-87; Fri, 09 Jun 2023 17:25:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Jun 2023 17:25:13 +0800
Date:   Fri, 9 Jun 2023 17:25:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: dm crypt: Avoid using MAX_CIPHER_BLOCKSIZE
Message-ID: <ZILv+U3B7izgtJAZ@gondor.apana.org.au>
References: <ZHhbL+SbWRnTW4b7@gondor.apana.org.au>
 <ZHjtGvf+gHxeV83V@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHjtGvf+gHxeV83V@redhat.com>
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

On Thu, Jun 01, 2023 at 03:10:18PM -0400, Mike Snitzer wrote:
>
> Strikes me as strange that open-coding skcipher_request_{alloc,free}
> is ideal, but dm-crypt is the only non-crypto consumer of
> MAX_CIPHER_BLOCKSIZE so really not worth standing up yet another
> interface wrapper.

It is pretty standard when you need to allocate data alongside the
request.  But yes if we could improve the helpers to handle this
that would be nice.

> Anyway, this code is certainly better for dm-crypt's needs.  I'm happy
> with you applying this change via your crypto tree.
> 
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

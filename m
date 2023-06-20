Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D17365F6
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Jun 2023 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjFTIVP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Jun 2023 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFTIVP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Jun 2023 04:21:15 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B93619B;
        Tue, 20 Jun 2023 01:21:12 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qBWbX-0051BY-9M; Tue, 20 Jun 2023 16:20:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Jun 2023 16:20:47 +0800
Date:   Tue, 20 Jun 2023 16:20:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com,
        syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com,
        syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com,
        syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] crypto: af_alg/hash: Fix recvmsg() after
 sendmsg(MSG_MORE)
Message-ID: <ZJFhX3RYknrkcN0x@gondor.apana.org.au>
References: <ZJEwPLudZlrInzYs@gondor.apana.org.au>
 <427646.1686913832@warthog.procyon.org.uk>
 <1220921.1687246935@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1220921.1687246935@warthog.procyon.org.uk>
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

On Tue, Jun 20, 2023 at 08:42:15AM +0100, David Howells wrote:
>
> Not so.  hash_recvmsg() will call crypto_ahash_init() first because ctx->more
> is false (hence why we came down this branch in hash_sendmsg()) and the result
> was released on the previous line (which you're objecting to).  If it goes to
> the "done" label, it will skip setting ctx->more to true if MSG_MORE is
> passed.

I see, yes it should work.

> However, given you want sendmsg() to do the init->digest cycle on zero length
> data, I think we should revert to the previous version of the patch that makes
> a pass of the loop even with no data.

Let's get this fixed ASAP and we can refine it later.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

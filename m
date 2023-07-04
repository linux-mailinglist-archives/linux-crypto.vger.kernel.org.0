Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FF8746624
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Jul 2023 01:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGCXTm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 3 Jul 2023 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGCXTl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 3 Jul 2023 19:19:41 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D96107;
        Mon,  3 Jul 2023 16:19:38 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qGSpE-000PAt-Ks; Tue, 04 Jul 2023 09:19:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Jul 2023 07:19:13 +0800
Date:   Tue, 4 Jul 2023 07:19:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        FUJITA Tomonori <fujita.tomonori@gmail.com>,
        rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] rust: add synchronous message digest support
Message-ID: <ZKNXcYXacvP8vyom@gondor.apana.org.au>
References: <20230615142311.4055228-1-fujita.tomonori@gmail.com>
 <20230615142311.4055228-2-fujita.tomonori@gmail.com>
 <udHI3v-OLUqHQt3fwnH71QuRJjzGxexw2rkIYEfnsChCmrLoJTIL_GL1wLCARf-UotY51jkPT6tC8nVDvjf8LkY2zvddpgeRQ5owysZwJos=@proton.me>
 <20230622.111419.241422502377572827.ubuntu@gmail.com>
 <0a9af5fa-4df2-11da-b3cb-0a6b1d27fdc2@proton.me>
 <o6lMzg30KAx1IKuGUzjTWb8ciTkkb_vbseDHu2u5nqLeijQ0vX1QgDOij0HGjQkW4NhJcOMoXHvMCstcByEzjq_CjMuN61l1rUo9DaIf97Y=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o6lMzg30KAx1IKuGUzjTWb8ciTkkb_vbseDHu2u5nqLeijQ0vX1QgDOij0HGjQkW4NhJcOMoXHvMCstcByEzjq_CjMuN61l1rUo9DaIf97Y=@proton.me>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 30, 2023 at 02:48:37PM +0000, Benno Lossin wrote:
>
> 4. return an error

This would seem to make the most sense.

If there is ever a need to hash more than 4G of data, we would
be adding this to C first.

At this point I can't see why we would need to do that so an
error would be the appropriate response.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

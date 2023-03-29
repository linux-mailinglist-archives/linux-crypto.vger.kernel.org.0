Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353AD6CD741
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Mar 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjC2KEr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 Mar 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjC2KEh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 Mar 2023 06:04:37 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0544AC
        for <linux-crypto@vger.kernel.org>; Wed, 29 Mar 2023 03:04:30 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1phSfJ-009u2D-7a; Wed, 29 Mar 2023 18:04:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 29 Mar 2023 18:04:25 +0800
Date:   Wed, 29 Mar 2023 18:04:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/utils - Move utilities into new header
Message-ID: <ZCQNKcPgzrTz7PmX@gondor.apana.org.au>
References: <ZB10ijozlmPmxjJr@gondor.apana.org.au>
 <20230328174038.GA890@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328174038.GA890@sol.localdomain>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 28, 2023 at 10:40:38AM -0700, Eric Biggers wrote:
>
> Thanks for doing this!  There are other files in lib/crypto/ that include
> <crypto/algapi.h> currently.  It seems they should be changed to include
> <crypto/utils.h> instead?

Yes they should.  I got side-tracked by other things so you're
more than welcome to send in patches for those :)

I already have a patch for dm-crypt but I'm waiting for another
cycle so that it can go straight into the dm tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

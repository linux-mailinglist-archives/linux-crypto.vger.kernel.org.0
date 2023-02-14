Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26D6955EC
	for <lists+linux-crypto@lfdr.de>; Tue, 14 Feb 2023 02:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBNB0s (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Feb 2023 20:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBNB0r (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Feb 2023 20:26:47 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C33713525
        for <linux-crypto@vger.kernel.org>; Mon, 13 Feb 2023 17:26:46 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pRk5h-00ArHL-Cz; Tue, 14 Feb 2023 09:26:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Feb 2023 09:26:41 +0800
Date:   Tue, 14 Feb 2023 09:26:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Clemens Lang <cllang@redhat.com>
Subject: Re: [PATCH] crypto: testmgr - Disable raw RSA in FIPS mode
Message-ID: <Y+rjUTy2V9/Dskp/@gondor.apana.org.au>
References: <Y+NrB5q1VcIIa+jk@gondor.apana.org.au>
 <CAFqZXNubjSeB38suRe5h6LTpXSi+7Qy8UqgfbiGMNikvHKRB8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNubjSeB38suRe5h6LTpXSi+7Qy8UqgfbiGMNikvHKRB8A@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 09, 2023 at 04:33:34PM +0100, Ondrej Mosnacek wrote:
>
> Seems to work as expected - with the patch I get the following lines
> in the kernel console (in FIPS MODE:

Thanks for checking Ondrej!

As Clemens informed me that this patch is no longer needed I'm
withdrawing it for now.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

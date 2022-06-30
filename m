Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8159D56131C
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Jun 2022 09:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiF3HQy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Jun 2022 03:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiF3HQx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Jun 2022 03:16:53 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79958381BA
        for <linux-crypto@vger.kernel.org>; Thu, 30 Jun 2022 00:16:51 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o6oPv-00Cwx1-Ly; Thu, 30 Jun 2022 17:16:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Jun 2022 15:16:47 +0800
Date:   Thu, 30 Jun 2022 15:16:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 0/2] crypto: Introduce ARIA symmetric cipher algorithm
Message-ID: <Yr1N376O00fS0Skd@gondor.apana.org.au>
References: <Yr1FBOC8Zi1ltlBi@gondor.apana.org.au>
 <50203730-35f1-4bf9-3f3a-ca6cd3b01d4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50203730-35f1-4bf9-3f3a-ca6cd3b01d4a@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 30, 2022 at 04:13:19PM +0900, Taehee Yoo wrote:
>
> So, my plan is to add the kTLS feature because aria-TLS[2] is now standard.
> So, Is it okay to add the aria-kTLS feature into the v2 patch, instead of
> aria-IPsec?

Sure.  As long as the kTLS people are happy to add this then it's
good to go.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

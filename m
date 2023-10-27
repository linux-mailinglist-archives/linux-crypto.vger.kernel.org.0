Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2417D95A2
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Oct 2023 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0Kxe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Oct 2023 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345488AbjJ0Kxd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Oct 2023 06:53:33 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A582C9
        for <linux-crypto@vger.kernel.org>; Fri, 27 Oct 2023 03:53:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qwKT0-00BeWK-1p; Fri, 27 Oct 2023 18:53:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Oct 2023 18:53:32 +0800
Date:   Fri, 27 Oct 2023 18:53:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, "Ospan, Abylay" <aospan@amazon.com>,
        Joachim Vandersmissen <git@jvdsn.com>
Subject: Re: [PATCH v2] crypto: jitter - use permanent health test storage
Message-ID: <ZTuWrAvzHaQ1DqwZ@gondor.apana.org.au>
References: <5719392.DvuYhMxLoT@positron.chronox.de>
 <2706159.mvXUDI8C0e@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2706159.mvXUDI8C0e@positron.chronox.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 19, 2023 at 09:40:42AM +0200, Stephan M�ller wrote:
> Changes v2:
> 
> - mark function jent_health_failure as static
> 
> ---8<---
> 
> The health test result in the current code is only given for the currently
> processed raw time stamp. This implies to react on the health test error,
> the result must be checked after each raw time stamp being processed. To
> avoid this constant checking requirement, any health test error is recorded
> and stored to be analyzed at a later time, if needed.
> 
> This change ensures that the power-up test catches any health test error.
> Without that patch, the power-up health test result is not enforced.
> 
> The introduced changes are already in use with the user space version of
> the Jitter RNG.
> 
> Fixes: 04597c8dd6c4 ("jitter - add RCT/APT support for different OSRs")
> Reported-by: Joachim Vandersmissen <git@jvdsn.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/jitterentropy.c | 125 ++++++++++++++++++++++++-----------------
>  1 file changed, 74 insertions(+), 51 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

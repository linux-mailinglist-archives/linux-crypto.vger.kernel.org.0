Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C16CC974
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Mar 2023 19:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjC1Rky (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Mar 2023 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjC1Rko (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Mar 2023 13:40:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8844E38D
        for <linux-crypto@vger.kernel.org>; Tue, 28 Mar 2023 10:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39EAEB81DA3
        for <linux-crypto@vger.kernel.org>; Tue, 28 Mar 2023 17:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D979EC433D2;
        Tue, 28 Mar 2023 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680025240;
        bh=oNbDgjbCH2Wv8j2byyR9OfjH3nCraTfNuG0EOkqirHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dd91MVwnmRHXhgSojtV8FPq00biDqi65/nd7mXJGNnl+O9SKNbJvy6nBVvayA9tZ8
         sStlNLU70zZWOrNpcuwIBZDj+qIqgv6iPVSI5Q7sUddY7SAttL6zg3pOEB/Ds4UaZw
         1XPwtsA3926zOjbux2stlgA3lPGovHhbmeMwdoitrtcFkZld9CiZFt8yxhBP1X3Hm+
         ETu8QxwexLGxM8WDC7KxfyH7+V2Z3YUfHRIEy0lXYGWjvLPW3GFR5rfw0WxUVCm/x8
         /ohrr84R4fZ55rG7cckwNfylFBhNpD6edZkKEgpf7OcyDi2OTLR4njfluh/UuLjJfL
         C5T1twCm3pQCA==
Date:   Tue, 28 Mar 2023 10:40:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/utils - Move utilities into new header
Message-ID: <20230328174038.GA890@sol.localdomain>
References: <ZB10ijozlmPmxjJr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB10ijozlmPmxjJr@gondor.apana.org.au>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 24, 2023 at 05:59:38PM +0800, Herbert Xu wrote:
> The utilities have historically resided in algapi.h as they were
> first used internally before being exported.  Move them into a
> new header file so external users don't see internal API details.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
> 
>  include/crypto/algapi.h |   63 -----------------------------------------
>  include/crypto/utils.h  |   73 ++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/crypto/utils.c      |    2 -
>  3 files changed, 75 insertions(+), 63 deletions(-)
> 

Thanks for doing this!  There are other files in lib/crypto/ that include
<crypto/algapi.h> currently.  It seems they should be changed to include
<crypto/utils.h> instead?

- Eric

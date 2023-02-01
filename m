Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2632A6862B6
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Feb 2023 10:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBAJWE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Feb 2023 04:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAJWD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Feb 2023 04:22:03 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15862457EA
        for <linux-crypto@vger.kernel.org>; Wed,  1 Feb 2023 01:22:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pN9JX-006JPH-2X; Wed, 01 Feb 2023 17:22:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 01 Feb 2023 17:21:59 +0800
Date:   Wed, 1 Feb 2023 17:21:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: arm64/aes-ccm - Rewrite skcipher walker loop
Message-ID: <Y9ovNyYP03rUBPlq@gondor.apana.org.au>
References: <Y9eGyzZ+JAqRQvtm@gondor.apana.org.au>
 <b83ca139-1e8c-60f3-939f-15f727710c36@linux.alibaba.com>
 <Y9opEyTFKXAVjk/D@gondor.apana.org.au>
 <477c73bd-b56e-3c63-1ad6-6a2a08af42af@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477c73bd-b56e-3c63-1ad6-6a2a08af42af@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 01, 2023 at 05:15:23PM +0800, Tianjia Zhang wrote:
>
> According to your previous reply, walker will ensure that the nbytes of
> each iteration is at least the size of the chunk. If walk.nbytes == 0,

walk.nbytes == 0 is used to indicate error.  Of course you could
check for an error return in addition to checking walk.nbytes but
that's how this bug got created in the first place.

So always check for walk.nbytes == 0.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

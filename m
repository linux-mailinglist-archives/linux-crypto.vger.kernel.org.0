Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967EA7C62B7
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Oct 2023 04:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjJLC1B (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Oct 2023 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJLC1A (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Oct 2023 22:27:00 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59AA4
        for <linux-crypto@vger.kernel.org>; Wed, 11 Oct 2023 19:26:57 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qqlPW-006DED-AR; Thu, 12 Oct 2023 10:26:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Oct 2023 10:26:55 +0800
Date:   Thu, 12 Oct 2023 10:26:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Prestwood <prestwoj@gmail.com>
Subject: Re: Linux 6.5 broke iwd
Message-ID: <ZSdZb8DVm6e0ikwx@gondor.apana.org.au>
References: <ab4d8025-a4cc-48c6-a6f0-1139e942e1db@gmail.com>
 <ZSc/9nUuF/d24iO6@gondor.apana.org.au>
 <4f5f4d52-a1c4-4726-80c2-dcc8b3e86e5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5f4d52-a1c4-4726-80c2-dcc8b3e86e5c@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 11, 2023 at 09:18:04PM -0500, Denis Kenzior wrote:
> 
> Possible.  I performed the bisect using a kernel configuration from the
> following instructions:
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/test-runner.txt#n55
> 
> In my case, I was using the User Mode Linux arch and testing locally using
> iwd's test runner.
> 
> # make ARCH=um olddefconfig
> # make ARCH=um -j8

I can't reproduce this with olddefconfig.  It produces a config
where crypto/asymmetric_keys is disabled altogether.

Please send me your actual config file that triggers the build
failure.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

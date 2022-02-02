Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FD44A6C56
	for <lists+linux-crypto@lfdr.de>; Wed,  2 Feb 2022 08:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiBBH3k (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 2 Feb 2022 02:29:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60834 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237745AbiBBH3k (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 2 Feb 2022 02:29:40 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nF90a-0005je-4L; Wed, 02 Feb 2022 17:20:49 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Feb 2022 17:20:48 +1100
Date:   Wed, 2 Feb 2022 17:20:48 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: your patch "crypto: api - Fix built-in testing dependency
 failures"
Message-ID: <YfoiwBx8WCpICKBD@gondor.apana.org.au>
References: <83208d0b-cbe0-8ca9-195c-ee1673f08573@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83208d0b-cbe0-8ca9-195c-ee1673f08573@suse.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 31, 2022 at 04:30:06PM +0100, Jan Beulich wrote:
> Herbert,
> 
> unexpectedly after updating to 5.16 on one of my systems (the 1st one
> I tried) btrfs.ko would not load anymore. Since this did happen before,
> I inspected module dependencies, but they were all fine. Nevertheless
> it was libcrc32c.ko which actually failed to load, but the error
> ("Accessing a corrupted shared library") wasn't very helpful. Until I
> spotted crypto_alg_lookup(), and "only" a few steps I found this commit
> of yours. The problem, ultimately, is that all of the sudden
> cryptomgr.ko needs to be available in initrd. Without any module having
> a dependency on it, it wouldn't get pulled in automatically. And there
> was no need for it before (until later in the boot process, when / was
> already mounted).
> 
> Can this be addressed in some way, i.e. is there a way to re-work your
> change to remove the dependency again?

Can you send me your .config file please?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

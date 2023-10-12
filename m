Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA37C62C9
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Oct 2023 04:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjJLCdH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Oct 2023 22:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjJLCdG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Oct 2023 22:33:06 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14CA4
        for <linux-crypto@vger.kernel.org>; Wed, 11 Oct 2023 19:33:03 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qqlVR-006DQC-Jj; Thu, 12 Oct 2023 10:32:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Oct 2023 10:33:02 +0800
Date:   Thu, 12 Oct 2023 10:33:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Prestwood <prestwoj@gmail.com>
Subject: Re: Linux 6.5 broke iwd
Message-ID: <ZSda3l7asdCr06kA@gondor.apana.org.au>
References: <ab4d8025-a4cc-48c6-a6f0-1139e942e1db@gmail.com>
 <ZSc/9nUuF/d24iO6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSc/9nUuF/d24iO6@gondor.apana.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 12, 2023 at 08:38:14AM +0800, Herbert Xu wrote:
>
> > Narrowing down further didn't work due to:
> > /usr/bin/ld: crypto/asymmetric_keys/x509_public_key.o: in function
> > `x509_get_sig_params':
> > x509_public_key.c:(.text+0x363): undefined reference to `sm2_compute_z_digest'
> > collect2: error: ld returned 1 exit status

I wonder if this is a bug in the bisection process.  The reference
to sm2_compute_z_digest is protected by an IS_REACHABLE test on
SM2 which is presumably disabled in your configuration.

Can you please do a clean rebuild from the first buggy commit with
the same config file and see if it still triggers the build failure?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

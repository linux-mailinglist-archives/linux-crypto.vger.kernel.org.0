Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC90E68622D
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Feb 2023 09:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBAIzw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Feb 2023 03:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAIzv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Feb 2023 03:55:51 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8850F38EB8
        for <linux-crypto@vger.kernel.org>; Wed,  1 Feb 2023 00:55:50 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pN8uB-006IpM-Nd; Wed, 01 Feb 2023 16:55:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 01 Feb 2023 16:55:47 +0800
Date:   Wed, 1 Feb 2023 16:55:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: arm64/aes-ccm - Rewrite skcipher walker loop
Message-ID: <Y9opEyTFKXAVjk/D@gondor.apana.org.au>
References: <Y9eGyzZ+JAqRQvtm@gondor.apana.org.au>
 <b83ca139-1e8c-60f3-939f-15f727710c36@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b83ca139-1e8c-60f3-939f-15f727710c36@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 01, 2023 at 10:53:37AM +0800, Tianjia Zhang wrote:
>
> 	while (walk.nbytes != walk.total) {

This is still buggy, because we can have walk.nbytes == 0 and
walk.nbytes != walk.total.  You will enter the loop and call
skcipher_walk_done which is not allowed.

That is why you should follow the standard calling convention
for skcipher walks, always check for walk.nbytes != 0 and not
whether the walk returns an error.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87840778DBC
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Aug 2023 13:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbjHKLau (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Aug 2023 07:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHKLat (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Aug 2023 07:30:49 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61642E64
        for <linux-crypto@vger.kernel.org>; Fri, 11 Aug 2023 04:30:48 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qUQLr-0024DW-AY; Fri, 11 Aug 2023 19:30:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Aug 2023 19:30:43 +0800
Date:   Fri, 11 Aug 2023 19:30:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Joachim Vandersmissen <git@jvdsn.com>
Cc:     linux-crypto@vger.kernel.org,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Subject: Re: [PATCH] Add clarifying comments to Jitter Entropy RCT cutoff
 values.
Message-ID: <ZNYb47YNlK65kQi9@gondor.apana.org.au>
References: <20230806191903.83423-1-git@jvdsn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806191903.83423-1-git@jvdsn.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Aug 06, 2023 at 02:19:03PM -0500, Joachim Vandersmissen wrote:
> The RCT cutoff values are correct, but they don't exactly match the ones
> one would expect when computing them using the formula in SP800-90B. This
> discrepancy is due to the fact that the Jitter Entropy RCT starts at 1. To
> avoid any confusion by future reviewers, add some comments and explicitly
> subtract 1 from the "correct" cutoff values in the definitions.
> 
> Signed-off-by: Joachim Vandersmissen <git@jvdsn.com>
> ---
>  crypto/jitterentropy.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

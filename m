Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969F56193AE
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Nov 2022 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKDJix (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Nov 2022 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDJiw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Nov 2022 05:38:52 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD1625B
        for <linux-crypto@vger.kernel.org>; Fri,  4 Nov 2022 02:38:51 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oqt9O-00A29U-S6; Fri, 04 Nov 2022 17:38:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Nov 2022 17:38:47 +0800
Date:   Fri, 4 Nov 2022 17:38:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Cc:     linux-crypto@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: Re: [PATCH v2 0/4] Printing improvements for tcrypt
Message-ID: <Y2Tdp98azrOhtE6s@gondor.apana.org.au>
References: <20221026191616.9169-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026191616.9169-1-anirudh.venkataramanan@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 26, 2022 at 12:16:12PM -0700, Anirudh Venkataramanan wrote:
> The text tcrypt prints to dmesg is a bit inconsistent. This makes it
> difficult to process tcrypt results using scripts. This little series
> makes the prints more consistent.
> 
> Changes v1 -> v2: Rebase to tag v6.1-p2, resolve conflict in patch 2/4
> 
> Anirudh Venkataramanan (4):
>   crypto: tcrypt - Use pr_cont to print test results
>   crypto: tcrypt - Use pr_info/pr_err
>   crypto: tcrypt - Drop module name from print string
>   crypto: tcrypt - Drop leading newlines from prints
> 
>  crypto/tcrypt.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> -- 
> 2.37.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

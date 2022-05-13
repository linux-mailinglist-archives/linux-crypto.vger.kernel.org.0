Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D610A525F47
	for <lists+linux-crypto@lfdr.de>; Fri, 13 May 2022 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379080AbiEMJgc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 May 2022 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379089AbiEMJgK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 May 2022 05:36:10 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEA53703A
        for <linux-crypto@vger.kernel.org>; Fri, 13 May 2022 02:36:09 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1npRiM-00DHG7-2z; Fri, 13 May 2022 19:36:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 May 2022 17:36:02 +0800
Date:   Fri, 13 May 2022 17:36:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: talitos - Uniform coding style with defined
 variable
Message-ID: <Yn4mgktkOzJMIdwp@gondor.apana.org.au>
References: <20220508052250.23000-1-jianchunfu@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508052250.23000-1-jianchunfu@cmss.chinamobile.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, May 08, 2022 at 01:22:50PM +0800, jianchunfu wrote:
> Use the defined variable "desc" to uniform coding style.
> 
> Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
> ---
>  drivers/crypto/talitos.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

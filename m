Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9557DCA1
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Jul 2022 10:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiGVIov (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Jul 2022 04:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiGVIog (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Jul 2022 04:44:36 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499849FE02;
        Fri, 22 Jul 2022 01:44:36 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oEoGn-003HMN-Bc; Fri, 22 Jul 2022 18:44:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jul 2022 16:44:25 +0800
Date:   Fri, 22 Jul 2022 16:44:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: rmd160: fix Kconfig "its" grammar
Message-ID: <Ytpjad+O48KFqXDt@gondor.apana.org.au>
References: <20220715015914.12554-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715015914.12554-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 14, 2022 at 06:59:14PM -0700, Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
>  crypto/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

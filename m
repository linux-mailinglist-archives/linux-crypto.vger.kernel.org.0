Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845767D07F1
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 07:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346955AbjJTFzJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 01:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbjJTFzB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 01:55:01 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520BD64;
        Thu, 19 Oct 2023 22:54:59 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiT8-0097c3-Da; Fri, 20 Oct 2023 13:54:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:54:51 +0800
Date:   Fri, 20 Oct 2023 13:54:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
        mcgrof@kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Limit MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or
 SHA512
Message-ID: <ZTIWK5qidPSVKUEi@gondor.apana.org.au>
References: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 10, 2023 at 10:27:55PM +0100, Dimitri John Ledkov wrote:
> NIST FIPS 186-5 states that it is recommended that the security
> strength associated with the bit length of n and the security strength
> of the hash function be the same, or higher upon agreement. Given NIST
> P384 curve is used, force using either SHA384 or SHA512.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  certs/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

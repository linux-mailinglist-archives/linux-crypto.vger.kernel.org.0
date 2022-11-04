Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641EA6193B4
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Nov 2022 10:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKDJj7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Nov 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKDJjz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Nov 2022 05:39:55 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96282A73F
        for <linux-crypto@vger.kernel.org>; Fri,  4 Nov 2022 02:39:53 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oqtAQ-00A2Bn-L0; Fri, 04 Nov 2022 17:39:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Nov 2022 17:39:51 +0800
Date:   Fri, 4 Nov 2022 17:39:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     linux-crypto@vger.kernel.org, ralph.siemsen@linaro.org
Subject: Re: [PATCH] crypto: devel-algos.rst: use correct function name
Message-ID: <Y2Td55sILlOxFJrX@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027193544.68632-1-ralph.siemsen@linaro.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
> The hashing API does not have a function called .finish()
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> Documentation/crypto/devel-algos.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D714DA740
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Mar 2022 02:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiCPBNB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Mar 2022 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbiCPBNA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Mar 2022 21:13:00 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7543EE2
        for <linux-crypto@vger.kernel.org>; Tue, 15 Mar 2022 18:11:48 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nUICV-0004gD-Vz; Wed, 16 Mar 2022 12:11:45 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Mar 2022 13:11:44 +1200
Date:   Wed, 16 Mar 2022 13:11:44 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: algapi - Remove test larvals to fix error paths
Message-ID: <YjE5UCeoziA8f+Q4@gondor.apana.org.au>
References: <20220126145322.646723-1-p.zabel@pengutronix.de>
 <c572bf6f0b0a5d7fd3f8f0744a85eb5660a003d4.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c572bf6f0b0a5d7fd3f8f0744a85eb5660a003d4.camel@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jan 26, 2022 at 04:01:04PM +0100, Philipp Zabel wrote:
> 
> I see this happen on ARM with CONFIG_CRYPTO_AES_ARM_BS=y since v5.16-rc1
> because the simd_skcipher_create_compat("ecb(aes)", "ecb-aes-neonbs",
> "__ecb-aes-neonbs") call in arch/arm/crypto/aes-neonbs-glue.c returns
> -ENOENT. I believe that is the same issue as reported in [1].

I cannot reproduce this crash with qemu.  If you can still
reproduce this, please send me your complete kconfig file.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

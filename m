Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D855659600
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Dec 2022 08:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiL3H4E (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Dec 2022 02:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiL3Hzt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Dec 2022 02:55:49 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6FBC27
        for <linux-crypto@vger.kernel.org>; Thu, 29 Dec 2022 23:55:47 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pBAEy-00CGpy-B7; Fri, 30 Dec 2022 15:55:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 15:55:44 +0800
Date:   Fri, 30 Dec 2022 15:55:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Markus Stockhausen <markus.stockhausen@gmx.de>
Cc:     linux-crypto@vger.kernel.org, markus.stockhausen@gmx.de
Subject: Re: [PATCH v2 3/6] crypto/realtek: hash algorithms
Message-ID: <Y66ZgBx+hduj9S3K@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206192037.608808-4-markus.stockhausen@gmx.de>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Markus Stockhausen <markus.stockhausen@gmx.de> wrote:
>
> +       /* Write back any uncommitted data to memory. */
> +       if (hreq->buflen)
> +               dma_sync_single_for_device(cdev->dev, virt_to_phys(hreq->buf),
> +                                          hreq->buflen, DMA_TO_DEVICE);

This is not how the DMA API works.  You must not do virt_to_phys.
Instead use dma_map_single and dma_sync_* is not necessary unless
you are using the mapping for something else.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

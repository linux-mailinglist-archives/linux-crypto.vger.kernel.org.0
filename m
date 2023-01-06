Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955765FD3E
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Jan 2023 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAFJDA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Jan 2023 04:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjAFJC7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Jan 2023 04:02:59 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA3668C93
        for <linux-crypto@vger.kernel.org>; Fri,  6 Jan 2023 01:02:57 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDico-00EVVG-Mf; Fri, 06 Jan 2023 17:02:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Jan 2023 17:02:54 +0800
Date:   Fri, 6 Jan 2023 17:02:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Markus Stockhausen <markus.stockhausen@gmx.de>
Cc:     linux-crypto@vger.kernel.org, markus.stockhausen@gmx.de
Subject: Re: [PATCH v3 2/6] crypto/realtek: core functions
Message-ID: <Y7fjvoc28CUza3qf@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231162525.416709-3-markus.stockhausen@gmx.de>
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
> +void rtcr_add_src_to_ring(struct rtcr_crypto_dev *cdev, int idx, void *vaddr,
> +                         int blocklen, int totallen)
> +{
> +       dma_addr_t dma = cdev->src_dma + idx * RTCR_SRC_DESC_SIZE;
> +       struct rtcr_src_desc *src = &cdev->src_ring[idx];
> +
> +       src->len = totallen;
> +       src->paddr = virt_to_phys(vaddr);
> +       src->opmode = RTCR_SRC_OP_OWN_ASIC | RTCR_SRC_OP_CALC_EOR(idx) | blocklen;
> +
> +       dma_sync_single_for_device(cdev->dev, dma, RTCR_SRC_DESC_SIZE, DMA_BIDIRECTIONAL);

Why aren't there any calls to dma_sync_single_for_cpu if this is
truly bidirectional?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

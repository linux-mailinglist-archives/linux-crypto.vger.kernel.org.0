Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14873575DD6
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Jul 2022 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiGOIsD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Jul 2022 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiGOIsC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 Jul 2022 04:48:02 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F008239C
        for <linux-crypto@vger.kernel.org>; Fri, 15 Jul 2022 01:47:51 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oCGz9-000nsz-C6; Fri, 15 Jul 2022 18:47:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 Jul 2022 16:47:43 +0800
Date:   Fri, 15 Jul 2022 16:47:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH crypto-next] crypto: caam/qi2 - switch to
 netif_napi_add_tx_weight()
Message-ID: <YtEpry9KPgYB+wII@gondor.apana.org.au>
References: <20220705225857.923711-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705225857.923711-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 05, 2022 at 03:58:57PM -0700, Jakub Kicinski wrote:
> caam has its own special NAPI weights. It's also a crypto device
> so presumably it can't be used for packet Rx. Switch to the (new)
> correct API.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: horia.geanta@nxp.com
> CC: pankaj.gupta@nxp.com
> CC: gaurav.jain@nxp.com
> CC: herbert@gondor.apana.org.au
> CC: linux-crypto@vger.kernel.org
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 5 +++--
>  drivers/crypto/caam/qi.c          | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

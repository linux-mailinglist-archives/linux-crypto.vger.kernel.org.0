Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6559556B400
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Jul 2022 10:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiGHICZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Jul 2022 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbiGHICZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Jul 2022 04:02:25 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB77E01F
        for <linux-crypto@vger.kernel.org>; Fri,  8 Jul 2022 01:02:24 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9iwK-00Frwo-1R; Fri, 08 Jul 2022 18:02:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 16:02:16 +0800
Date:   Fri, 8 Jul 2022 16:02:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     oferh@marvell.com
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        atenart@kernel.org
Subject: Re: [PATCH] crypto: inside-secure: fix packed bit-field result
 descriptor
Message-ID: <YsfkiFRefmuh62+p@gondor.apana.org.au>
References: <20220702071426.1915429-1-oferh@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702071426.1915429-1-oferh@marvell.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jul 02, 2022 at 10:14:26AM +0300, oferh@marvell.com wrote:
> From: Ofer Heifetz <oferh@marvell.com>
> 
> When mixing bit-field and none bit-filed in packed struct the
> none bit-field starts at a distinct memory location, thus adding
> an additional byte to the overall structure which is used in
> memory zero-ing and other configuration calculations.
> 
> Fix this by removing the none bit-field that has a following
> bit-field.
> 
> Signed-off-by: Ofer Heifetz <oferh@marvell.com>
> ---
>  drivers/crypto/inside-secure/safexcel.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

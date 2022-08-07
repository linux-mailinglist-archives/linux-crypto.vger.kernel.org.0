Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CAB58B8C5
	for <lists+linux-crypto@lfdr.de>; Sun,  7 Aug 2022 02:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiHGAjL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 6 Aug 2022 20:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHGAjK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 6 Aug 2022 20:39:10 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EB1057E
        for <linux-crypto@vger.kernel.org>; Sat,  6 Aug 2022 17:39:08 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oKUJi-008UGG-VC; Sun, 07 Aug 2022 10:38:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Aug 2022 08:38:54 +0800
Date:   Sun, 7 Aug 2022 08:38:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: talitos b0030000.crypto: length exceeds h/w max limit
Message-ID: <Yu8JngER3t8UIP8f@gondor.apana.org.au>
References: <4d9e644d-3d2d-518a-3d05-2539c69d88c1@c-s.fr>
 <1955828.3d07pK88Qj@tauon.chronox.de>
 <326109a3-bb5c-eac4-1340-70c179a3ad2a@c-s.fr>
 <10231361.cnp4CI42qt@positron.chronox.de>
 <de9d2ae5-e794-6e54-baf6-f83a16d710a3@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9d2ae5-e794-6e54-baf6-f83a16d710a3@csgroup.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Aug 06, 2022 at 05:45:25PM +0200, Christophe Leroy wrote:
>
> Is there a way to tell crypto kernel core that a given driver has a fixed
> limit and that data shall be sent in chunks ? Or is it the responsibility of
> the driver to cut off the data in acceptable chunks ? I guess the Talitos
> driver is not the only driver with such a limit, so something centralised
> must exist to handle it ?

There is no length limit on the interface between the Crypto API
and the drivers.  If the hardware is unable to handle requests
longer than a certain size, then the driver should handle it by
splitting up the SG list or using a fallback.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42A2811B2
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Oct 2020 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgJBLzQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Oct 2020 07:55:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49174 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBLzQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Oct 2020 07:55:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOJeK-0005T2-CD; Fri, 02 Oct 2020 21:54:57 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 21:54:56 +1000
Date:   Fri, 2 Oct 2020 21:54:56 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     mpm@selenic.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, joel@jms.id.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1] hw_random: npcm: modify readl to readb
Message-ID: <20201002115456.GG1205@gondor.apana.org.au>
References: <20200923212305.198485-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923212305.198485-1-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 24, 2020 at 12:23:05AM +0300, Tomer Maimon wrote:
> Modify the read size to the correct HW random
> registers size, 8bit.
> The incorrect read size caused and faulty
> HW random value.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/char/hw_random/npcm-rng.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

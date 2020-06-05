Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0B1EFFDB
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2020 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFESZ0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Jun 2020 14:25:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43144 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgFESZ0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Jun 2020 14:25:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jhH1u-00086s-Dp; Sat, 06 Jun 2020 04:25:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Jun 2020 04:25:22 +1000
Date:   Sat, 6 Jun 2020 04:25:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [v2 PATCH] crc-t10dif: Fix potential crypto notify dead-lock
Message-ID: <20200605182522.GA9536@gondor.apana.org.au>
References: <20200604063324.GA28813@gondor.apana.org.au>
 <20200605065918.GA813@gondor.apana.org.au>
 <20200605182237.GG1373@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605182237.GG1373@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 05, 2020 at 11:22:37AM -0700, Eric Biggers wrote:
>
> Wouldn't it be better to have crct10dif_fallback enabled by default, and then
> disable it once the tfm is allocated?

That's a semantic change.  As it is if the first allocation fails
then we never try again.  You can do this in a different patch.

> That would make the checks for a NULL tfm in crc_t10dif_transform_show() and
> crc_t10dif_notify() unnecessary.  Also, it would make it so that
> crc_t10dif_update() no longer crashes if called before module_init().

crc_t10dif_update can never be called prior to module_init while
the other two functions both can.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

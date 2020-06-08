Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B951F12D3
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jun 2020 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgFHGZ1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 8 Jun 2020 02:25:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53878 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbgFHGZ1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:27 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jiBDi-0001ad-Le; Mon, 08 Jun 2020 16:25:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 08 Jun 2020 16:25:18 +1000
Date:   Mon, 8 Jun 2020 16:25:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [v2 PATCH] crc-t10dif: Fix potential crypto notify dead-lock
Message-ID: <20200608062518.GB21732@gondor.apana.org.au>
References: <20200604063324.GA28813@gondor.apana.org.au>
 <20200605065918.GA813@gondor.apana.org.au>
 <20200605182237.GG1373@sol.localdomain>
 <20200605182522.GA9536@gondor.apana.org.au>
 <20200605184846.GI1373@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605184846.GI1373@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 05, 2020 at 11:48:46AM -0700, Eric Biggers wrote:
>
> That's only guaranteed to be true if the code is built is a loadable module.  If
> it's built-in to the kernel, it could be called earlier, by a previous initcall.

That would just be a bug.  The same thing can happen with any code
in the kernel but we don't add NULL-pointer checks all over the
place just because some buggy code could call functions before
init.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

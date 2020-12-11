Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E702D7454
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394309AbgLKKz7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Dec 2020 05:55:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33502 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394302AbgLKKzl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Dec 2020 05:55:41 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kng4e-0005f7-LL; Fri, 11 Dec 2020 21:54:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Dec 2020 21:54:56 +1100
Date:   Fri, 11 Dec 2020 21:54:56 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        qat-linux <qat-linux@intel.com>,
        Marco Chiappero <marco.chiappero@intel.com>,
        Tomaszx Kowalik <tomaszx.kowalik@intel.com>
Subject: Re: [PATCH 2/3] crypto: qat - add AES-XTS support for QAT GEN4
 devices
Message-ID: <20201211105456.GA4423@gondor.apana.org.au>
References: <20201201142451.138221-1-giovanni.cabiddu@intel.com>
 <20201201142451.138221-3-giovanni.cabiddu@intel.com>
 <20201211100748.GA994@gondor.apana.org.au>
 <CAMj1kXGr-aJ_uqoq+ooqp6iFSfGraQMHaGi8idd+qc_UXvp7FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGr-aJ_uqoq+ooqp6iFSfGraQMHaGi8idd+qc_UXvp7FA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 11, 2020 at 11:42:08AM +0100, Ard Biesheuvel wrote:
>
> I think this is a valid use of a bare cipher - it lives as long as the
> TFM itself, and may be used on a hot path.
> 
> I need to respin the bare cipher change I sent the other day anyway,
> so I'll make sure this driver gets the right treatment as well (which
> shouldn't cause any conflicts so the changes can be merged in any
> order)

Thanks for looking into this Ard!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

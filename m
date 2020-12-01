Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA02CAFA1
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Dec 2020 23:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgLAWCe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Dec 2020 17:02:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51248 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392237AbgLAWCd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Dec 2020 17:02:33 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kkDiQ-0001S0-0A; Wed, 02 Dec 2020 09:01:43 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Dec 2020 09:01:42 +1100
Date:   Wed, 2 Dec 2020 09:01:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        Steve deRosier <derosier@cal-sierra.com>
Subject: Re: [PATCH v2] crypto: aesni - add ccm(aes) algorithm implementation
Message-ID: <20201201220141.GA32029@gondor.apana.org.au>
References: <20201201194556.5220-1-ardb@kernel.org>
 <20201201215722.GA31941@gondor.apana.org.au>
 <60938181-3c15-9cc0-a4b4-1fa33595c44c@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60938181-3c15-9cc0-a4b4-1fa33595c44c@candelatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 01, 2020 at 02:00:42PM -0800, Ben Greear wrote:
>
> No one wanted to do this for the last 6+ years, so I don't think it is likely
> to happen any time soon.  If the patch is better than
> existing behaviour, please let it into the kernel.  And it is certainly
> better in my test case.

No I'm not taking this.  This just papers over the problem with
a bandaid and goes against every other implementation in aesni.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

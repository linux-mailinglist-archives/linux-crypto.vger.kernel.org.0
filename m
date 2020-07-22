Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4B2291CF
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jul 2020 09:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgGVHMN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jul 2020 03:12:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59656 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGVHMM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jul 2020 03:12:12 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jy8u9-0002Pa-FR; Wed, 22 Jul 2020 17:11:06 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 22 Jul 2020 17:11:05 +1000
Date:   Wed, 22 Jul 2020 17:11:05 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH for v5.9] ARM: STM32: Replace HTTP links with HTTPS ones
Message-ID: <20200722071105.GA27451@gondor.apana.org.au>
References: <20200719094948.57487-1-grandmaster@al2klimov.de>
 <43c11c7a-269e-cc41-6934-0d2e0dec3226@st.com>
 <219075a0-d7cf-a699-21d7-fabc6f077f95@al2klimov.de>
 <55c95208-de0f-b2d3-c20c-d19f3ce34e2a@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c95208-de0f-b2d3-c20c-d19f3ce34e2a@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 22, 2020 at 09:06:29AM +0200, Alexandre Torgue wrote:
>
> hum, I was not aware that I could take "crypto" patches. But anyway I think,
> the clean way (to avoid merge  issue later) is that I take mach-stm32 patch
> and Herbert the crypto one. Except if Herbert doesn't agree can you please
> split ?

Yes I think splitting it up would be better in case there are
other patches down the track that may cause conflicts.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

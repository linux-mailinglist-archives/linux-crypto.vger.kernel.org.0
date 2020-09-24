Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9E2771B3
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Sep 2020 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgIXM60 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Sep 2020 08:58:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50124 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgIXM60 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Sep 2020 08:58:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLQpJ-0002lv-PD; Thu, 24 Sep 2020 22:58:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 24 Sep 2020 22:58:21 +1000
Date:   Thu, 24 Sep 2020 22:58:21 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: inside-secure - Fix corruption on not fully
 coherent systems
Message-ID: <20200924125821.GA11034@gondor.apana.org.au>
References: <1599466784-23596-1-git-send-email-pvanleeuwen@rambus.com>
 <20200918065806.GA9698@gondor.apana.org.au>
 <CY4PR0401MB365283BF192613FD82EC0C12C33F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200918080127.GA24222@gondor.apana.org.au>
 <CY4PR0401MB365268AA17E35E5B55ABF7E6C33F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200924031154.GA8282@gondor.apana.org.au>
 <CY4PR0401MB3652E2654AE84DC173E008E2C3390@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200924123559.GA10827@gondor.apana.org.au>
 <CY4PR0401MB36528881D714296074EF135AC3390@CY4PR0401MB3652.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR0401MB36528881D714296074EF135AC3390@CY4PR0401MB3652.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 24, 2020 at 12:51:11PM +0000, Van Leeuwen, Pascal wrote:
>
> But you still have 2 potential gaps (from buffer 1 to buffer 2 and from buffer 2 to
> the other items in the struct) that are larger then they may need to be.

So put some of the rest of your struct in the middle, up to 128
bytes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

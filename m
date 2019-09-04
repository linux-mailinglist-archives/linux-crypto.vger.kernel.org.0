Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E73A842C
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfIDNJd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Sep 2019 09:09:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60376 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfIDNJd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Sep 2019 09:09:33 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5V20-0001sI-Hj; Wed, 04 Sep 2019 23:09:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Sep 2019 23:08:59 +1000
Date:   Wed, 4 Sep 2019 23:08:59 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] crypto: inside-secure - Fix build error without
 CONFIG_PCI
Message-ID: <20190904130859.GA32301@gondor.apana.org.au>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <MN2PR20MB297342698B98343D49FC2C82CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu_EA8-=Vc3aAdJSz7399Y5WBeKNjw_T3LEq7yOY2XQ+BA@mail.gmail.com>
 <20190904123158.GA29870@gondor.apana.org.au>
 <MN2PR20MB2973A03BFD630B654A46ACB8CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB2973A03BFD630B654A46ACB8CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 04, 2019 at 12:45:00PM +0000, Pascal Van Leeuwen wrote:
> So, with that patch you ONLY get a warning on that unused int rc, right?
> 
> I do understand that one, that should have been inside an #ifdef as well.
> Everybody happy if I just fix that and leave the rest as is?

Yes please send a patch to fix the unused variable warning.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

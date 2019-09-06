Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6BAB8D6
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Sep 2019 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392432AbfIFNF0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Sep 2019 09:05:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60814 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387851AbfIFNF0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Sep 2019 09:05:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i6DvX-0007X6-Qr; Fri, 06 Sep 2019 23:05:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Sep 2019 23:05:21 +1000
Date:   Fri, 6 Sep 2019 23:05:21 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2] crypto: inside-secure - Fix unused variable warning
 when CONFIG_PCI=n
Message-ID: <20190906130521.GA26780@gondor.apana.org.au>
References: <1567757243-16598-1-git-send-email-pvanleeuwen@verimatrix.com>
 <20190906121843.GA22696@gondor.apana.org.au>
 <MN2PR20MB2973DC6D4E1DC55EB1AF2825CABA0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB2973DC6D4E1DC55EB1AF2825CABA0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 06, 2019 at 01:01:19PM +0000, Pascal Van Leeuwen wrote:
>
> I explicitly DON'T want to abort if the PCI registration fails,
> since that may be irrelevant if the OF registration passes AND
> the device actually happens to be Device Tree.
> So not checking the result value is on purpose here.

Well if you want to support that you'll need to remember whether
PCI registration succeeded or not before unregistering it in the
exit function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

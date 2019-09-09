Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC93FAD7FD
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Sep 2019 13:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfIILfR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Sep 2019 07:35:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:32972 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbfIILfR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Sep 2019 07:35:17 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i7Hwu-0003ed-Sk; Mon, 09 Sep 2019 21:35:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Sep 2019 21:35:06 +1000
Date:   Mon, 9 Sep 2019 21:35:06 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 0/3] crypto: inside-secure - Add support for the CBCMAC
Message-ID: <20190909113506.GA4011@gondor.apana.org.au>
References: <1567582608-29177-1-git-send-email-pvanleeuwen@verimatrix.com>
 <20190909073752.GA20487@gondor.apana.org.au>
 <MN2PR20MB297379E80B6CD087822AD9CDCAB70@MN2PR20MB2973.namprd20.prod.outlook.com>
 <MN2PR20MB29735284B8567182E7B916D0CAB70@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB29735284B8567182E7B916D0CAB70@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 09, 2019 at 10:50:12AM +0000, Pascal Van Leeuwen wrote:
>
> So my suggestion would be to supply the CRC32 patch and
> then resubmit this patchset unmodified. Would that be OK?

That's fine.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

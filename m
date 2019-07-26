Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF67660B
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jul 2019 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfGZMik (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jul 2019 08:38:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46566 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfGZMik (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jul 2019 08:38:40 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzUc-00048x-1X; Fri, 26 Jul 2019 22:38:38 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzUZ-0002FX-NX; Fri, 26 Jul 2019 22:38:35 +1000
Date:   Fri, 26 Jul 2019 22:38:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCHv2 0/3] crypto: inside-secure - broaden driver scope
Message-ID: <20190726123835.GA8631@gondor.apana.org.au>
References: <1561469816-7871-1-git-send-email-pleeuwen@localhost.localdomain>
 <MN2PR20MB2973DAAEF813270C88BB941CCAC00@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190726120246.GA6956@gondor.apana.org.au>
 <MN2PR20MB297317829CB71379F92D9514CAC00@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190726122429.GA7866@gondor.apana.org.au>
 <MN2PR20MB297370D86ADB8A099818D3BCCAC00@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB297370D86ADB8A099818D3BCCAC00@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 26, 2019 at 12:34:06PM +0000, Pascal Van Leeuwen wrote:
>
> Which now makes me wonder which of the patches I sent out ended up
> on the mailing list at alll ...

Just check the patchwork list:

	https://patchwork.kernel.org/project/linux-crypto/list/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

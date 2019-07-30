Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B87A709
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfG3LfK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jul 2019 07:35:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35310 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbfG3LfK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jul 2019 07:35:10 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hsQPF-0008Gy-2X; Tue, 30 Jul 2019 21:35:01 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hsQP7-0001zC-SQ; Tue, 30 Jul 2019 21:34:53 +1000
Date:   Tue, 30 Jul 2019 21:34:53 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: inside-secure - Fix null ptr derefence on rmmod
 for macchiatobin
Message-ID: <20190730113453.GA7595@gondor.apana.org.au>
References: <1564155069-18491-1-git-send-email-pvanleeuwen@verimatrix.com>
 <20190730081203.GB3108@kwain>
 <MN2PR20MB2973F225CFE1CBA34C83ACFBCADC0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB2973F225CFE1CBA34C83ACFBCADC0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 30, 2019 at 10:27:26AM +0000, Pascal Van Leeuwen wrote:
>
> As you already figured out by now, this patch just fixes something
> that was broken by one of my earlier patches (which has not been
> applied just yet). So I don't think it applies to stable trees.

If your earlier patch has been applied to cryptodev already then you
should use a Fixes header.  If not then you should repost that patch
with the fix folded into it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

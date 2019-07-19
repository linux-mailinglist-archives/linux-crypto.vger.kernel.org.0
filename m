Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157CC6E79C
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Jul 2019 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfGSO6F (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Jul 2019 10:58:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56640 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSO6F (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Jul 2019 10:58:05 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hoUKi-00031h-EX; Fri, 19 Jul 2019 22:58:04 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hoUKg-00089i-Pq; Fri, 19 Jul 2019 22:58:02 +0800
Date:   Fri, 19 Jul 2019 22:58:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: generic ahash question
Message-ID: <20190719145802.lo7te2shj76trin6@gondor.apana.org.au>
References: <MN2PR20MB297347B80C7E3DCD19127B05CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB297347B80C7E3DCD19127B05CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 19, 2019 at 02:41:03PM +0000, Pascal Van Leeuwen wrote:
> 
> So I'm guessing there must be some flags that I can set to indicate I'm not supporting seperate
> init/update/final calls so that testmgr skips those specific tests? Which flag(s) do I need to set?

All implementations must support all of these calls.  If your
hardware cannot produce non-finalised output, then what you need
to do is use a fallback for init/update and then implement final,
finup and digest.  If your hardware can't even accept non-finalised
input, then you will need to use a fallback for everything but
digest.

Since IPsec uses the digest call it would still be able to benefit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

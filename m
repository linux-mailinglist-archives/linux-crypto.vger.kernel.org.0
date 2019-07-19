Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD276E8AD
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Jul 2019 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfGSQXG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Jul 2019 12:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfGSQXG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Jul 2019 12:23:06 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BEC7204FD;
        Fri, 19 Jul 2019 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563553385;
        bh=Dc3gsKrSid84MRQEeWMHe0d19jqLwCDWZUgTUb9nTMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbJ3ZR6SJ96t7tUhnr8VbHb+t1k/i1qiNzlVoxRkB5mEhkV8Oy47rCcxQ2ryBXbw2
         yWiyn4/aXNhbPxyZamy6YsxMkGRoxY5tdRh7Xxlm4kf9SdQFBP2x5D5saCTxxlVA3o
         jO0F83uYke5L220gHDoF8wXbBUzbrGcUVu7TU3x0=
Date:   Fri, 19 Jul 2019 09:23:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: generic ahash question
Message-ID: <20190719162303.GB1422@gmail.com>
Mail-Followup-To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <MN2PR20MB297347B80C7E3DCD19127B05CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR20MB297347B80C7E3DCD19127B05CACB0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 19, 2019 at 02:41:03PM +0000, Pascal Van Leeuwen wrote:
> Hi,
> 
> I recall reading somewhere in the Linux Crypto documentation that support for finup() and digest()
> calls were explicitly added to support hardware that couldn't handle seperate init/update/final
> calls so they could at least be used with e.g. the IPsec stack.  I also noticed that testmgr *does*
>  attempt to verify these seperate calls ...
> 
> So I'm guessing there must be some flags that I can set to indicate I'm not supporting seperate
> init/update/final calls so that testmgr skips those specific tests? Which flag(s) do I need to set?
> 

Where does the documentation say that?

AFAICS, init/update/final have been mandatory for at least 9 years, as that's
when testmgr started testing it.  See:

	commit a8f1a05292db8b410be47fa905669672011f0343
	Author: David S. Miller <davem@davemloft.net>
	Date:   Wed May 19 14:12:03 2010 +1000

	    crypto: testmgr - Add testing for async hashing and update/final

- Eric

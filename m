Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9CF557
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Apr 2019 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfD3LVY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Apr 2019 07:21:24 -0400
Received: from [5.180.42.13] ([5.180.42.13]:36806 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfD3LVY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Apr 2019 07:21:24 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hLQp9-0002TN-3U; Tue, 30 Apr 2019 19:21:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hLQp0-0004nD-BM; Tue, 30 Apr 2019 19:21:14 +0800
Date:   Tue, 30 Apr 2019 19:21:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     linux-crypto@vger.kernel.org,
        Andrzej Zaborowski <andrew.zaborowski@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: crypto: akcipher: userspace API?
Message-ID: <20190430112114.rvoygpbu5jp7c473@gondor.apana.org.au>
References: <20190430125228.4b0deae6@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430125228.4b0deae6@nic.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Apr 30, 2019 at 12:52:28PM +0200, Marek Behun wrote:
> 
> I would like to ask what is the current status of the userspace
> akcipher crypto API.
> 
> The last patches I found are from 2017
> https://marc.info/?t=150234726200004&r=1&w=2 and were not applied.

The akcipher kernel API is still in a state of flux.  See the
recent work on ecrdsa for example which affected the RSA API.

Until that settles down I will not allow akcipher to be exported
through af_alg as that would commit us to that API forever.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

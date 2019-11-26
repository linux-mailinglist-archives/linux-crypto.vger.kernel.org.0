Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F9109A9B
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Nov 2019 09:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKZI7i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 26 Nov 2019 03:59:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59694 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfKZI7i (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 26 Nov 2019 03:59:38 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iZWh6-0006kF-W1; Tue, 26 Nov 2019 16:59:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iZWh4-0003cQ-PT; Tue, 26 Nov 2019 16:59:34 +0800
Date:   Tue, 26 Nov 2019 16:59:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH 3/3] crypto/testmgr: add selftests for paes-s390
Message-ID: <20191126085934.w5h3h2zjpqebknpe@gondor.apana.org.au>
References: <20191113105523.8007-1-freude@linux.ibm.com>
 <20191113105523.8007-4-freude@linux.ibm.com>
 <20191122081611.vznhvhouim6hnehc@gondor.apana.org.au>
 <88154ccf-84e8-17d1-1917-b8deeff20311@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88154ccf-84e8-17d1-1917-b8deeff20311@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 22, 2019 at 10:11:30AM +0100, Harald Freudenberger wrote:
>
> I thought about this too. But it would require to implement own versions of
> alg_test_skcipher() and test_skcipher() and test_skcipher_vs_generic_impl()
> and that's a lot of complicated code unique for paes within testmgr.c
> I'd like to avoid.

I don't think you have to do test_skcipher_vs_generic_impl right
away.  Just supporting the normal test vectors should be the same
as your current patch with the advantage that any changes to the
generic test vectors will be picked up automatically for paes.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

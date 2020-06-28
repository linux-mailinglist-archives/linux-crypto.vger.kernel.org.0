Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1315F20C9FE
	for <lists+linux-crypto@lfdr.de>; Sun, 28 Jun 2020 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgF1Tuh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 28 Jun 2020 15:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgF1Tuh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 28 Jun 2020 15:50:37 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB8432053B;
        Sun, 28 Jun 2020 19:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593373837;
        bh=g+bMH3YB2ROaJ1m9B5DHD4PP1izygQc5rj5oqPF7RMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=so9+QGwuY05Q1b1RGP3RYwsCzVrWaO/fBjcXaA37lU8bqyZbiLo4iprRdi6CwqxOW
         sDZrXyoMIVCw2QR6Sj9NqT5sihdQfVh+eG4VKLzTn/4qvBO1/zaZsExDJlSlchwLrG
         b7S1ZDxnogEFOC8XCLag1is5NjsrwMOCrDfPTB/0=
Date:   Sun, 28 Jun 2020 12:50:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, dm-devel@redhat.com,
        George Cherian <gcherian@marvell.com>,
        linux-crypto@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>
Subject: Re: [dm-devel] [PATCH 1/3 v2] crypto: introduce the flag
 CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <20200628195035.GD11197@sol.localdomain>
References: <alpine.LRH.2.02.2006161101080.28052@file01.intranet.prod.int.rdu2.redhat.com>
 <20200616173620.GA207319@gmail.com>
 <alpine.LRH.2.02.2006171107220.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2006171108440.18714@file01.intranet.prod.int.rdu2.redhat.com>
 <20200626044534.GA2870@gondor.apana.org.au>
 <alpine.LRH.2.02.2006261109520.11899@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2006261215480.13882@file01.intranet.prod.int.rdu2.redhat.com>
 <20200626164617.GA211634@gmail.com>
 <20200626170039.GB211634@gmail.com>
 <alpine.LRH.2.02.2006281505530.347@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2006281505530.347@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Jun 28, 2020 at 03:07:49PM -0400, Mikulas Patocka wrote:
> 
> > Also, "seqiv" instances can be created without CRYPTO_ALG_ALLOCATES_MEMORY set,
> > despite seqiv_aead_encrypt() allocating memory.
> > 

This comment wasn't addressed.

- Eric

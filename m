Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2491F295785
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Oct 2020 07:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507707AbgJVFC7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Oct 2020 01:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507705AbgJVFC6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Oct 2020 01:02:58 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C452D20657;
        Thu, 22 Oct 2020 05:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603342978;
        bh=grOL9UzXnA0JO4eRDSJG6Nrn9WZXrL2VbgFYaFjGelE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSeZLdbv2dG9Cs3UKg1lwf4W9cFcRN148Z/ZyujpikqHGI1YlMy4pgiIcwe/N7aXN
         W5UHrq2DJ9kArqNIuXQnC/XUEtLEG7wHjNl/GpzpxE1Tt1fSsW7d0plBGT9oXyE+MM
         degOUYvnD+2I7jyjBpwqwFeb1JxVJ6zQNbx9wAgU=
Date:   Wed, 21 Oct 2020 22:02:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] crypto: lib/sha256 - Unroll LOAD and BLEND loops
Message-ID: <20201022050256.GH857@sol.localdomain>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020203957.3512851-6-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 20, 2020 at 04:39:56PM -0400, Arvind Sankar wrote:
> Unrolling the LOAD and BLEND loops improves performance by ~8% on x86_64
> (tested on Broadwell Xeon) while not increasing code size too much.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

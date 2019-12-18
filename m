Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F33123D73
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Dec 2019 03:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRCtB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Dec 2019 21:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLRCtB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Dec 2019 21:49:01 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C130321775;
        Wed, 18 Dec 2019 02:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576637340;
        bh=1BKv8h/+dzKcUiIfipxIZWMQ8i8upDc4jXEX7+m0KVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHDpXpALTn6/Be8Yse/ug/O91UvMPuhyuptwvlSsvUrrAIrzfNXPsgip3vSS4oeXp
         g22yLz0AGajElYC8RHCFGA6lnFaQ0O7b5jCAWRR6JSy5+MBB5x+pVf6AgtM8ExX9xc
         iTawQKfedGnY8lQeqpjO9w+ZFL+1KJhTTmkLZ3hM=
Date:   Tue, 17 Dec 2019 18:48:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH crypto-next v6 0/3] crypto: poly1305 improvements
Message-ID: <20191218024859.GB3636@sol.localdomain>
References: <20191217174445.188216-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217174445.188216-1-Jason@zx2c4.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 17, 2019 at 06:44:42PM +0100, Jason A. Donenfeld wrote:
> With no feedback on v5 beyond the need for a .gitignore in the second
> commit of this v6, I think this series should now be good to go.

Well, you've also sent 6 versions of this patchset in less than a week, so I'm
not sure people have had enough time to review it.  I've just left a few
comments for things I noticed in a quick read-through.

That being said, I don't think anyone plans to review the 4200 lines of assembly
code anyway (which even the other OpenSSL developers don't understand [1]), so
maybe it doesn't matter.

[1] https://github.com/openssl/openssl/pull/2056#pullrequestreview-12242604

- Eric

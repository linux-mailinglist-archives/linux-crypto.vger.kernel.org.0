Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F613144BF4
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jan 2020 07:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgAVGsY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jan 2020 01:48:24 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53094 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgAVGsY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jan 2020 01:48:24 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iu9oN-00033W-6f; Wed, 22 Jan 2020 14:48:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iu9oL-0002yX-La; Wed, 22 Jan 2020 14:48:21 +0800
Date:   Wed, 22 Jan 2020 14:48:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, Jason@zx2c4.com
Subject: Re: [PATCH] crypto: allow tests to be disabled when manager is
 disabled
Message-ID: <20200122064821.dbjwljxoxo245vnp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117110136.305162-1-Jason@zx2c4.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The library code uses CRYPTO_MANAGER_DISABLE_TESTS to conditionalize its
> tests, but the library code can also exist without CRYPTO_MANAGER. That
> means on minimal configs, the test code winds up being built with no way
> to disable it.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I think we still want to keep the extra tests option within the
if block unless you have plans on using that option in the lib
code as well?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

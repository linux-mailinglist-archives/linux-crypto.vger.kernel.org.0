Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8209B3B57DE
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Jun 2021 05:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhF1DeA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 27 Jun 2021 23:34:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51014 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhF1Dd6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 27 Jun 2021 23:33:58 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lxhzg-0001rx-Tw; Mon, 28 Jun 2021 11:31:32 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lxhzd-0002na-LQ; Mon, 28 Jun 2021 11:31:29 +0800
Date:   Mon, 28 Jun 2021 11:31:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, Vlad Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] crypto: DRBG - self test for HMAC(SHA-512)
Message-ID: <20210628033129.GB10694@gondor.apana.org.au>
References: <3171520.o5pSzXOnS6@positron.chronox.de>
 <20210624143019.GA20222@gondor.apana.org.au>
 <11782290.ZbvtA0Mc7t@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11782290.ZbvtA0Mc7t@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 24, 2021 at 05:44:35PM +0200, Stephan Müller wrote:
> Considering that the HMAC(SHA-512) DRBG is the default DRBG now, a self
> test is to be provided.
> 
> The test vector is obtained from a successful NIST ACVP test run.
> 
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/testmgr.c |  5 ++++-
>  crypto/testmgr.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA92426AA5
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Oct 2021 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhJHMZ5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Oct 2021 08:25:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55918 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241351AbhJHMZ5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Oct 2021 08:25:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mYouv-0003cP-5i; Fri, 08 Oct 2021 20:24:01 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mYouv-00086R-2o; Fri, 08 Oct 2021 20:24:01 +0800
Date:   Fri, 8 Oct 2021 20:24:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] crypto: testmgr - Only disable migration in
 crypto_disable_simd_for_test()
Message-ID: <20211008122401.GD31060@gondor.apana.org.au>
References: <20210928115401.441339-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928115401.441339-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 28, 2021 at 01:54:01PM +0200, Sebastian Andrzej Siewior wrote:
> crypto_disable_simd_for_test() disables preemption in order to receive a
> stable per-CPU variable which it needs to modify in order to alter
> crypto_simd_usable() results.
> 
> This can also be achived by migrate_disable() which forbidds CPU
> migrations but allows the task to be preempted. The latter is important
> for PREEMPT_RT since operation like skcipher_walk_first() may allocate
> memory which must not happen with disabled preemption on PREEMPT_RT.
> 
> Use migrate_disable() in crypto_disable_simd_for_test() to achieve a
> stable per-CPU pointer.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  crypto/testmgr.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

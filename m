Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351A2811B3
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Oct 2020 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBLz3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Oct 2020 07:55:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49186 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgJBLz3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Oct 2020 07:55:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOJem-0005Vu-WC; Fri, 02 Oct 2020 21:55:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 21:55:25 +1000
Date:   Fri, 2 Oct 2020 21:55:25 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v2 0/2] crypto: xor - defer and optimize boot time
 benchmark
Message-ID: <20201002115525.GI1205@gondor.apana.org.au>
References: <20200926102651.31598-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926102651.31598-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Sep 26, 2020 at 12:26:49PM +0200, Ard Biesheuvel wrote:
> Doug reports [0] that the XOR boot time benchmark takes more time than
> necessary, and runs at a time when there is little room for other
> boot time tasks to run concurrently.
> 
> Let's fix this by #1 deferring the benchmark, and #2 uses a faster
> implementation.
> 
> Changes since v2:
> - incorporate Doug's review feedback re coarse clocks and the use of pr_info
> - add Doug's ack to #1
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid/
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: David Laight <David.Laight@aculab.com>
> 
> Ard Biesheuvel (2):
>   crypto: xor - defer load time benchmark to a later time
>   crypto: xor - use ktime for template benchmarking
> 
>  crypto/xor.c | 67 +++++++++++++-------
>  1 file changed, 44 insertions(+), 23 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14F1393DBF
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhE1H1M (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:27:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50206 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhE1H1L (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:27:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWsA-0003Zj-HQ; Fri, 28 May 2021 15:25:34 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWsA-0001xI-By; Fri, 28 May 2021 15:25:34 +0800
Date:   Fri, 28 May 2021 15:25:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: remove leading spaces before tabs
Message-ID: <20210528072534.GD7392@gondor.apana.org.au>
References: <1621403984-40037-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621403984-40037-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 19, 2021 at 01:59:44PM +0800, Hui Tang wrote:
> There are a few leading spaces before tabs and remove it by running the
> following commard:
> 
> 	$ find . -name '*.c' | xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> At the same time, fix two warning by running checkpatch.pl:
> 	WARNING: suspect code indent for conditional statements (16, 16)
> 	WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  crypto/khazad.c |  2 +-
>  crypto/wp512.c  | 40 +++++++++++++++++++---------------------
>  2 files changed, 20 insertions(+), 22 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

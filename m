Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54D172DB6
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Feb 2020 01:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgB1Axo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Feb 2020 19:53:44 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55692 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbgB1Axo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Feb 2020 19:53:44 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1j7TuL-0000OA-KG; Fri, 28 Feb 2020 11:53:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Feb 2020 11:53:37 +1100
Date:   Fri, 28 Feb 2020 11:53:37 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: md5: remove unused macros
Message-ID: <20200228005337.GD9506@gondor.apana.org.au>
References: <20200221135515.14948-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221135515.14948-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Feb 21, 2020 at 09:55:15PM +0800, YueHaibing wrote:
> crypto/md5.c:26:0: warning: macro "MD5_DIGEST_WORDS" is not used [-Wunused-macros]
> crypto/md5.c:27:0: warning: macro "MD5_MESSAGE_BYTES" is not used [-Wunused-macros]
> 
> They are never used since commit 3c7eb3cc8360 ("md5: remove from
> lib and only live in crypto").
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  crypto/md5.c | 3 ---
>  1 file changed, 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

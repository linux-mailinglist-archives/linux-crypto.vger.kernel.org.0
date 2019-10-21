Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D710DE407
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Oct 2019 07:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfJUFqJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Oct 2019 01:46:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55420 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfJUFqJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Oct 2019 01:46:09 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iMQVz-0006Ej-AW; Mon, 21 Oct 2019 16:46:00 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 21 Oct 2019 16:45:59 +1100
Date:   Mon, 21 Oct 2019 16:45:59 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] crypto: zlib-deflate - add zlib-deflate test case in
 tcrypt
Message-ID: <20191021054559.GA32542@gondor.apana.org.au>
References: <1570695707-46528-1-git-send-email-wangzhou1@hisilicon.com>
 <20191018071424.GA16131@gondor.apana.org.au>
 <5DAD2D40.6000901@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DAD2D40.6000901@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 21, 2019 at 12:00:00PM +0800, Zhou Wang wrote:
>
> seems it can not work, when I run insmod tcrypt.ko alg="zlib-deflate" type=10 mask=15
> I got: insmod: can't insert 'tcrypt.ko': Resource temporarily unavailable

This error is intentional.  This is so that you can test again
without having to unload the module.

> crypto_has_alg in case 0 in do_test does find "zlib-deflate", however, it breaks and
> do nothing about test.

It doesn't have to do anything.  As long as it causes the algorithm
to be registered the crypto API will test it automatically.  So
after doing the modprobe, can you find the algorithm in /proc/crypto
and if so what does its test status say?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

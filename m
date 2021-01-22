Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00030008F
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Jan 2021 11:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhAVKoy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Jan 2021 05:44:54 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55326 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbhAVKlZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Jan 2021 05:41:25 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l2trf-0000Yq-8L; Fri, 22 Jan 2021 21:40:28 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jan 2021 21:40:27 +1100
Date:   Fri, 22 Jan 2021 21:40:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>
Subject: Re: [PATCH] crypto: marvell/cesa - Fix use of sg_pcopy on iomem
 pointer
Message-ID: <20210122104027.GA1935@gondor.apana.org.au>
References: <20210121051646.GA24114@gondor.apana.org.au>
 <20210122100203.uyurjtxjiier6257@SvensMacbookPro.hq.voleatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122100203.uyurjtxjiier6257@SvensMacbookPro.hq.voleatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 22, 2021 at 11:02:03AM +0100, Sven Auhagen wrote:
>
> Hi Herbert,
> 
> sorry, no luck on my armfh system with this patch:
> 
> [169999.310405] INFO: task cryptomgr_test:7698 blocked for more than 120 seconds.
> [169999.317669]       Tainted: G           OE     5.10.0-1-vtair-armmp #1 Debian 5.10.3-3~vtair
> [169999.326139] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.

Hi Sven:

Thanks for testing this!

Just to check the obvious you tested this on top of my other patch,
right?

https://patchwork.kernel.org/project/linux-crypto/patch/20210120054045.GA8539@gondor.apana.org.au/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

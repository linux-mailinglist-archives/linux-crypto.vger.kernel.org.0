Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102CE341B09
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Mar 2021 12:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCSLFb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Mar 2021 07:05:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60796 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhCSLEz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Mar 2021 07:04:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lNCvq-0008B2-Un; Fri, 19 Mar 2021 22:04:44 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Mar 2021 22:04:42 +1100
Date:   Fri, 19 Mar 2021 22:04:42 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Hadar Gat <hadar.gat@arm.com>, Matt Mackall <mpm@selenic.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: hw_random: delete redundant printing of return
 value
Message-ID: <20210319110442.GE8367@gondor.apana.org.au>
References: <1615621663-1948-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615621663-1948-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Mar 13, 2021 at 03:47:42PM +0800, Wang Qing wrote:
> platform_get_irq() has already checked and printed the return value, 
> the printing here is nothing special, it is not necessary at all.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/char/hw_random/cctrng.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

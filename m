Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE20545E777
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Nov 2021 06:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358725AbhKZFiF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Nov 2021 00:38:05 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57164 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343912AbhKZFgD (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Nov 2021 00:36:03 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mqTqs-0008S6-Lu; Fri, 26 Nov 2021 13:32:50 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mqTqs-0004au-Ib; Fri, 26 Nov 2021 13:32:50 +0800
Date:   Fri, 26 Nov 2021 13:32:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: DH - limit key size to 2048 in FIPS mode
Message-ID: <20211126053250.GH17477@gondor.apana.org.au>
References: <2564099.lGaqSPkdTl@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2564099.lGaqSPkdTl@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Nov 21, 2021 at 03:51:44PM +0100, Stephan M�ller wrote:
> FIPS disallows DH with keys < 2048 bits. Thus, the kernel should
> consider the enforcement of this limit.
> 
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/dh.c | 4 ++++
>  1 file changed, 4 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

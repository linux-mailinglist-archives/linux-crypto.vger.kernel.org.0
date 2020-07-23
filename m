Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3831E22B03B
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgGWNQp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 09:16:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35898 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbgGWNQp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 09:16:45 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyb5V-0005dd-VC; Thu, 23 Jul 2020 23:16:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 23:16:41 +1000
Date:   Thu, 23 Jul 2020 23:16:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        j-keerthy@ti.com
Subject: Re: [PATCH] crypto: sa2ul - Fix build warnings
Message-ID: <20200723131641.GA17133@gondor.apana.org.au>
References: <20200723074350.GA3233@gondor.apana.org.au>
 <4e5eee05-c956-448f-10ea-06102852e979@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5eee05-c956-448f-10ea-06102852e979@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 23, 2020 at 12:57:23PM +0300, Tero Kristo wrote:
> On 23/07/2020 10:43, Herbert Xu wrote:
> > This patch fixes a bunch of initialiser warnings.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Looks ok to me, however I never saw any build warnings with the code myself.
> Which compiler/version produces them?

You're right.  I was getting it due to an out-of-date version of
sparse.  Please disregard this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

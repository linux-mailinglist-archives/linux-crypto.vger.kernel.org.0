Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD46FA99D3
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 06:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIEExq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 00:53:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60508 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfIEExq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 00:53:46 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5jmA-0006Fh-6I; Thu, 05 Sep 2019 14:53:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Sep 2019 14:53:41 +1000
Date:   Thu, 5 Sep 2019 14:53:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net, pvanleeuwen@verimatrix.com
Subject: Re: [PATCH] crypto: inside-secure - Minor code cleanup and
 optimizations
Message-ID: <20190905045341.GA32247@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567150981-10853-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> Some minor cleanup changing e.g. "if (!x) A else B" to "if (x) B else A",
> merging some back-to-back if's with the same condition, collapsing some
> back-to-back assignments to the same variable and replacing some weird
> assignments with proper symbolics.
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
> drivers/crypto/inside-secure/safexcel_cipher.c | 86 ++++++++++++++------------
> 1 file changed, 47 insertions(+), 39 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

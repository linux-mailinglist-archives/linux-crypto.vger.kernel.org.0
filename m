Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C37AA99D1
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 06:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfIEExY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 00:53:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60488 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfIEExY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 00:53:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5jlp-0006FR-39; Thu, 05 Sep 2019 14:53:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Sep 2019 14:53:20 +1000
Date:   Thu, 5 Sep 2019 14:53:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net, pvanleeuwen@verimatrix.com
Subject: Re: [PATCH] crypto: inside-secure - Made .cra_priority value a define
Message-ID: <20190905045320.GA32164@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567150907-10741-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> Instead of having a fixed value (of 300) all over the place, the value for
> for .cra_priority is now made into a define (SAFEXCEL_CRA_PRIORITY).
> This makes it easier to play with, e.g. during development.
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
> drivers/crypto/inside-secure/safexcel.h        |  3 ++
> drivers/crypto/inside-secure/safexcel_cipher.c | 38 +++++++++++++-------------
> drivers/crypto/inside-secure/safexcel_hash.c   | 24 ++++++++--------
> 3 files changed, 34 insertions(+), 31 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

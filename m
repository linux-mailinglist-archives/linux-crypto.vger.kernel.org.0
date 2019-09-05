Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A97A99CF
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 06:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfIEExH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 00:53:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60480 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfIEExH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 00:53:07 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5jlY-0006FJ-I7; Thu, 05 Sep 2019 14:53:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Sep 2019 14:53:02 +1000
Date:   Thu, 5 Sep 2019 14:53:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net, pvanleeuwen@verimatrix.com
Subject: Re: [PATCH 0/3] crypto: inside-secure - Add AES-XTS cipher support
Message-ID: <20190905045302.GA32129@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567150854-10589-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> This patch adds support for the AES-XTS algorithm for HW that supports it.
> 
> Pascal van Leeuwen (3):
>  crypto: inside-secure - Move static cipher alg & mode settings to init
>  crypto: inside-secure - Add support for the AES-XTS algorithm
>  crypto: inside-secure - Only enable algorithms advertised by the
>    hardware
> 
> drivers/crypto/inside-secure/safexcel.c        |  37 ++-
> drivers/crypto/inside-secure/safexcel.h        |  35 +++
> drivers/crypto/inside-secure/safexcel_cipher.c | 401 +++++++++++++++----------
> drivers/crypto/inside-secure/safexcel_hash.c   |  12 +
> 4 files changed, 332 insertions(+), 153 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

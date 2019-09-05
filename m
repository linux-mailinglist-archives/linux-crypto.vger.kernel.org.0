Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C86A99D4
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 06:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfIEExw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 00:53:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60518 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfIEExw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 00:53:52 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5jmG-0006Fq-WB; Thu, 05 Sep 2019 14:53:50 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Sep 2019 14:53:48 +1000
Date:   Thu, 5 Sep 2019 14:53:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net, pvanleeuwen@verimatrix.com
Subject: Re: [PATCH 0/4] Add support for AES-GCM, AES-CFB, AES-OFB and AES-CCM
Message-ID: <20190905045348.GA32281@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567151553-11108-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> This patchset adds support for the AES-GCM and AES-CCM AEAD ciphersuites
> and the AES-CFB and AES-OFB feedback modes for AES.
> 
> Pascal van Leeuwen (4):
>  crypto: inside-secure - Added support for basic AES-GCM
>  crypto: inside-secure - Added AES-CFB support
>  crypto: inside-secure - Added AES-OFB support
>  crypto: inside-secure - Added support for basic AES-CCM
> 
> drivers/crypto/inside-secure/safexcel.c        |   4 +
> drivers/crypto/inside-secure/safexcel.h        |  19 +-
> drivers/crypto/inside-secure/safexcel_cipher.c | 508 ++++++++++++++++++++++---
> drivers/crypto/inside-secure/safexcel_ring.c   |   8 +-
> 4 files changed, 488 insertions(+), 51 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

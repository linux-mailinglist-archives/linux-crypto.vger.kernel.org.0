Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C026765D4
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jul 2019 14:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfGZMcl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jul 2019 08:32:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46424 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfGZMcl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jul 2019 08:32:41 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzOp-0003oK-CY; Fri, 26 Jul 2019 22:32:39 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzOn-00029I-Qc; Fri, 26 Jul 2019 22:32:37 +1000
Date:   Fri, 26 Jul 2019 22:32:37 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net, pvanleeuwen@verimatrix.com
Subject: Re: [PATCH 0/3] crypto: inside-secure - add more AEAD ciphersuites
Message-ID: <20190726123237.GA8253@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562309364-942-1-git-send-email-pvanleeuwen@verimatrix.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal van Leeuwen <pascalvanl@gmail.com> wrote:
> This patch set adds support for the following additional AEAD suites:
> - authenc(hmac(sha1),cbc(des3_ede))
> - authenc(hmac(sha1),rfc3686(ctr(aes)))
> - authenc(hmac(sha224),rfc3686(ctr(aes)))
> - authenc(hmac(sha256),rfc3686(ctr(aes)))
> - authenc(hmac(sha384),rfc3686(ctr(aes)))
> - authenc(hmac(sha512),rfc3686(ctr(aes)))
> 
> It has been verified on an FPGA devboard and Macchiatobin (Armada 8K)
> 
> Pascal van Leeuwen (3):
>  crypto: inside-secure - add support for
>    authenc(hmac(sha1),cbc(des3_ede))
>  crypto: inside-secure - added support for rfc3686(ctr(aes))
>  crypto: inside-secure - add support for
>    authenc(hmac(sha*),rfc3686(ctr(aes))) suites
> 
> drivers/crypto/inside-secure/safexcel.c        |  30 +-
> drivers/crypto/inside-secure/safexcel.h        |  38 +--
> drivers/crypto/inside-secure/safexcel_cipher.c | 456 ++++++++++++++++++++++---
> 3 files changed, 428 insertions(+), 96 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

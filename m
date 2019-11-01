Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A9EBD8C
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 07:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfKAGHH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 02:07:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37478 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbfKAGHH (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:07:07 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQ5S-0001rc-GJ; Fri, 01 Nov 2019 14:07:06 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQ5R-0004p4-Jn; Fri, 01 Nov 2019 14:07:05 +0800
Date:   Fri, 1 Nov 2019 14:07:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH] crypto: inside-secure - Fixed warnings on inconsistent
 byte order handling
Message-ID: <20191101060705.inuebiukpfrx4ndd@gondor.apana.org.au>
References: <1571734903-24443-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571734903-24443-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 22, 2019 at 11:01:43AM +0200, Pascal van Leeuwen wrote:
> This fixes a bunch of endianness related sparse warnings reported by the
> kbuild test robot as well as Ben Dooks.
> 
> Credits for the fix to safexcel.c go to Ben Dooks.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
>  drivers/crypto/inside-secure/safexcel.c        |  5 +-
>  drivers/crypto/inside-secure/safexcel.h        |  4 +-
>  drivers/crypto/inside-secure/safexcel_cipher.c | 88 ++++++++++++--------------
>  drivers/crypto/inside-secure/safexcel_hash.c   | 31 +++++----
>  4 files changed, 61 insertions(+), 67 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

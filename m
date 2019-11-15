Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC70FD5B9
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfKOGGV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:06:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57866 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKOGGV (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:06:21 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUkO-0004iq-5M; Fri, 15 Nov 2019 14:06:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUkM-000663-ET; Fri, 15 Nov 2019 14:06:18 +0800
Date:   Fri, 15 Nov 2019 14:06:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCH] crypto: inside-secure - Fix hangup during probing for
 EIP97 engine
Message-ID: <20191115060618.ircolgczknt25lzy@gondor.apana.org.au>
References: <1573053187-8342-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573053187-8342-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 06, 2019 at 04:13:07PM +0100, Pascal van Leeuwen wrote:
> Fixed mask used for CFSIZE and RFSIZE fields of HIA_OPTIONS register,
> these were all 1 bit too wide. Which caused the probing of a standard
> EIP97 to actually hang due to assume way too large descriptor FIFO's.
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
>  drivers/crypto/inside-secure/safexcel.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

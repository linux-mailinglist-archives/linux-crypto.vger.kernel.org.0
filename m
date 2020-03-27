Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1808919502D
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2020 05:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgC0EyQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Mar 2020 00:54:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57054 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgC0EyQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Mar 2020 00:54:16 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jHh0T-0000BP-L3; Fri, 27 Mar 2020 15:54:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2020 15:54:09 +1100
Date:   Fri, 27 Mar 2020 15:54:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, manojmalviya@chelsio.com
Subject: Re: [PATCH Crypto 0/2] Fixes issues during driver registration
Message-ID: <20200327045409.GA19912@gondor.apana.org.au>
References: <20200316060318.20896-1-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316060318.20896-1-ayush.sawal@chelsio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Mar 16, 2020 at 11:33:16AM +0530, Ayush Sawal wrote:
> Patch 1: Avoid the accessing of wrong u_ctx pointer.
> Patch 2: Fixes a deadlock between rtnl_lock and uld_mutex.
> 
> Ayush Sawal (2):
>   chcr: Fixes a hang issue during driver registration
>   chcr: Fixes a deadlock between rtnl_lock and uld_mutex
> 
>  drivers/crypto/chelsio/chcr_core.c  | 34 +++++++++++++++++++++++------
>  drivers/crypto/chelsio/chcr_ipsec.c |  2 --
>  2 files changed, 27 insertions(+), 9 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

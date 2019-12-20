Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2890912763A
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Dec 2019 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTHHz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Dec 2019 02:07:55 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58932 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLTHHy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Dec 2019 02:07:54 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iiCO9-00006R-Aw; Fri, 20 Dec 2019 15:07:53 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iiCO8-0007rd-W0; Fri, 20 Dec 2019 15:07:53 +0800
Date:   Fri, 20 Dec 2019 15:07:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, atul.gupta@chelsio.com
Subject: Re: [Crypto/chcr] calculating tx_channel_id as per the max number of
 channels
Message-ID: <20191220070752.amn3hbd5gzy55kyq@gondor.apana.org.au>
References: <1576237132-15580-1-git-send-email-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576237132-15580-1-git-send-email-ayush.sawal@chelsio.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 13, 2019 at 05:08:52PM +0530, Ayush Sawal wrote:
> chcr driver was not using the number of channels from lld and
> assuming that there are always two channels available. With following
> patch chcr will use number of channel as passed by cxgb4.
> 
> Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
> ---
>  drivers/crypto/chelsio/chcr_algo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

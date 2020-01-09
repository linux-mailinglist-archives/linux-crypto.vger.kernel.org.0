Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16716135284
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jan 2020 06:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgAIFPZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jan 2020 00:15:25 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:40460 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgAIFPZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jan 2020 00:15:25 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ipQAG-0003NM-Av; Thu, 09 Jan 2020 13:15:24 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ipQAF-0003YK-Ez; Thu, 09 Jan 2020 13:15:23 +0800
Date:   Thu, 9 Jan 2020 13:15:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [Crypto/chcr] Resetting crypto counters during the driver
 unregister
Message-ID: <20200109051523.rdhouof6cmien4hf@gondor.apana.org.au>
References: <1578027411-32239-1-git-send-email-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578027411-32239-1-git-send-email-ayush.sawal@chelsio.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 03, 2020 at 10:26:51AM +0530, Ayush Sawal wrote:
> Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
> ---
>  drivers/crypto/chelsio/chcr_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0302FD5B7
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfKOGGE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:06:04 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57832 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfKOGGE (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:06:04 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUk6-0004fr-Vs; Fri, 15 Nov 2019 14:06:03 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUk5-00065b-G6; Fri, 15 Nov 2019 14:06:01 +0800
Date:   Fri, 15 Nov 2019 14:06:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tian Tao <tiantao6@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] crypto: tgr192 remove unneeded semicolon
Message-ID: <20191115060601.orbexwqynttjeygh@gondor.apana.org.au>
References: <1573001621-58594-1-git-send-email-tiantao6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573001621-58594-1-git-send-email-tiantao6@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 06, 2019 at 08:53:41AM +0800, Tian Tao wrote:
> Fix the warning below.
> ./crypto/tgr192.c:558:43-44: Unneeded semicolon
> ./crypto/tgr192.c:586:44-45: Unneeded semicolon
> 
> Fixes: f63fbd3d501b ("crypto: tgr192 - Switch to shash")
> 
> Signed-off-by: Tian Tao <tiantao6@huawei.com>
> ---
>  crypto/tgr192.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

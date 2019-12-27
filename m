Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E512B3F1
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Dec 2019 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfL0KhD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Dec 2019 05:37:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60174 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfL0KhD (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Dec 2019 05:37:03 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ikmzM-0007Jr-7O; Fri, 27 Dec 2019 18:37:00 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ikmzL-0005lS-4O; Fri, 27 Dec 2019 18:36:59 +0800
Date:   Fri, 27 Dec 2019 18:36:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: remove unneeded semicolon
Message-ID: <20191227103658.2ygest57fxtijele@gondor.apana.org.au>
References: <20191216105848.10669-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216105848.10669-1-chenzhou10@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 16, 2019 at 06:58:48PM +0800, Chen Zhou wrote:
> Fixes coccicheck warning:
> 
> ./include/linux/crypto.h:573:2-3: Unneeded semicolon
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  include/linux/crypto.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

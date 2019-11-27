Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A392D10A9D9
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Nov 2019 06:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfK0FMn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Nov 2019 00:12:43 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42046 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfK0FMn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Nov 2019 00:12:43 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iZpcx-0002y0-KE; Wed, 27 Nov 2019 13:12:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iZpct-0001mD-Oc; Wed, 27 Nov 2019 13:12:31 +0800
Date:   Wed, 27 Nov 2019 13:12:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Zaibo Xu <xuzaibo@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Longfang Liu <liulongfang@huawei.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - fix a NULL vs IS_ERR() bug in
 sec_create_qp_ctx()
Message-ID: <20191127051231.a3i34iawq666rbwc@gondor.apana.org.au>
References: <20191126122120.vnf6mxmvf25ppyeo@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126122120.vnf6mxmvf25ppyeo@kili.mountain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 26, 2019 at 03:21:20PM +0300, Dan Carpenter wrote:
> The hisi_acc_create_sgl_pool() function returns error pointers, it never
> returns NULL pointers.
> 
> Fixes: 416d82204df4 ("crypto: hisilicon - add HiSilicon SEC V2 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

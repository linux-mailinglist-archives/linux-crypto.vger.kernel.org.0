Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E845FD5BC
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOGG2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:06:28 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57874 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKOGG2 (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:06:28 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUkV-0004jM-Kq; Fri, 15 Nov 2019 14:06:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUkV-00066H-HA; Fri, 15 Nov 2019 14:06:27 +0800
Date:   Fri, 15 Nov 2019 14:06:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] crypto: hisilicon - add vfs_num module param for zip
Message-ID: <20191115060627.mvbxgil3py3p3ls5@gondor.apana.org.au>
References: <1573098509-72682-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573098509-72682-1-git-send-email-fanghao11@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Nov 07, 2019 at 11:48:29AM +0800, Hao Fang wrote:
> Currently the VF can be enabled only through sysfs interface
> after module loaded, but this also needs to be done when the
> module loaded in some scenarios.
> 
> This patch adds module param vfs_num, adds hisi_zip_sriov_enable()
> in probe, and also adjusts the position of probe.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 182 +++++++++++++++++---------------
>  1 file changed, 98 insertions(+), 84 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

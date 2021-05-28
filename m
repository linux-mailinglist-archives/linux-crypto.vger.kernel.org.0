Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA28C393DE3
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhE1H3f (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:29:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50364 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236018AbhE1H3b (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:29:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWuS-0003kR-1v; Fri, 28 May 2021 15:27:56 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWuR-00021Y-Sc; Fri, 28 May 2021 15:27:55 +0800
Date:   Fri, 28 May 2021 15:27:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 0/2] crypto: hisilicon/qm - add dfx log and a bugfix
Message-ID: <20210528072755.GO7392@gondor.apana.org.au>
References: <1621591364-46526-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621591364-46526-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 21, 2021 at 06:02:42PM +0800, Kai Ye wrote:
> This patchset adds the dfx log and fixes an algorithm registration bug.
> 
> changes v1->v2:
> modify the patchset commits
> 
> Kai Ye (2):
>   crypto: hisilicon/qm - add dfx log if not use hardware crypto algs
>   crypto: hisilicon/qm - fix the process of VF's list adding
> 
>  drivers/crypto/hisilicon/qm.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

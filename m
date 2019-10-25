Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C65E5017
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2019 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440708AbfJYP04 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Oct 2019 11:26:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36074 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440654AbfJYP0z (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 25 Oct 2019 11:26:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iO1UK-0001uJ-3E; Fri, 25 Oct 2019 23:26:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iO1UI-0007uG-DM; Fri, 25 Oct 2019 23:26:50 +0800
Date:   Fri, 25 Oct 2019 23:26:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, wangzhou1@hisilicon.com,
        linux-crypto@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 0/4] Misc fixes and optimisation patch
Message-ID: <20191025152650.szpwc72elsrvy7m5@gondor.apana.org.au>
References: <1571643663-29593-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571643663-29593-1-git-send-email-tanshukun1@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 21, 2019 at 03:40:59PM +0800, Shukun Tan wrote:
> This series mainly fix sparse warnings, optimise the code to be more concise.
> 
> Shukun Tan (3):
>   crypto: hisilicon - Fix using plain integer as NULL pointer
>   crypto: hisilicon - fix param should be static when not external.
>   crypto: hisilicon - fix endianness verification problem of QM
> 
> Zhou Wang (1):
>   crypto: hisilicon - tiny fix about QM/ZIP error callback print
> 
>  drivers/crypto/hisilicon/qm.c             | 96 +++++++++++++++----------------
>  drivers/crypto/hisilicon/qm.h             |  2 +-
>  drivers/crypto/hisilicon/zip/zip_crypto.c |  2 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   |  9 ++-
>  4 files changed, 52 insertions(+), 57 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

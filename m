Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326D1393D83
	for <lists+linux-crypto@lfdr.de>; Fri, 28 May 2021 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhE1HMF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 May 2021 03:12:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49906 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234999AbhE1HME (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 May 2021 03:12:04 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lmWdY-0003NN-RA; Fri, 28 May 2021 15:10:28 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lmWdV-0007Ru-Qg; Fri, 28 May 2021 15:10:25 +0800
Date:   Fri, 28 May 2021 15:10:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 2/2] crypto: hisilicon/sec - driver adapt to new SQE
Message-ID: <20210528071025.GB22601@gondor.apana.org.au>
References: <1621249800-11582-1-git-send-email-yekai13@huawei.com>
 <1621249800-11582-3-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621249800-11582-3-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 17, 2021 at 07:10:00PM +0800, Kai Ye wrote:
> Due to Kunpeng930 adds new SQE data structure, the SEC driver needs
> to be upgraded. It mainly includes bd parsing process and bd filling
> process.
> 
> Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec.h        |   1 +
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 291 ++++++++++++++++++++++++-----

This triggers two sparse warnings.  Please fix.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

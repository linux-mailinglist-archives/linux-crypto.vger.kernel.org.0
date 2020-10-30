Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2029FE08
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Oct 2020 07:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgJ3Guy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Oct 2020 02:50:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60522 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgJ3Guy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Oct 2020 02:50:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kYOFQ-0004ts-46; Fri, 30 Oct 2020 17:50:53 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Oct 2020 17:50:52 +1100
Date:   Fri, 30 Oct 2020 17:50:52 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: hisilicon - misc fixes
Message-ID: <20201030065051.GG25453@gondor.apana.org.au>
References: <1602728584-47722-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602728584-47722-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 15, 2020 at 10:23:02AM +0800, Longfang Liu wrote:
> This patchset fixes some coding style.
> 
> Longfang Liu (2):
>   crypto: hisilicon - delete unused structure member variables
>   crypto: hisilicon - fixes some coding style
> 
>  drivers/crypto/hisilicon/sec2/sec.h        |  2 --
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 17 ++++++-----------
>  drivers/crypto/hisilicon/sec2/sec_main.c   | 30 ++++++++++++------------------
>  3 files changed, 18 insertions(+), 31 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

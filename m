Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32CC3084E8
	for <lists+linux-crypto@lfdr.de>; Fri, 29 Jan 2021 06:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhA2FLd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 Jan 2021 00:11:33 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55892 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhA2FL1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 Jan 2021 00:11:27 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l5M2z-0002AJ-6m; Fri, 29 Jan 2021 16:10:18 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Jan 2021 16:10:17 +1100
Date:   Fri, 29 Jan 2021 16:10:17 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - delete ECC 1bit error reported
 threshold
Message-ID: <20210129051016.GA12070@gondor.apana.org.au>
References: <1610957740-2989-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610957740-2989-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 18, 2021 at 04:15:40PM +0800, Hui Tang wrote:
> Delete 'HPRE_RAS_ECC1BIT_TH' register setting of hpre,
> since register 'QM_RAS_CE_THRESHOLD' of qm has done this work.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

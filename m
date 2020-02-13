Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87615BB70
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Feb 2020 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgBMJR1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Feb 2020 04:17:27 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42168 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgBMJR1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Feb 2020 04:17:27 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2Acg-00047N-E1; Thu, 13 Feb 2020 17:17:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2Acg-0006kd-6e; Thu, 13 Feb 2020 17:17:26 +0800
Date:   Thu, 13 Feb 2020 17:17:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH 0/4] crypto: hisilicon: Unify hardware error handle
 process
Message-ID: <20200213091726.vnjg2nyqjtkrrody@gondor.apana.org.au>
References: <1579505409-3776-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579505409-3776-1-git-send-email-tanshukun1@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 20, 2020 at 03:30:05PM +0800, Shukun Tan wrote:
> ZIP/HPRE/SEC hardware error handle process has great similarities, unify
> the essential error handle process looks necessary. We mainly unify error
> init/uninit and error detect process in this patch set.
> 
> We also add the configure of ZIP RAS error and fix qm log error bug.
> 
> Shukun Tan (4):
>   crypto: hisilicon: Unify hardware error init/uninit into QM
>   crypto: hisilicon: Configure zip RAS error type
>   crypto: hisilicon: Unify error detect process into qm
>   crypto: hisilicon: Fix duplicate print when qm occur multiple errors
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 108 +++++----------
>  drivers/crypto/hisilicon/qm.c             | 216 +++++++++++++++++++++---------
>  drivers/crypto/hisilicon/qm.h             |  25 +++-
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 162 ++++++++--------------
>  drivers/crypto/hisilicon/zip/zip_main.c   | 183 +++++++++++--------------
>  5 files changed, 346 insertions(+), 348 deletions(-)

All applid.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

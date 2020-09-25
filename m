Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836B127824E
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Sep 2020 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgIYILn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Sep 2020 04:11:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53200 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgIYILm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Sep 2020 04:11:42 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLipI-00072l-Fz; Fri, 25 Sep 2020 18:11:33 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:11:32 +1000
Date:   Fri, 25 Sep 2020 18:11:32 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: qat - convert to use DEFINE_SEQ_ATTRIBUTE
 macro
Message-ID: <20200925081132.GD6381@gondor.apana.org.au>
References: <20200916025017.3992367-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916025017.3992367-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 16, 2020 at 10:50:17AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/crypto/qat/qat_common/adf_cfg.c       | 19 +--------
>  .../qat/qat_common/adf_transport_debug.c      | 42 ++-----------------
>  2 files changed, 5 insertions(+), 56 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

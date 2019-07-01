Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9627632
	for <lists+linux-crypto@lfdr.de>; Thu, 23 May 2019 08:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfEWGuU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 May 2019 02:50:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47742 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWGuU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 May 2019 02:50:20 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hThYQ-0001kl-Tx; Thu, 23 May 2019 14:50:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hThYN-00069q-8y; Thu, 23 May 2019 14:50:15 +0800
Date:   Thu, 23 May 2019 14:50:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, Xin Zeng <xin.zeng@intel.com>,
        Conor Mcloughlin <conor.mcloughlin@intel.com>,
        Sergey Portnoy <sergey.portnoy@intel.com>
Subject: Re: [PATCH 1/7] crypto: qat - remove spin_lock in
 qat_ablkcipher_setkey
Message-ID: <20190523065015.xsnddpcrhdmsphee@gondor.apana.org.au>
References: <20190429154321.21098-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429154321.21098-1-giovanni.cabiddu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Apr 29, 2019 at 04:43:15PM +0100, Giovanni Cabiddu wrote:
> From: Xin Zeng <xin.zeng@intel.com>
> 
> Remove unnecessary spin lock in qat_ablkcipher_setkey.
> 
> Reviewed-by: Conor Mcloughlin <conor.mcloughlin@intel.com>
> Tested-by: Sergey Portnoy <sergey.portnoy@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/qat/qat_common/qat_algs.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

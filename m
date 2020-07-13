Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF98219807
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2020 07:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgGIFg3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jul 2020 01:36:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34830 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgGIFg3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jul 2020 01:36:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtPEJ-0004jF-5c; Thu, 09 Jul 2020 15:36:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 15:36:19 +1000
Date:   Thu, 9 Jul 2020 15:36:19 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [Patch v2 8/9] crypto: hisilicon/qm - fix the process of
 register algorithms to crypto
Message-ID: <20200709053619.GA5637@gondor.apana.org.au>
References: <1593587995-7391-1-git-send-email-shenyang39@huawei.com>
 <1593587995-7391-9-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593587995-7391-9-git-send-email-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 01, 2020 at 03:19:54PM +0800, Yang Shen wrote:
> When the devices are removed or not existing, the corresponding algorithms
> which are registered by 'hisi-zip' driver can't be used.
> 
> Move 'hisi_zip_register_to_crypto' from 'hisi_zip_init' to
> 'hisi_zip_probe'. The algorithms will be registered to crypto only when
> there is device bind on the driver. And when the devices are removed,
> the algorithms will be unregistered.

You can't just unregister a live algorithm because if someone
holds a reference count on it then the Crypto API will crash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

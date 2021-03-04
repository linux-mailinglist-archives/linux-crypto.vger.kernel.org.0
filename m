Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2664D32CB59
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 05:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhCDE0Q (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Mar 2021 23:26:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47516 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233414AbhCDEZz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Mar 2021 23:25:55 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHfXb-0005pM-Tc; Thu, 04 Mar 2021 15:24:49 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Mar 2021 15:24:47 +1100
Date:   Thu, 4 Mar 2021 15:24:47 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     clabbe.montjoie@gmail.com, clabbe@baylibre.com,
        gcherian@marvell.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linuxarm@openeuler.org,
        prime.zeng@huawei.com
Subject: Re: [PATCH 2/4] crypto: cavium - Fix the parameter of dma_unmap_sg()
Message-ID: <20210304042447.GA25578@gondor.apana.org.au>
References: <1612853965-67777-1-git-send-email-chenxiang66@hisilicon.com>
 <1612853965-67777-3-git-send-email-chenxiang66@hisilicon.com>
 <20210303085907.GA8134@gondor.apana.org.au>
 <e70ae2a0-9b96-ed86-c7fe-8410965342f5@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e70ae2a0-9b96-ed86-c7fe-8410965342f5@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 04, 2021 at 10:18:51AM +0800, chenxiang (M) wrote:
>
> Thank you for reminding me about this. I didn't notice that it changes the
> count passed to create_sg_component.
> I have a change on this patch as follows, and please have a check on it:

Yes this looks fine.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

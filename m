Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0C3E2627
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Aug 2021 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhHFIck (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Aug 2021 04:32:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51746 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235706AbhHFIck (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Aug 2021 04:32:40 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mBvHD-0007OM-R0; Fri, 06 Aug 2021 16:32:23 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mBvHD-0003Qi-OI; Fri, 06 Aug 2021 16:32:23 +0800
Date:   Fri, 6 Aug 2021 16:32:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 3/5] crypto: hisilicon/sec - fix the max length of AAD
 for the CCM mode
Message-ID: <20210806083223.GB13132@gondor.apana.org.au>
References: <1627701996-4589-1-git-send-email-yekai13@huawei.com>
 <1627701996-4589-4-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627701996-4589-4-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jul 31, 2021 at 11:26:34AM +0800, Kai Ye wrote:
>
> @@ -2218,6 +2219,10 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
>  	}
>  
>  	if (c_mode == SEC_CMODE_CCM) {
> +		if (unlikely(req->assoclen > SEC_MAX_CCM_AAD_LEN)) {
> +			dev_err(dev, "CCM input aad parameter is too long!\n");
> +			return -EINVAL;
> +		}

You shouldn't be printing messages on a code path that can be
triggered by userspace without rate limit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC5F4F57
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKHPVD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 10:21:03 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58026 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfKHPVC (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 8 Nov 2019 10:21:02 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iT64I-0007JU-JV; Fri, 08 Nov 2019 23:20:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iT64H-00079u-Qd; Fri, 08 Nov 2019 23:20:57 +0800
Date:   Fri, 8 Nov 2019 23:20:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - replace #ifdef with IS_ENABLED for
 CONFIG_NUMA
Message-ID: <20191108152057.gqmw43zxhh3eiuh7@gondor.apana.org.au>
References: <1572610909-91857-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572610909-91857-1-git-send-email-wangzhou1@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 01, 2019 at 08:21:49PM +0800, Zhou Wang wrote:
> Replace #ifdef CONFIG_NUMA with IS_ENABLED(CONFIG_NUMA) to fix kbuild error.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 51 ++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 26 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

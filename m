Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4AD2221B8
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgGPLx3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 07:53:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40042 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPLx2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 07:53:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jw2S2-0008JL-Fc; Thu, 16 Jul 2020 21:53:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 21:53:22 +1000
Date:   Thu, 16 Jul 2020 21:53:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/5] crypto: hisilicon/sec2 - fix SEC bugs and coding
 styles
Message-ID: <20200716115322.GA31166@gondor.apana.org.au>
References: <1594084541-22177-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594084541-22177-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 07, 2020 at 09:15:36AM +0800, Longfang Liu wrote:
> Fix some SEC driver bugs and modify some coding styles
> 
> Changes v1 -> v2:
> 	- Apply MAY_BACKLOG.
> 
> Kai Ye (2):
>   crypto: hisilicon/sec2 - clear SEC debug regs
>   crypto:hisilicon/sec2 - update busy processing logic
> 
> Longfang Liu (3):
>   crypto: hisilicon/sec2 - update SEC initialization and reset
>   crypto: hisilicon/sec2 - update debugfs interface parameters
>   crypto: hisilicon/sec2 - fix some coding styles
> 
>  drivers/crypto/hisilicon/qm.h              |   1 +
>  drivers/crypto/hisilicon/sec2/sec.h        |   4 +
>  drivers/crypto/hisilicon/sec2/sec_crypto.c |  91 +++++++++++++++------
>  drivers/crypto/hisilicon/sec2/sec_main.c   | 126 +++++++++++++++--------------
>  4 files changed, 138 insertions(+), 84 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

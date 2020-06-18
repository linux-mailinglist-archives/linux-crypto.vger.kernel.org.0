Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6811FED09
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2020 09:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFRH5a (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jun 2020 03:57:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60468 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgFRH53 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jun 2020 03:57:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jlpQN-00029w-0s; Thu, 18 Jun 2020 17:57:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 17:57:26 +1000
Date:   Thu, 18 Jun 2020 17:57:26 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linuxarm@huawei.com,
        kong.kongxinwei@hisilicon.com, ike.pan@canonical.com
Subject: Re: [PATCH] crypto: hisilicon - update SEC driver module parameter
Message-ID: <20200618075726.GG10091@gondor.apana.org.au>
References: <1591624871-49173-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591624871-49173-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 08, 2020 at 10:01:11PM +0800, Longfang Liu wrote:
> As stress-ng running SEC engine on the Ubuntu OS,
> we found that SEC only supports two threads each with one TFM
> based on the default module parameter 'ctx_q_num'.
> If running more threads, stress-ng will fail since it cannot
> get more TFMs.
> 
> In order to fix this, we adjusted the default values
> of the module parameters to support more TFMs.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

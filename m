Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC68234119
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGaIUd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 04:20:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39968 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgGaIUd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 04:20:33 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1QHG-0002Mf-HZ; Fri, 31 Jul 2020 18:20:31 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 18:20:30 +1000
Date:   Fri, 31 Jul 2020 18:20:30 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "shenyang (M)" <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v3 08/10] crypto: hisilicon/qm - fix the process of
 register algorithms to crypto
Message-ID: <20200731082030.GA21715@gondor.apana.org.au>
References: <1595488780-22085-1-git-send-email-shenyang39@huawei.com>
 <1595488780-22085-9-git-send-email-shenyang39@huawei.com>
 <20200731075722.GA20350@gondor.apana.org.au>
 <79b37e17-8eb6-b89b-d49f-46a3faf2783a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b37e17-8eb6-b89b-d49f-46a3faf2783a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 31, 2020 at 04:15:41PM +0800, shenyang (M) wrote:
>
> Here if the user alloc a tfm of the algorithm the driver registers,
> the function 'hisi_qm_wait_task_finish' which be added in patch 10 will
> stop to remove the driver until the tfm is freed.

1. You don't introduce a bug in patch 8 only to fix it in patch 10.
   Lay the groundwork first before you rely on it.

2. You need to explain how the wait fixes the problem of unregistering
   an algorithm under a live tfm.  Can you even do a wait at all
   in the face of a PCI unbind? What happens when the device reappears?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

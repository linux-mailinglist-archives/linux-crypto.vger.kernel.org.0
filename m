Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625B834A488
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCZJec (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:34:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35514 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhCZJeA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:34:00 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPiqr-0003aw-Hz; Fri, 26 Mar 2021 20:33:58 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:33:57 +1100
Date:   Fri, 26 Mar 2021 20:33:57 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/4] crypto: hisilicon/qm - support doorbell isolation
 and queue number configuration
Message-ID: <20210326093357.GO12658@gondor.apana.org.au>
References: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Mar 20, 2021 at 07:27:42PM +0800, Weili Qian wrote:
> Kunpeng930 supports getting the number of queues from hardware registers
> and queue doorbell isolation.
> 
> This patchset configures the total number of hardware queues and the
> maximum number of function queues, and supports queue doorbell isolation.
> 
> Weili Qian (4):
>   crypto: hisilicon/qm - set the total number of queues
>   crypto: hisilicon/qm - move 'CURRENT_QM' code to qm.c
>   crypto: hisilicon/qm - set the number of queues for function
>   crypto: hisilicon/qm - add queue isolation support for Kunpeng 930
> 
>  drivers/crypto/hisilicon/hpre/hpre.h      |   1 -
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  64 ------
>  drivers/crypto/hisilicon/qm.c             | 332 +++++++++++++++++++++++-------
>  drivers/crypto/hisilicon/qm.h             |  17 +-
>  drivers/crypto/hisilicon/sec2/sec.h       |   1 -
>  drivers/crypto/hisilicon/sec2/sec_main.c  |  65 +-----
>  drivers/crypto/hisilicon/zip/zip_main.c   |  65 +-----
>  include/uapi/misc/uacce/hisi_qm.h         |   1 +
>  8 files changed, 272 insertions(+), 274 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

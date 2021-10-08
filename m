Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9B426988
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Oct 2021 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbhJHLjN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Oct 2021 07:39:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55908 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241068AbhJHLhn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Oct 2021 07:37:43 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mYoAC-0002Vd-MZ; Fri, 08 Oct 2021 19:35:44 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mYoAB-0006z4-6F; Fri, 08 Oct 2021 19:35:43 +0800
Date:   Fri, 8 Oct 2021 19:35:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] crypto: hisilicon - replace 'smp_processor_id' with
 'get_cpu' in preemptible
Message-ID: <20211008113543.GB26495@gondor.apana.org.au>
References: <20210930085546.54000-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930085546.54000-1-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 30, 2021 at 04:55:46PM +0800, Kai Ye wrote:
>
> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
> index 65a641396c07..d1754e7b7a9c 100644
> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> @@ -277,10 +277,11 @@ static inline int hpre_cluster_core_mask(struct hisi_qm *qm)
>  
>  struct hisi_qp *hpre_create_qp(u8 type)
>  {
> -	int node = cpu_to_node(smp_processor_id());
> +	int node = cpu_to_node(get_cpu());
>  	struct hisi_qp *qp = NULL;
>  	int ret;
>  
> +	put_cpu();

This looks wrong.  You're just changing the code to make the warning
go away.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

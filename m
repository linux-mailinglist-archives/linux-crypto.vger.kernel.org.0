Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09D9338E7F
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Mar 2021 14:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhCLNOV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Mar 2021 08:14:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54552 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhCLNOT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Mar 2021 08:14:19 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhc3-0006Jb-Mg; Sat, 13 Mar 2021 00:13:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:13:55 +1100
Date:   Sat, 13 Mar 2021 00:13:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, marco.chiappero@intel.com,
        ebiggers@google.com, tomaszx.kowalik@intel.com,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] crypto: qat - fixes related to 'dma_map_single'
Message-ID: <20210312131355.GJ31502@gondor.apana.org.au>
References: <1614926102-44388-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614926102-44388-1-git-send-email-tanghui20@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 05, 2021 at 02:35:00PM +0800, Hui Tang wrote:
> This patchset fix bugs related to 'dma_map_single' use:
> 
> Hui Tang (2):
>   crypto: qat - fix 'dma_unmap_single' invalid address
>   crypto: qat - fix use of 'dma_map_single'
> 
> 
> v1 -> v2:
> 	1.fix build warning reported by kernel test rebot
> 	2.add patch #1
> 
>  drivers/crypto/qat/qat_common/qat_algs.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

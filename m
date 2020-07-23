Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE89622A99C
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGWHZl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:25:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34464 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGWHZk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:25:40 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyVbL-0005NT-MS; Thu, 23 Jul 2020 17:25:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:25:11 +1000
Date:   Thu, 23 Jul 2020 17:25:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     miaoqinglang@huawei.com, gregkh@linuxfoundation.org,
        aymen.sghaier@nxp.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: caam: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200723072511.GA6095@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00ab6498-a1cb-afb2-b1e4-75389bfbbd4c@nxp.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Horia Geantă <horia.geanta@nxp.com> wrote:
> On 7/16/2020 12:00 PM, Qinglang Miao wrote:
>> From: Liu Shixin <liushixin2@huawei.com>
>> 
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>> 
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> 
> This patch depends on linux-next
> commit 4d4901c6d748 ("seq_file: switch over direct seq_read method calls to seq_read_iter")

Please postpone these cleanups until that patch hits mainline.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

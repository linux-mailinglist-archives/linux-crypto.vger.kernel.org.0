Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE62F62F0DA
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Nov 2022 10:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbiKRJSW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Nov 2022 04:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiKRJRr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Nov 2022 04:17:47 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC8942F2
        for <linux-crypto@vger.kernel.org>; Fri, 18 Nov 2022 01:17:25 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ovxUw-00FYZS-SE; Fri, 18 Nov 2022 17:17:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Nov 2022 17:17:22 +0800
Date:   Fri, 18 Nov 2022 17:17:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     qianweili@huawei.com, wangzhou1@hisilicon.com,
        linux-crypto@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/qm - add missing pci_dev_put() in
 q_num_set()
Message-ID: <Y3dNomp8BkDTowmq@gondor.apana.org.au>
References: <20221111100036.129685-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111100036.129685-1-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 11, 2022 at 06:00:36PM +0800, Xiongfeng Wang wrote:
> pci_get_device() will increase the reference count for the returned
> pci_dev. We need to use pci_dev_put() to decrease the reference count
> before q_num_set() returns.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  include/linux/hisi_acc_qm.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19599F4EA1
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKHOq3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 09:46:29 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56468 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKHOq3 (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 8 Nov 2019 09:46:29 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iT5Wt-0006gp-LF; Fri, 08 Nov 2019 22:46:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iT5Wo-00043S-Ml; Fri, 08 Nov 2019 22:46:22 +0800
Date:   Fri, 8 Nov 2019 22:46:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zaibo Xu <xuzaibo@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        jonathan.cameron@huawei.com, liulongfang@huawei.com,
        wangzhou1@hisilicon.com, linuxarm@huawei.com,
        zhangwei375@huawei.com, yekai13@huawei.com,
        forest.zhouchang@huawei.com
Subject: Re: [PATCH 4/5] crypto: hisilicon - add DebugFS for HiSilicon SEC
Message-ID: <20191108144622.d32akww5g2ag6kql@gondor.apana.org.au>
References: <1572507330-34502-1-git-send-email-xuzaibo@huawei.com>
 <1572507330-34502-5-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572507330-34502-5-git-send-email-xuzaibo@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 31, 2019 at 03:35:29PM +0800, Zaibo Xu wrote:
>
> +	tmp_d = debugfs_create_dir("sec_dfx", sec->qm.debug.debug_root);

Please update this patch according to Greg's fix to hisilicon:

	https://patchwork.kernel.org/patch/11232313/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

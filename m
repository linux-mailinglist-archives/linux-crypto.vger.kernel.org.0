Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72BA213321
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2020 06:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgGCEtw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Jul 2020 00:49:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40268 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCEtw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Jul 2020 00:49:52 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jrDdn-00085I-43; Fri, 03 Jul 2020 14:49:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2020 14:49:35 +1000
Date:   Fri, 3 Jul 2020 14:49:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     wangzhou1@hisilicon.com, tony.luck@intel.com, ashok.raj@intel.com,
        joro@8bytes.org, tglx@linutronix.de, ravi.v.shankar@intel.com,
        linux-crypto@vger.kernel.org, fenghua.yu@intel.com
Subject: Re: [PATCH] crypto: hisilicon/qm: Change type of pasid to u32
Message-ID: <20200703044934.GA23320@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593115632-31417-1-git-send-email-fenghua.yu@intel.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> wrote:
> PASID is defined as "int" although it's a 20-bit value and shouldn't be
> negative int. To be consistent with PASID type in iommu, define PASID
> as "u32".
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> PASID type will be changed consistently as u32:
> https://lore.kernel.org/patchwork/patch/1257770/
> 
> drivers/crypto/hisilicon/qm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

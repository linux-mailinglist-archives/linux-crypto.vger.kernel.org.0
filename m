Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB721361EC5
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 13:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbhDPLc0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Apr 2021 07:32:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53104 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240600AbhDPLc0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Apr 2021 07:32:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMhb-0003Rw-AW; Fri, 16 Apr 2021 21:32:00 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:31:59 +1000
Date:   Fri, 16 Apr 2021 21:31:59 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: correct the use of print format
Message-ID: <20210416113159.GJ16633@gondor.apana.org.au>
References: <1617877431-38290-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617877431-38290-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 08, 2021 at 06:23:49PM +0800, Kai Ye wrote:
> According to Documentation/core-api/printk-formats.rst,
> Use the correct print format. Printing an unsigned int value should use %u
> instead of %d. Otherwise printk() might end up displaying negative numbers.
> 
> Kai Ye (2):
>   crypto/atmel - use the correct print format
>   crypto: hisilicon/sec_drv - use the correct print format
> 
>  drivers/crypto/atmel-i2c.c             | 2 +-
>  drivers/crypto/atmel-sha.c             | 4 ++--
>  drivers/crypto/hisilicon/sec/sec_drv.c | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

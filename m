Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEEF2F5AEC
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Jan 2021 07:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhANGrp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Jan 2021 01:47:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42196 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbhANGrp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Jan 2021 01:47:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzwPP-00087z-9g; Thu, 14 Jan 2021 17:47:04 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 14 Jan 2021 17:47:03 +1100
Date:   Thu, 14 Jan 2021 17:47:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] crypto: hisilicon - register device to uacce
Message-ID: <20210114064703.GG12584@gondor.apana.org.au>
References: <1609827404-6024-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609827404-6024-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 05, 2021 at 02:16:41PM +0800, Kai Ye wrote:
> 1. Add parameter of UACCE mode selection for ZIP.
> 2. Register SEC and HPRE devices to UACCE framework for user space drivers.
> 
> Kai Ye (3):
>   crypto: hisilicon - add ZIP device using mode parameter
>   crypto: hisilicon/hpre - register HPRE device to uacce
>   crypto: hisilicon/sec - register SEC device to uacce
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 54 +++++++++++++++++++++++++++++++
>  drivers/crypto/hisilicon/qm.c             |  2 +-
>  drivers/crypto/hisilicon/qm.h             | 27 ++++++++++++++++
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 39 +++++++++++++++++++++-
>  drivers/crypto/hisilicon/zip/zip_main.c   | 14 ++++++++
>  5 files changed, 134 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

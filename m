Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A024D00B
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgHUHzY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Aug 2020 03:55:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49904 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHUHzS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Aug 2020 03:55:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91tJ-0003tm-59; Fri, 21 Aug 2020 17:55:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:55:13 +1000
Date:   Fri, 21 Aug 2020 17:55:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH] crypto: qat - add delay before polling mailbox
Message-ID: <20200821075513.GB25143@gondor.apana.org.au>
References: <20200730122742.216566-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730122742.216566-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 30, 2020 at 01:27:42PM +0100, Giovanni Cabiddu wrote:
> The mailbox CSR register has a write latency and requires a delay before
> being read. This patch replaces readl_poll_timeout with read_poll_timeout
> that allows to sleep before read.
> The initial sleep was removed when the mailbox poll loop was replaced with
> readl_poll_timeout.
> 
> Fixes: a79d471c6510 ("crypto: qat - update timeout logic in put admin msg")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/qat/qat_common/adf_admin.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

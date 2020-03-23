Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3A18EFD1
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2020 07:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgCWGbU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Mar 2020 02:31:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56950 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCWGbU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Mar 2020 02:31:20 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jGGbv-0004YR-OH; Mon, 23 Mar 2020 17:30:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 23 Mar 2020 17:30:55 +1100
Date:   Mon, 23 Mar 2020 17:30:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     mpe@ellerman.id.au, dja@axtens.net, mikey@neuling.org,
        sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-crypto@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH v4 4/9] crypto/nx: Initialize coproc entry with kzalloc
Message-ID: <20200323063055.GA5932@gondor.apana.org.au>
References: <1584934879.9256.15321.camel@hbabu-laptop>
 <1584936180.9256.15326.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584936180.9256.15326.camel@hbabu-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Mar 22, 2020 at 09:03:00PM -0700, Haren Myneni wrote:
> 
> coproc entry is initialized during NX probe on power9, but not on P8.
> nx842_delete_coprocs() is used for both and frees receive window if it
> is allocated. Getting crash for rmmod on P8 since coproc->vas.rxwin
> is not initialized.
> 
> This patch replaces kmalloc with kzalloc in nx842_powernv_probe()
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  drivers/crypto/nx/nx-842-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

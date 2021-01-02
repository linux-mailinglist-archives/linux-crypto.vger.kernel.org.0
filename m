Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7223D2E88C2
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Jan 2021 23:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbhABWBo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 Jan 2021 17:01:44 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37272 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbhABWBo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 Jan 2021 17:01:44 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvoxF-0000UP-6d; Sun, 03 Jan 2021 09:00:58 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:00:57 +1100
Date:   Sun, 3 Jan 2021 09:00:57 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: sahara - Remove unused .id_table support
Message-ID: <20210102220056.GE12767@gondor.apana.org.au>
References: <20201209215014.15467-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209215014.15467-1-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 09, 2020 at 06:50:14PM -0300, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
> .id_table support in this driver was only useful for old non-devicetree
> platforms.
> 
> Remove the unused .id_table support.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/crypto/sahara.c | 7 -------
>  1 file changed, 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

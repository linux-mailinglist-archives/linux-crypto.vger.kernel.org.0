Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED5D18EFD0
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Mar 2020 07:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCWGbU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Mar 2020 02:31:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56952 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgCWGbU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Mar 2020 02:31:20 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jGGc3-0004YW-VU; Mon, 23 Mar 2020 17:31:05 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 23 Mar 2020 17:31:03 +1100
Date:   Mon, 23 Mar 2020 17:31:03 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     mpe@ellerman.id.au, dja@axtens.net, mikey@neuling.org,
        sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-crypto@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH v4 5/9] crypto/nx: Rename nx-842-powernv file name to
 nx-common-powernv
Message-ID: <20200323063103.GB5932@gondor.apana.org.au>
References: <1584934879.9256.15321.camel@hbabu-laptop>
 <1584936230.9256.15327.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584936230.9256.15327.camel@hbabu-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Mar 22, 2020 at 09:03:50PM -0700, Haren Myneni wrote:
> 
> Rename nx-842-powernv.c to nx-common-powernv.c to add code for setup
> and enable new GZIP compression type. The actual functionality is not
> changed in this patch.
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  drivers/crypto/nx/Makefile            |    2 +-
>  drivers/crypto/nx/nx-842-powernv.c    | 1062 ---------------------------------
>  drivers/crypto/nx/nx-common-powernv.c | 1062 +++++++++++++++++++++++++++++++++
>  3 files changed, 1063 insertions(+), 1063 deletions(-)
>  delete mode 100644 drivers/crypto/nx/nx-842-powernv.c
>  create mode 100644 drivers/crypto/nx/nx-common-powernv.c

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

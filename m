Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F77182F7A
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2020 12:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgCLLoC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Mar 2020 07:44:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59650 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLLoC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Mar 2020 07:44:02 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jCMFn-00012f-Ja; Thu, 12 Mar 2020 22:43:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2020 22:43:55 +1100
Date:   Thu, 12 Mar 2020 22:43:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srujana Challa <schalla@marvell.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        pathreya@marvell.com
Subject: Re: [PATCH 4/4] crypto: marvell: enable OcteonTX cpt options for
 build
Message-ID: <20200312114355.GA21315@gondor.apana.org.au>
References: <1583324716-23633-1-git-send-email-schalla@marvell.com>
 <1583324716-23633-5-git-send-email-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583324716-23633-5-git-send-email-schalla@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 04, 2020 at 05:55:16PM +0530, Srujana Challa wrote:
>
> +config CRYPTO_DEV_OCTEONTX_CPT
> +	tristate "Support for Marvell OcteonTX CPT driver"
> +	depends on ARCH_THUNDER || COMPILE_TEST
> +	depends on PCI_MSI && 64BIT
> +	depends on CRYPTO_LIB_AES
> +	select CRYPTO_BLKCIPHER

The BLKCIPHER option has been replaced by SKCIPHER.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

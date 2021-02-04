Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7030EC2A
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Feb 2021 06:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBDFnh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Feb 2021 00:43:37 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51592 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhBDFng (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Feb 2021 00:43:36 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7XPe-00022t-2p; Thu, 04 Feb 2021 16:42:43 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Feb 2021 16:42:41 +1100
Date:   Thu, 4 Feb 2021 16:42:41 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Saulo Alessandre <saulo.alessandre@gmail.com>,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
Subject: Re: [PATCH v2 4/4] ecdsa: implements ecdsa signature verification
Message-ID: <20210204054241.GC7229@gondor.apana.org.au>
References: <20210129212535.2257493-1-saulo.alessandre@gmail.com>
 <20210129212535.2257493-5-saulo.alessandre@gmail.com>
 <20210202051003.GA27641@gondor.apana.org.au>
 <20210203153406.pqheygwcyzmmhfxd@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203153406.pqheygwcyzmmhfxd@altlinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 03, 2021 at 06:34:06PM +0300, Vitaly Chikunov wrote:
>
> Thanks for the invitation, I'm didn't receive this thread - is
> there a temporary problem with the linux-crypto@vger.kernel.org list?
> I re-checked my subscription and it seems valid.

There was a problem between vger and gmail (and possibly others)
recently.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

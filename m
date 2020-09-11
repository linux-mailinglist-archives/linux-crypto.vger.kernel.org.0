Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D719C26586B
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 06:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgIKEhv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Sep 2020 00:37:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58528 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIKEhv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Sep 2020 00:37:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGaoO-0006Ob-Fi; Fri, 11 Sep 2020 14:37:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 14:37:24 +1000
Date:   Fri, 11 Sep 2020 14:37:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Atte Tommiska <atte.tommiska@xiphera.com>
Cc:     Matt Mackall <mpm@selenic.com>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hwrng: xiphera-trng: add support for XIP8001B
 hwrng
Message-ID: <20200911043724.GA5710@gondor.apana.org.au>
References: <20200902102817.32172-1-atte.tommiska@xiphera.com>
 <20200902102817.32172-4-atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102817.32172-4-atte.tommiska@xiphera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 02, 2020 at 01:28:17PM +0300, Atte Tommiska wrote:
> Xiphera XIP8001B is an FPGA-based True Random Number Generator
> Intellectual Property (IP) Core which can be instantiated in
> multiple FPGA families. This driver adds Linux support for it through
> the hwrng interface.
> 
> Signed-off-by: Atte Tommiska <atte.tommiska@xiphera.com>
> Reported-by: kernel test robot <lkp@intel.com>

This Reported-by appears to be superfluous and I'll remove it
when applying.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

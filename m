Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8864038087E
	for <lists+linux-crypto@lfdr.de>; Fri, 14 May 2021 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhENLfs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 May 2021 07:35:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37184 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLfr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 May 2021 07:35:47 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.89 #2 (Debian))
        id 1lhW5J-0002t5-RJ; Fri, 14 May 2021 19:34:25 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lhW5E-0002X1-Ks; Fri, 14 May 2021 19:34:20 +0800
Date:   Fri, 14 May 2021 19:34:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] crypto: arm: generate *.S by Perl at build time
 instead of shipping them
Message-ID: <20210514113420.ofirlhwsub2f7bes@gondor.apana.org.au>
References: <20210425175734.1310191-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425175734.1310191-1-masahiroy@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Apr 26, 2021 at 02:57:31AM +0900, Masahiro Yamada wrote:
> Generate *.S by Perl like arch/{mips,x86}/crypto/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/arm/crypto/Makefile                |    8 +-
>  arch/arm/crypto/poly1305-core.S_shipped | 1158 ----------
>  arch/arm/crypto/sha256-core.S_shipped   | 2816 -----------------------
>  arch/arm/crypto/sha512-core.S_shipped   | 1869 ---------------
>  4 files changed, 3 insertions(+), 5848 deletions(-)
>  delete mode 100644 arch/arm/crypto/poly1305-core.S_shipped
>  delete mode 100644 arch/arm/crypto/sha256-core.S_shipped
>  delete mode 100644 arch/arm/crypto/sha512-core.S_shipped

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1CEBD9A
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 07:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfKAGIk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 02:08:40 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37586 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKAGIk (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:08:40 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQ6x-0001vM-0K; Fri, 01 Nov 2019 14:08:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQ6w-0004r1-TB; Fri, 01 Nov 2019 14:08:38 +0800
Date:   Fri, 1 Nov 2019 14:08:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ecdh - fix big endian bug in ECC library
Message-ID: <20191101060838.qnzulo3aaibds3hb@gondor.apana.org.au>
References: <20191023095044.12319-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023095044.12319-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 23, 2019 at 11:50:44AM +0200, Ard Biesheuvel wrote:
> The elliptic curve arithmetic library used by the EC-DH KPP implementation
> assumes big endian byte order, and unconditionally reverses the byte
> and word order of multi-limb quantities. On big endian systems, the byte
> reordering is not necessary, while the word ordering needs to be retained.
> 
> So replace the __swab64() invocation with a call to be64_to_cpu() which
> should do the right thing for both little and big endian builds.
> 
> Cc: <stable@vger.kernel.org> # v4.9+
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  crypto/ecc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

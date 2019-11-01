Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8BEBDB4
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 07:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfKAGOB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 02:14:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37808 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKAGOB (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:14:01 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQC7-000212-VO; Fri, 01 Nov 2019 14:14:00 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQC6-0004wA-Jk; Fri, 01 Nov 2019 14:13:58 +0800
Date:   Fri, 1 Nov 2019 14:13:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH] crypto: amcc - restore CRYPTO_AES dependency
Message-ID: <20191101061358.zhq2jtir7azv24l5@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027154747.14844-1-chunkeey@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:
> This patch restores the CRYPTO_AES dependency. This is
> necessary since some of the crypto4xx driver provided
> modes need functioning software fallbacks for
> AES-CTR/CCM and GCM.
> 
> Fixes: da3e7a9715ea ("crypto: amcc - switch to AES library for GCM key derivation")
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> drivers/crypto/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7B2E21C9
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgLWU6p (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 15:58:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39032 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgLWU6p (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 15:58:45 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1ksBCl-0002gy-DI; Thu, 24 Dec 2020 07:57:56 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 24 Dec 2020 07:57:55 +1100
Date:   Thu, 24 Dec 2020 07:57:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Marco Chiappero <marco.chiappero@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        qat-linux <qat-linux@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] crypto: qat - add CRYPTO_AES to Kconfig dependencies
Message-ID: <20201223205755.GA19858@gondor.apana.org.au>
References: <20201222130024.694558-1-marco.chiappero@intel.com>
 <CAMj1kXGUBQX2HrGSS8OAC2zDS0_WyaiRQzxyFatpUG+Px+WcKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGUBQX2HrGSS8OAC2zDS0_WyaiRQzxyFatpUG+Px+WcKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 23, 2020 at 07:39:46PM +0100, Ard Biesheuvel wrote:
> 
> This should be 'select CRYPTO_LIB_AES'

Please send a follow-up.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

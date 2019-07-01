Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75F4C8FE
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Jun 2019 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFTIIN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Jun 2019 04:08:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43642 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfFTIIM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Jun 2019 04:08:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hds6w-0002GE-K7; Thu, 20 Jun 2019 16:07:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hds6t-0008BD-NL; Thu, 20 Jun 2019 16:07:55 +0800
Date:   Thu, 20 Jun 2019 16:07:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     leitao@debian.org, nayna@linux.ibm.com, pfsmorigo@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] crypto: nx: no need to check return value of
 debugfs_create functions
Message-ID: <20190620080755.bl2klotl5em43b4s@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614142904.GA11066@kroah.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Also, there is no need to store the individual debugfs file names,
> especially as the whole directiry is deleted at once, so remove the
> unneeded structure entirely.
> 
> Cc: "Breno Leit�o" <leitao@debian.org>
> Cc: Nayna Jain <nayna@linux.ibm.com>
> Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: fixed build error found by kbuild
> 
> drivers/crypto/nx/nx.c         |  4 +-
> drivers/crypto/nx/nx.h         | 12 +-----
> drivers/crypto/nx/nx_debugfs.c | 71 +++++++++++-----------------------
> 3 files changed, 26 insertions(+), 61 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

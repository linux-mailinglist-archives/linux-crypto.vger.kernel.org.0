Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A326183076
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2020 13:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCLMjF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Mar 2020 08:39:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59970 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCLMjF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Mar 2020 08:39:05 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jCN78-00021b-5O; Thu, 12 Mar 2020 23:39:03 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2020 23:39:02 +1100
Date:   Thu, 12 Mar 2020 23:39:02 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eneas U de Queiroz <cotequeiroz@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: qce - fix wrong config symbol reference
Message-ID: <20200312123901.GC28885@gondor.apana.org.au>
References: <20200304182455.29066-1-cotequeiroz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304182455.29066-1-cotequeiroz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 04, 2020 at 03:24:55PM -0300, Eneas U de Queiroz wrote:
> The CONFIG_CRYPTO_DEV_QCE_SOFT_THRESHOLD symbol was renamed during
> development, but the stringify reference in the parameter description
> sneaked by unnoticed.
> 
> Signed-off-by: Eneas U de Queiroz <cotequeiroz@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

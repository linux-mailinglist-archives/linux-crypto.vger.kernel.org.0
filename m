Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8670315BB9E
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Feb 2020 10:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgBMJZG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Feb 2020 04:25:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42506 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbgBMJZG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Feb 2020 04:25:06 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2Ak5-0004BY-Dr; Thu, 13 Feb 2020 17:25:05 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2Ak4-0006r9-PF; Thu, 13 Feb 2020 17:25:04 +0800
Date:   Thu, 13 Feb 2020 17:25:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: tcrypt - fix printed skcipher [a]sync mode
Message-ID: <20200213092504.povmrutpehvw6ogb@gondor.apana.org.au>
References: <20200205101958.29879-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200205101958.29879-1-horia.geanta@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 05, 2020 at 12:19:58PM +0200, Horia Geantă wrote:
> When running tcrypt skcipher speed tests, logs contain things like:
> testing speed of async ecb(des3_ede) (ecb(des3_ede-generic)) encryption
> or:
> testing speed of async ecb(aes) (ecb(aes-ce)) encryption
> 
> The algorithm implementations are sync, not async.
> Fix this inaccuracy.
> 
> Fixes: 7166e589da5b6 ("7166e589da5b crypto: tcrypt - Use skcipher")
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  crypto/tcrypt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

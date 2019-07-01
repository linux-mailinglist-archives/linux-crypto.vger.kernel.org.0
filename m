Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC21E27640
	for <lists+linux-crypto@lfdr.de>; Thu, 23 May 2019 08:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfEWGwU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 May 2019 02:52:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47802 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfEWGwU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 May 2019 02:52:20 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hThaN-0001pq-G1; Thu, 23 May 2019 14:52:19 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hThaL-0006CV-L7; Thu, 23 May 2019 14:52:17 +0800
Date:   Thu, 23 May 2019 14:52:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-crypto@vger.kernel.org,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] crypto: caam - print debugging hex dumps after unmapping
Message-ID: <20190523065217.7zf7vqf6zbbit6oo@gondor.apana.org.au>
References: <20190516142442.32537-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516142442.32537-1-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 16, 2019 at 04:24:42PM +0200, Sascha Hauer wrote:
> For encryption the destination pointer was still mapped, so the hex dump
> may be wrong. The IV still contained the input IV while printing instead
> of the output IV as intended.
> 
> For decryption the destination pointer was still mapped, so the hex dump
> may be wrong. The IV dump was correct.
> 
> Do the hex dumps consistenly after the buffers have been unmapped and
> in case of IV copied to their final destination.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

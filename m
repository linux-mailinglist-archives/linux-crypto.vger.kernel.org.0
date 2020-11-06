Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE702A8FC4
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 08:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgKFHBI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 02:01:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35008 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHBH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 02:01:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kavk8-0007zq-Nj; Fri, 06 Nov 2020 18:01:05 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Nov 2020 18:01:04 +1100
Date:   Fri, 6 Nov 2020 18:01:04 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Andrei Botila <andrei.botila@nxp.com>,
        Dragos Rosioru <dragos.rosioru@nxp.com>
Subject: Re: [PATCH v2] crypto: caam - enable crypto-engine retry mechanism
Message-ID: <20201106070104.GB11620@gondor.apana.org.au>
References: <1603739186-4007-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603739186-4007-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 26, 2020 at 09:06:26PM +0200, Iuliana Prodan wrote:
> Use the new crypto_engine_alloc_init_and_set() function to
> initialize crypto-engine and enable retry mechanism.
> 
> Set the maximum size for crypto-engine software queue based on
> Job Ring size (JOBR_DEPTH) and a threshold (reserved for the
> non-crypto-API requests that are not passed through crypto-engine).
> 
> The callback for do_batch_requests is NULL, since CAAM
> doesn't support linked requests.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
> Changes since v1:
> - add comment for THRESHOLD define;
> - update max size for crypto-engine queue.
> 
>  drivers/crypto/caam/intern.h | 8 ++++++++
>  drivers/crypto/caam/jr.c     | 4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3297213318
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jul 2020 06:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgGCEsb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 Jul 2020 00:48:31 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40230 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgGCEs3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 Jul 2020 00:48:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jrDcK-00081B-CY; Fri, 03 Jul 2020 14:48:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Jul 2020 14:48:04 +1000
Date:   Fri, 3 Jul 2020 14:48:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     davem@davemloft.net, stanimir.varbanov@linaro.org, ardb@kernel.org,
        cotequeiroz@gmail.com, ebiggers@google.com, horia.geanta@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] qce crypto fixes for tcrypto failures
Message-ID: <20200703044804.GB23200@gondor.apana.org.au>
References: <1592806506-23978-1-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592806506-23978-1-git-send-email-sivaprak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 22, 2020 at 11:45:03AM +0530, Sivaprakash Murugesan wrote:
> while running tcrypto test cases on qce crypto engine few failures are
> noticed, this is mainly because of the updates on tcrypto driver and
> not testing qce reqgularly with mainline tcrypto driver.
> 
> This series tries to address few of the errors while running tcrypto on
> qce.
> 
> Sivaprakash Murugesan (3):
>   crypto: qce: support zero length test vectors
>   crypto: qce: re-initialize context on import
>   crypto: qce: sha: Do not modify scatterlist passed along with request
> 
>  drivers/crypto/Kconfig      |  2 ++
>  drivers/crypto/qce/common.h |  2 ++
>  drivers/crypto/qce/sha.c    | 36 +++++++++++++++++++++++++++++-------
>  3 files changed, 33 insertions(+), 7 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

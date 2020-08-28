Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897F12554F8
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Aug 2020 09:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgH1HTp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Aug 2020 03:19:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35298 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1HTp (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Aug 2020 03:19:45 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kBYfb-0003gW-CX; Fri, 28 Aug 2020 17:19:32 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Aug 2020 17:19:31 +1000
Date:   Fri, 28 Aug 2020 17:19:31 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     George Acosta <acostag.ubuntu@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Phani Kiran Hemadri <phemadri@marvell.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium/nitrox: add an error message to explain
 the failure of pci_request_mem_regions
Message-ID: <20200828071931.GB28064@gondor.apana.org.au>
References: <20200821031209.21279-1-acostag.ubuntu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821031209.21279-1-acostag.ubuntu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 20, 2020 at 10:12:08PM -0500, George Acosta wrote:
> Provide an error message for users when pci_request_mem_regions failed.
> 
> Signed-off-by: George Acosta <acostag.ubuntu@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704C17EBAA
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 06:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfHBEyt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 00:54:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48626 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732011AbfHBEyt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 00:54:49 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htPaZ-0006Gc-0t; Fri, 02 Aug 2019 14:54:47 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htPaX-0004iT-SP; Fri, 02 Aug 2019 14:54:45 +1000
Date:   Fri, 2 Aug 2019 14:54:45 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vakul Garg <vakul.garg@nxp.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Subject: Re: [PATCH v5] crypto: caam/qi2 - Add printing dpseci fq stats using
 debugfs
Message-ID: <20190802045445.GC18077@gondor.apana.org.au>
References: <20190723091005.827-1-vakul.garg@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723091005.827-1-vakul.garg@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 23, 2019 at 09:14:24AM +0000, Vakul Garg wrote:
> Add support of printing the dpseci frame queue statistics using debugfs.
> 
> Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
> ---
> 
> Changes since v4:
> 	- Corrected license header commenting style
> 
>  drivers/crypto/caam/Makefile         |  1 +
>  drivers/crypto/caam/caamalg_qi2.c    |  5 +++
>  drivers/crypto/caam/caamalg_qi2.h    |  2 +
>  drivers/crypto/caam/dpseci-debugfs.c | 79 ++++++++++++++++++++++++++++++++++++
>  drivers/crypto/caam/dpseci-debugfs.h | 18 ++++++++
>  5 files changed, 105 insertions(+)
>  create mode 100644 drivers/crypto/caam/dpseci-debugfs.c
>  create mode 100644 drivers/crypto/caam/dpseci-debugfs.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

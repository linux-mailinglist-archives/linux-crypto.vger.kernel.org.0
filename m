Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21523E6E0
	for <lists+linux-crypto@lfdr.de>; Fri,  7 Aug 2020 06:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgHGEy3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 7 Aug 2020 00:54:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35256 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgHGEy3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 7 Aug 2020 00:54:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k3uOe-0004FA-Kr; Fri, 07 Aug 2020 14:54:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Aug 2020 14:54:24 +1000
Date:   Fri, 7 Aug 2020 14:54:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Aymen Sghaier <aymen.sghaier@nxp.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH] crypto: caam - Move debugfs fops into standalone file
Message-ID: <20200807045424.GA24062@gondor.apana.org.au>
References: <20200730135426.GA13682@gondor.apana.org.au>
 <c7fa483a-8f57-ee12-3c72-68c770ba4e00@nxp.com>
 <20200801124249.GA18580@gondor.apana.org.au>
 <bf2588f8-95f0-dd10-cd03-25268ea68837@nxp.com>
 <20200806221005.GA22325@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200806221005.GA22325@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 07, 2020 at 08:10:05AM +1000, Herbert Xu wrote:
> On Thu, Aug 06, 2020 at 09:09:49PM +0300, Horia Geantă wrote:
> >
> > I'd rather move these in the newly-created debugfs.c, see below v3.
> 
> I'd rather not because this creates more ifdefs.

Actually I take that back.  This does seem to be nicer than my patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

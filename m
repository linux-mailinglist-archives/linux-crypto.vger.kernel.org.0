Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F11F4A58
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2020 02:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFJAVe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Jun 2020 20:21:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59144 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgFJAVd (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Jun 2020 20:21:33 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jioUd-0007I3-FC; Wed, 10 Jun 2020 10:21:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2020 10:21:23 +1000
Date:   Wed, 10 Jun 2020 10:21:23 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [v2 PATCH] crypto: af_alg - fix use-after-free in
 af_alg_accept() due to bh_lock_sock()
Message-ID: <20200610002123.GA6230@gondor.apana.org.au>
References: <20200605161657.535043-1-mfo@canonical.com>
 <20200608064843.GA22167@gondor.apana.org.au>
 <CAO9xwp0KimEV-inWB8176Z+MyzXqO3tgNtbtYF9JnBtg07-PiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp0KimEV-inWB8176Z+MyzXqO3tgNtbtYF9JnBtg07-PiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jun 09, 2020 at 12:17:32PM -0300, Mauricio Faria de Oliveira wrote:
>
> Per your knowledge/experience with the crypto subsystem, the changed code
> paths are not hot enough to suffer from such implications?

I don't think replacing a spin-lock with a pair of atomic ops is
going to be too much of an issue.  We can always look at this again
if someone comes up with real numbers of course.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

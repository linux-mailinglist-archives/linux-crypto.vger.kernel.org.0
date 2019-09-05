Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE901A99AA
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfIEEgH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 00:36:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60460 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfIEEgH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 00:36:07 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5jUv-00062N-Ha; Thu, 05 Sep 2019 14:35:54 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Sep 2019 14:35:48 +1000
Date:   Thu, 5 Sep 2019 14:35:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] padata: use unbound workqueues for parallel jobs
Message-ID: <20190905043548.GA27131@gondor.apana.org.au>
References: <20190829173038.21040-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829173038.21040-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 29, 2019 at 01:30:29PM -0400, Daniel Jordan wrote:
> Hello,
> 
> Everything in the Testing section has been rerun after the suggestion
> from Herbert last round.  Thanks again to Steffen for giving this a run.
> 
> Any comments welcome.
> 
> Daniel
> 
> v1[*]  -> v2:
>  - Updated patch 8 to avoid queueing the reorder work if the next object
>    by sequence number isn't ready yet (Herbert)
>  - Added Steffen's ack to all but patch 8 since that one changed.

This doesn't apply against cryptodev.  Perhaps it depends on the
flushing patch series? If that's the case please combine both into
one series.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

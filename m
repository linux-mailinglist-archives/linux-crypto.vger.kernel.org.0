Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B645AB08A
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Sep 2019 04:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfIFCPy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 22:15:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60740 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfIFCPy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 22:15:54 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i63mx-0005z1-G2; Fri, 06 Sep 2019 12:15:52 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Sep 2019 12:15:50 +1000
Date:   Fri, 6 Sep 2019 12:15:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org
Subject: Re: crypto: skcipher - Unmap pages after an external error
Message-ID: <20190906021550.GA17115@gondor.apana.org.au>
References: <20190821143253.30209-1-ard.biesheuvel@linaro.org>
 <20190821143253.30209-9-ard.biesheuvel@linaro.org>
 <20190830080347.GA6677@gondor.apana.org.au>
 <CAKv+Gu-4QBvPcE7YUqgWbT31gdLM8vcHTPbdOCN+UnUMXreuPg@mail.gmail.com>
 <20190903065438.GA9372@gondor.apana.org.au>
 <20190903135020.GB5144@zzz.localdomain>
 <20190903223641.GA7430@gondor.apana.org.au>
 <20190905052217.GA722@sol.localdomain>
 <20190905054032.GA3022@gondor.apana.org.au>
 <20190906015753.GA803@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906015753.GA803@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 05, 2019 at 06:57:53PM -0700, Eric Biggers wrote:
>
> That's not what I'm talking about.  I'm talking about flushing the page, in
> scatterwalk_done().  It assumes the page that was just processed was:
> 
> 	sg_page(walk->sg) + ((walk->offset - 1) >> PAGE_SHIFT)
> 
> But if no bytes were processed, this is invalid.  Notably, if no bytes were
> processed then walk->offset can be 0, causing a crash.

You're right.  What's worse is that my patch doesn't even unmap
the pages anyway.  Let me do this again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

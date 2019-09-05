Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60DA9A0C
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Sep 2019 07:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfIEFWU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Sep 2019 01:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfIEFWT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Sep 2019 01:22:19 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D504206DF;
        Thu,  5 Sep 2019 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567660939;
        bh=5nXCr8GuHBHbrtHekJQBV9M0nwUVD6wnWKHsBw1VH04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOUPPJN70EBgoXkc2RUyuzmpydUFmMXBEwf5xyNgFsuADkzX9AoIcxNveoVSWwI5P
         cjbsXUOVWvyc62Rdhxt1UUI7wEfPvSyr/xTAUEKEUI9enArXEAoBBjH/fxQhal4KUe
         cREGftok9tSYPH/d5XssFtzLIcD9eO0G+v3Fjb+k=
Date:   Wed, 4 Sep 2019 22:22:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org
Subject: Re: crypto: skcipher - Unmap pages after an external error
Message-ID: <20190905052217.GA722@sol.localdomain>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org
References: <20190821143253.30209-1-ard.biesheuvel@linaro.org>
 <20190821143253.30209-9-ard.biesheuvel@linaro.org>
 <20190830080347.GA6677@gondor.apana.org.au>
 <CAKv+Gu-4QBvPcE7YUqgWbT31gdLM8vcHTPbdOCN+UnUMXreuPg@mail.gmail.com>
 <20190903065438.GA9372@gondor.apana.org.au>
 <20190903135020.GB5144@zzz.localdomain>
 <20190903223641.GA7430@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903223641.GA7430@gondor.apana.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 04, 2019 at 08:36:41AM +1000, Herbert Xu wrote:
> On Tue, Sep 03, 2019 at 08:50:20AM -0500, Eric Biggers wrote:
> >
> > Doesn't this re-introduce the same bug that my patch fixed -- that
> > scatterwalk_done() could be called after 0 bytes processed, causing a crash in
> > scatterwalk_pagedone()?
> 
> No because that crash is caused by the internal calls to the
> function skcipher_walk_done with an error.  Those two internal
> calls have now been changed into skcipher_walk_unwind which does
> not try to unmap the pages.
> 

Okay, but what about external callers that pass in an error?  (I mean, I don't
actually see any currently, but the point of this patch is to allow it...)
What would prevent the crash in scatterwalk_done() in that case?

- Eric

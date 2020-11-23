Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCEC2C190C
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Nov 2020 23:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbgKWW5J (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Nov 2020 17:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387779AbgKWW5C (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Nov 2020 17:57:02 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7D620721;
        Mon, 23 Nov 2020 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172221;
        bh=PeMQuHRGafr+MH2732H5QIsziSBuet+1mwJXJH8dm1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n+j7HwL8BbB9Km2nF00W/Pq/sX28PulgJRwpNZcfyVUbMNE1fi1wpz2uUurb1wLHy
         wRtiDzqTqnNmilMexYWv8IaMAWCnJwVDaYwj1Ghc8/SPWi5dymoEth0ujDjKC0+/rc
         LWh/icwmYdFcFRevDeVEeY5PPvmd/KuexXsaw5Po=
Date:   Mon, 23 Nov 2020 16:57:15 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 075/141] crypto: ccree - Fix fall-through warnings for
 Clang
Message-ID: <20201123225715.GT21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <7c424191001cafdc7abd060790ecfcccdf3dd3ae.1605896059.git.gustavoars@kernel.org>
 <CAOtvUMeLZXChtoEUNyy=hwHQDqqncUX5V_=JSH3YaiVNLyTcHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMeLZXChtoEUNyy=hwHQDqqncUX5V_=JSH3YaiVNLyTcHw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Nov 22, 2020 at 09:54:29AM +0200, Gilad Ben-Yossef wrote:
> On Fri, Nov 20, 2020 at 8:34 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding multiple break statements instead of
> > letting the code fall through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
[..]
> 
> Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks, Gilad.
--
Gustavo

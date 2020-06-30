Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B66520ECCC
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2020 06:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgF3Etl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jun 2020 00:49:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:32908 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgF3Etl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jun 2020 00:49:41 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jq8DB-0008UL-2G; Tue, 30 Jun 2020 14:49:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 30 Jun 2020 14:49:37 +1000
Date:   Tue, 30 Jun 2020 14:49:37 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
Subject: Re: [PATCHv4 3/7] crypto: sa2ul: add sha1/sha256/sha512 support
Message-ID: <20200630044936.GA22565@gondor.apana.org.au>
References: <20200615071452.25141-1-t-kristo@ti.com>
 <20200615071452.25141-4-t-kristo@ti.com>
 <20200626043155.GA2683@gondor.apana.org.au>
 <2a89ea86-3b9e-06b5-fa8e-9dc6e5ad9aeb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a89ea86-3b9e-06b5-fa8e-9dc6e5ad9aeb@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 26, 2020 at 12:15:42PM +0300, Tero Kristo wrote:
>
> I have been experimenting with an alternate approach, where I have a small
> buffer within the context, this would be more like the way other drivers do
> this. If the buffer is closed before running out of space, I can push this
> to be processed by HW, otherwise I must fallback to SW. Does this sound like
> a better approach?

You can buffer up to a block obviously.  Anything beyond that
should just use a fallback.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

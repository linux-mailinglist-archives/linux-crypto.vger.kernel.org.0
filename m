Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07F3596BB
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDIHv3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 03:51:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51992 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhDIHv2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 03:51:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlv3-0006Ct-4z; Fri, 09 Apr 2021 17:51:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:51:09 +1000
Date:   Fri, 9 Apr 2021 17:51:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: crypto: possible NULL reference
Message-ID: <20210409075108.GB31447@gondor.apana.org.au>
References: <08384a82-8b41-69e0-ad04-705f011ed92a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08384a82-8b41-69e0-ad04-705f011ed92a@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Mar 29, 2021 at 09:11:17PM -0700, Randy Dunlap wrote:
>
> Is there something else protecting the improper use of <curve>
> in these cases?  or is a patch warranted?

The curve ID is always hard-coded and AFAIK we don't have any
use-cases where an unsupported curve ID is used.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

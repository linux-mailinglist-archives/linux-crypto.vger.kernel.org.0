Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFF4450B
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Jun 2019 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfFMQlV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Jun 2019 12:41:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49932 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730548AbfFMGx5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Jun 2019 02:53:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbJcS-0006CR-EK; Thu, 13 Jun 2019 14:53:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbJcQ-000507-Tn; Thu, 13 Jun 2019 14:53:54 +0800
Date:   Thu, 13 Jun 2019 14:53:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: make cra_driver_name mandatory
Message-ID: <20190613065354.l63pxq5fj7yokpf7@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603054058.5449-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> Most generic crypto algorithms declare a driver name ending in
> "-generic".  The rest don't declare a driver name and instead rely on
> the crypto API automagically appending "-generic" upon registration.
> 
> Having multiple conventions is unnecessarily confusing and makes it
> harder to grep for all generic algorithms in the kernel source tree.
> But also, allowing NULL driver names is problematic because sometimes
> people fail to set it, e.g. the case fixed by commit 417980364300
> ("crypto: cavium/zip - fix collision with generic cra_driver_name").
> 
> Of course, people can also incorrectly name their drivers "-generic".
> But that's much easier to notice / grep for.
> 
> Therefore, let's make cra_driver_name mandatory.  Patch 1 gives all
> generic algorithms an explicit cra_driver_name, and Patch 2 makes
> cra_driver_name required for algorithm registration.
> 
> Eric Biggers (2):
>  crypto: make all generic algorithms set cra_driver_name
>  crypto: algapi - require cra_name and cra_driver_name

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

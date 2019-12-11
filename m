Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16ED11A5DD
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 09:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfLKIax (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 03:30:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49598 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfLKIax (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 03:30:53 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iexOV-000725-O6; Wed, 11 Dec 2019 16:30:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iexOV-0006Zn-Jq; Wed, 11 Dec 2019 16:30:51 +0800
Date:   Wed, 11 Dec 2019 16:30:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v2 PATCH 0/3] crypto: shash - Enforce descsize limit in init_tfm
Message-ID: <20191211083051.o6yq3njomodxnpxv@gondor.apana.org.au>
References: <20191206023527.k4kxngcsb7rpq2rz@gondor.apana.org.au>
 <20191208054229.h4smagmiuqhxxc6w@gondor.apana.org.au>
 <20191211033211.GF732@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211033211.GF732@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 10, 2019 at 07:32:11PM -0800, Eric Biggers wrote:
>
> I left some nits on patches 1 and 2, but not too important.  Feel free to add:
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Thanks.  I've added your suggestions as well as your review tag.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

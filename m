Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16E91FED0E
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2020 09:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFRH6H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jun 2020 03:58:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60486 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgFRH6H (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jun 2020 03:58:07 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jlpQz-0002CO-59; Thu, 18 Jun 2020 17:58:06 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 17:58:05 +1000
Date:   Thu, 18 Jun 2020 17:58:05 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 0/2] crc-t10dif library improvements
Message-ID: <20200618075804.GA10317@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610063943.378796-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> This series makes some more improvements to lib/crc-t10dif.c, as discussed at
> https://lkml.kernel.org/linux-crypto/20200604063324.GA28813@gondor.apana.org.au/T/#u
> 
> This applies on top of Herbert's
> "[v2 PATCH] crc-t10dif: Fix potential crypto notify dead-lock".
> 
> Eric Biggers (2):
>  crc-t10dif: use fallback in initial state
>  crc-t10dif: clean up some more things
> 
> lib/crc-t10dif.c | 61 +++++++++++++++++-------------------------------
> 1 file changed, 21 insertions(+), 40 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

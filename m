Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C924C693
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Aug 2020 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHTUHH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Aug 2020 16:07:07 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49316 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgHTUHH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Aug 2020 16:07:07 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k8qpW-0001dQ-Cs; Fri, 21 Aug 2020 06:06:35 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 06:06:34 +1000
Date:   Fri, 21 Aug 2020 06:06:34 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Rix <trix@redhat.com>
Cc:     davem@davemloft.net, smueller@chronox.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: drbg: check blocklen is non zero
Message-ID: <20200820200634.GA24064@gondor.apana.org.au>
References: <20200802171247.16558-1-trix@redhat.com>
 <20200820071522.GA21511@gondor.apana.org.au>
 <97371bc7-ebb6-92f2-bbaa-6b444e27cb8b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97371bc7-ebb6-92f2-bbaa-6b444e27cb8b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 20, 2020 at 06:27:36AM -0700, Tom Rix wrote:
> There are many divide by 0 reports.  This one got attention because it is in crypto, where i believe problems, even false positives, should be fixed.

Please don't top post.

AS your bug report is a false positive I'm rejecting your patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC28765E5
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jul 2019 14:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfGZMeU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jul 2019 08:34:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46466 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGZMeU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jul 2019 08:34:20 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzQP-0003wP-97; Fri, 26 Jul 2019 22:34:17 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzQO-0002B2-6M; Fri, 26 Jul 2019 22:34:16 +1000
Date:   Fri, 26 Jul 2019 22:34:16 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        Thomas.Lendacky@amd.com, Gary.Hook@amd.com
Subject: Re: [PATCH 0/2] Improve system log messaging in ccp-crypto
Message-ID: <20190726123416.GA8361@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710214504.3420-1-gary.hook@amd.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hook, Gary <Gary.Hook@amd.com> wrote:
> From: Gary R Hook <gary.hook@amd.com>
> 
> Add a prefix to any messages logged by the ccp-crypto module, and
> add a notice if the module fails to load in the case that no CCPs
> are defined.
> 
> Gary R Hook (2):
>  crypto: ccp - Include the module name in system log messages
>  crypto: ccp - Log an error message when ccp-crypto fails to load
> 
> drivers/crypto/ccp/ccp-crypto-main.c | 4 +++-
> drivers/crypto/ccp/ccp-crypto.h      | 4 ++++
> 2 files changed, 7 insertions(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

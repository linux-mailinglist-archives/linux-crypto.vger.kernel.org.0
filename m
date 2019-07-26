Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC60765C9
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jul 2019 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGZMbj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jul 2019 08:31:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:46388 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfGZMbg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jul 2019 08:31:36 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hqzNl-0003il-VC; Fri, 26 Jul 2019 22:31:34 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hqzNl-00027a-D3; Fri, 26 Jul 2019 22:31:33 +1000
Date:   Fri, 26 Jul 2019 22:31:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hannah Pan <hannahpan@google.com>
Cc:     linux-crypto@vger.kernel.org, dave.rodgman@arm.com,
        hannahpan@google.com
Subject: Re: [PATCH] crypto: testmgr - add tests for lzo-rle
Message-ID: <20190726123133.GA8146@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702221602.120879-1-hannahpan@google.com>
Organization: Core
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hannah Pan <hannahpan@google.com> wrote:
> Add self-tests for the lzo-rle algorithm.
> 
> Signed-off-by: Hannah Pan <hannahpan@google.com>
> ---
> crypto/testmgr.c | 10 ++++++
> crypto/testmgr.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 90 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A85444FD
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Jun 2019 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392713AbfFMQk5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Jun 2019 12:40:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49998 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbfFMGzr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Jun 2019 02:55:47 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbJeD-0006Dr-LF; Thu, 13 Jun 2019 14:55:45 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbJeD-00053l-FD; Thu, 13 Jun 2019 14:55:45 +0800
Date:   Thu, 13 Jun 2019 14:55:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: chacha - constify ctx and iv arguments
Message-ID: <20190613065545.kbmr35mkxzfzy7kt@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603054714.6477-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Constify the ctx and iv arguments to crypto_chacha_init() and the
> various chacha*_stream_xor() functions.  This makes it clear that they
> are not modified.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> arch/arm/crypto/chacha-neon-glue.c   | 2 +-
> arch/arm64/crypto/chacha-neon-glue.c | 2 +-
> arch/x86/crypto/chacha_glue.c        | 2 +-
> crypto/chacha_generic.c              | 4 ++--
> include/crypto/chacha.h              | 2 +-
> 5 files changed, 6 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

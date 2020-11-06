Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1632A8FC3
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Nov 2020 08:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKFHAx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Nov 2020 02:00:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35004 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKFHAx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Nov 2020 02:00:53 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kavjv-0007zP-30; Fri, 06 Nov 2020 18:00:52 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Nov 2020 18:00:51 +1100
Date:   Fri, 6 Nov 2020 18:00:51 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - WARN on test failure
Message-ID: <20201106070050.GA11691@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026163112.45163-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently, by default crypto self-test failures only result in a
> pr_warn() message and an "unknown" status in /proc/crypto.  Both of
> these are easy to miss.  There is also an option to panic the kernel
> when a test fails, but that can't be the default behavior.
> 
> A crypto self-test failure always indicates a kernel bug, however, and
> there's already a standard way to report (recoverable) kernel bugs --
> the WARN() family of macros.  WARNs are noisier and harder to miss, and
> existing test systems already know to look for them in dmesg or via
> /proc/sys/kernel/tainted.
> 
> Therefore, call WARN() when an algorithm fails its self-tests.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> crypto/testmgr.c | 20 +++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

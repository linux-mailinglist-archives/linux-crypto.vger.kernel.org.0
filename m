Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B89700624
	for <lists+linux-crypto@lfdr.de>; Fri, 12 May 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbjELK7S (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 May 2023 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjELK6v (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 May 2023 06:58:51 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D2C12E9D
        for <linux-crypto@vger.kernel.org>; Fri, 12 May 2023 03:58:46 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pxQTv-008CA1-Aj; Fri, 12 May 2023 18:58:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 May 2023 18:58:40 +0800
Date:   Fri, 12 May 2023 18:58:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org, Vladis Dronov <vdronov@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>
Subject: Re: [PATCH v3 0/2] crypto: jitter - SHA-3 conditioner and test
 interface
Message-ID: <ZF4b4DHR22f0W5NY@gondor.apana.org.au>
References: <2684670.mvXUDI8C0e@positron.chronox.de>
 <4825604.31r3eYUQgx@positron.chronox.de>
 <2687238.mvXUDI8C0e@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2687238.mvXUDI8C0e@positron.chronox.de>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 21, 2023 at 08:07:39AM +0200, Stephan Müller wrote:
> The patch set replaces the LFSR conditioning function of the Jitter RNG
> with SHA-3 256. This change requires also a new test interface to
> analyze the raw unconditioned noise data.
> 
> Albeit the test interface can be used directly with dd, a small helper
> tool is provided at [1] which can be used to perform the collection
> of raw entropy. The analysis of the data can be done with your favorite
> tool. Or you may use the helper in [2] which uses the NIST SP800-90B
> tool for entropy rate measurement.
> 
> [1] https://github.com/smuellerDD/jitterentropy-library/tree/master/tests/raw-entropy/recording_runtime_kernelspace
> 
> [2] https://github.com/smuellerDD/jitterentropy-library/tree/master/tests/raw-entropy/validation-runtime-kernel
> 
> Changes v3:
> 
> - fix jent_kcapi_init: error code for jent_entropy_collector_alloc now
>   properly cleans up the state
> 
> - fix jent_kcapi_init: initialize lock at the beginning as it is used in
>   error code path function jent_kcapi_cleanup
> 
> - editorial change: update description in MODULE_PARM_DESC in patch 0002
> 
> Changes v2:
> 
> - fix use-after-free by switching shash_desc_zero and crypto_free_shash
>   in jent_mod_init reported by kernel-test-robot
> 
> Stephan Mueller (2):
>   crypto: jitter - replace LFSR with SHA3-256
>   crypto: jitter - add interface for gathering of raw entropy
> 
>  crypto/Kconfig                 |  21 +++
>  crypto/Makefile                |   1 +
>  crypto/jitterentropy-kcapi.c   | 190 ++++++++++++++++++---
>  crypto/jitterentropy-testing.c | 294 +++++++++++++++++++++++++++++++++
>  crypto/jitterentropy.c         | 145 ++++++----------
>  crypto/jitterentropy.h         |  20 ++-
>  6 files changed, 551 insertions(+), 120 deletions(-)
>  create mode 100644 crypto/jitterentropy-testing.c
> 
> -- 
> 2.40.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

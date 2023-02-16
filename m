Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5417B6992A8
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Feb 2023 12:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBPLEk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Feb 2023 06:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBPLEj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Feb 2023 06:04:39 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37CBA
        for <linux-crypto@vger.kernel.org>; Thu, 16 Feb 2023 03:04:38 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pSbag-00BwGl-C5; Thu, 16 Feb 2023 18:34:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Feb 2023 18:34:14 +0800
Date:   Thu, 16 Feb 2023 18:34:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [v2 PATCH 0/10] crypto: api - Restructure stats code
Message-ID: <Y+4GpkkLQjyv7KUt@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

v2 changes:
- Move crypto_alg back to the end, crypto_instance requires this.
- Remove statesize check from shash (digest_null breaks this).
- Remove unnecessary local cryptlen from aead.
- Remove redundant __maybe_unused prototypes.

The stats code resurrected the unions from the early days of
kernel crypto.  This patch series moves them into the individual
crypto algorithm type structures.

The last two patches are minor clean-ups.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

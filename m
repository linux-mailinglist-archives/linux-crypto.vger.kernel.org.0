Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5716CF983
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Mar 2023 05:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjC3DRh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 Mar 2023 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC3DRg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 Mar 2023 23:17:36 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791594EFC
        for <linux-crypto@vger.kernel.org>; Wed, 29 Mar 2023 20:17:35 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1phin4-00AD5Y-3F; Thu, 30 Mar 2023 11:17:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Mar 2023 11:17:30 +0800
Date:   Thu, 30 Mar 2023 11:17:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: hash - Remove maximum statesize limit
Message-ID: <ZCT/SoUW4q5PA4JF@gondor.apana.org.au>
References: <ZCJk8JQV+0N3VwPS@gondor.apana.org.au>
 <ZCJllZQBWfjMCaoQ@gondor.apana.org.au>
 <0ac4854f-a8cb-1344-7de7-3c2579e6eba6@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac4854f-a8cb-1344-7de7-3c2579e6eba6@foss.st.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 29, 2023 at 05:26:29PM +0200, Thomas BOURGOIN wrote:
> Hi herbert,
> 
> I'm testing the serie on STM32MP1.
> I cannot apply the patch on my kernel tree.
> The patch fails to apply for the file crypto/ahash.c
> I tried on tags v6.3-rc1 ans v6.3-p2.
> 
> On which branch can I test your patch ?

Please use the cryptodev tree for all crypto work.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

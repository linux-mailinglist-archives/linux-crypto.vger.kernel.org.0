Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658576B5A2A
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Mar 2023 10:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjCKJm0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 11 Mar 2023 04:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCKJmX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 11 Mar 2023 04:42:23 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AEB13F6BC
        for <linux-crypto@vger.kernel.org>; Sat, 11 Mar 2023 01:42:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pavHM-002xo1-BW; Sat, 11 Mar 2023 17:12:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 11 Mar 2023 17:12:40 +0800
Date:   Sat, 11 Mar 2023 17:12:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [RFC] crypto: qat - enable polling for compression
Message-ID: <ZAxGCBrGWLljLIS4@gondor.apana.org.au>
References: <20230118171411.8088-1-giovanni.cabiddu@intel.com>
 <Y8pQ38EkAK/DVTJ2@gondor.apana.org.au>
 <Y/5DVkSpJ5pSD25V@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/5DVkSpJ5pSD25V@gcabiddu-mobl1.ger.corp.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 28, 2023 at 06:09:26PM +0000, Giovanni Cabiddu wrote:
>
> I might need to do it per tfm as it requires re-configuring the ring
> pair and has an impact on all requests sharing the same.

OK, I was initially worried that putting this in the tfm might
be burdensome for the users.  But given that I'm working on
light-weight tfm cloning for hashing, we can use that here as
well.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21F1733115
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Jun 2023 14:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbjFPMXK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Jun 2023 08:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbjFPMXI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Jun 2023 08:23:08 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414730F2
        for <linux-crypto@vger.kernel.org>; Fri, 16 Jun 2023 05:23:04 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA8Ti-003oWp-Qm; Fri, 16 Jun 2023 20:22:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 20:22:58 +0800
Date:   Fri, 16 Jun 2023 20:22:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Damian Muszynski <damian.muszynski@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH] crypto: qat - add internal timer for qat 4xxx
Message-ID: <ZIxUIjwZMHrZiDg6@gondor.apana.org.au>
References: <20230601091340.12626-1-damian.muszynski@intel.com>
 <ZILrxDmxkHyIZ1Sw@gondor.apana.org.au>
 <ZIMVSDWXOcS6/Whg@dmuszyns-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIMVSDWXOcS6/Whg@dmuszyns-mobl.ger.corp.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 09, 2023 at 02:04:24PM +0200, Damian Muszynski wrote:
>
> We considered the usage of delayed work when implementing this, but it will 
> break functionality. Apart from scheduling the work queue, timer_handler() is 
> incrementing a counter which keeps track of how many times the timer was scheduled.

Please be more specific.  I don't understand why the counter can't
be incremented in the delayed work instead of the timer.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

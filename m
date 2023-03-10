Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BB6B358B
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Mar 2023 05:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCJEWF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Mar 2023 23:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCJEVW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Mar 2023 23:21:22 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A449D3
        for <linux-crypto@vger.kernel.org>; Thu,  9 Mar 2023 20:17:19 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paUBt-002Ofp-CE; Fri, 10 Mar 2023 12:17:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 12:17:13 +0800
Date:   Fri, 10 Mar 2023 12:17:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Meadhbh Fitzpatrick <meadhbh.fitzpatrick@intel.com>,
        linux-crypto@vger.kernel.org,
        Damian Muszynski <damian.muszynski@intel.com>
Subject: Re: [PATCH] crypto: qat - change size of status variable
Message-ID: <ZAqvSeXLDG26E8+O@gondor.apana.org.au>
References: <20230309113306.4008-1-meadhbh.fitzpatrick@intel.com>
 <ZAm3cSjNderM7gzn@gondor.apana.org.au>
 <ZAm9MpyFnU1q2pmc@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAm9MpyFnU1q2pmc@gcabiddu-mobl1.ger.corp.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 09, 2023 at 11:04:18AM +0000, Giovanni Cabiddu wrote:
>
> You are right. Thanks for spotting this.
> When reviewing it I mixed up the cmp_err and xlt_err with the status which
> is a u8.

In general s8/u8 should only be used when you are directly reading
or writing from hardware.  Once the value has entered your driver,
you should use int/unsigned int to deal with them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

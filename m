Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3063870F
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Nov 2022 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKYKH5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Nov 2022 05:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKYKH4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Nov 2022 05:07:56 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0181312AC9
        for <linux-crypto@vger.kernel.org>; Fri, 25 Nov 2022 02:07:51 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyVcR-000ii5-6t; Fri, 25 Nov 2022 18:07:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 18:07:39 +0800
Date:   Fri, 25 Nov 2022 18:07:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>
Subject: Re: [PATCH v2 11/11] crypto: qat - add resubmit logic for
 decompression
Message-ID: <Y4CT61fknX5aNvpa@gondor.apana.org.au>
References: <20221123121032.71991-1-giovanni.cabiddu@intel.com>
 <20221123121032.71991-12-giovanni.cabiddu@intel.com>
 <Y4BKgx2axzqsjWch@gondor.apana.org.au>
 <Y4CO3O21Kx/Ywi6S@gcabiddu-mobl1.ger.corp.intel.com>
 <Y4CRBasSFNhXywKj@gondor.apana.org.au>
 <Y4CTLD7BdfFt5T5X@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4CTLD7BdfFt5T5X@gcabiddu-mobl1.ger.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 25, 2022 at 10:04:28AM +0000, Giovanni Cabiddu wrote:
>
> Just double checking if I understood correctly.
> At the first iteration, i.e. first call to decompress, allocate a
> destination buffer of 2 * src_len rounded up to 4K. If this job fails
> allocate a destination buffer of 128K and retry. If this fails, terminate.

Right, that's what I was suggesting.

Oh and please add the limit to include/crypto/acompress.h so that
it's part of the API.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

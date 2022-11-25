Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735A638347
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Nov 2022 05:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKYEym (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Nov 2022 23:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYEyl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Nov 2022 23:54:41 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883828727
        for <linux-crypto@vger.kernel.org>; Thu, 24 Nov 2022 20:54:40 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQjL-000e0E-7U; Fri, 25 Nov 2022 12:54:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:54:27 +0800
Date:   Fri, 25 Nov 2022 12:54:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vlad Dronov <vdronov@redhat.com>
Subject: Re: [PATCH v2 11/11] crypto: qat - add resubmit logic for
 decompression
Message-ID: <Y4BKgx2axzqsjWch@gondor.apana.org.au>
References: <20221123121032.71991-1-giovanni.cabiddu@intel.com>
 <20221123121032.71991-12-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123121032.71991-12-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 23, 2022 at 12:10:32PM +0000, Giovanni Cabiddu wrote:
>
> +#define MAX_NULL_DST_RETRIES 5

Why do we need this limit? Doesn't that mean that anything that
compresses by a factor of more than 2^5 or 2^6 will fail?

Perhaps it would also be wise to enforce a minimum for dlen in
case of a NULL dst, perhaps PAGE_SIZE just in case slen is very
small and it would take many doublings to get to the right size.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

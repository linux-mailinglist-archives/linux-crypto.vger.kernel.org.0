Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D2691BD6
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Feb 2023 10:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjBJJrY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Feb 2023 04:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBJJrX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Feb 2023 04:47:23 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2677CCA21
        for <linux-crypto@vger.kernel.org>; Fri, 10 Feb 2023 01:47:22 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pQPzx-009c5z-7s; Fri, 10 Feb 2023 17:47:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Feb 2023 17:47:17 +0800
Date:   Fri, 10 Feb 2023 17:47:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Vladis Dronov <vdronov@redhat.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: Re: [PATCH] crypto: qat - drop log level of msg in
 get_instance_node()
Message-ID: <Y+YSpRaDsvznHiy3@gondor.apana.org.au>
References: <20230201170441.29756-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201170441.29756-1-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 01, 2023 at 05:04:41PM +0000, Giovanni Cabiddu wrote:
> The functions qat_crypto_get_instance_node() and
> qat_compression_get_instance_node() allow to get a QAT instance (ring
> pair) on a device close to the node specified as input parameter.
> When this is not possible, and a QAT device is available in the system,
> these function return an instance on a remote node and they print a
> message reporting that it is not possible to find a device on the specified
> node. This is interpreted by people as an error rather than an info.
> 
> The print "Could not find a device on node" indicates that a kernel
> application is running on a core in a socket that does not have a QAT
> device directly attached to it and performance might suffer.
> 
> Due to the nature of the message, this can be considered as a debug
> message, therefore drop the severity to debug and report it only once
> to avoid flooding.
> 
> Suggested-by: Vladis Dronov <vdronov@redhat.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
> ---
>  drivers/crypto/qat/qat_common/qat_compression.c | 2 +-
>  drivers/crypto/qat/qat_common/qat_crypto.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

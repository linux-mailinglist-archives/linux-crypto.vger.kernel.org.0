Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15866733143
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Jun 2023 14:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFPMdA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Jun 2023 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFPMc7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Jun 2023 08:32:59 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03C268A
        for <linux-crypto@vger.kernel.org>; Fri, 16 Jun 2023 05:32:58 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA8dJ-003ouA-AA; Fri, 16 Jun 2023 20:32:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 20:32:53 +0800
Date:   Fri, 16 Jun 2023 20:32:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [RESEND 0/2] crypto: qat - unmap buffers before free
Message-ID: <ZIxWdfxPGoyoFMTb@gondor.apana.org.au>
References: <20230605210607.7185-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605210607.7185-1-giovanni.cabiddu@intel.com>
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

On Mon, Jun 05, 2023 at 10:06:05PM +0100, Giovanni Cabiddu wrote:
> The callbacks functions for RSA and DH free the memory allocated for the
> source and destination buffers before unmapping it.
> This sequence is not correct.
> 
> Change the cleanup sequence to unmap the buffers before freeing them.
> 
> Resending adding Reviewed-by Andy got from an internal review.
> 
> Hareshx Sankar Raj (2):
>   crypto: qat - unmap buffer before free for DH
>   crypto: qat - unmap buffers before free for RSA
> 
>  .../crypto/intel/qat/qat_common/qat_asym_algs.c    | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> -- 
> 2.40.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A84B216F
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Feb 2022 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbiBKJS6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Feb 2022 04:18:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiBKJS6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Feb 2022 04:18:58 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540EA333
        for <linux-crypto@vger.kernel.org>; Fri, 11 Feb 2022 01:18:57 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nIS4o-0003ie-I4; Fri, 11 Feb 2022 20:18:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Feb 2022 20:18:50 +1100
Date:   Fri, 11 Feb 2022 20:18:50 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harman Kalra <hkalra@marvell.com>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Srujana Challa <schalla@marvell.com>,
        linux-crypto@vger.kernel.org, jerinj@marvell.com,
        sgoutham@marvell.com
Subject: Re: [PATCH] crypto: octeontx2 - add synchronization between mailbox
 accesses
Message-ID: <YgYp+mHwwEiLHhCk@gondor.apana.org.au>
References: <20220204124601.3617217-1-hkalra@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204124601.3617217-1-hkalra@marvell.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Feb 04, 2022 at 06:16:01PM +0530, Harman Kalra wrote:
>
>  		offset = msg->next_msgoff;
> +		/* Write barrier required for VF responses which are handled by
> +		 * PF driver and not forwarded to AF.
> +		 */
> +		smp_wmb();

Who is the reader in this case? Is it also part of the kernel?
Because if a device is involved then smp_wmb is not appropriate.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

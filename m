Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC04E4C0A48
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Feb 2022 04:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiBWDcO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Feb 2022 22:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiBWDcO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Feb 2022 22:32:14 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132D2DA80
        for <linux-crypto@vger.kernel.org>; Tue, 22 Feb 2022 19:31:47 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nMiNQ-0006vK-8K; Wed, 23 Feb 2022 14:31:41 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Feb 2022 15:31:40 +1200
Date:   Wed, 23 Feb 2022 15:31:40 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harman Kalra <hkalra@marvell.com>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Srujana Challa <schalla@marvell.com>,
        linux-crypto@vger.kernel.org, jerinj@marvell.com,
        sgoutham@marvell.com
Subject: Re: [PATCH] crypto: octeontx2 - add synchronization between mailbox
 accesses
Message-ID: <YhWqnBOO5eHOusqs@gondor.apana.org.au>
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
> Since there are two workqueues implemented in CPTPF driver - one
> for handling mailbox requests from VFs and another for handling FLR.
> In both cases PF driver will forward the request to AF driver by
> writing to mailbox memory. A race condition may arise if two
> simultaneous requests are written to mailbox memory. Introducing
> locking mechanism to maintain synchronization between multiple
> mailbox accesses.
> 
> Signed-off-by: Harman Kalra <hkalra@marvell.com>
> ---
>  .../marvell/octeontx2/otx2_cpt_common.h       |  1 +
>  .../marvell/octeontx2/otx2_cpt_mbox_common.c  | 14 +++++++++++
>  drivers/crypto/marvell/octeontx2/otx2_cptpf.h |  1 +
>  .../marvell/octeontx2/otx2_cptpf_main.c       | 21 ++++++++++-------
>  .../marvell/octeontx2/otx2_cptpf_mbox.c       | 23 ++++++++++++++-----
>  5 files changed, 46 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

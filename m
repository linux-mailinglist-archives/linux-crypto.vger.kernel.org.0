Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F27643C16
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Dec 2022 05:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiLFEK5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Dec 2022 23:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiLFEKy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Dec 2022 23:10:54 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6C186D8
        for <linux-crypto@vger.kernel.org>; Mon,  5 Dec 2022 20:10:52 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2PI9-004LBT-9L; Tue, 06 Dec 2022 12:10:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 12:10:49 +0800
Date:   Tue, 6 Dec 2022 12:10:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Markus Stockhausen <markus.stockhausen@gmx.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/6] crypto/realtek: add new driver
Message-ID: <Y47AycWFkn48EvL5@gondor.apana.org.au>
References: <20221013184026.63826-1-markus.stockhausen@gmx.de>
 <fe7800282ff11f7822778eb9109864f1f3b144f2.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7800282ff11f7822778eb9109864f1f3b144f2.camel@gmx.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 05, 2022 at 07:47:59PM +0100, Markus Stockhausen wrote:
>
> as I got neither positive nor negative feedback after your last
> question I just want to ask if there is any work for me to do on this
> series?

Sorry about that.

There is still an issue with your import function.  You dereference
the imported state directly.  That is not allowed because there is
no guarantee that the imported state is aligned for a direct CPU
load.

So you'll either need to copy it somewhere first or use an unaligned
load to access hexp->state.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

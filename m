Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4BB674F77
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Jan 2023 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjATI31 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Jan 2023 03:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjATI30 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Jan 2023 03:29:26 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF9C14F
        for <linux-crypto@vger.kernel.org>; Fri, 20 Jan 2023 00:29:22 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pImlz-0028rH-Dk; Fri, 20 Jan 2023 16:29:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Jan 2023 16:29:19 +0800
Date:   Fri, 20 Jan 2023 16:29:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, giovanni.cabiddu@intel.com
Subject: Re: [RFC] crypto: qat - enable polling for compression
Message-ID: <Y8pQ38EkAK/DVTJ2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118171411.8088-1-giovanni.cabiddu@intel.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:
> When a request is synchronous, it is more efficient to submit it and
> poll for a response without going through the interrupt path.

Can you quantify how polling is more efficient? Does it actually make
an observable difference?

> This patch adds logic in the transport layer to poll the response ring
> and enables polling for compression in the QAT driver.
> 
> This is an initial and not complete implementation. The reason why it
> has been sent as RFC is to discuss about ways to mark a request as
> synchronous from the acomp APIs.

What existing (or future) users would benefit from this?

You could poll based on a request flag, e.g., the existing MAY_SLEEP
flag.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

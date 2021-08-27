Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85363F9649
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Aug 2021 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhH0Iiy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Aug 2021 04:38:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54414 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhH0Iiw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Aug 2021 04:38:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mJXN9-0007cC-Ks; Fri, 27 Aug 2021 16:37:59 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mJXN3-0005eC-2W; Fri, 27 Aug 2021 16:37:53 +0800
Date:   Fri, 27 Aug 2021 16:37:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        caihuoqing@baidu.com
Subject: Re: [PATCH] padata: Remove repeated verbose license text
Message-ID: <20210827083753.GA21689@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210822022734.1002-1-caihuoqing@baidu.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Cai Huoqing <caihuoqing@baidu.com> wrote:
> remove it because SPDX-License-Identifier is already used
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> kernel/padata.c | 13 -------------
> 1 file changed, 13 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

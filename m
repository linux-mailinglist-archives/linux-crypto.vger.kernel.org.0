Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0735A663D7
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jul 2019 04:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfGLCU7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 11 Jul 2019 22:20:59 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37410 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfGLCU6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 11 Jul 2019 22:20:58 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hllBA-0007Eg-Gw; Fri, 12 Jul 2019 10:20:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hllB5-0007bd-E3; Fri, 12 Jul 2019 10:20:51 +0800
Date:   Fri, 12 Jul 2019 10:20:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gary R Hook <ghook@amd.com>
Cc:     "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] crypto: ccp - memset structure fields to zero before
 reuse
Message-ID: <20190712022051.jpqpt46mzw625ewv@gondor.apana.org.au>
References: <20190710000849.3131-1-gary.hook@amd.com>
 <20190710015725.GA746@sol.localdomain>
 <2875285f-d438-667e-52d9-801124ffba88@amd.com>
 <20190710203428.GC83443@gmail.com>
 <d4b8006c-0243-b4a4-c695-a67041acc82f@amd.com>
 <20190711004617.GA628@sol.localdomain>
 <7a4dfdce-41ca-2047-f9f2-77e0b7abedb3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4dfdce-41ca-2047-f9f2-77e0b7abedb3@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 11, 2019 at 03:25:00PM +0000, Gary R Hook wrote:
>
> Our device only allows 16 byte tags. So I have to figure out how to set 
> up the driver to expose/enforce that limitation. That's where we go awry.

You need to work around it by using a fallback.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

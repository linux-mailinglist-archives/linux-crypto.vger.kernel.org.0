Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D298AFD
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Aug 2019 07:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfHVFzL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Aug 2019 01:55:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58354 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfHVFzK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Aug 2019 01:55:10 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1i0g3v-0002uy-7k; Thu, 22 Aug 2019 15:55:07 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1i0g3t-00010o-FU; Thu, 22 Aug 2019 15:55:05 +1000
Date:   Thu, 22 Aug 2019 15:55:05 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] crypto: ccp - Ignore unconfigured CCP device on
 suspend/resume
Message-ID: <20190822055505.GA3860@gondor.apana.org.au>
References: <20190819222315.61244-1-gary.hook@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819222315.61244-1-gary.hook@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 19, 2019 at 10:23:27PM +0000, Hook, Gary wrote:
> From: Gary R Hook <gary.hook@amd.com>
> 
> If a CCP is unconfigured (e.g. there are no available queues) then
> there will be no data structures allocated for the device. Thus, we
> must check for validity of a pointer before trying to access structure
> members.
> 
> Fixes: 720419f01832f ("crypto: ccp - Introduce the AMD Secure Processor device")
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/crypto/ccp/ccp-dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

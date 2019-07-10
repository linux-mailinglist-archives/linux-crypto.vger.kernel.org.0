Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3ECF63F0D
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jul 2019 03:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGJB51 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Jul 2019 21:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfGJB51 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Jul 2019 21:57:27 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88862081C;
        Wed, 10 Jul 2019 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562723847;
        bh=4kmJxbSTwak7WxaS9zxyCTA7zuSBK7iwMUMRH5ekjEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=137KtHHrUcBRIARG7MiMu6pVA24uD3bOSggDJpDHyneZyV4g7Vc4WybquSCmuYbjj
         RdO0m43P6O2UMh1i3B4V0bR0PO9J6dPl3tXArhTAGujxhf9VlolezEfdUzfJCj+NSG
         pu2Befw8bg/NocPWLTtOYMv3yVsu8RkUAaU7uSm8=
Date:   Tue, 9 Jul 2019 18:57:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] crypto: ccp - memset structure fields to zero before
 reuse
Message-ID: <20190710015725.GA746@sol.localdomain>
Mail-Followup-To: "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
References: <20190710000849.3131-1-gary.hook@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710000849.3131-1-gary.hook@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 10, 2019 at 12:09:22AM +0000, Hook, Gary wrote:
> The AES GCM function reuses an 'op' data structure, which members
> contain values that must be cleared for each (re)use.
> 
> This fix resolves a crypto self-test failure:
> alg: aead: gcm-aes-ccp encryption test failed (wrong result) on test vector 2, cfg="two even aligned splits"
> 
> Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>

FYI, with this patch applied I'm still seeing another test failure:

[    2.140227] alg: aead: gcm-aes-ccp setauthsize unexpectedly succeeded on test vector "random: alen=264 plen=161 authsize=6 klen=32"; expected_error=-22

Are you aware of that one too, and are you planning to fix it?

- Eric

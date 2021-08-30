Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D3E3FB128
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Aug 2021 08:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhH3G1c (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Aug 2021 02:27:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:54548 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhH3G1b (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Aug 2021 02:27:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mKakf-0001Vs-Bg; Mon, 30 Aug 2021 14:26:37 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mKakc-0007u4-9S; Mon, 30 Aug 2021 14:26:34 +0800
Date:   Mon, 30 Aug 2021 14:26:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v7 0/7] running kernel mode SIMD with softirqs disabled
Message-ID: <20210830062634.GA30356@gondor.apana.org.au>
References: <20210827070342.218276-1-ardb@kernel.org>
 <CAMj1kXEUbPMadj1J7MWD_B-=2zRc2ir_zZQN3Puz3n+PjQw58Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEUbPMadj1J7MWD_B-=2zRc2ir_zZQN3Puz3n+PjQw58Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Aug 29, 2021 at 08:35:37AM +0200, Ard Biesheuvel wrote:
>
> Any chance we could get this queued for v5.15? If it's too late,
> please consider taking only the first three patches as an alternative,
> and I will resend the CCM ones for v5.16 once they have all been
> reviewed.

Sorry, it's too late for that.  If these are to serve as dependencies
for other work, perhaps you can just add my acks to them and
submit them to the trees where they are needed?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

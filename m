Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB069D45AC
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2019 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJKQqA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Oct 2019 12:46:00 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55985 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKQqA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Oct 2019 12:46:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7642192f;
        Fri, 11 Oct 2019 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=R9R0mfHyyZnAUPQzaF1dtZ6xWfc=; b=CY5yILr
        Z3MM4DRiukW8nZ9itx8n6nL0j+yjHQB3e/6s3O5jF7+POkJZ1dGbcdVixi8/E8AN
        g0jFQIdlioQytqRikVwp23ZTBl4MaD/Uq1PRI0C37SEh91eWR5e4o6CvQQvVisMN
        ltqk5lTGlUIa4BY7VyfJMObvGl9Ax8J+TWWQ89TJKqDJSfefL2lfpYcm/1/IdBp5
        FwI8KDNVJG9t26FsLWBmrxbEZXAewdWUpBqEeIQRla7LsF3ryV0oNdeMoS/pumMb
        2Z6TMzwPTfd3cr7Ok0LPTs3iI2ifx0XDZvLxhRfyqL7jPZyuYa3XR/2UAQLCxOcS
        K0a02eJ6kKvLQJw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fb12882c (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 11 Oct 2019 15:58:09 +0000 (UTC)
Date:   Fri, 11 Oct 2019 18:45:50 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>
Subject: Re: [PATCH v3 21/29] crypto: BLAKE2s - generic C library
 implementation and selftest
Message-ID: <20191011164550.GA203415@zx2c4.com>
References: <20191007164610.6881-1-ard.biesheuvel@linaro.org>
 <20191007164610.6881-22-ard.biesheuvel@linaro.org>
 <20191011060232.GB23882@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011060232.GB23882@sol.localdomain>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 10, 2019 at 11:02:32PM -0700, Eric Biggers wrote:
> FYI, I had left a few review comments on Jason's last version of this patch
> (https://lkml.kernel.org/linux-crypto/20190326173759.GA607@zzz.localdomain/),
> some of which Jason addressed in the Wireguard repository
> (https://git.zx2c4.com/WireGuard) but they didn't make it into this patch.
> I'd suggest taking a look at the version there.

Indeed I hadn't updated the Zinc patchset since then, but you can see
the changes since ~March here:

https://git.zx2c4.com/WireGuard/log/src/crypto

There are actually quite a few interesting Blake changes.

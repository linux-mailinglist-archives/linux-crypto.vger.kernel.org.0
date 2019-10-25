Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1668E4F1D
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2019 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfJYO3w (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Oct 2019 10:29:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60890 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392064AbfJYO3w (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Oct 2019 10:29:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iO0at-0000lZ-3y; Fri, 25 Oct 2019 22:29:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iO0aj-0007VZ-0T; Fri, 25 Oct 2019 22:29:25 +0800
Date:   Fri, 25 Oct 2019 22:29:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
        glider@google.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9e3b178624a8a2f8fa28@syzkaller.appspotmail.com>
Subject: Re: [net/tls] Re: KMSAN: uninit-value in aes_encrypt (2)
Message-ID: <20191025142924.7pgxabkbsbvpgygl@gondor.apana.org.au>
References: <00000000000065ef5f0595aafe71@google.com>
 <20191024172353.GA740@sol.localdomain>
 <20191024104537.5a98f5b7@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024104537.5a98f5b7@cakuba.hsd1.ca.comcast.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 24, 2019 at 10:45:37AM -0700, Jakub Kicinski wrote:
>
> Oh, thanks for the CC, I don't see any of these in my inbox. We have 
> 6 TLS maintainers, the 3 that were CCed on the thread above don't
> participate much :(

Can you please ensure that all the maintainers are listed in the
MAINTAINERS file so people can cc them when needed?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

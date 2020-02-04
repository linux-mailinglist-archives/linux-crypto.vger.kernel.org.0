Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D707115170F
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Feb 2020 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBDI27 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Feb 2020 03:28:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:45570 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgBDI27 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Feb 2020 03:28:59 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iytZq-0005tj-Du; Tue, 04 Feb 2020 16:28:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iytZM-0005Lv-89; Tue, 04 Feb 2020 16:28:28 +0800
Date:   Tue, 4 Feb 2020 16:28:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: allow tests to be disabled when manager is
 disabled
Message-ID: <20200204082828.25vvgapbizmxcg34@gondor.apana.org.au>
References: <20200117110136.305162-1-Jason@zx2c4.com>
 <20200122064821.dbjwljxoxo245vnp@gondor.apana.org.au>
 <CAHmME9p8T_1V+3FfUeAMjBLShQk08xR7RQqijov8zWS286hTNg@mail.gmail.com>
 <CAHmME9pxAV=w9wV7Mp12HphaiyQP1VRvWEuoTdNNi7onN178Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pxAV=w9wV7Mp12HphaiyQP1VRvWEuoTdNNi7onN178Kw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 04, 2020 at 09:18:43AM +0100, Jason A. Donenfeld wrote:
> Hi Herbert,
> 
> Can we get this in as a fix for 5.6 please? This is definitely a small
> and trivial bug that's easily fixed here.

Yes I will take this patch for 5.6.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

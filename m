Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478EE2CCAFE
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Dec 2020 01:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgLCAax (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 2 Dec 2020 19:30:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55864 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCAaw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 2 Dec 2020 19:30:52 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kkcVB-0005vo-LM; Thu, 03 Dec 2020 11:29:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Dec 2020 11:29:41 +1100
Date:   Thu, 3 Dec 2020 11:29:41 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Stephen Boyd <swboyd@chromium.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Keerthy <j-keerthy@ti.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: Don't freeze in add_hwgenerator_randomness() if
 stopping kthread
Message-ID: <20201203002941.GA18133@gondor.apana.org.au>
References: <20191110135543.3476097-1-mail@maciej.szmigiero.name>
 <5dcee409.1c69fb81.f5027.48ad@mx.google.com>
 <415922ac-3c87-081c-6fdf-73fc97d0f397@maciej.szmigiero.name>
 <20191117005641.qgremf2lrj46qy4p@gondor.apana.org.au>
 <2f581f84-378f-05cf-1902-f0494aafe706@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f581f84-378f-05cf-1902-f0494aafe706@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 02, 2020 at 04:28:07PM +0200, Horia Geantă wrote:
>
> I wasn't able to find a follow-up on this topic.
> Could you advise on what's the proper thing to do going forward?

I think someone needs to come up with a patch that does not
cause regressions.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBDCFF787
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Nov 2019 05:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfKQEKV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 16 Nov 2019 23:10:21 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49711 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfKQEKU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 16 Nov 2019 23:10:20 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAH49jHK017868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Nov 2019 23:09:47 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7153F4202FD; Sat, 16 Nov 2019 23:09:45 -0500 (EST)
Date:   Sat, 16 Nov 2019 23:09:45 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Keerthy <j-keerthy@ti.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: Don't freeze in add_hwgenerator_randomness() if
 stopping kthread
Message-ID: <20191117040945.GB31360@mit.edu>
References: <20191110135543.3476097-1-mail@maciej.szmigiero.name>
 <5dcee409.1c69fb81.f5027.48ad@mx.google.com>
 <415922ac-3c87-081c-6fdf-73fc97d0f397@maciej.szmigiero.name>
 <20191117005641.qgremf2lrj46qy4p@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117005641.qgremf2lrj46qy4p@gondor.apana.org.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Nov 17, 2019 at 08:56:41AM +0800, Herbert Xu wrote:
> On Sun, Nov 17, 2019 at 12:01:20AM +0100, Maciej S. Szmigiero wrote:
> >
> > If a reader (user space) task is frozen then it is no longer waiting
> > on this waitqueue - at least if I understand correctly how the freezer
> > works for user space tasks, that is by interrupting waits via a fake
> > signal.
> 
> At this point I'm just going to revert the whole thing and we can
> sort it out in the next development cycle.

Thanks, I hadn't planned on taking any /dev/random changes this cycle
because it had gotten too late and the ext4 tree had gotten unusually
busy.

						- Ted

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908CCD5A69
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Oct 2019 06:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfJNEr3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Oct 2019 00:47:29 -0400
Received: from audible.transient.net ([24.143.126.66]:56476 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725554AbfJNEr3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Oct 2019 00:47:29 -0400
Received: (qmail 28518 invoked from network); 14 Oct 2019 04:47:27 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 14 Oct 2019 04:47:27 -0000
Received: (nullmailer pid 5717 invoked by uid 1000);
        Mon, 14 Oct 2019 04:47:27 -0000
Date:   Mon, 14 Oct 2019 04:47:27 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: padlock-aes - convert to skcipher API
Message-ID: <20191014044726.GB3266@audible.transient.net>
References: <20191013041741.265150-1-ebiggers@kernel.org>
 <20191013232050.GA3266@audible.transient.net>
 <20191014031222.GC10007@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014031222.GC10007@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers wrote:
> > I built a patched 5.3.6 with none of the crypto bits modularized
> > and you can find that dmesg and config at:
> > 
> > http://audible.transient.net/~jamie/k/skcipher.config-5.3.6
> > http://audible.transient.net/~jamie/k/skcipher.dmesg
> > 
> 
> Great, I don't see any test failures in the log.  Just to double
> check, you had applied both Ard's patch and this one, right?:
> 
> 	crypto: geode-aes - switch to skcipher for cbc(aes) fallback
> 	crypto: geode-aes - convert to skcipher API and make thread-safe

Er, no?  Just the VIA padlock-aes.c change from you on top of a stock
5.3.6 tree, nothing from Ard.  No geode here.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

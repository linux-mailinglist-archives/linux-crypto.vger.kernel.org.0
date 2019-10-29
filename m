Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF1E8CF5
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Oct 2019 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbfJ2Qnd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 29 Oct 2019 12:43:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43075 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390258AbfJ2Qnc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 29 Oct 2019 12:43:32 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iPUah-0000AM-I8; Tue, 29 Oct 2019 17:43:31 +0100
Message-ID: <226f5a669c2199408abcdec0ccddc9ff05672631.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] enable CAAM's HWRNG as default
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-crypto@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Oct 2019 17:43:30 +0100
In-Reply-To: <20191029162916.26579-1-andrew.smirnov@gmail.com>
References: <20191029162916.26579-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Di, 2019-10-29 at 09:29 -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This series is a continuation of original [discussion]. I don't know
> if what's in the series is enough to use CAAMs HWRNG system wide, but
> I am hoping that with enough iterations and feedback it will be.
> 
> Feedback is welcome!

I'm not sure if we can ever use the job based RNG interface to hook it
up to the Linux HWRNG interface. After all the job based RNG interface
is always a DRNG, which only gets seeded by the TRNG. The reseed
interval is given in number of clock cycles, so there is no clear
correlation between really true random input bits and the number of
DRNG output bits.

I've hacked up some proof of concept code which uses the TRNG access in
the control interface to get the raw TRNG random bits. This seems to
yield about 6400 bit/s of true entropy. It may be better to use this
interface to hook up to the Linux HWRNG framework.

Regards,
Lucas


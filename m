Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39F04241A
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409052AbfFLLfj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Jun 2019 07:35:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56071 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409013AbfFLLfj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Jun 2019 07:35:39 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hb1XV-0002w6-4S; Wed, 12 Jun 2019 13:35:37 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hb1XU-0002rB-Ds; Wed, 12 Jun 2019 13:35:36 +0200
Date:   Wed, 12 Jun 2019 13:35:36 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: ctr(aes) broken in CAAM driver
Message-ID: <20190612113536.eixnu5sqphynyjfr@pengutronix.de>
References: <20190515130746.cvhkxxffrmmynfq3@pengutronix.de>
 <CAOMZO5CJvcipPNY6TXnwwET2fc=zaP3Dj3HPT-zfZpzfqHkeHQ@mail.gmail.com>
 <20190515132225.oczgouglycuhqo4l@pengutronix.de>
 <VI1PR0402MB3485ED478A2A3E0087E81F7C98090@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190612094050.6esonhumzv2ywhdh@pengutronix.de>
 <VI1PR0402MB3485F22CE6052F7CC24AAC3E98EC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3485F22CE6052F7CC24AAC3E98EC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:35:05 up 25 days, 17:53, 84 users,  load average: 0.08, 0.07,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jun 12, 2019 at 10:33:56AM +0000, Horia Geanta wrote:
> On 6/12/2019 12:40 PM, Sascha Hauer wrote:
> > Hi Horia,
> > 
> > On Wed, May 15, 2019 at 01:35:16PM +0000, Horia Geanta wrote:
> >> For talitos, the problem is the lack of IV update.
> >>
> >> For caam, the problem is incorrect IV update (output IV is equal to last
> >> ciphertext block, which is correect for cbc, but not for ctr mode).
> >>
> >> I am working at a fix, but it takes longer since I would like to program the
> >> accelerator to the save the IV (and not do counter increment in SW, which
> >> created problems for many other implementations).
> > 
> > Any news here? With the fix Ard provided gcm(aes) now works again, but
> > only as long as the crypto self tests are disabled.
> > 
> I've recently submitted support for IV update done in HW (caam engine),
> which fixes this issue:
> https://patchwork.kernel.org/cover/10984927/

Thanks, I haven't seen this. I'll give it a try.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

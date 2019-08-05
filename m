Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E735E819B0
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2019 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfHEMnd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Aug 2019 08:43:33 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51313 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfHEMnb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:31 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C80FD240008;
        Mon,  5 Aug 2019 12:43:28 +0000 (UTC)
Date:   Mon, 5 Aug 2019 14:43:28 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCHv3 4/4] crypto: inside-secure - add support for using the
 EIP197 without vendor firmware
Message-ID: <20190805124328.GK14470@kwain>
References: <1564586959-9963-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1564586959-9963-5-git-send-email-pvanleeuwen@verimatrix.com>
 <20190805090725.GH14470@kwain>
 <MN2PR20MB29730648846013A67753624ECADA0@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190805095424.GJ14470@kwain>
 <MN2PR20MB2973944BBF39EB11537E3163CADA0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR20MB2973944BBF39EB11537E3163CADA0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 05, 2019 at 10:12:07AM +0000, Pascal Van Leeuwen wrote:
> > From: Antoine Tenart <antoine.tenart@bootlin.com>
> > On Mon, Aug 05, 2019 at 09:48:13AM +0000, Pascal Van Leeuwen wrote:
> > > > On Wed, Jul 31, 2019 at 05:29:19PM +0200, Pascal van Leeuwen wrote:
> > > > >
> > > > > -	/* Release engine from reset */
> > > > > -	val = readl(EIP197_PE(priv) + ctrl);
> > > > > -	val &= ~EIP197_PE_ICE_x_CTRL_SW_RESET;
> > > > > -	writel(val, EIP197_PE(priv) + ctrl);
> > > > > +	for (pe = 0; pe < priv->config.pes; pe++) {
> > > > > +		base = EIP197_PE_ICE_SCRATCH_RAM(pe);
> > > > > +		pollcnt = EIP197_FW_START_POLLCNT;
> > > > > +		while (pollcnt &&
> > > > > +		       (readl_relaxed(EIP197_PE(priv) + base +
> > > > > +			      pollofs) != 1)) {
> > > > > +			pollcnt--;
> > > >
> > > > You might want to use readl_relaxed_poll_timeout() here, instead of a
> > > > busy polling.
> > > >
> > > Didn't know such a thing existed, but I also wonder how appropriate it
> > > is in this case, condering it measures in whole microseconds, while the
> > > response time I'm expecting here is in the order of a few dozen nano-
> > > seconds internally ... i.e. 1 microsecond is already a *huge* overkill.
> > >
> > > The current implementation runs that loop for only 16 iterations which
> > > should be both more than sufficient (it probably could be reduced
> > > further, I picked 16 rather arbitrarily) and at the same time take so
> > > few cycles on the CPU that I doubt it is worthwhile to reschedule/
> > > preempt/whatever?
> > 
> > Your choice, I was just making a suggestion :)
> > 
> After reading the implementation code, I think using it with a 
> sleep_us value of 0 and a time-out value of 1 may be reasonable here,
> as time-out means some serious error that shouldn't normally happen.
> I just wouldn't want any microsecond delays for the "normal" case.

Using this function that is designed to sleep with a delay of 0 and
designed to timeout with a value of 1 does not seem to follow what the
function is designed for :) It could work but I would suggest to keep
the polling as it is in the patch in this case.

Thanks,
Antoine

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

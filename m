Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2495D60806
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jul 2019 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfGEOjm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Jul 2019 10:39:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59817 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfGEOjm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Jul 2019 10:39:42 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 648A060005;
        Fri,  5 Jul 2019 14:39:40 +0000 (UTC)
Date:   Fri, 5 Jul 2019 16:39:40 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: inside-secure - remove unused struct entry
Message-ID: <20190705143940.GG3926@kwain>
References: <1562314645-22949-1-git-send-email-pvanleeuwen@verimatrix.com>
 <20190705141800.GE3926@kwain>
 <MN2PR20MB297394029C591248FA258760CAF50@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR20MB297394029C591248FA258760CAF50@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 05, 2019 at 02:32:46PM +0000, Pascal Van Leeuwen wrote:
> > From: Antoine Tenart <antoine.tenart@bootlin.com>
> > 
> > You should wait for either those patches to be merged (or directly
> > integrate this change in a newer version of those patches), or send this
> > patch in the same series. Otherwise it's problematic as you do not know
> > which patches will be applied first.
> 
> This patch indeed depends on earlier patches. I was just assuming 
> people to be smart enough to apply the patches in the correct order :-)

It's actually very difficult for a maintainer to remember this,
especially when he has to deal with plenty of patches from many
contributors. And some series can take time to be merged while others
can be accepted easily, so it's hard to keep track of dependencies :)

> So please ignore, I'll either resend or incorporate it in an update of the 
> earlier series later. It's nothing important (i.e. functional) anyway.

Thank you!

Antoine

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868AC814C5
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2019 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfHEJJ7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Aug 2019 05:09:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60987 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJJ6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Aug 2019 05:09:58 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D5563FF804;
        Mon,  5 Aug 2019 09:09:56 +0000 (UTC)
Date:   Mon, 5 Aug 2019 11:09:56 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCHv3 3/4] crypto: inside-secure - add support for PCI based
 FPGA development board
Message-ID: <20190805090956.GI14470@kwain>
References: <1564586959-9963-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1564586959-9963-4-git-send-email-pvanleeuwen@verimatrix.com>
 <20190805083602.GG14470@kwain>
 <MN2PR20MB29735954E5670FE3476F18B6CADA0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR20MB29735954E5670FE3476F18B6CADA0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

On Mon, Aug 05, 2019 at 08:47:42AM +0000, Pascal Van Leeuwen wrote:
> 
> Thanks for the review and I agree with all of your comments below.
> So I'm willing to fix those but I'm a bit unclear of the procedure now,
> since you acked part of the patch set already.
> 
> Should I resend just the subpatches that need fixes or should I resend 
> the whole patchset? Please advise :-)

You should add my Acked-by tag on the first two patches (below your SoB
tag), and then yes please resubmit the whole series.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

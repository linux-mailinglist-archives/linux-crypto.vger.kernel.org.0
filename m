Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF462B80D
	for <lists+linux-crypto@lfdr.de>; Mon, 27 May 2019 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfE0PBB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 May 2019 11:01:01 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41367 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfE0PBA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 May 2019 11:01:00 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9472524000B;
        Mon, 27 May 2019 15:00:58 +0000 (UTC)
Date:   Mon, 27 May 2019 17:00:58 +0200
From:   "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>
To:     Pascal Van Leeuwen <pvanleeuwen@insidesecure.com>
Cc:     "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: crypto: inside_secure - call for volunteers
Message-ID: <20190527150057.GD8900@kwain>
References: <DBBPR09MB352627DA3C425CECC763B99FD23A0@DBBPR09MB3526.eurprd09.prod.outlook.com>
 <20190430132653.GB3508@kwain>
 <DBBPR09MB352652D305657569DCA6E436D23A0@DBBPR09MB3526.eurprd09.prod.outlook.com>
 <20190430135542.GC3508@kwain>
 <AM6PR09MB3523E393D4EA082FDDBC9251D2090@AM6PR09MB3523.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR09MB3523E393D4EA082FDDBC9251D2090@AM6PR09MB3523.eurprd09.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

On Wed, May 15, 2019 at 09:02:42AM +0000, Pascal Van Leeuwen wrote:
> 
> It's been 2 weeks already so I'm kind of curious if either one of you
> managed to try anything with my modified Inside Secure driver yet?
> Note that if you experience any issues at all that:
> 
> a) I'd be very interested to hear about them
> b) I'm fully willing to help resolve those issues
> 
> BTW: if there are no issues and everything worked fine I'm also
> interested to hear about that :-)

Sorry about the looong delay. I did make a quick test of your series and
had some issues:
- You added use of PCI helpers, but this new dependency wasn't described
  in Kconfig (leading to have build issues).
- Using an EIP197 and a MacchiatoBin many of the boot tests did not
  pass (but I haven't look into it).

I'll perform the test again to at least give you a trace :)

Btw, I'm available on IRC (atenart on Freenode), that might be easier to
have a discussion when debugging things.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

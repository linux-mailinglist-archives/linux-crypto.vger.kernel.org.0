Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E727B7C541
	for <lists+linux-crypto@lfdr.de>; Wed, 31 Jul 2019 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfGaOps (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 31 Jul 2019 10:45:48 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39487 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfGaOps (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 31 Jul 2019 10:45:48 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 06F6460014;
        Wed, 31 Jul 2019 14:45:44 +0000 (UTC)
Date:   Wed, 31 Jul 2019 16:45:44 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCHv2 3/3] crypto: inside-secure - add support for using the
 EIP197 without vendor firmware
Message-ID: <20190731144544.GE3579@kwain>
References: <1564145005-26731-1-git-send-email-pvanleeuwen@verimatrix.com>
 <1564145005-26731-4-git-send-email-pvanleeuwen@verimatrix.com>
 <20190731122629.GC3579@kwain>
 <MN2PR20MB297305FF43E83B4BBB5728B7CADF0@MN2PR20MB2973.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR20MB297305FF43E83B4BBB5728B7CADF0@MN2PR20MB2973.namprd20.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 31, 2019 at 02:23:27PM +0000, Pascal Van Leeuwen wrote:
> > From: Antoine Tenart <antoine.tenart@bootlin.com>
> 
> > What happens if i < 2 ?
> > 
> Ok, I did not consider that as it can't happen for any kind of legal FW. But it
> wouldn't be pretty (neither would 2 itself, BTW). I could throw an error for it
> but it wouldn't make that much sense as we don't do any checks on the firm-
> ware *contents* either ... So either way, if your firmware file is no good, you
> have a problem ...

The thing is to avoid doing harm to the kernel if a single driver can't
work as expected, especially when we have an user input (the firmware).
The firmware being a valid one is another topic. But honestly I'm not
sure if a wrong returned value would change anything here, apart from
not probing the driver successfully as we know something went wrong.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E974B85B
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Jun 2019 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfFSMay (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Jun 2019 08:30:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:49939 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731931AbfFSMax (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:53 -0400
Received: from localhost (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AA24E20000A;
        Wed, 19 Jun 2019 12:30:50 +0000 (UTC)
Date:   Wed, 19 Jun 2019 14:30:50 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@insidesecure.com>
Subject: Re: [PATCH 2/3] crypto: inside-secure - add support for PCI based
 FPGA development board
Message-ID: <20190619123050.GD3254@kwain>
References: <1560837384-29814-1-git-send-email-pvanleeuwen@insidesecure.com>
 <1560837384-29814-3-git-send-email-pvanleeuwen@insidesecure.com>
 <20190619121502.GA3254@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619121502.GA3254@kwain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Pascal,

On Wed, Jun 19, 2019 at 02:15:02PM +0200, Antoine Tenart wrote:
> On Tue, Jun 18, 2019 at 07:56:23AM +0200, Pascal van Leeuwen wrote:
> 
> More generally, you should protect all the PCI specific functions and
> definitions between #ifdef.

And I think there are compilation issues if CONFIG_PCI is disabled with
this patch. This approach would probably fix it.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

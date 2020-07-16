Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C841D222221
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGPME3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 08:04:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40212 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgGPME3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 08:04:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jw2ce-0000To-JH; Thu, 16 Jul 2020 22:04:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 22:04:20 +1000
Date:   Thu, 16 Jul 2020 22:04:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/1] inside-secure irq balance
Message-ID: <20200716120420.GA31780@gondor.apana.org.au>
References: <20200708150844.2626m3pgdo5oidzm@SvensMacBookAir.sven.lan>
 <20200716072133.GA28028@gondor.apana.org.au>
 <CY4PR0401MB3652C2232E0B0A7951B84596C37F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200716092136.j4xt2s4ogr7murod@SvensMacbookPro.hq.voleatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716092136.j4xt2s4ogr7murod@SvensMacbookPro.hq.voleatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 16, 2020 at 11:21:36AM +0200, Sven Auhagen wrote:
>
> You are correct, let me have a look at how to get the cpu bit correctly.
> Well everything runs on the first CPU now, what do you do if that does down or up?
> I think there is no mechanism in general at the moment for the current or my implementation.

Unless the driver changed it the default affinity should be all
CPUs, no? In which case if the first CPU goes down it'll just move
to the second CPU.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

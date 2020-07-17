Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C68223D4D
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jul 2020 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGQNuP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jul 2020 09:50:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:44332 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgGQNuN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jul 2020 09:50:13 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jwQkU-0005Cj-VX; Fri, 17 Jul 2020 23:50:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Jul 2020 23:50:02 +1000
Date:   Fri, 17 Jul 2020 23:50:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/1] inside-secure irq balance
Message-ID: <20200717135002.GA4044@gondor.apana.org.au>
References: <20200708150844.2626m3pgdo5oidzm@SvensMacBookAir.sven.lan>
 <20200716072133.GA28028@gondor.apana.org.au>
 <CY4PR0401MB3652C2232E0B0A7951B84596C37F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <20200716092136.j4xt2s4ogr7murod@SvensMacbookPro.hq.voleatech.com>
 <20200716120420.GA31780@gondor.apana.org.au>
 <20200717050134.dk5naairvhmyyxyu@SvensMacBookAir.sven.lan>
 <20200717052050.GA2045@gondor.apana.org.au>
 <20200717063504.sdmjt75oh2jp7z62@SvensMacBookAir.hq.voleatech.com>
 <20200717065738.GC2504@gondor.apana.org.au>
 <20200717075334.vg7nvidds25f5ltb@SvensMacBookAir.hq.voleatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717075334.vg7nvidds25f5ltb@SvensMacBookAir.hq.voleatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 17, 2020 at 09:53:34AM +0200, Sven Auhagen wrote:
>
> I do not have access to a numa node inside the inside secure
> driver and can only use -1 as the cpumask_local_spread numa node.
> Is that what you are looking for?

Yes, at least it won't be giving us CPUs that are off-line.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

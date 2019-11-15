Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74380FD5B8
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfKOGGN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:06:13 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57852 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKOGGM (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 15 Nov 2019 01:06:12 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUkF-0004hB-OZ; Fri, 15 Nov 2019 14:06:11 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUkE-00065p-Bj; Fri, 15 Nov 2019 14:06:10 +0800
Date:   Fri, 15 Nov 2019 14:06:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Vitaly Andrianov <vitalya@ti.com>
Subject: Re: [PATCH] hwrng: ks-sa: Add minimum sleep time before ready-polling
Message-ID: <20191115060610.2sjw7stopxr73jhn@gondor.apana.org.au>
References: <20191106093019.117233-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106093019.117233-1-alexander.sverdlin@nokia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 06, 2019 at 09:30:49AM +0000, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Current polling timeout is 25 us. The hardware is currently configured to
> harvest the entropy for 81920 us. This leads to timeouts even during
> blocking read (wait=1).
> 
> Log snippet:
> [    5.727589] [<c040ffcc>] (ks_sa_rng_probe) from [<c04181e8>] (platform_drv_probe+0x58/0xb4)
> ...
> [    5.727805] hwrng: no data available
> ...
> [   13.157016] random: systemd: uninitialized urandom read (16 bytes read)
> [   13.157033] systemd[1]: Initializing machine ID from random generator.
> ...
> [   15.848770] random: fast init done
> ...
> [   15.848807] random: crng init done
> 
> After the patch:
> [    6.223534] random: systemd: uninitialized urandom read (16 bytes read)
> [    6.223551] systemd[1]: Initializing machine ID from random generator.
> ...
> [    6.876075] random: fast init done
> ...
> [    6.954200] random: systemd: uninitialized urandom read (16 bytes read)
> [    6.955244] random: systemd: uninitialized urandom read (16 bytes read)
> ...
> [    7.121948] random: crng init done
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  drivers/char/hw_random/ks-sa-rng.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

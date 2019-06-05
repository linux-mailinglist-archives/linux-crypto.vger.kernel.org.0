Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D135CE5
	for <lists+linux-crypto@lfdr.de>; Wed,  5 Jun 2019 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfFEMcG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 5 Jun 2019 08:32:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:41920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbfFEMcF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 5 Jun 2019 08:32:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D62CAE8B;
        Wed,  5 Jun 2019 12:32:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D58EDA843; Wed,  5 Jun 2019 14:32:54 +0200 (CEST)
Date:   Wed, 5 Jun 2019 14:32:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        keescook@chromium.org, gustavo@embeddedor.com, joe@perches.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        terrelln@fb.com
Subject: Re: [PATCH 1/4] zstd: pass pointer rathen than structure to functions
Message-ID: <20190605123253.GZ15290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Andrew Morton <akpm@linux-foundation.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        keescook@chromium.org, gustavo@embeddedor.com, joe@perches.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        terrelln@fb.com
References: <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
 <CGME20190603090232epcas5p1630d0584e8a1aa9495edc819605664fc@epcas5p1.samsung.com>
 <1559552526-4317-2-git-send-email-maninder1.s@samsung.com>
 <20190604154326.8868a10f896c148a0ce804d1@linux-foundation.org>
 <20190605115703.GY15290@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605115703.GY15290@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jun 05, 2019 at 01:57:03PM +0200, David Sterba wrote:
> On Tue, Jun 04, 2019 at 03:43:26PM -0700, Andrew Morton wrote:
> > On Mon,  3 Jun 2019 14:32:03 +0530 Maninder Singh <maninder1.s@samsung.com> wrote:
> > 
> > > currently params structure is passed in all functions, which increases
> > > stack usage in all the function and lead to stack overflow on target like
> > > ARM with kernel stack size of 8 KB so better to pass pointer.
> > > 
> > > Checked for ARM:
> > > 
> > >                                 Original               Patched
> > > Call FLow Size:                  1264                   1040
> > > ....
> > > (HUF_sort)                      -> 296
> > > (HUF_buildCTable_wksp)          -> 144
> > > (HUF_compress4X_repeat)         -> 88
> > > (ZSTD_compressBlock_internal)   -> 200
> > > (ZSTD_compressContinue_internal)-> 136                  -> 88
> > > (ZSTD_compressCCtx)             -> 192                  -> 64
> > > (zstd_compress)                 -> 144                  -> 96
> > > (crypto_compress)               -> 32
> > > (zcomp_compress)                -> 32
> > > ....
> > > 
> > > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> > > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> > > 
> > 
> > You missed btrfs.  This needs review, please - particularly the
> > kernel-wide static ZSTD_parameters in zstd_get_btrfs_parameters().
> 
> > 
> > The base patch is here:
> > 
> > http://lkml.kernel.org/r/1559552526-4317-2-git-send-email-maninder1.s@samsung.com  
> > 
> > --- a/fs/btrfs/zstd.c~zstd-pass-pointer-rathen-than-structure-to-functions-fix
> > +++ a/fs/btrfs/zstd.c
> > @@ -27,15 +27,17 @@
> >  /* 307s to avoid pathologically clashing with transaction commit */
> >  #define ZSTD_BTRFS_RECLAIM_JIFFIES (307 * HZ)
> >  
> > -static ZSTD_parameters zstd_get_btrfs_parameters(unsigned int level,
> > +static ZSTD_parameters *zstd_get_btrfs_parameters(unsigned int level,
> >  						 size_t src_len)
> >  {
> > -	ZSTD_parameters params = ZSTD_getParams(level, src_len, 0);
> > +	static ZSTD_parameters params;
> 
> > +
> > +	params = ZSTD_getParams(level, src_len, 0);
> 
> No thats' broken, the params can't be static as it depends on level and
> src_len. What happens if there are several requests in parallel with
> eg. different levels?
> 
> Would be really great if the mailinglist is CCed when the code is
> changed in a non-trivial way.

So this does not compile fs/btrfs/zstd.o which Andrew probably found
too, otherwise btrfs is the only in-tree user of the function outside of
lib/ and crypto/.

I think that Nick Terrell should have been CCed too, as he ported zstd
to linux.

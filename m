Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC15BB9AB1
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Sep 2019 01:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404757AbfITX2u (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Sep 2019 19:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404621AbfITX2u (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Sep 2019 19:28:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB4A2070C;
        Fri, 20 Sep 2019 23:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569022129;
        bh=CAbZ84WKONW+t7eKvZY0iLJYWWpttBNaUPe/GI/2yAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dXI923zm3OtD0Z4zZt3Mba+OlKgyAYmkUUUmoBl6FdLxtazIPu7a2BStL3Ljd3tsD
         RXuuP8w5HADP9/cQKuPHCaLWSchZAwT0v54gLCvsFgELITS9deTHMvnmVH9dO4zFkB
         3FStVq/pqxfv294BugLGDU3RTz7GPPkJS+25D5WA=
Date:   Fri, 20 Sep 2019 16:28:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        Atul Gupta <atul.gupta@chelsio.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: Introduce page_size()
Message-Id: <20190920162848.950dd70264e670a485f410dc@linux-foundation.org>
In-Reply-To: <20190723160248.GK363@bombadil.infradead.org>
References: <20190721104612.19120-1-willy@infradead.org>
        <20190721104612.19120-2-willy@infradead.org>
        <20190723004307.GB10284@iweiny-DESK2.sc.intel.com>
        <20190723160248.GK363@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 23 Jul 2019 09:02:48 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jul 22, 2019 at 05:43:07PM -0700, Ira Weiny wrote:
> > > diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
> > > index 551bca6fef24..925be5942895 100644
> > > --- a/drivers/crypto/chelsio/chtls/chtls_io.c
> > > +++ b/drivers/crypto/chelsio/chtls/chtls_io.c
> > > @@ -1078,7 +1078,7 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> > >  			bool merge;
> > >  
> > >  			if (page)
> > > -				pg_size <<= compound_order(page);
> > > +				pg_size = page_size(page);
> > >  			if (off < pg_size &&
> > >  			    skb_can_coalesce(skb, i, page, off)) {
> > >  				merge = 1;
> > > @@ -1105,8 +1105,7 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> > >  							   __GFP_NORETRY,
> > >  							   order);
> > >  					if (page)
> > > -						pg_size <<=
> > > -							compound_order(page);
> > > +						pg_size <<= order;
> > 
> > Looking at the code I see pg_size should be PAGE_SIZE right before this so why
> > not just use the new call and remove the initial assignment?
> 
> This driver is really convoluted.  I wasn't certain I wouldn't break it
> in some horrid way.  I made larger changes to it originally, then they
> touched this part of the driver and I had to rework the patch to apply
> on top of their changes.  So I did something more minimal.
> 
> This, on top of what's in Andrew's tree, would be my guess, but I don't
> have the hardware.
> 
> diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
> index 925be5942895..d4eb0fcd04c7 100644
> --- a/drivers/crypto/chelsio/chtls/chtls_io.c
> +++ b/drivers/crypto/chelsio/chtls/chtls_io.c
> @@ -1073,7 +1073,7 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  		} else {
>  			int i = skb_shinfo(skb)->nr_frags;
>  			struct page *page = TCP_PAGE(sk);
> -			int pg_size = PAGE_SIZE;
> +			unsigned int pg_size = 0;
>  			int off = TCP_OFF(sk);
>  			bool merge;
>  
> @@ -1092,7 +1092,7 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  			if (page && off == pg_size) {
>  				put_page(page);
>  				TCP_PAGE(sk) = page = NULL;
> -				pg_size = PAGE_SIZE;
> +				pg_size = 0;
>  			}
>  
>  			if (!page) {
> @@ -1104,15 +1104,13 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  							   __GFP_NOWARN |
>  							   __GFP_NORETRY,
>  							   order);
> -					if (page)
> -						pg_size <<= order;
>  				}
>  				if (!page) {
>  					page = alloc_page(gfp);
> -					pg_size = PAGE_SIZE;
>  				}
>  				if (!page)
>  					goto wait_for_memory;
> +				pg_size = page_size(page);
>  				off = 0;
>  			}

I didn't do anything with this.  I assume the original patch (which has
been in -next since July 22) is good and the above is merely a cleanup?



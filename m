Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6BD213B
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Oct 2019 08:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbfJJG4L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Oct 2019 02:56:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732930AbfJJG4K (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Oct 2019 02:56:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DA0D3001A6C;
        Thu, 10 Oct 2019 06:56:10 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C749519D70;
        Thu, 10 Oct 2019 06:56:04 +0000 (UTC)
Date:   Thu, 10 Oct 2019 14:56:00 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] lib/string: make memzero_explicit inline instead of
 external
Message-ID: <20191010065600.GA9838@dhcp-128-65.nay.redhat.com>
References: <1d17349e-98ab-b582-6981-b484b0e970b6@redhat.com>
 <20191007220000.GA408752@rani.riverdale.lan>
 <20191010025229.GA3376@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010025229.GA3376@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 10 Oct 2019 06:56:10 +0000 (UTC)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 10/10/19 at 10:52am, Dave Young wrote:
> On 10/07/19 at 06:00pm, Arvind Sankar wrote:
> > With the use of the barrier implied by barrier_data(), there is no need
> > for memzero_explicit to be extern. Making it inline saves the overhead
> > of a function call, and allows the code to be reused in arch/*/purgatory
> > without having to duplicate the implementation.
> > 
> > Fixes: 906a4bb97f5d ("crypto: sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > ---
> >  include/linux/string.h | 21 ++++++++++++++++++++-
> >  lib/string.c           | 21 ---------------------
> >  2 files changed, 20 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index b2f9df7f0761..b6ccdc2c7f02 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -227,7 +227,26 @@ static inline bool strstarts(const char *str, const char *prefix)
> >  }
> >  
> >  size_t memweight(const void *ptr, size_t bytes);
> > -void memzero_explicit(void *s, size_t count);
> > +
> > +/**
> > + * memzero_explicit - Fill a region of memory (e.g. sensitive
> > + *		      keying data) with 0s.
> > + * @s: Pointer to the start of the area.
> > + * @count: The size of the area.
> > + *
> > + * Note: usually using memset() is just fine (!), but in cases
> > + * where clearing out _local_ data at the end of a scope is
> > + * necessary, memzero_explicit() should be used instead in
> > + * order to prevent the compiler from optimising away zeroing.
> > + *
> > + * memzero_explicit() doesn't need an arch-specific version as
> > + * it just invokes the one of memset() implicitly.
> > + */
> > +static inline void memzero_explicit(void *s, size_t count)
> > +{
> > +	memset(s, 0, count);
> > +	barrier_data(s);
> > +}
> >  
> >  /**
> >   * kbasename - return the last part of a pathname.
> > diff --git a/lib/string.c b/lib/string.c
> > index cd7a10c19210..08ec58cc673b 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -748,27 +748,6 @@ void *memset(void *s, int c, size_t count)
> >  EXPORT_SYMBOL(memset);
> >  #endif
> >  
> > -/**
> > - * memzero_explicit - Fill a region of memory (e.g. sensitive
> > - *		      keying data) with 0s.
> > - * @s: Pointer to the start of the area.
> > - * @count: The size of the area.
> > - *
> > - * Note: usually using memset() is just fine (!), but in cases
> > - * where clearing out _local_ data at the end of a scope is
> > - * necessary, memzero_explicit() should be used instead in
> > - * order to prevent the compiler from optimising away zeroing.
> > - *
> > - * memzero_explicit() doesn't need an arch-specific version as
> > - * it just invokes the one of memset() implicitly.
> > - */
> > -void memzero_explicit(void *s, size_t count)
> > -{
> > -	memset(s, 0, count);
> > -	barrier_data(s);
> > -}
> > -EXPORT_SYMBOL(memzero_explicit);
> > -
> >  #ifndef __HAVE_ARCH_MEMSET16
> >  /**
> >   * memset16() - Fill a memory area with a uint16_t
> > -- 
> 
> Thanks for the fix!  Ccing kexec list since the problem is kexec/kdump
> related.  People can try it when they see same issue.
> 

Also:

Tested-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


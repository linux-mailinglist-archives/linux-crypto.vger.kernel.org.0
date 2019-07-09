Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5161863E0A
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jul 2019 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGIW4Z (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Jul 2019 18:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGIW4Y (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Jul 2019 18:56:24 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA6320693;
        Tue,  9 Jul 2019 22:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562712984;
        bh=J6W7sUp70RTbsExh4OMZ0wHEnDSwXb4Yk6ProJWsGuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8HItla4z2mcqc9/Pp9RfqNetEQAPbIoeUWg2UGYhligZSdTSHjGDeCLIJ39Wtfsz
         uE84oIDu8N570F2fPalxKu81cEmDoCc9fa0FHirEfQBrV5yM7wEpd7E8U1xEHftaBB
         OXNrUsijpSoLKvcTqajPm3fO1bRyQQ8ZkS34JYss=
Date:   Tue, 9 Jul 2019 15:56:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gary R Hook <ghook@amd.com>
Cc:     "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: ccp - memset structure fields to zero before
 reuse
Message-ID: <20190709225622.GN641@sol.localdomain>
Mail-Followup-To: Gary R Hook <ghook@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <156218168473.3184.15319927087462863547.stgit@sosrh3.amd.com>
 <20190705194028.GB4022@sol.localdomain>
 <2cc5e065-0fce-5278-9c38-3bdd4755f21f@amd.com>
 <20190709201014.GH641@sol.localdomain>
 <c770ea90-fad8-8379-76ad-889e410b6d74@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c770ea90-fad8-8379-76ad-889e410b6d74@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 09, 2019 at 10:09:16PM +0000, Gary R Hook wrote:
> On 7/9/19 3:10 PM, Eric Biggers wrote:
> > On Mon, Jul 08, 2019 at 05:08:09PM +0000, Gary R Hook wrote:
> >> On 7/5/19 2:40 PM, Eric Biggers wrote:
> >>> Hi Gary,
> >>>
> >>> On Wed, Jul 03, 2019 at 07:21:26PM +0000, Hook, Gary wrote:
> >>>> The AES GCM function reuses an 'op' data structure, which members
> >>>> contain values that must be cleared for each (re)use.
> >>>>
> >>>> Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
> >>>>
> >>>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> >>>> ---
> >>>>    drivers/crypto/ccp/ccp-ops.c |   12 +++++++++++-
> >>>>    1 file changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> Is this patch meant to fix the gcm-aes-ccp self-tests failure?
> >>
> >> Yessir, that is the intention. Apologies for not clarifying that point.
> >>
> >> grh
> > 
> > Okay, it would be helpful if you'd explain that in the commit message.
> 
> Gah. Of course. I'll repost.
> 
> > Also, what branch does this patch apply to?  It doesn't apply to cryptodev.
> 
> I have endeavored to make a "git pull" and a full build a required, 
> regular part of my submission process, having made (plenty of) mistakes 
> in the past. I did so last week before posting this, and the patch 
> applied then, and applies now in my local copy, before and after a git 
> pull today.
> 
> We've been having trouble with our SMTP mail server, and patches have 
> been going out base64 encoded. I'm willing to bet that's what you're 
> wrestling with.
> 
> The last patch of mine that Herbert applied appeared to be encoded 
> thusly, but he was able to successfully apply it.
> 
> I've been experimenting with changing the transfer encoding value 
> (charset=) to iso-8859-1 and us-ascii, but the best I can do is an 
> encoding that contains a lot of "=##" stuff. I'm not sure that's any 
> better, but my recent documentation patches contained those, and Herbert 
> was also able to apply them.
> 
> We'd really like to know what Herbert does to accommodate these 
> non-textual emails? And is that something that others could do?
> 

What I did was simply save your email and use 'git am -3' to try to apply it.
It didn't work.

Yes, your email is base64 encoded, which apparently 'git am' handles.  But even
after base64 decoding your patch has an extra blank line at the end, which
corrupts it since it's part of the diff context.

Can't you just use git send-email like everyone else?

- Eric

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D9463A42
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Nov 2021 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhK3Pmj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Nov 2021 10:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhK3Pmf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Nov 2021 10:42:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B7C061748;
        Tue, 30 Nov 2021 07:39:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F11BCE1A44;
        Tue, 30 Nov 2021 15:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDECFC53FC7;
        Tue, 30 Nov 2021 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638286752;
        bh=9wV20obSinXS+ABsgOuQMAFzhvhGcNOouX9VfzNg/S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=METdwXbwh7NFIXdrY/nO4exuSLNBH3QC37K8CD6oZ3Kl7RnJsNV9fRkZDl8B5fqZf
         np2XYSRXfUpATJC16TKmsvQduKfDNgWO29rPgqYy2kzlPCyXUpMh3z2LtB6SIwBjv1
         1m+cZx5qHv5fzXbx0/Vll5sDbH9Cp62K8Iq7luIk=
Date:   Tue, 30 Nov 2021 16:39:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Simo Sorce <simo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YaZFni65mRi7Yx/4@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
 <22137816.pfsBpAd9cS@tauon.chronox.de>
 <YaEJtv4A6SoDFYjc@kroah.com>
 <9311513.S0ZZtNTvxh@tauon.chronox.de>
 <YaT+9MueQIa5p8xr@kroah.com>
 <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
 <YaYvYdnSaAvS8MAk@kroah.com>
 <CAH8yC8nWLk9vhV1iACE+vmtby2rRN8RDqeuS54qZahE-xH2X_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8nWLk9vhV1iACE+vmtby2rRN8RDqeuS54qZahE-xH2X_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 30, 2021 at 10:13:26AM -0500, Jeffrey Walton wrote:
> On Tue, Nov 30, 2021 at 9:04 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Nov 30, 2021 at 07:24:15AM -0500, Jeffrey Walton wrote:
> > > On Mon, Nov 29, 2021 at 6:07 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > ...
> > > > Sometimes, yes, it is valid to have different implementations for things
> > > > that do different things in the same area (like filesystems), but for a
> > > > core function of the kernel, so far the existing random maintainer has
> > > > not wanted to have multiple implementations.  Same goes for other parts
> > > > of the kernel, it's not specific only to this one very tiny driver.
> > > >
> > > > As a counterpoint, we do not allow duplicate drivers that control the
> > > > same hardware types in the tree.  We have tried that in the past and it
> > > > was a nightmare to support and maintain and just caused massive user
> > > > confusion as well.  One can argue that the random driver is in this same
> > > > category.
> > >
> > > I think an argument could be made that they are different drivers
> > > since they have different requirements and security goals. I don't
> > > think it matters where the requirements came from, whether it was ad
> > > hoc from the developer, NIST, KISA, CRYPTREC, NESSIE, or another
> > > organization.
> > >
> > > Maybe the problem is with the name of the driver? Perhaps the current
> > > driver should be named random-linux, Stephan's driver should be named
> > > random-nist, and the driver should be wired up based on a user's
> > > selection. That should sidestep the problems associated with the
> > > "duplicate drivers" policy.
> >
> > The "problem" here is that the drivers/char/random.c file has three users,
> > the userspace /dev/random and syscall api, the in-kernel "here's some
> > entropy for the random core to use" api, and the in-kernel "give me some
> > random data" api.
> >
> > Odds are, you REALLY do not want the in-kernel calls to be pulling from
> > the "random-government-crippled-specification" implementation, right?
> 
> It's not a question of whether some folks want it or not. They have to
> accept it due to policy. They have no choice in the matter.

I strongly doubt that policy dictates all of the current calls to
get_random_*() require that they return data that is dictated by that
policy.  If so, that's not a valid specification for a variety of
reasons (i.e. it will break other specification requirements...)

thanks,

greg k-h

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46DE4636B2
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Nov 2021 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhK3Oee (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Nov 2021 09:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242201AbhK3Oed (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Nov 2021 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638282673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b39QhQhZNF+m8f/S5X/tqCTJzRiTL6UGur68GxD7eAQ=;
        b=PcnIVDLhUnV8ludtJLLnfCdP2yBKY2ka9ML70ULqIeRzgJ1ExOwCLLhCzfQ5E1fzPWpfKs
        2j1sVxyYVo+uzQmhF/ZCyKyVM/Vhj9IUtprKC3NDw1Ux/6za3pmqM9LpSxBzGNny/E6aQr
        rgqF7lmr7tDsPLKXWtJsZV69Ah8FYQQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-6awvsCVaMRqO09OOZYW-BQ-1; Tue, 30 Nov 2021 09:31:12 -0500
X-MC-Unique: 6awvsCVaMRqO09OOZYW-BQ-1
Received: by mail-qt1-f200.google.com with SMTP id u14-20020a05622a198e00b002b2f35a6dcfso27434480qtc.21
        for <linux-crypto@vger.kernel.org>; Tue, 30 Nov 2021 06:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=b39QhQhZNF+m8f/S5X/tqCTJzRiTL6UGur68GxD7eAQ=;
        b=IDrQof+lUbr+PJoeoTP/8lt7fL0bV0fgHhGSH98dLy63MSqsY3PVPr1jZUWwLccdpT
         8jEZf6yZjjELxjwv5mgdIaTUduhypUVu00wZtHojZAtjv44uqX932pqMpkZ3Nj3Q7K+U
         WjCUrC3B9Yrz/JQ6ARwBl1oOTNlXFMYHVWZLofnFQb0pedOCp36ZWf4EYFNYDB4q5bTd
         suzceNJ0UxOsPmegEh8VYCIEQcKg1HGaEZeXvW9Y6r1Bga/KW3MlUylba9XsNO1RQnY3
         zgmkVohk+WPXXiC/77Cq18kMNZg1Elnc3R2EK+4nVxWA4X0R00WGkgO/VcaIUmQvPnJ1
         BE6Q==
X-Gm-Message-State: AOAM530ThHHDVWl215ejEVt9pvUuivYDd5obP4ftiwU3be78p/kdvg0H
        DN3Hxv9dnEa4AK0OWzPJpfeurMkzWvtLayxOhBKchwbK/sz/gjGuLzdrYs+0YA5mwQ502QMZ/GZ
        lzNhggswbrmjfhbO6M0v7wuyn
X-Received: by 2002:a37:654e:: with SMTP id z75mr36951314qkb.732.1638282671918;
        Tue, 30 Nov 2021 06:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztbuhdQW1yYLX1CRtVuiT3637z0MirwXgBcjKeFgtgbog7RMQDU2wQ89ZtMkqZ275ORUcFyA==
X-Received: by 2002:a37:654e:: with SMTP id z75mr36951269qkb.732.1638282671522;
        Tue, 30 Nov 2021 06:31:11 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id b9sm10605257qtb.53.2021.11.30.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:31:10 -0800 (PST)
Message-ID: <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
From:   Simo Sorce <simo@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
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
Date:   Tue, 30 Nov 2021 09:31:09 -0500
In-Reply-To: <YaYvYdnSaAvS8MAk@kroah.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
         <22137816.pfsBpAd9cS@tauon.chronox.de> <YaEJtv4A6SoDFYjc@kroah.com>
         <9311513.S0ZZtNTvxh@tauon.chronox.de> <YaT+9MueQIa5p8xr@kroah.com>
         <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
         <YaYvYdnSaAvS8MAk@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2021-11-30 at 15:04 +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 30, 2021 at 07:24:15AM -0500, Jeffrey Walton wrote:
> > On Mon, Nov 29, 2021 at 6:07 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > ...
> > > Sometimes, yes, it is valid to have different implementations for things
> > > that do different things in the same area (like filesystems), but for a
> > > core function of the kernel, so far the existing random maintainer has
> > > not wanted to have multiple implementations.  Same goes for other parts
> > > of the kernel, it's not specific only to this one very tiny driver.
> > > 
> > > As a counterpoint, we do not allow duplicate drivers that control the
> > > same hardware types in the tree.  We have tried that in the past and it
> > > was a nightmare to support and maintain and just caused massive user
> > > confusion as well.  One can argue that the random driver is in this same
> > > category.
> > 
> > I think an argument could be made that they are different drivers
> > since they have different requirements and security goals. I don't
> > think it matters where the requirements came from, whether it was ad
> > hoc from the developer, NIST, KISA, CRYPTREC, NESSIE, or another
> > organization.
> > 
> > Maybe the problem is with the name of the driver? Perhaps the current
> > driver should be named random-linux, Stephan's driver should be named
> > random-nist, and the driver should be wired up based on a user's
> > selection. That should sidestep the problems associated with the
> > "duplicate drivers" policy.
> 
> The "problem" here is that the drivers/char/random.c file has three users,
> the userspace /dev/random and syscall api, the in-kernel "here's some
> entropy for the random core to use" api, and the in-kernel "give me some
> random data" api.
> 
> Odds are, you REALLY do not want the in-kernel calls to be pulling from
> the "random-government-crippled-specification" implementation, right?

You really *do* want that.
When our customers are mandated to use FIPS certified cryptography,
they want to use it for kernel cryptography as well, and in general
they want to use a certified randomness source as well.

I do not get why you call the implementation crippled? The
specification is quite thorough and provides well reasoned requirements
as well as self-test that insure coding mistakes won't end up returning
non-random values.

I understand the mistrust vs gov agencies due to past mishaps like the
Dual-DRBG thing, but we are not talking about something like that in
this case. NIST is not mandating any specific algorithmic
implementation, the requirement set forth allow to use a variety of
different algorithms so that everyone can choose what they think is
sane.

> Again, just try evolving the existing code to meet the needs that you
> all have, stop trying to do wholesale reimplementations.  Those never
> succeed, and it's pretty obvious that no one wants a "plugin a random
> random driver" interface, right?

I think one of the issues is that the number of changes required
against the current random driver amount essentially to a re-
implementation. Sure, you can do it as a series of patches that
transform the current code in something completely different.

And the main question here is, how can we get there, in any case, if
the maintainer of the random device doesn't even participate in
discussions, does not pick obvious bug fixes and is simply not engaging
at all?

Your plan requires an active maintainer that guides these changes and
interact with the people proposing them to negotiate the best outcome.
But that is not happening so that road seem blocked at the moment.

HTH,
Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc





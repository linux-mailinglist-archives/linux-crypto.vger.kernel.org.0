Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316282BB45C
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 20:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgKTSwQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 13:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731397AbgKTSwQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 13:52:16 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A012242B;
        Fri, 20 Nov 2020 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605898335;
        bh=TOm8+E7QSfFHHrs5MxkrMPjm3NEOVrQslJtGI4sgauQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wA2HsvP/OWpc9I0nbT5LPnhdTTA8eKlIHY+JzpILdOh6eA0SgynwhWTw8GCjPOp7B
         yUKjsMJsRMPsTvVJQdTGaNKGIgbi4aWNzN+93Fq1HFHl3n3rmpfDSk576AifO59erz
         hqleKOwZaTu69H9pV4sRQU68csevrf0mQ/pNdxRw=
Date:   Fri, 20 Nov 2020 10:52:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: fix the RNDRESEEDCRNG ioctl
Message-ID: <X7gQXgoXHHEr6HXC@sol.localdomain>
References: <20200916041908.66649-1-ebiggers@kernel.org>
 <20201007035021.GB912@sol.localdomain>
 <20201026163343.GA858@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026163343.GA858@sol.localdomain>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 26, 2020 at 09:33:43AM -0700, Eric Biggers wrote:
> On Tue, Oct 06, 2020 at 08:50:21PM -0700, Eric Biggers wrote:
> > On Tue, Sep 15, 2020 at 09:19:08PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > The RNDRESEEDCRNG ioctl reseeds the primary_crng from itself, which
> > > doesn't make sense.  Reseed it from the input_pool instead.
> > > 
> > > Fixes: d848e5f8e1eb ("random: add new ioctl RNDRESEEDCRNG")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Ping?
> 
> Ping.

Ping.

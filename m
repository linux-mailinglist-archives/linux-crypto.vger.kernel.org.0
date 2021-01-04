Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D7C2E9D8A
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Jan 2021 19:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbhADS4X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Jan 2021 13:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbhADS4X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Jan 2021 13:56:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B0F21D93;
        Mon,  4 Jan 2021 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786543;
        bh=lfuRlvnU3MX7Q76GjUxnuAch3ZAE2cJl5GKkJRqRjw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mphgZOudRAF3sv89J/9KdaCJd3S6F+uDlVn6Xk8VAohn8qAPYltm6Mxi9ae8fY0es
         Fq6CJb4ZtLn4jgDwSycAj1IXkIDTkOD8o9ICh1iiIHhw0H0Wne3RhSOu/CTZPofc/+
         qeHCG0Oyhk+NRKM3X4FCqvkDwGJmp4UBlE1ifNSspfw1q4DESAXnI5hV+myMraX1de
         SKDi0xQJEZfHQsT2F2tNG2ap5GUkQWRxOsFUo6Eyu3/+jJ8SfgX4uNvLXdQi6UlBK9
         qYP+hDkRY8BcfWri25l6NmfnO/JECuEiTh2nu1df9UqAHKHJ0TAoIX6eeZdvtbqP3I
         unFpzcf8hridg==
Date:   Mon, 4 Jan 2021 10:55:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: fix the RNDRESEEDCRNG ioctl
Message-ID: <X/NkrKpaIBTjQzbv@sol.localdomain>
References: <20200916041908.66649-1-ebiggers@kernel.org>
 <20201007035021.GB912@sol.localdomain>
 <20201026163343.GA858@sol.localdomain>
 <X7gQXgoXHHEr6HXC@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7gQXgoXHHEr6HXC@sol.localdomain>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 20, 2020 at 10:52:14AM -0800, Eric Biggers wrote:
> On Mon, Oct 26, 2020 at 09:33:43AM -0700, Eric Biggers wrote:
> > On Tue, Oct 06, 2020 at 08:50:21PM -0700, Eric Biggers wrote:
> > > On Tue, Sep 15, 2020 at 09:19:08PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > The RNDRESEEDCRNG ioctl reseeds the primary_crng from itself, which
> > > > doesn't make sense.  Reseed it from the input_pool instead.
> > > > 
> > > > Fixes: d848e5f8e1eb ("random: add new ioctl RNDRESEEDCRNG")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > 
> > > Ping?
> > 
> > Ping.
> 
> Ping.

Ping.

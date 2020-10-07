Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E933F28574F
	for <lists+linux-crypto@lfdr.de>; Wed,  7 Oct 2020 05:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgJGDuX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Oct 2020 23:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgJGDuX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Oct 2020 23:50:23 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4318B208C3;
        Wed,  7 Oct 2020 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602042623;
        bh=i3oNKL/37PPF5simVBecYvjtkUyfqCYU9nKNvTJQoAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iy5sYNRbdCkoUvm6wbjexcNUisor0wYEB5HIrkxoGtYbZRbJr7BEnqhK1J1EZg21I
         fIHaiv/M+IgV6PXLv3rJQqAKW9OTXxOmFDcPAYKwVHmEk4o6GRPlGgF0ANy9dzLOAq
         I50gl3OUVDLNw0PVxK2oPHelXeXLf4Ry6fRiKPvA=
Date:   Tue, 6 Oct 2020 20:50:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: fix the RNDRESEEDCRNG ioctl
Message-ID: <20201007035021.GB912@sol.localdomain>
References: <20200916041908.66649-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916041908.66649-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 15, 2020 at 09:19:08PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The RNDRESEEDCRNG ioctl reseeds the primary_crng from itself, which
> doesn't make sense.  Reseed it from the input_pool instead.
> 
> Fixes: d848e5f8e1eb ("random: add new ioctl RNDRESEEDCRNG")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Ping?

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157A81C270E
	for <lists+linux-crypto@lfdr.de>; Sat,  2 May 2020 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEBQqW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 May 2020 12:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgEBQqV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 May 2020 12:46:21 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E43A21775;
        Sat,  2 May 2020 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588437981;
        bh=EfqB5VEyLDHVobqONY0PvHdj6NAu5VbSwfn8MGDu7Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7y7shPXTyTF/zij/E/XRTLqLBw8owxjWuqFtv4+TuJrK3pAj57sIxdpf7XjoyA+g
         SLA3oFgZ1fVuc0e1KnZt0auMOGZhP3lMaxSxxj7PFEsrrY0NxbwvVne8OsR3S5De1X
         xndj2foJNePxRPGoC49m6Lk6zXJtV4iS+G82CWCU=
Date:   Sat, 2 May 2020 09:46:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] lib/xxhash: make xxh{32,64}_update() return void
Message-ID: <20200502164620.GA840@sol.localdomain>
References: <20200502063423.1052614-1-ebiggers@kernel.org>
 <367527ae-0471-e6be-eab2-c575e7b70564@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367527ae-0471-e6be-eab2-c575e7b70564@suse.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, May 02, 2020 at 11:01:35AM +0300, Nikolay Borisov wrote:
> > +void xxh32_update(struct xxh32_state *state, const void *input,
> > +		  const size_t len)
> >  {
> >  	const uint8_t *p = (const uint8_t *)input;
> >  	const uint8_t *const b_end = p + len;
> >  
> > -	if (input == NULL)
> > -		return -EINVAL;
> > -
> 
> Values calculated based on input are dereferenced further down, wouldn't
> that cause crashes in case input is null ?
> 

Only if len > 0, which would mean the caller provided an invalid buffer.

- Eric

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA352E9D8D
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Jan 2021 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbhADS4l (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Jan 2021 13:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbhADS4k (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Jan 2021 13:56:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2284521D1B;
        Mon,  4 Jan 2021 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786560;
        bh=S9ybZbdWFDfs+hHbWVkSzBsG+xNYXajfZmoF8ziQt4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1hCHDiCrbrG/hVdnGIK3eXSIJ2+exLP6hJyEG/ZjYjIFBW2fPzZSmvNfDdvKhxTz
         /Y8n26sriprL8IGu8Ci/j5W9PvQHzxmBt9fPA/7cpiNowHOpQnIL2BBtKdupU4P0ow
         J4bOW+vRCcIn4uwTFkivsTXXgfn42jlqp6raVSDIlq83fQ8HU8YbGdkZ/hjV1TaQLT
         cPFRrT3fD0hYuSkllSmw8mVUsFBgO3RcjFkZSyfIzf/AmtDRHH+PK8/G38omiGdzza
         tz2kdMcYQQrS+z/vgtKt4LhhiAUmZP5jvLxYRXjQyPZ0ze5mZWas1LiGPGfh5Fn5OX
         ixTvgwHQualjw==
Date:   Mon, 4 Jan 2021 10:55:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] random: remove dead code left over from blocking pool
Message-ID: <X/NkvusG9Z9GK/Bh@sol.localdomain>
References: <20200916043652.96640-1-ebiggers@kernel.org>
 <20201007035058.GC912@sol.localdomain>
 <20201026163403.GC858@sol.localdomain>
 <X7gQc1IrC18+WBST@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7gQc1IrC18+WBST@sol.localdomain>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 20, 2020 at 10:52:35AM -0800, Eric Biggers wrote:
> On Mon, Oct 26, 2020 at 09:34:03AM -0700, Eric Biggers wrote:
> > On Tue, Oct 06, 2020 at 08:50:58PM -0700, Eric Biggers wrote:
> > > On Tue, Sep 15, 2020 at 09:36:52PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Remove some dead code that was left over following commit 90ea1c6436d2
> > > > ("random: remove the blocking pool").
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > 
> > > Ping?
> > 
> > Ping.
> 
> Ping.

Ping.

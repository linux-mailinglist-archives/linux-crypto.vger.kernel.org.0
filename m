Return-Path: <linux-crypto+bounces-12338-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1787EA9DBA9
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Apr 2025 17:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694793BD551
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Apr 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C125C713;
	Sat, 26 Apr 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bgBoFfuu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3A253F3D
	for <linux-crypto@vger.kernel.org>; Sat, 26 Apr 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679807; cv=none; b=lFbwzL0srY1QUYfyozzTKh9xHltREkDhIgmuqIioWQSad1Vo/jzQggujsG9ur5Nh/3AkA4L7MEyYMYIfNq1uqmbN5svPxqu9FhUkFyyPmluQnnXMYtJd5441hCAFMETB2PdV8sOOSCL3CWuCFjk1+vwBEn6RY5vnfUBl1/TlTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679807; c=relaxed/simple;
	bh=Vm8is0fZMA8KIAs1cGn6dnzN77suefz/64PXNNt+6pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwV5pnefqNuSDkrJSo7GTTPs3uJ/f3eVO52gvBWq8zqbzy0gyFniCIzs6u36TI2fuod9ssb01O5qacWOyLGQsdlGc6wm9Uj570BS+SUmeUS16kUh4UTcoYCBt5B9IXek+A1vChrHtowvoz0fzwvDLt7Fy6jGEGGWS05pfm98q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bgBoFfuu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Apr 2025 11:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745679792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfBFNtrkXGpwEI1f8qxFcLLJ+djj3QoJA6M531zvfsg=;
	b=bgBoFfuucV1MYv23Sx+JWqkW37ke3hwsYGwVnAywb7CCGdvWPBhkaOVe6kU9Ji/OrgPuZc
	uGvUevBF2m4UPwGcFH4UmpGEcBGhSzOevfJ8QF+0V3v4p1nWfsLhK3c3f92fA3PXHCWFkM
	HbfMBFjpPoVmBYELvhEhkq2coWXPCgY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com, 
	bfoster@redhat.com, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	davem@davemloft.net, herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] bcachefs: Fix unit-value within btree_bounce_alloc()
Message-ID: <c32cu4mrdeln3kovzgehwjccfx2qpfh7evsgiug6ckshfux76q@ms6mab54ivy5>
References: <000000000000736bd406151001d7@google.com>
 <20250423163718.194316-1-richard120310@gmail.com>
 <ur4a24w2wb3euh3ej7ybeqnvmqyhzmqp2wwsjtilh6mfetv45l@qlxs3vggfq5h>
 <aAu-Heqb3malYkjI@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAu-Heqb3malYkjI@vaxr-BM6660-BM6360>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 26, 2025 at 12:53:49AM +0800, I Hsin Cheng wrote:
> On Wed, Apr 23, 2025 at 12:45:20PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 24, 2025 at 12:37:18AM +0800, I Hsin Cheng wrote:
> > > Use "kvzalloc()" instead of "kvmalloc()" in btree_bounce_alloc() to
> > > prevent uninit-value issue.
> > > 
> > > Reported-by: syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
> > > Fixes: cb6fc943b650 ("bcachefs: kill kvpmalloc()")
> > > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > > ---
> > > syzbot reported an uninit-value issue. [1]
> > > 
> > > Though the uninit value was detected in the context of crc32_body(), the
> > > memory was actually allocated in "btree_bounce_alloc()". Use
> > > "kvzalloc()" to allocate the memory can solve the issue, and I've tested
> > > against syzbot. [2]
> > > 
> > > If there're any further tests needed to be performed, please let me
> > > know. I'll be more than happy to assist you with that, thanks !
> > 
> > See Documentation/filesystems/bcachefs/SubmittingPatches.
> >
> 
> Sure ! Thanks for the info.
> 
> > And this isn't the correct fix - the correct fix is already in Linus's
> > tree.
> 
> Ahh ok, may I ask for the commit hash or title so I can learn from it ?

9c3a2c9b471a bcachefs: Disable asm memcpys when kmsan enabled


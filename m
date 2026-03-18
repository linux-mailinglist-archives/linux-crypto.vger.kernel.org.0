Return-Path: <linux-crypto+bounces-22107-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGYBIoAuu2ksgQIAu9opvQ
	(envelope-from <linux-crypto+bounces-22107-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 00:00:16 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE98E2C3B0F
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF65A303BB27
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11630C618;
	Wed, 18 Mar 2026 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcjxgPvI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509031F1537;
	Wed, 18 Mar 2026 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874809; cv=none; b=juwW94cyXAhLCngc1MIx5t7y+1vlHl+ZCJ/A0AEyIFKhNgJvdOr50W2AHUF0oA7LD5BGLB5BP9ND7ueySIhZx/oLECGaUwamMXZU8Jo9ZywnlJQPpOgiKxnUcdcYu+7To3uVkQxlo/jQnfdakw6MzdDtDG0yvSjZXBKhxIwyYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874809; c=relaxed/simple;
	bh=2JTDMuhc/A2g3wL+Ka0kBPLhcjr+9DtDMfgXlPUl79Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQElYuwvb7SrUkrwE5Q/0B/EMM0tz/YP4/LyErbTr7QOvw2rLSR1vb7w8qj4KRqDXWJ5Ji/kxh5KA1FX0P0gHqxXDjaTQb7fI8CQ0VVBaiBrxHFe+we+udF8lVjFssFLkLJ8U9hvosIFzhDVwYRvoYv8V6O61H5hgkQsI6lyff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcjxgPvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FBAC19421;
	Wed, 18 Mar 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773874808;
	bh=2JTDMuhc/A2g3wL+Ka0kBPLhcjr+9DtDMfgXlPUl79Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcjxgPvImHLLGbG/87IHLU9MaYNxucg34z/SD+qzNawEPsmuPhMSaDpk++6qSVSzH
	 aY5p7oPUZ6F7GczrxbT79vvIzBtTJEmaReWjBaWkdEH7L6TfDnTVs+ainyef9z6Pyn
	 pVg5ircX+VB1pPdM3/3plF+bU/eNe/570hviOFtD3QFsIdHlWdPSjV/KitfWfz8ew1
	 N2B+SgkSnBT9pTL51s1ZHi1UcoQrrlmIUJ8g/jGw4muQUTe7KO61ozQY8/yTWPX98j
	 H5zgLEfrYSSlg8XNCRUPgBnvzXahB88Ez7dreiWUHr1++U6HouNp84XNdGJWlM6Ymb
	 G+NPaQYsbNs+Q==
Date: Wed, 18 Mar 2026 13:00:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, puranjay@kernel.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Michael van der Westhuizen <rmikey@meta.com>, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/5] workqueue: add WQ_AFFN_CACHE_SHARD affinity scope
Message-ID: <absud4FKm-3Trvjj@slm.duckdns.org>
References: <20260312-workqueue_sharded-v1-0-2c43a7b861d0@debian.org>
 <6b952e7087c5fd8f040b692a92374871@kernel.org>
 <abk6PMrSDcb-yXZ9@gmail.com>
 <30adaf6c-657c-41f1-9234-79d807d74f02@oracle.com>
 <abrkrZc52h0vcTTj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abrkrZc52h0vcTTj@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22107-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,linux-foundation.org,vger.kernel.org,kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE98E2C3B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:51:15AM -0700, Breno Leitao wrote:
> On Tue, Mar 17, 2026 at 09:58:54AM -0400, Chuck Lever wrote:
> > On 3/17/26 7:32 AM, Breno Leitao wrote:
> > >> - How was the default shard size of 8 picked? There's a tradeoff
> > >> between the number of kworkers created and locality. Can you also
> > >> report the number of kworkers for each configuration? And is there
> > >> data on different shard sizes? It'd be useful to see how the numbers
> > >> change across e.g. 4, 8, 16, 32.
> > >
> > > The choice of 8 as the default shard size was somewhat arbitrary – it was
> > > selected primarily to generate initial data points.
> >
> > Perhaps instead of basing the sharding on a particular number of CPUs
> > per shard, why not cap the total number of shards? IIUC that is the main
> > concern about ballooning the number of kworker threads.
> 
> That's a great suggestion. I'll send a v2 that implements this approach,
> where the parameter specifies the number of shards rather than the number
> of CPUs per shard.

Woudl it make sense tho? If feels really odd to define the maximum number of
shards when contention is primarily a function of the number of CPUs banging
on the same CPU. Why would 32 cpu and 512 cpu systems have the same number
of shards?

Thanks.

-- 
tejun


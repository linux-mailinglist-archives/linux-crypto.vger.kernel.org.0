Return-Path: <linux-crypto+bounces-21925-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBBOBYZMtGk4kAAAu9opvQ
	(envelope-from <linux-crypto+bounces-21925-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 18:42:30 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F72883DD
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 18:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8D5303A5D9
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Mar 2026 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359F3CCFDE;
	Fri, 13 Mar 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R36vKp3z"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D63CE4BD;
	Fri, 13 Mar 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423674; cv=none; b=PoAb0H9RyVngtzlEc4wtb+eL1zZ2HGUszgM863zkxb3o7EGSALQaGdn1iN5XrTijZ02lyExQeC67ytJIHWbKShZw6fOayjcZT5QRUWULyxSJN6S38L7oziCsXMlhFj+LSKjRb9Gj2l1zodViLgKK9YV0Pld9dChOhF9pQoWimjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423674; c=relaxed/simple;
	bh=IXfSFyY6NzJ1cn+WUQH+w/sjieLNa7e6oS1eoJmxQ1k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ksg5yHRatrvAKvOiIJB53WLcNjnMKmtxngIobduwmYlyXMHtNR1YpHkIBCfSj7Y2GPK+ANoAqeg1fq18iu9w/3iHfKvuY4bIKdgj4uk3O0SToPj1uK9DuaUZxOVsxRNNPWM72fZy50r9LSq6pBC8V3DNF8rAuFEd0U3qOX1946w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R36vKp3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00688C19421;
	Fri, 13 Mar 2026 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423674;
	bh=IXfSFyY6NzJ1cn+WUQH+w/sjieLNa7e6oS1eoJmxQ1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R36vKp3z913vJh/gmJbExl1mP0+qz4Pdwm+KUz8oeyslYIWS93fEqr6P9CkF8jE3t
	 5fBLFFC6jNCgd2wVDltGIywN/4+Y9oRnfbnA7LEG83dO+BzG7DquTnXf5hiIcichq3
	 vwvsfNUaKKKouQ7SwrEVOZ8YH0nPWj2KEWb1PDw8pXlNcnCsiEEDMMHx743Bf7mhM5
	 MSHMDjQrck6GPf4A+dEhUn5tzbWVS9QD3XvfFbIS2EX9gaW3DYgAK8XljPf9txE5Iy
	 mGK3WzU/eodkaAFV4NM8NiqFKz6zrViDGFUglAQDJTUAxLcrUuu/5jCJvJAhlIWPiI
	 mC0V39VxHjBXg==
Date: Fri, 13 Mar 2026 07:41:12 -1000
Message-ID: <2eef24999c6eeef8e8ea8daf54990e76@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, puranjay@kernel.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Michael van der Westhuizen <rmikey@meta.com>,
 kernel-team@meta.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC 1/5] workqueue: fix parse_affn_scope() prefix
 matching bug
In-Reply-To: <20260312-workqueue_sharded-v1-1-2c43a7b861d0@debian.org>
References: <20260312-workqueue_sharded-v1-0-2c43a7b861d0@debian.org>
 <20260312-workqueue_sharded-v1-1-2c43a7b861d0@debian.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21925-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,kernel.org,meta.com,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 959F72883DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied to wq/for-7.1.

Thanks.

--
tejun


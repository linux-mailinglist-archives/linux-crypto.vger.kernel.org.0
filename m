Return-Path: <linux-crypto+bounces-22708-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPBKO3yCzWmaeQYAu9opvQ
	(envelope-from <linux-crypto+bounces-22708-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 22:39:24 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83291380475
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65EE630BB161
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BCA33C518;
	Wed,  1 Apr 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVTaksi5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E901EB19B;
	Wed,  1 Apr 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775075533; cv=none; b=nI7rqrN+Dony40ItERbWYEJSLP28VpBTRwUFb7hsgQtzQDYs91nQFHOKxvc+F0ThRpxyIYks9w1qhlagQwpmAJCUeEsXIJXiEbI4AdIKTuLqWQ5Pa/riRoSuD6uEmL7iimfERNjZfedalkt73uyMjCNxSyYkFrr9Sc7fJJEm9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775075533; c=relaxed/simple;
	bh=nYW5g1VvC9kM7IdnhRH0cccs40ZcgKrVNoGr3sp/v00=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cCvkT7Dx/4tm02XOohhC2Z9/XwKrRJ9XLYnivUA/KMj2FXYXgJpRUzEc5PfhOAKcgm45g9ukJeNt+y04W/4csoCS5y87pMySyVkrRCnAT+qGiImINbwIh3OubKBQLlThQMvG8J5AQaZJMNoOMFcV7VBi3Ol1sZu3BWyI5Gl/EZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVTaksi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C86C4CEF7;
	Wed,  1 Apr 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775075533;
	bh=nYW5g1VvC9kM7IdnhRH0cccs40ZcgKrVNoGr3sp/v00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVTaksi5fPbboDT950vmqdBszxdhgA1A5brMOIXrcq+DLA1aoxyQMreJzZwEW0MqG
	 3nhpMieq2A/mc2uUYLlgY/+7VMyIvZsiaMIZ7vwGvwmEV5z7yX0iBVQFovBAQ6PGhl
	 yJPwqpTUI2IkbLk/Rch1U1f4rgQ1SsKv65FUUKMU8XXf4klia46gskOSSLMRoRTOdC
	 VPz8atsYBaHJN+6Fp7K628vhd0OP4t5p6UFMXSLhvduVKxDSpuR33rFWEhI343zDUb
	 tXrZf77V8xdz42teYi5bjG33ee29bRIyKOFVAW6t3SOVt+1MWcbwRyaS8WEGMWrjmQ
	 E5mb8Gzq4oT7g==
Date: Wed, 01 Apr 2026 10:32:12 -1000
Message-ID: <d689b6644895ab4ab0cec5e316db1022@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, puranjay@kernel.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Michael van der Westhuizen <rmikey@meta.com>,
 kernel-team@meta.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 0/6] workqueue: Introduce a sharded cache affinity
 scope
In-Reply-To: <20260401-workqueue_sharded-v3-0-ab0b9336bf0b@debian.org>
References: <20260401-workqueue_sharded-v3-0-ab0b9336bf0b@debian.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,kernel.org,meta.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-22708-lists,linux-crypto=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83291380475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied 1-6 to wq/for-7.1.

Thanks.

-- 
tejun


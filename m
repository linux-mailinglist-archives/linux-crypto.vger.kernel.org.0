Return-Path: <linux-crypto+bounces-25421-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tRcCBiY3PmphBgkAu9opvQ
	(envelope-from <linux-crypto+bounces-25421-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 10:24:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830C6CB4ED
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 10:24:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VRNylShy;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25421-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25421-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680BD30C8127
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE13DCDA3;
	Fri, 26 Jun 2026 08:21:13 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA827FD51;
	Fri, 26 Jun 2026 08:21:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462073; cv=none; b=F0nQZFnDiQhTt9c5MjvSYbcn/uk62jD2Gk9PNSKTtbTHLBWBe2udgowp4WO8xnzZamhn19B6KzeG7vmxtoBFmR6q6rF7h/HJSILrX3ZTeK5yWo1Umx9zHU5ULsgac/E0OtTOhD9zVrySRTk9rqS69Xpb/vl3bBcs1sf1TkrzmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462073; c=relaxed/simple;
	bh=1LBlkTheA3kClbGdWMDAwKTnWvFnD+kxP8XV/azEEVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNldIJRmg1YLI2lNnat3lM+BlTlQhYkqEOeQQykeSZOXQ2aP5BFVrRqDL1OyVrToi1bWX6CNoMMdpEk8hns3PxNA1EVxLbiN57yIqGt+5QVjMWgN4Hn3A/juXhS+XqPzCIZzY6H4FzD1nleohLGjFkIdfoQKfL0jPHOUtTdbzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRNylShy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F631F000E9;
	Fri, 26 Jun 2026 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462071;
	bh=iV8Y1qpbWig8yFM44HizyDZ9SD78GLMuCnUipxKToIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VRNylShyN+OO0dqReJbUBK5qFI1f6x5ouAiqFCYrkYYUy8b1gMx/LM0S+wdPJVGQF
	 jJ/q0NoPAVrPkfBKALquiLSi66MRTNQPndo+znqjmDQLg1xvBKHoopICntwZGcuu8X
	 ikLcRHzizfC+yRm+bZ7OqmquLsXsx3wcYGymB8+hC4hw6j6FB7rvlCxdjjIDW9i03i
	 E/eIBYBNSh2a2AMpC34HSlEWm0jMor1n5uqlth3PC9c/0gDQf2WRm6QHi6eYZoWMYY
	 DrTngTHNnd66HVz+Vov38qbQvIoPF2E9rhyCjS5TazDwiUUoPzl699cy+/S32kavM1
	 FKdrOosJGm0+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0B39389E8;
	Fri, 26 Jun 2026 08:20:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/18] raid6: turn the userspace test harness into a kunit
 test
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246205852.3816447.1024923704586855592.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:20:58 +0000
References: <20260518051804.462141-2-hch@lst.de>
In-Reply-To: <20260518051804.462141-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 herbert@gondor.apana.org.au, dan.j.williams@intel.com, clm@fb.com,
 dsterba@suse.com, arnd@arndb.de, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25421-lists,linux-crypto=lfdr.de,linux-riscv];
	FREEMAIL_CC(0.00)[lists.infradead.org,linux-foundation.org,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:linux-riscv@lists.infradead.org,m:akpm@linux-foundation.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:ardb@kernel.org,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:herbert@gondor.apana.org.au,m:dan.j.williams@intel.com,m:clm@fb.com,m:dsterba@suse.com,m:arnd@arndb.de,m:song@kernel.org,m:yukuai@fnnas.com,m:linan122@huawei.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-arch@vge
 r.kernel.org,m:linux-raid@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6830C6CB4ED

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 18 May 2026 07:17:44 +0200 you wrote:
> Currently the raid6 code can be compiled as userspace code to run the
> test suite.  Convert that to be a kunit case with minimal changes to
> avoid mutating global state so that we can drop this requirement.
> 
> Note that this is not a good kunit test case yet and will need a lot more
> work, but that is deferred until the raid6 code is moved to it's new
> place, which is easier if the userspace makefile doesn't need adjustments
> for the new location first.
> 
> [...]

Here is the summary with links:
  - [01/18] raid6: turn the userspace test harness into a kunit test
    https://git.kernel.org/riscv/c/c4697486fc23
  - [02/18] raid6: remove __KERNEL__ ifdefs
    https://git.kernel.org/riscv/c/3d6beb659ddf
  - [03/18] raid6: move to lib/raid/
    https://git.kernel.org/riscv/c/3626738bc714
  - [04/18] raid6: remove unused defines in pq.h
    https://git.kernel.org/riscv/c/06d2a66fb7c0
  - [05/18] raid6: remove raid6_get_zero_page
    https://git.kernel.org/riscv/c/885d31423183
  - [06/18] raid6: use named initializers for struct raid6_calls
    https://git.kernel.org/riscv/c/7e91f76a9668
  - [07/18] raid6: improve the public interface
    https://git.kernel.org/riscv/c/35472bc6f31b
  - [08/18] raid6: warn when using less than four devices
    https://git.kernel.org/riscv/c/2790045a62eb
  - [09/18] raid6: hide internals
    (no matching commit)
  - [10/18] raid6: rework registration of optimized algorithms
    (no matching commit)
  - [11/18] raid6: use static_call for gen_syndrom and xor_syndrom
    https://git.kernel.org/riscv/c/10f4b8e2a164
  - [12/18] raid6: use static_call for raid6_recov_2data and raid6_recov_datap
    https://git.kernel.org/riscv/c/dd83de0341da
  - [13/18] raid6: update top of file comments
    https://git.kernel.org/riscv/c/30bf04bd13a5
  - [14/18] raid6_kunit: use KUNIT_CASE_PARAM
    https://git.kernel.org/riscv/c/2175395f76c3
  - [15/18] raid6_kunit: dynamically allocate data buffers using vmalloc
    https://git.kernel.org/riscv/c/d67c25712fe3
  - [16/18] raid6_kunit: cleanup dataptr handling
    https://git.kernel.org/riscv/c/562bcbfcb99b
  - [17/18] raid6_kunit: randomize parameters and increase limits
    https://git.kernel.org/riscv/c/fa0c812c0aa5
  - [18/18] raid6_kunit: randomize buffer alignment
    https://git.kernel.org/riscv/c/8cf0a6c4bb9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




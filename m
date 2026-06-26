Return-Path: <linux-crypto+bounces-25422-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id be/QL1w5Pmr1BgkAu9opvQ
	(envelope-from <linux-crypto+bounces-25422-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 10:33:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3891E6CB611
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 10:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MC6yAmsd;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25422-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25422-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F218A3130333
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4473E6DEC;
	Fri, 26 Jun 2026 08:21:28 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193033C1AD;
	Fri, 26 Jun 2026 08:21:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462088; cv=none; b=r67WLPmcgIdj78kxFfVSWGfTWR5uFFiGwPss+U+sr7mV2lpUXZdUWCV/7mpiDPGa/QRPA2z3gKMaUB6/CmlYAirXxl7rHJDiapOLY69QkkhfFU/LypZjyBQeTK4wpxKo9/RWJSetAnhNClDyUyNI5hPf8XZz5ewn0+RCkjw+AoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462088; c=relaxed/simple;
	bh=gjxS0uNdvbRMwyFGc5xVYSwTFrigLCR+dmWJeZKb1X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hculBsYa+I+kvH9QRro8M7ZwAD78mPiwHDgXKdmAysW8rbwC64x1Y5rg6Bnew4/lp6MQAiM7xP7SvfwiSBvyE9xsa44KSQDZ1Nvvsy02ZxmD/AXMroYgEOLKnhQJY6ycZXIPY7A9xCAg4bgcdYM7SQwwzYNuYJoM1GGANO55bkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC6yAmsd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FFB1F00AC4;
	Fri, 26 Jun 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462081;
	bh=cnDZkcdojzG6TP+7FyMqVMauu4QrpFoQrKFZui4fel0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MC6yAmsds/bx8R7anvknX1AQ8wYErykOAlLqPC3rBrW/haRJJv9chUhiwT+CvnTmN
	 khK/Dcw19LSCUFchb8D/hw+DpMaTb1XpLahGVWuQ2ovAXgjD87gIQurL0gIl9+xHit
	 ncTog7IyU918i0n0R2d/om837p9tvnVMwNZwfwlMdGa5QlmnH1j/rqWXUCSJ6gUh9Z
	 brR2GYKjb1zdGevtCBdmugxCTe8YRqU7Ur91VQYGPcJyxomzPIKGl4smPb/Yxi36dG
	 9lOJILFIUiOpBT1cUYSLvvKVEE9Xu8TR8Q7d0eK5LtRY1OrEVkIWnTXlTpm48x7ej4
	 4HMiz7mE0JbVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C839389E8;
	Fri, 26 Jun 2026 08:21:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206859.3816447.16178589769412306177.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:08 +0000
References: <20260512052230.2947683-2-hch@lst.de>
In-Reply-To: <20260512052230.2947683-2-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-25422-lists,linux-crypto=lfdr.de,linux-riscv];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3891E6CB611

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 12 May 2026 07:20:41 +0200 you wrote:
> While the RAID6 algorithm could in theory support 3 devices by just
> copying the data disk to the two parity disks, this version is not only
> useless because it is a suboptimal version of 3-way mirroring, but also
> broken with various crashes and incorrect parity generation in various
> architecture-optimized implementations.  Disallow it similar to mdraid
> which requires at least 4 devices for RAID 6.
> 
> [...]

Here is the summary with links:
  - [01/19] btrfs: require at least 4 devices for RAID 6
    (no matching commit)
  - [02/19] raid6: turn the userspace test harness into a kunit test
    (no matching commit)
  - [03/19] raid6: remove __KERNEL__ ifdefs
    https://git.kernel.org/riscv/c/3d6beb659ddf
  - [04/19] raid6: move to lib/raid/
    (no matching commit)
  - [05/19] raid6: remove unused defines in pq.h
    https://git.kernel.org/riscv/c/06d2a66fb7c0
  - [06/19] raid6: remove raid6_get_zero_page
    https://git.kernel.org/riscv/c/885d31423183
  - [07/19] raid6: use named initializers for struct raid6_calls
    https://git.kernel.org/riscv/c/7e91f76a9668
  - [08/19] raid6: improve the public interface
    (no matching commit)
  - [09/19] raid6: hide internals
    (no matching commit)
  - [10/19] raid6: rework the init helpers
    (no matching commit)
  - [11/19] raid6: use static_call for gen_syndrom and xor_syndrom
    https://git.kernel.org/riscv/c/10f4b8e2a164
  - [12/19] raid6: use static_call for raid6_recov_2data and raid6_recov_datap
    (no matching commit)
  - [13/19] raid6: update top of file comments
    https://git.kernel.org/riscv/c/30bf04bd13a5
  - [14/19] raid6_kunit: use KUNIT_CASE_PARAM
    https://git.kernel.org/riscv/c/2175395f76c3
  - [15/19] raid6_kunit: dynamically allocate data buffers using vmalloc
    https://git.kernel.org/riscv/c/d67c25712fe3
  - [16/19] raid6_kunit: cleanup dataptr handling
    https://git.kernel.org/riscv/c/562bcbfcb99b
  - [17/19] raid6_kunit: randomize parameters and increase limits
    (no matching commit)
  - [18/19] raid6_kunit: randomize parameters and increase limits
    (no matching commit)
  - [19/19] raid6_kunit: randomize buffer alignment
    https://git.kernel.org/riscv/c/8cf0a6c4bb9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-crypto+bounces-24929-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtK2DknoImpSfAEAu9opvQ
	(envelope-from <linux-crypto+bounces-24929-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 17:16:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C0649340
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 17:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jrPorASL;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24929-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24929-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFF20307D769
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC1A3FFFB6;
	Fri,  5 Jun 2026 15:10:28 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657323C73E5;
	Fri,  5 Jun 2026 15:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672228; cv=none; b=DmPJ5zGSYETpPX5mY0d/gyXBZWAKXfy5VijiPiLrN2LiiOjapx8GfLz/Zyl/pBV5kQUj022vSEeA54iqm++UJaDTW/bRlZwwEcAW46QLv00WLZEzJD9agWg2tj9n1cB7ssEmeelrzX6Av9Gd0xODMFMTUjIQ51hZ2sVPlp2NmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672228; c=relaxed/simple;
	bh=+44rknf9POmsbTO3YJaOJjrIrp1KTt5t6L0xUpx1d48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J7YbThWFsKRHBheQQWivOWaBgmREoCjglqjBF5dwYrQ8+RMcp/CiCPC2idLjUhVagjwfA6/YP8EF9gTG+CrPzSbnqtJykwqkzXgFIVu0aXC+afmzOuGrAIQtEoykl+q9Amfko0hEh71gaZYPEDv3foKlM9Xk0fIa9kgI3fdMsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrPorASL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0413A1F00893;
	Fri,  5 Jun 2026 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672227;
	bh=bNiYy2YfaQcMsJTyZlifLww+uLEb+yP4a6jCsMOj3Sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jrPorASLeRpkOPGO7F6vrxY3NuV5wyaZAPTEVhTDu5EEptrx4tn6qYXP5/r1Xsk18
	 FmPLL2je9581h59q6RZNYph0vPTUODEmY5QXamdacqcMVRXB4/Kru42DAwBVjwN7t/
	 vZNtb9tMeAsnQ9ejx4EkDa51LHvpCl8zluey4wMxFfm6wtj1HRoLWD05ldv8w4LqhP
	 MsFMwIk5oOl+H/RpU24RXVrq2TFQvUYA8alRjMXo11ExxTiOJhXjgMHuteNrjL8KEC
	 M378Nd9x3VqDYrIGlM9mL8u+KqxCR1nm7Kfs+Y6qKq0n49abtFH6xnPbwQ7jcmECiu
	 NuuaGkxD1ONiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D333930BA1;
	Fri,  5 Jun 2026 15:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rhashtable: Use irq work for shrinking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178067222714.3794367.10286050193642059000.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 15:10:27 +0000
References: <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
In-Reply-To: <aiDgUPXZUi-jnTdo@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mykyta.yatsenko5@gmail.com, bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev, tj@kernel.org, linux-crypto@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24929-lists,linux-crypto=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,iogearbox.net,meta.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:mykyta.yatsenko5@gmail.com,m:bot+bpf-ci@kernel.org,m:bpf@vger.kernel.org,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:kafai@meta.com,m:kernel-team@meta.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:yatsenko@meta.com,m:martin.lau@kernel.org,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:tj@kernel.org,m:linux-crypto@vger.kernel.org,m:mykytayatsenko5@gmail.com,m:bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
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
	TAGGED_RCPT(0.00)[linux-crypto,bpf-ci];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B5C0649340

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 4 Jun 2026 10:17:52 +0800 you wrote:
> On Wed, Jun 03, 2026 at 02:08:25PM +0100, Mykyta Yatsenko wrote:
> >
> > For v7 I'm dropping automatic_shrinking, because it adds a risk of
> > calling schedule_work() on element deletion path (__rhashtable_remove_fast_one())
> > when hashtable size drops below 30% of the capacity.
> 
> Now that expansion uses irq work I think shrinking should switch
> to that as well.
> 
> [...]

Here is the summary with links:
  - rhashtable: Use irq work for shrinking
    https://git.kernel.org/bpf/bpf-next/c/46730ee6e884

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




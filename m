Return-Path: <linux-crypto+bounces-22760-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF2FG0k+z2myuAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22760-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 06:12:57 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDF0390D8B
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 06:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B81F304D16C
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Apr 2026 04:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0734EEE1;
	Fri,  3 Apr 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6ac28sP"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE161A3166;
	Fri,  3 Apr 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189572; cv=none; b=f2RE36ufmv/1OcsRIaDRwZUgT81sTimiBFngN2eyJrYJg8lhVsUkWGNHOBCyEOJHlAMBf3ObVM94LnUp+ZVeqvcKXpcKdrNuLoh7FREJ640rmZ8B+Lp0GYWKXjqCFxmTCGVca0IVOOlRoAZab3KRrKMScxG0NG0pveLkA2kgT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189572; c=relaxed/simple;
	bh=JA6yPaKvVzgFVGwAYVz++xBoU0ZSIlpBzgggRFpF9Mk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tJY1gVJNAgqTedRxqBXOvYSP39/4yV6FhVs7dwvDQNMmD0RNrNT8Y7IKMXReVL9ua0Dfjg/jk53wsyRHI/GhP/DVxDLvs5whVvzMlXWHJbCIf1BqvtcmniV8A4sxcpjwEE8Qd70UMEWxFm0k7Mv+P7FFJ2cWnslrwy1e8C7TBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6ac28sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF402C4CEF7;
	Fri,  3 Apr 2026 04:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775189572;
	bh=JA6yPaKvVzgFVGwAYVz++xBoU0ZSIlpBzgggRFpF9Mk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d6ac28sPsMR4CCkU1NM6nRPoSm65qW6YNAU8TdCV4x4DjVccVi7y4G3YbAPG5Htwx
	 h6XLVcj+XGBBM5Wygd5heM5H0UxzGnaCAI00FY3iRnaqgGPQeNNzb3cvNmQs35m5GD
	 50Nj2+g+M6X38JjU1MEmUdDOOv37MK2IwmzfJ5SsvLZiy50MvfRhsM70qrhcdEY0qz
	 dGfWs8lt0gFBCCNNgJaiYqVIOqDK7yDdPKYEMFjnZ15nbpW188qXa3Oi1Cv5b+nsbu
	 umHQfcGREMvUm0lnc6W1GZYybc79hD1YTEYmTwRmqDHLoSAL6x1Lwhj2Mar+FAQsMd
	 EboiqmdkkFpew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4009D3809A09;
	Fri,  3 Apr 2026 04:12:35 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <ac8IpdQbWxiGuq0E@gondor.apana.org.au>
References: <ac8IpdQbWxiGuq0E@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ac8IpdQbWxiGuq0E@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v7.0-p4
X-PR-Tracked-Commit-Id: e02494114ebf7c8b42777c6cd6982f113bfdbec7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a9617dde77d0777b53f0af7dee58109650bda41
Message-Id: <177518955374.733087.9675383635609444281.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 04:12:33 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22760-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDDF0390D8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Fri, 3 Apr 2026 08:24:05 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v7.0-p4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a9617dde77d0777b53f0af7dee58109650bda41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


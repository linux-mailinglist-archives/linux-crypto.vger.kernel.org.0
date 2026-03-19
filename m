Return-Path: <linux-crypto+bounces-22132-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GuFBdQdvGlEsQIAu9opvQ
	(envelope-from <linux-crypto+bounces-22132-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 17:01:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7B2CE313
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDA8A3046F15
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2026 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8813E92B3;
	Thu, 19 Mar 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFfiLH06"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190D3E92AC;
	Thu, 19 Mar 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935565; cv=none; b=kPZnqESQ9FMPX30jv5inui8OHrw8QbegBsFJcdORetoi1iJMnL49nVdc82D+Wkhwzco/1sjod0hWVBz9rRow0Qg+rNa4PK3wP+a8lJnd1b723fjeVNzT7gchGK/o6NvjjbFHpByFM8Jgr9Ti12Nm+jeH9ECR+/cRC8AcPkPz+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935565; c=relaxed/simple;
	bh=b3zUTEjs4DbA003+dOdt2kKz+8zlSW2dsX1+25xumxs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p1cz3TtJC5/BgN2UI3pE3dgPBSuRBfPmvG+yn/HrhlfFVKYwRn/hWWsgXw6fHxfhE3csVvqXH19bw6XAQVTMjFBU4ukWkEZ6AHKWaH3YUmMifCT8p6wXP46xjDZwGG8tKjZoKn6AUl+yGKiiAa23ZJ/2hoGLexyRF2mMddxKLg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFfiLH06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10355C19424;
	Thu, 19 Mar 2026 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773935565;
	bh=b3zUTEjs4DbA003+dOdt2kKz+8zlSW2dsX1+25xumxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LFfiLH06VUV1YLfor4wULfN0c7hM5LMhHZ/dyEpP/W3JMLvhpoClqJiCu+mXT6zAl
	 8HUKeCOGeDyVHu+sKjxQP/7nRnjqpg+k4Sx2QEESbA/jhSzVXnFnLUgrfQOMVUaEhF
	 Iah9U/v7pdVZa5XMuIWRiJFLA1AoapJHLJfbaWTeRYI7bbbkDdbtqDVZ1dTvpN7FP2
	 Iwp3KoTFULlApxuW6Jp8DdLac9wWTMPrlHzGgS/P8DiwiIkm2XVGFd32BUmK3HwEBI
	 20y/y9h70V2MIC2nsFJAvFQVyKHRLgafY7H31QOvA4WiycX7uJqe4JRLc0uau+2UtE
	 Nfk/3dvt+9xog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE21380692A;
	Thu, 19 Mar 2026 15:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto library fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260318220651.GA2177@quark>
References: <20260318220651.GA2177@quark>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260318220651.GA2177@quark>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus
X-PR-Tracked-Commit-Id: d5b66179b0e27c14a9033c4356937506577485e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1863b4055b7902de43a1dcc7396805eb631682e5
Message-Id: <177393555579.1677649.398499821306306330.pr-tracker-bot@kernel.org>
Date: Thu, 19 Mar 2026 15:52:35 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, AlanSong-oc <AlanSong-oc@zhaoxin.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,zhaoxin.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-22132-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-crypto@vger.kernel.org]
X-Rspamd-Queue-Id: C3F7B2CE313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Wed, 18 Mar 2026 15:06:51 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1863b4055b7902de43a1dcc7396805eb631682e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


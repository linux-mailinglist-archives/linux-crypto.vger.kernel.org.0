Return-Path: <linux-crypto+bounces-18622-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D664C9DA05
	for <lists+linux-crypto@lfdr.de>; Wed, 03 Dec 2025 04:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C743A97C7
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Dec 2025 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3F26F2A0;
	Wed,  3 Dec 2025 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQw426jp"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA826ED5D;
	Wed,  3 Dec 2025 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731692; cv=none; b=nuPPBn0fsv1vHC1kTWt6OOU6DfeKGH+Me0vrCs3IWYGvAol+GmWZtfkPDm725EeZzIfdaKZ2CkzDHoUFpGLdfFuu9ZRcc2p6SKlwJw5cPWn3zqjMndjzoxDF07tlWphX9aVrx7EKwFYGQNTG2FbJqkqmRXeAqYacWpYi6WUgEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731692; c=relaxed/simple;
	bh=GKQ2ak6q4t30pRCw2QUUMC0EJMIeKYrUpbmi3ltyMUg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o8nZkJobDAVBWJ431mcZtE2RLRkDkKC8qLcKrh812GT9MPeCCD1tT3ul0zs3VV5BQc+7Z9bxoC7r8UQ7/K7tMn7Lfz6LvvFbJMYxAlaAgh9v+iRxVaUKVLJrTx+wRgNTEWxeM/zM+ZsnqbqJxaU03K17+zPPGyQn0sLd+MKTvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQw426jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08E0C4CEFB;
	Wed,  3 Dec 2025 03:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764731691;
	bh=GKQ2ak6q4t30pRCw2QUUMC0EJMIeKYrUpbmi3ltyMUg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gQw426jpYHGM+OrO4B9Obv5z5mpF/ZLR2p2VvXN4gCJtLKsfH4DjswjJmiGiXKfNz
	 c0z6P2HBEnVO9GH84Y1vqmDm9/dImwuQ1fWGIWvgLcymKUA8WxH8ipV/uXeCfKAFPi
	 QaATm3Jto+MUGoyJus20+qkqd6xU4Zl8vRp/1AMfvCsgP/bRSQmKcrC0/dHZU2/x1Z
	 V6NZNt2KXlYohVBbJa+FUGuqyKllj8ZssrK61/4EHBUbfhEehbqn7sD1hSxRAkgSpO
	 lf9e+uWQTSKXcEK0yOWjTQMBJtLKymRhKZCGa697e5Fmu5pdzPfGk5jvXmOQP5oNXr
	 j2nkcdAaPh6nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8C53A72A63;
	Wed,  3 Dec 2025 03:11:52 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 FPSIMD buffer on-stack for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251130030105.GF12664@sol>
References: <20251130030105.GF12664@sol>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251130030105.GF12664@sol>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/fpsimd-on-stack-for-linus
X-PR-Tracked-Commit-Id: 5dc8d277520be6f0be11f36712e557167b3964c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f617d24606553159a271f43e36d1c71a4c317e48
Message-Id: <176473151071.3498170.16297964704270989529.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 03:11:50 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Mark Brown <broonie@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Nov 2025 19:01:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/fpsimd-on-stack-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f617d24606553159a271f43e36d1c71a4c317e48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


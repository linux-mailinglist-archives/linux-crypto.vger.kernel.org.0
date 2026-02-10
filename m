Return-Path: <linux-crypto+bounces-20697-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK4LIw11i2nZUQAAu9opvQ
	(envelope-from <linux-crypto+bounces-20697-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Feb 2026 19:12:29 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA011E405
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Feb 2026 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0D03088636
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Feb 2026 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278538F233;
	Tue, 10 Feb 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R23oVCfS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4F38B9B1;
	Tue, 10 Feb 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747018; cv=none; b=OgVuZKoBAydKDfY57vsFMNmhFsaDjfkreWGstLIokKW6FYs1daotBt3tfUAXK81UQzUJFCCEQStswOdmK7wPaAlY9UNV4fm09HTteU8iyYaUdU6KzmXV1dO7kwHpiJDwi4KNNtuXZiaswx2NUxob/q2gHU4yauVjrY4mFXO05Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747018; c=relaxed/simple;
	bh=7YxZpb55Jdi2X7ANtT+EbNZhaB3JuyUrMhhbrflzfF0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LCkx0rs9Z/v6Jq0qPLQ+PwpRCbn0DtAE1Lk4CeSfHrcdeAWcsd5POhB1L22DbNs/kgMxQtwc7LX4qezOqela+3Mu2lD4MLoFLlwgRp8ksbfRMU1xfKWxCm0LOGQ7CC8YVU2L1heqZShnKRoRsWCK/ybyu8214iFr2Ftm5EWSesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R23oVCfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240F8C19421;
	Tue, 10 Feb 2026 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770747018;
	bh=7YxZpb55Jdi2X7ANtT+EbNZhaB3JuyUrMhhbrflzfF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R23oVCfSG3axqdXnToqzhc9hwM7BFiNfJtzo99YXgUov52DjQwrzowUNJJ06vjP3s
	 G6sP1MHsIcHFcsaQcP6SD3LzGN+I/ApWAULMoej0StjdtLaEDUqPwSZ4+F2+bnv95A
	 G1ARbYY9fjmwZlOPgiDsmE0EhXZa6UQTHGtmUWyaZgqwVYFS2VAiFpJEKFyUGLlWUp
	 iyE0Ohx+5s2O89YQKxr4fXFGghrk5c7dW7+Sz6tjs0Y5KCqJ45CO6qIuwlFg1ZmYwG
	 O7QNMDcSpbvtD0DE35CBdsaPyUyC5nNCwUGysQzWYuUjaqgHUif2vXhTI5Jod+M3Dv
	 MISZh2RgIBGng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B26C739E3B79;
	Tue, 10 Feb 2026 18:10:14 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aYmVl48IIm7vtmfL@gondor.apana.org.au>
References: <aYmVl48IIm7vtmfL@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <aYmVl48IIm7vtmfL@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v7.0-p1
X-PR-Tracked-Commit-Id: 0ce90934c0a6baac053029ad28566536ae50d604
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08df88fa142f3ba298bf0f7840fa9187e2fb5956
Message-Id: <177074701362.3619225.15445149041227588989.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 18:10:13 +0000
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20697-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9DA011E405
X-Rspamd-Action: no action

The pull request you sent on Mon, 9 Feb 2026 16:06:47 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v7.0-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08df88fa142f3ba298bf0f7840fa9187e2fb5956

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


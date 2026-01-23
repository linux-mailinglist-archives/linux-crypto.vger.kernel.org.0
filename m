Return-Path: <linux-crypto+bounces-20279-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO96OYHucmkxrQAAu9opvQ
	(envelope-from <linux-crypto+bounces-20279-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 04:44:01 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82313702B3
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 04:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A21A30067B7
	for <lists+linux-crypto@lfdr.de>; Fri, 23 Jan 2026 03:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F214389E17;
	Fri, 23 Jan 2026 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebLdm/mv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF9387375;
	Fri, 23 Jan 2026 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139833; cv=none; b=eCIZHxedotKxVogB2JEAQGutz47jJhdJYuTt3EVYoaAo0bATjeiMlpDSA52Vx7Je2ApvPWcsQbijUFzivhloQnj0WNpcx/hZezp3OpCm2WVVx0Qm/YADpotQqtcQ6G4nAapjj0lcvxhMMrv+ccaFeJ5mIFY5zAbUSV2rCu5ySjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139833; c=relaxed/simple;
	bh=IkOOBmm5XglU54qOihvmwhTQY65obUABchP6v6D/E74=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OwpRSKGC3u3zMLGwGE7GE59ALUeR9nWbTcgXwoSjH53SSkzRICr8qPHgx9iLZyGOLN9gE5nrtDyPQrlP3f1KQO7OO60Ik5JdVXHFlk9xCVwfq9ciwcoA2wZWKk8tUfubQsWybZnrT/ctj1Lo22YC19pyRdxfpAZcMAz36PUtlEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebLdm/mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE41C4CEF1;
	Fri, 23 Jan 2026 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769139832;
	bh=IkOOBmm5XglU54qOihvmwhTQY65obUABchP6v6D/E74=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ebLdm/mvxuzVnLYDorK5v5gXyEY6w3AzJyonH1WSFAZDWd7bp/srkzhPDtlR8N/wi
	 YnD9xt+3GblRAsbAy+mtyLhdGJr2v1jn/ytGSqnkV/8aWgHWfnpsor1RDNAnJA3ERA
	 a2byrtUxDAmUf/TNgnMyVnE1ULO67CTeqdXLP/Osh2kLJhgo/wGg4l5kL96MlBuBw+
	 iROFTVLxl2gm0zG6+bU43FpkLT5PTz3dGPW0nahwHznTiwzajGIPj6YpsnqfedqDJg
	 DAYuwCoin4OsgCVS+S59vb22lArhKKTMXfmxBVEJyj9BCKzGCAJCfyGuGCNQeUO5j+
	 KPBWz3g9SC3Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC643808200;
	Fri, 23 Jan 2026 03:43:50 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <aXLbDbSraxaYgfym@gondor.apana.org.au>
References: <aXLbDbSraxaYgfym@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aXLbDbSraxaYgfym@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.19-p4
X-PR-Tracked-Commit-Id: 2397e9264676be7794f8f7f1e9763d90bd3c7335
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c072629f05d7bca1148ab17690d7922a31423984
Message-Id: <176913982891.2385556.13061800691176644125.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 03:43:48 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20279-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82313702B3
X-Rspamd-Action: no action

The pull request you sent on Fri, 23 Jan 2026 10:21:01 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.19-p4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c072629f05d7bca1148ab17690d7922a31423984

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


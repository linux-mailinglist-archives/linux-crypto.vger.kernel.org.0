Return-Path: <linux-crypto+bounces-22973-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLWCLrva22mlHgkAu9opvQ
	(envelope-from <linux-crypto+bounces-22973-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 19:47:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C903E5353
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 19:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0324230036D4
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Apr 2026 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3734B3624C2;
	Sun, 12 Apr 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7AX11qV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D53002B9;
	Sun, 12 Apr 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015978; cv=none; b=BWIXoCRw3zy2KsSxqW+hboti5ALvZhCy9w7ySw0k+qhZ69JK3G+JbBqeIcNHqJPWeXHA5OKQVOFarGxZ7RDLbKlGIep89MXCUkCmc2Xla1XjSgOFB2j5dJe94AUJRKL/dkAE/sfTClisH2muglRgl2dB27AUXAP5/3U1T+OwpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015978; c=relaxed/simple;
	bh=HzmO/jj/bJOqj6Ogx7VC0J0njP0OL/yz2qVzwYeg3AQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SU/cJxsx7BZ7DBSqxiwF2w9mKmKluVayb6WrhAKN7AJ5pR/jbPPxtyK8Hkg7NexZAZqN9nvS28G/wqCPJDEQWmDOirr4swacJlDMe3swT0ggD1jGDMsI1vYPwaSl+yV1/8OulgQG43G2Xe4ody8iY4RmwJ0dM50h6tHi4T/V2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7AX11qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA638C19425;
	Sun, 12 Apr 2026 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776015978;
	bh=HzmO/jj/bJOqj6Ogx7VC0J0njP0OL/yz2qVzwYeg3AQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e7AX11qV4ju8sHf7eXQxWLqTFPSfyZ0Tmj6UtMSAI4k8a744HDn27xZYYP65xmycT
	 nJLJi8dstppuaw4uCnI5X0FSww1O7Rp4pcRk56aF8XBBRFfHx7CsStx+ud7aqp1Drp
	 y2BE0gAANc/4Zj/RAGVrtnzN8wbXr8IWuOw+fUqXC8fAMSvb9jVoCxtUWIx1hrsTUN
	 iFaaliv1usvrCqkGGe3zVbzPxzpeTcNloID3cYmtUYf6jwF7Sq5PzjsCkdvp+Y4C46
	 pGjj6KkC+/94yRMpG0ib3s6JJkM5kLx+M7ESeEO+RGnr9O1zpsmZXI6woyShrdyYmM
	 2U83hbZHJwJ+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFF33809A8C;
	Sun, 12 Apr 2026 17:45:52 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <adswvtLQx42MYSX8@gondor.apana.org.au>
References: <adswvtLQx42MYSX8@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <adswvtLQx42MYSX8@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v7.0-p5
X-PR-Tracked-Commit-Id: 3d14bd48e3a77091cbce637a12c2ae31b4a1687c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8648ac819d4bc08f7d2a1e0bc9ec2d83de31f19d
Message-Id: <177601595112.3355117.13925223333091399304.pr-tracker-bot@kernel.org>
Date: Sun, 12 Apr 2026 17:45:51 +0000
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22973-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-crypto@vger.kernel.org]
X-Rspamd-Queue-Id: 58C903E5353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Sun, 12 Apr 2026 13:42:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 tags/v7.0-p5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8648ac819d4bc08f7d2a1e0bc9ec2d83de31f19d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


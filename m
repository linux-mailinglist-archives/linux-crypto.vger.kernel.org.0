Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FC2DA252
	for <lists+linux-crypto@lfdr.de>; Mon, 14 Dec 2020 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503487AbgLNU5J (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 14 Dec 2020 15:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503474AbgLNU5J (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 14 Dec 2020 15:57:09 -0500
Subject: Re: [GIT PULL] Crypto Update for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607979388;
        bh=Lmn6ZsEaEUQ9mue61U1vPzfAhy3bz2nfUmE7MAWqucI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iK/j62QiB/2JPf85XZ7lKsgCvy3a2Gp45RswzgN7MKMphF5XOLYGLASUNiUZxdmYn
         HnpR35tJsDvlI2tAdjg+pSa3GgG5U2BZYNYUEHaVw0L6i/TiArxzPVUl/A7JcKLXai
         yG8bWDVxGprrkdOYXThFQDCqbUm69OrbZXwnnT3UbWsYLhVFwmlqWrhGDU8K4o8iRH
         ZsgZtSnA1lP7r1Kx74CmZIwz6JszCPftNrx/6dgSKxBUMVzYBTX/BSABGCayurNDjT
         qQFvfczQu1a2RPZbT80iOgravz3PcuYFaAopWUSonuq6VxmKvUUj3jiOu6YEddmfc2
         +Wod4U5+dRN1A==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214055515.GA14196@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au> <20201214055515.GA14196@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214055515.GA14196@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 linus
X-PR-Tracked-Commit-Id: 93cebeb1c21a65b92636aaa278a32fbc0415ec67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e4b0d55d84a66dbfede56890501dc96e696059c
Message-Id: <160797938848.26822.10464960743618800942.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 20:56:28 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 16:55:16 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e4b0d55d84a66dbfede56890501dc96e696059c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

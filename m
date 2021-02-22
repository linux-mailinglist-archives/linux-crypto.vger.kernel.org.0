Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36767320F17
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Feb 2021 02:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBVB3i (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Feb 2021 20:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhBVB3i (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Feb 2021 20:29:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 90D0B60234;
        Mon, 22 Feb 2021 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613957337;
        bh=r/mieAIuGocXGqqhoN00S3IK812JKkJYsADOgDF0Gto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jhj/TL+CzZi/aIMCNJr+vlmfPtC1mbjDSPSI8S/KFuKLV1TEFQ++0EQcSq1BGfPyv
         hMs5Ew8PERJhRTaXrCoSu+7pxbqjUsmj6pl98vTU2T+S2P7eCOFtd7YJIxFqqkGaWb
         nv6v9M/Ce99Xg1R7002wFFjMy9e3tqoA5ePlZlVdxZo5tyibFvdgz3iMFqm3stJhZ8
         8mvbsi48NbtJvYTuA+mB7Rc2jLTskHOWLh/UL+1WqxKzy/xD5yPD4mRzug/FK6MFB5
         KGFs1mr1IS+9wV9YqHuv5zIwheUfBj93S3LF3XJGDtt8HXUGzVLrbVCYeWfkcbg0Dd
         OGQpuyiFQZ0EA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 78E4E60A3D;
        Mon, 22 Feb 2021 01:28:57 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215024721.GA20593@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au> <20210215024721.GA20593@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215024721.GA20593@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 0de9dc80625b0ca1cb9730c5ed1c5a8cab538369
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31caf8b2a847214be856f843e251fc2ed2cd1075
Message-Id: <161395733744.5020.10211479517423908542.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 01:28:57 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 13:47:21 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31caf8b2a847214be856f843e251fc2ed2cd1075

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4A19B87B
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Apr 2020 00:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgDAWfR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Apr 2020 18:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733164AbgDAWfR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:17 -0400
Subject: Re: [GIT PULL] Crypto Update for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780516;
        bh=LRgdnLuJcS7/CWipB+tmFu5gtxtwhF87azfE0yMxQdA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WXsbK81hcirKmkkpYGuh0ly2DBD4lRq/LDheRSqa53asa25Gz1hrqFNVySkIUF12U
         YI/+QAReEmOn3Dyy0kAvjBjgJ4fO+Td6Dd1JOaQtODBz3BkwYsiooeT7Ntzw/5CED9
         eF4hLivqgjcy8rpcYUlvW5S04ME1Bo4Flrx1jrwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200401042720.GA12178@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20191125034536.wlgw25gpgn7y7vni@gondor.apana.org.au>
 <20200128050326.x3cfjz3rj7ep6xr2@gondor.apana.org.au>
 <20200401042720.GA12178@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200401042720.GA12178@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: fcb90d51c375d09a034993cda262b68499e233a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72f35423e8a6a2451c202f52cb8adb92b08592ec
Message-Id: <158578051648.24680.17707593369397670566.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:16 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 15:27:21 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72f35423e8a6a2451c202f52cb8adb92b08592ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

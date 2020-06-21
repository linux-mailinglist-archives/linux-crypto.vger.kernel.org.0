Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7D202BB3
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2020 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgFURKX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 21 Jun 2020 13:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbgFURKX (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 21 Jun 2020 13:10:23 -0400
Subject: Re: [GIT PULL] Crypto Fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592759422;
        bh=ocy2CBb8YSNngwrC+UysoFLpnTC1EMjS+5CRmk0QH5I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wFvgpIu8fls5HIRTydgWsHhKblrvur6nGd5BR3SL72xIUf7Re7rmt++uiUc4xmgeP
         jpivWUc4gpu9prCM789ZBjWuoVJDqznmilgo+v38dT2wAntGwn6SHR12A67W8gmnzV
         xDSCnl3/8ioMbZNOAR9wifkE+uCuPwWI4Xkerqhg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200621082303.GA30729@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200408061513.GA23636@gondor.apana.org.au>
 <20200611040544.GA27603@gondor.apana.org.au>
 <20200621082303.GA30729@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200621082303.GA30729@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 819966c06b759022e9932f328284314d9272b9f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93bbca271a715e2730b6f4ae0be42056cdab6561
Message-Id: <159275942265.6032.2639454929805852776.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Jun 2020 17:10:22 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Sun, 21 Jun 2020 18:23:03 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93bbca271a715e2730b6f4ae0be42056cdab6561

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

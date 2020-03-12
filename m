Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F056F1836D7
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2020 18:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCLRFI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Mar 2020 13:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLRFI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Mar 2020 13:05:08 -0400
Subject: Re: [GIT PULL] Crypto Fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584032707;
        bh=GbZZ4aYI+cLYHWwRvk43rEhPBQGgOEkKA27p0kLQwQQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1p++pvx8YQMe2jbA4jxuq3MOuXCwRTQzVthS1EDleTLGi/WXNTMupDeQK5IWGYdVj
         Z7WY2Hb/LRfffdzhph4o9AfjH1Zp3SNeETF4NsSFJ3Au5wN44nCPIdaImvBXISEZLJ
         ZzPPt23huBsRieBLkgNAPUz7KLiqKtcqHuG2XDSw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200312115714.GA21470@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200224060042.GA26184@gondor.apana.org.au>
 <20200312115714.GA21470@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200312115714.GA21470@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 1579f1bc3b753d17a44de3457d5c6f4a5b14c752
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2644bc8569baa735ae9c0a92432d6a30c20c1694
Message-Id: <158403270774.17459.13242225624968956554.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Mar 2020 17:05:07 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Thu, 12 Mar 2020 22:57:14 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2644bc8569baa735ae9c0a92432d6a30c20c1694

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

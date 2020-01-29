Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85E514C408
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Jan 2020 01:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgA2AaF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jan 2020 19:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgA2AaF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jan 2020 19:30:05 -0500
Subject: Re: [GIT PULL] Crypto Update for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580257805;
        bh=m3leiE5V9XGyal7Smz33rVZe92f4gkt1+15SfF5M7ys=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zbfifgj6lN7Yw+XDwGz7dbcBFPeqzYt2lTpk7tSRhitHdl//Gkx0iQGiyxoCk5g3f
         NGLgPrvcvdMdK4iK9MSpePZNT/qVr/hX4/6NCKGB6ACkMuGpnee6nzRmmQ5JWsIhR2
         0ETRCCZ4qg8PAI1dQo3cMUk1EtoHJVCk8Ajq5ef8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128050326.x3cfjz3rj7ep6xr2@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20191125034536.wlgw25gpgn7y7vni@gondor.apana.org.au>
 <20200128050326.x3cfjz3rj7ep6xr2@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128050326.x3cfjz3rj7ep6xr2@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 0bc81767c5bd9d005fae1099fb39eb3688370cb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a78208e2436963d0b2c7d186277d6e1a9755029a
Message-Id: <158025780497.29571.16610144198309100026.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 00:30:04 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 13:03:26 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a78208e2436963d0b2c7d186277d6e1a9755029a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397801580A
	for <lists+linux-crypto@lfdr.de>; Tue,  7 May 2019 05:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEGDZE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 May 2019 23:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfEGDZE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 May 2019 23:25:04 -0400
Subject: Re: [GIT] Crypto Update for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557199503;
        bh=A5GABfHaZbrF7j5aDHnPitrUiAk9/KZEsOuCCMwR9AQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J+ztFMQOqVfeYWertxPkjoL3J/vkPR9cKeik+427L9NiF3uTN/MkJz2h4Vi9/sDhS
         ozRLxf4LNrDMzORF/U1axGAVz8BsVoHAEnfyj+5wsxSIsOVwsRswcyD4ugtKQ/i4w8
         Waxrg3dmiCRUu13boKIiJdndDvIvl5wsvzyPk/AY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506032938.fgyw2qupyktvsx7w@gondor.apana.org.au>
References: <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
 <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
 <20190215024738.fynl64d5u5htcy2l@gondor.apana.org.au>
 <20190305081155.7rpkydnc4ipm43o6@gondor.apana.org.au>
 <20190506032938.fgyw2qupyktvsx7w@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506032938.fgyw2qupyktvsx7w@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: e59f755ceb6d6f39f90899d2a4e39c3e05837e12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81ff5d2cba4f86cd850b9ee4a530cd221ee45aa3
Message-Id: <155719950316.20841.8532149559553493918.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 03:25:03 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:29:38 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81ff5d2cba4f86cd850b9ee4a530cd221ee45aa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

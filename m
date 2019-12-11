Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A958C11A319
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 04:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKDia (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Dec 2019 22:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLKDia (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Dec 2019 22:38:30 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E149B206EC;
        Wed, 11 Dec 2019 03:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576035510;
        bh=V32w5zqM8gCX639zDiGkeYhGeKaxca/ICcrMvCfPc/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EvU9uiFzXVxXacuOS3H92ycfab4ORDwg0J95Eek92sVa9XC98kYlJKmsoqYxFRTFr
         GhJjDAI0hBcvvsQSPWA3wVXz9YMf7m5g8bSU5/ffZRYNqUg4Qahy18ejsNHC/Sv00r
         OteHtV/UflbW9lLi2t2Vtfbeew+qHJf6KrWoSrTA=
Date:   Tue, 10 Dec 2019 19:38:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: api - Fix race condition in crypto_spawn_alg
Message-ID: <20191211033828.GH732@sol.localdomain>
References: <20191207141501.ims4xdv46ltykbwy@gondor.apana.org.au>
 <E1idarb-0002qH-Va@gondobar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1idarb-0002qH-Va@gondobar>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Dec 07, 2019 at 10:15:15PM +0800, Herbert Xu wrote:
> The function crypto_spawn_alg is racy because it drops the lock
> before shooting the dying algorithm.  The algorithm could disappear
> altogether before we shoot it.
> 
> This patch fixes it by moving the shooting into the locked section.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Does this need Fixes and Cc stable tags?

- Eric

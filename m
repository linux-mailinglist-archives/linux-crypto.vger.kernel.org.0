Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE10760BD4
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jul 2019 21:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfGETka (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Jul 2019 15:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfGETka (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Jul 2019 15:40:30 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F9C216E3;
        Fri,  5 Jul 2019 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562355629;
        bh=33sanTgaKidShQsQ9x0gVqI6gGYyIqpvHZVzq2eJEKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=towVTwSreztO79wTE8FZoGeBhxj6iIdN0Mb4twzTjG3q6gVs8KEMuPA67wiN8ZgeH
         yU3dMp7LnxW17Z85iSIW79NvkriMqYcATZ7NCmBNt73400F6G2HYiXepysJGpZfCsC
         9rlnYqG+zQ2pt50DG5nfo371YLZtT5PU3boNJ5H8=
Date:   Fri, 5 Jul 2019 12:40:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: ccp - memset structure fields to zero before
 reuse
Message-ID: <20190705194028.GB4022@sol.localdomain>
References: <156218168473.3184.15319927087462863547.stgit@sosrh3.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156218168473.3184.15319927087462863547.stgit@sosrh3.amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Gary,

On Wed, Jul 03, 2019 at 07:21:26PM +0000, Hook, Gary wrote:
> The AES GCM function reuses an 'op' data structure, which members
> contain values that must be cleared for each (re)use.
> 
> Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/crypto/ccp/ccp-ops.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Is this patch meant to fix the gcm-aes-ccp self-tests failure?

- Eric

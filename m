Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F214E33361E
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Mar 2021 08:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCJHHq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Mar 2021 02:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhCJHHb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Mar 2021 02:07:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD29164FE8;
        Wed, 10 Mar 2021 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615360051;
        bh=qKf18z2QlQPGGLamvy7zeeIPpki5qsIFwSLN9jPCpg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsKFu2220FTguffAJ2ZNsh3nnAna4QZ+tC78ABSCB3hNCr8tG4TIUerYxvsucrTEq
         BR0lO2NP5XyJJUNlQdogXre7oMM1KL1iBTKI4XKWKgggRkvq2Ns0ZNPbE21hvN09Qe
         CiJPoRWdyhzTAAlcKE4xe42+TxCezZnZ3jjAjI7H10buZGCIcZ2IRPtYvf8XeLpYuC
         /d9CTWjU6XE+/BOE9xWon4L4WB3vssvRDbTIthP+3k/xJ7QxlTZfmefZwjWhtLEttA
         Fa/LZt1ctJraoDye50vXSKcFyNOUvMTJ5heg7WqGnruBYBFQG+3zPRebCZqSs5QIlb
         2fsAHjaww+BuA==
Date:   Tue, 9 Mar 2021 23:07:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] crypto: arm/chacha-scalar - switch to common
 rev_32 macro
Message-ID: <YEhwMRECiY+LWLWu@sol.localdomain>
References: <20210307165424.165188-1-ardb@kernel.org>
 <20210307165424.165188-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307165424.165188-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Mar 07, 2021 at 05:54:24PM +0100, Ard Biesheuvel wrote:
> Drop the local definition of a byte swapping macro and use the common
> one instead.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>

Although shouldn't the commit title say "rev_l" instead of "rev_32"?

- Eric

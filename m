Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8C2D824D
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 23:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436538AbgLKWqL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Dec 2020 17:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436534AbgLKWpt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Dec 2020 17:45:49 -0500
Date:   Fri, 11 Dec 2020 14:45:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726708;
        bh=xKrxRm0m8w5epwsR+IqQc2+kgG3EEMjfoYSbM8QFvs0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ED21hGwmRHXa6+74u9GoAqbMOylIdw1GSZEhxPUSqqdRi8SpPbEo9P65v5oOvDOSb
         l2Btb3cztQf3lu8MPibCwEli4oahrXIOGIT4Q8ZUeB4MA+J779oYN9ZDCUuiNCyDU4
         IL69v/zdB7YUSzn05e2tV5QpN0SHS/Q+BtiKFPw4tiGOnbiE8o3zOXTiMqcr5Rpop6
         /WNaHJo0fuHab7E/DX5/RygyPInUQUPE3JcjqwGH0dbNeJpwbKrdTwxiYYdWXGKzQk
         UaY01lO6zkWxmYTjsW5AhbP32be9Cksf8sL8x7B3poIJDHEjynVntasuT7gSguDvja
         KBNleH2+OY0XQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 2/2] crypto: remove cipher routines from public crypto
 API
Message-ID: <X9P2c2DQjAPiIjoh@sol.localdomain>
References: <20201211122715.15090-1-ardb@kernel.org>
 <20201211122715.15090-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211122715.15090-3-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 11, 2020 at 01:27:15PM +0100, Ard Biesheuvel wrote:
> The cipher routines in the crypto API are mostly intended for templates
> implementing skcipher modes generically in software, and shouldn't be
> used outside of the crypto subsystem. So move the prototypes and all
> related definitions to a new header file under include/crypto/internal.
> Also, let's use the new module namespace feature to move the symbol
> exports into a new namespace CRYPTO_INTERNAL.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Eric Biggers <ebiggers@google.com>

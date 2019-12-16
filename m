Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BF11FE50
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Dec 2019 07:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfLPGA3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 16 Dec 2019 01:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfLPGA2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 16 Dec 2019 01:00:28 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5AD20717;
        Mon, 16 Dec 2019 06:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576476028;
        bh=xhPWjfFE+qhwPksYcJkqFRjUWdGxE51xVXJ5CF94IpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvyIhqC3youUNxf7GSWlDCdnuJkJ/vox4jv3AvypiyBo44Jpfo9/QILLyUoOm9kbH
         eqdC1EEBawGA1ZCoyxirUcqy6pQTLOamreA6MBoN1EMlCRmMa+4MFo7TW3gHUCz/vw
         sygkpRkh2/YxyfS6/YEAItCrawgNARFJbMbQycB0=
Date:   Sun, 15 Dec 2019 22:00:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Polyakov <appro@openssl.org>
Subject: Re: [PATCH crypto-next v5 2/3] crypto: x86_64/poly1305 - add faster
 implementations
Message-ID: <20191216060026.GC908@sol.localdomain>
References: <20191215204631.142024-1-Jason@zx2c4.com>
 <20191215204631.142024-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215204631.142024-3-Jason@zx2c4.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Dec 15, 2019 at 09:46:30PM +0100, Jason A. Donenfeld wrote:
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 958440eae27e..6982a2f8863f 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -73,6 +73,10 @@ aegis128-aesni-y := aegis128-aesni-asm.o aegis128-aesni-glue.o
>  
>  nhpoly1305-sse2-y := nh-sse2-x86_64.o nhpoly1305-sse2-glue.o
>  blake2s-x86_64-y := blake2s-core.o blake2s-glue.o
> +poly1305-x86_64-y := poly1305-x86_64.o poly1305_glue.o
> +ifneq ($(CONFIG_CRYPTO_POLY1305_X86_64),)
> +targets += poly1305-x86_64.S
> +endif

poly1305-x86_64.S is a generated file, so it needs to be listed in a gitignore
file arch/x86/crypto/.gitignore.

- Eric

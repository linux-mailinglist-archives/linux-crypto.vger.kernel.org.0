Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85F01C36E5
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2020 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEDK1j (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 May 2020 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgEDK1i (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 May 2020 06:27:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1115C061A0E;
        Mon,  4 May 2020 03:27:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49FzZH12j2z9sSc;
        Mon,  4 May 2020 20:27:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588588056;
        bh=6kYgnh3xuavjou7j89KPt2ZLR/bBS6MAYSPgbK+bcWE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bX0hwGoTdTynk07RtOrX90klkiQMESa0oWs1CmtQ1/y2s7B/psw+249zKxxW1u5fV
         2OdvG8ZpmiK9aahJjHsAnVKtBkzOCcxvnEQg1ra3z+uFHq97lOSPHJ+BC/WM/m1MGn
         gfYSCLgKxGiKqC41qsAoPQNf22hSJ8aSstxX9+4I2AXhCoYvn5YPtEESwsbAFzr75l
         TXQU4Pe5ejs+yOSPW9dbGaWDjgGrSrCx8fPl93cqknNhabjQkIKfd44XJml6eibRrb
         gT7fT+DcA9JvATKuMMs0r2bmNJajWhGLjSJHh9wrAlPmCuqW2ymOgshWIaAw4VAuE8
         HM1UkbyEsvxuw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/7] crypto: powerpc/sha1 - remove unused temporary workspace
In-Reply-To: <20200502182427.104383-3-ebiggers@kernel.org>
References: <20200502182427.104383-1-ebiggers@kernel.org> <20200502182427.104383-3-ebiggers@kernel.org>
Date:   Mon, 04 May 2020 20:27:50 +1000
Message-ID: <87d07kdmft.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:
> From: Eric Biggers <ebiggers@google.com>
>
> The PowerPC implementation of SHA-1 doesn't actually use the 16-word
> temporary array that's passed to the assembly code.  This was probably
> meant to correspond to the 'W' array that lib/sha1.c uses.  However, in
> sha1-powerpc-asm.S these values are actually stored in GPRs 16-31.
>
> Referencing SHA_WORKSPACE_WORDS from this code also isn't appropriate,
> since it's an implementation detail of lib/sha1.c.
>
> Therefore, just remove this unneeded array.
>
> Tested with:
>
> 	export ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
> 	make mpc85xx_defconfig
> 	cat >> .config << EOF
> 	# CONFIG_MODULES is not set
> 	# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> 	CONFIG_DEBUG_KERNEL=y
> 	CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> 	CONFIG_CRYPTO_SHA1_PPC=y
> 	EOF
> 	make olddefconfig
> 	make -j32
> 	qemu-system-ppc -M mpc8544ds -cpu e500 -nographic \
> 		-kernel arch/powerpc/boot/zImage \
> 		-append "cryptomgr.fuzz_iterations=1000 cryptomgr.panic_on_fail=1"

Thanks for testing.

I gave it a quick spin on a Power9 and it showed no issues.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

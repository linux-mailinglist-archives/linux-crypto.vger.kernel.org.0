Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9866524683
	for <lists+linux-crypto@lfdr.de>; Tue, 21 May 2019 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfEUD6M (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 May 2019 23:58:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEUD6M (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 May 2019 23:58:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457MS06LgNz9s9T;
        Tue, 21 May 2019 13:58:08 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Breno =?utf-8?Q?Leit=C3=A3o?= <leitao@debian.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: vmx - convert to SPDX license identifiers
In-Reply-To: <20190520164232.159053-1-ebiggers@kernel.org>
References: <20190520164232.159053-1-ebiggers@kernel.org>
Date:   Tue, 21 May 2019 13:58:06 +1000
Message-ID: <874l5o8nn5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:
> From: Eric Biggers <ebiggers@google.com>
>
> Remove the boilerplate license text and replace it with the equivalent
> SPDX license identifier.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/crypto/vmx/aes.c     | 14 +-------------
>  drivers/crypto/vmx/aes_cbc.c | 14 +-------------
>  drivers/crypto/vmx/aes_ctr.c | 14 +-------------
>  drivers/crypto/vmx/aes_xts.c | 14 +-------------
>  drivers/crypto/vmx/vmx.c     | 14 +-------------
>  5 files changed, 5 insertions(+), 65 deletions(-)

Looks good to me.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

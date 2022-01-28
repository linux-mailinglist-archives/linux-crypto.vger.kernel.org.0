Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C534F49F38E
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Jan 2022 07:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346431AbiA1GZH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jan 2022 01:25:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60606 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346425AbiA1GZG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jan 2022 01:25:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDKgw-00014r-Fw; Fri, 28 Jan 2022 17:25:03 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 17:25:02 +1100
Date:   Fri, 28 Jan 2022 17:25:02 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kevin Bracey <kevin@bracey.fi>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 0/4] arm64: accelerate crc32_be
Message-ID: <YfOMPhAczX7KBu8v@gondor.apana.org.au>
References: <20220118102351.3356105-1-kevin@bracey.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118102351.3356105-1-kevin@bracey.fi>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 18, 2022 at 12:23:47PM +0200, Kevin Bracey wrote:
> Originally sent only to the arm-linux list - now including linux-crypto.
> Ard suggested that Herbert take the series.
> 
> This series completes the arm64 crc32 helper acceleration by adding crc32_be.
> 
> There are plenty of users, for example OF.
> 
> To compensate for the extra supporting cruft in lib/crc32.c, a couple of minor
> tidies.
> 
> changes since v2:
> - no code change, but sent to Herbert+crypto with Catalin's ack for arm64
> 
> changes since v1:
> - assembler style fixes from Ard's review
> 
> Kevin Bracey (4):
>   lib/crc32.c: remove unneeded casts
>   lib/crc32.c: Make crc32_be weak for arch override
>   lib/crc32test.c: correct printed bytes count
>   arm64: accelerate crc32_be
> 
>  arch/arm64/lib/crc32.S | 87 +++++++++++++++++++++++++++++++++++-------
>  lib/crc32.c            | 14 +++----
>  lib/crc32test.c        |  2 +-
>  3 files changed, 80 insertions(+), 23 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

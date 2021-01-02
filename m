Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6452E81AE
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Dec 2020 19:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgLaSzQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Dec 2020 13:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgLaSzQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Dec 2020 13:55:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1992222BB;
        Thu, 31 Dec 2020 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609440875;
        bh=ME0bBlCd5kvbIqAWHokJy1knDRd2YSwvX3bzRCBcSrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/WRG6Nwg997n5jVpR59bPpPpAPlA0BOJMD9uepXWuVPfAwB0txwbkaXEoyghxey0
         GQOBUr6ljgZLg99sssUP7KtB0pjb9lC8SRPl/z98a+pg1FCuUHbNHbAECvASmj8LFD
         QzY3tIJbwYgwZvFyxT4ux7KdCk3JsKlfx2luwXB94W1/e4XXsUqfJJqQAUCpYd7G6l
         538oWK2nhkEHGWRpkb1++jdqE3WYu3yyKo63p0Z0U5CtLKQlXW3oDn5nTCchsAjVFb
         4tKTKsXTw88wvdSIR61QCW6XGkzxEdzCNYACyVPY6znSpLBE9PCA4aOgT/HsGqgHJO
         Cb/y2ED/WDSXw==
Date:   Thu, 31 Dec 2020 10:54:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Megha Dey <megha.dey@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 12/21] crypto: x86/des - drop CTR mode implementation
Message-ID: <X+4eamc0Btz+/fk6@sol.localdomain>
References: <20201231172337.23073-1-ardb@kernel.org>
 <20201231172337.23073-13-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231172337.23073-13-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:28PM +0100, Ard Biesheuvel wrote:
> DES or Triple DES in counter mode is never used in the kernel, so there
> is no point in keeping an accelerated implementation around.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/crypto/des3_ede_glue.c | 104 --------------------
>  crypto/Kconfig                  |   1 +
>  2 files changed, 1 insertion(+), 104 deletions(-)

Acked-by: Eric Biggers <ebiggers@google.com>

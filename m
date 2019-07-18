Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61646D1E0
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jul 2019 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRQSk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jul 2019 12:18:40 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:36818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729774AbfGRQSk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jul 2019 12:18:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 568338023D98;
        Thu, 18 Jul 2019 16:18:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2195:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:7903:8603:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13160:13229:13439:13869:14181:14659:14721:21080:21324:21451:21627:30005:30012:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: deer25_684dc6a622a40
X-Filterd-Recvd-Size: 4295
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jul 2019 16:18:36 +0000 (UTC)
Message-ID: <db0a363fa35f1582f20e529d79927995a5512c0d.camel@perches.com>
Subject: Re: [PATCH] crypto: aegis: fix badly optimized clang output
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ondrej Mosnacek <omosnacek@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Thu, 18 Jul 2019 09:18:35 -0700
In-Reply-To: <20190718135017.2493006-1-arnd@arndb.de>
References: <20190718135017.2493006-1-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 2019-07-18 at 15:50 +0200, Arnd Bergmann wrote:
> Clang sometimes makes very different inlining decisions from gcc.
> In case of the aegis crypto algorithms, it decides to turn the innermost
> primitives (and, xor, ...) into separate functions but inline most of
> the rest.

> This results in a huge amount of variables spilled on the stack, leading
> to rather slow execution as well as kernel stack usage beyond the 32-bit
> warning limit when CONFIG_KASAN is enabled:
> 
> crypto/aegis256.c:123:13: warning: stack frame size of 648 bytes in function 'crypto_aegis256_encrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis256.c:366:13: warning: stack frame size of 1264 bytes in function 'crypto_aegis256_crypt' [-Wframe-larger-than=]
> crypto/aegis256.c:187:13: warning: stack frame size of 656 bytes in function 'crypto_aegis256_decrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128l.c:135:13: warning: stack frame size of 832 bytes in function 'crypto_aegis128l_encrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128l.c:415:13: warning: stack frame size of 1480 bytes in function 'crypto_aegis128l_crypt' [-Wframe-larger-than=]
> crypto/aegis128l.c:218:13: warning: stack frame size of 848 bytes in function 'crypto_aegis128l_decrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128.c:116:13: warning: stack frame size of 584 bytes in function 'crypto_aegis128_encrypt_chunk' [-Wframe-larger-than=]
> crypto/aegis128.c:351:13: warning: stack frame size of 1064 bytes in function 'crypto_aegis128_crypt' [-Wframe-larger-than=]
> crypto/aegis128.c:177:13: warning: stack frame size of 592 bytes in function 'crypto_aegis128_decrypt_chunk' [-Wframe-larger-than=]
> 
> Forcing the primitives to all get inlined avoids the issue and the
> resulting code is similar to what gcc produces.

Why weren't these functions in .h files
not always marked with inline?

Are there other static non-inlined function
definitions in .h files that should also get
this inline/__always_inline marking?

I presume there are but can't think of a
reasonable way to find them off the top of
my head.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/aegis.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/aegis.h b/crypto/aegis.h
> index 41a3090cda8e..efed7251c49d 100644
> --- a/crypto/aegis.h
> +++ b/crypto/aegis.h
> @@ -34,21 +34,21 @@ static const union aegis_block crypto_aegis_const[2] = {
>  	} },
>  };
>  
> -static void crypto_aegis_block_xor(union aegis_block *dst,
> +static __always_inline void crypto_aegis_block_xor(union aegis_block *dst,
>  				   const union aegis_block *src)
>  {
>  	dst->words64[0] ^= src->words64[0];
>  	dst->words64[1] ^= src->words64[1];
>  }
>  
> -static void crypto_aegis_block_and(union aegis_block *dst,
> +static __always_inline void crypto_aegis_block_and(union aegis_block *dst,
>  				   const union aegis_block *src)
>  {
>  	dst->words64[0] &= src->words64[0];
>  	dst->words64[1] &= src->words64[1];
>  }
>  
> -static void crypto_aegis_aesenc(union aegis_block *dst,
> +static __always_inline void crypto_aegis_aesenc(union aegis_block *dst,
>  				const union aegis_block *src,
>  				const union aegis_block *key)
>  {


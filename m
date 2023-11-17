Return-Path: <linux-crypto+bounces-167-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269DB7EF2D5
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 13:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0984280A74
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3030F99
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA7D18B
	for <linux-crypto@vger.kernel.org>; Fri, 17 Nov 2023 03:24:36 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3wxc-000dMl-5q; Fri, 17 Nov 2023 19:24:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 19:24:40 +0800
Date: Fri, 17 Nov 2023 19:24:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, roxana.nicolescu@canonical.com
Subject: Re: [PATCH v2] crypto: x86/sha256 - autoload if SHA-NI detected
Message-ID: <ZVdNeBV6M44WRz+t@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101031811.23028-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The x86 SHA-256 module contains four implementations: SSSE3, AVX, AVX2,
> and SHA-NI.  Commit 1c43c0f1f84a ("crypto: x86/sha - load modules based
> on CPU features") made the module be autoloaded when SSSE3, AVX, or AVX2
> is detected.  The omission of SHA-NI appears to be an oversight, perhaps
> because of the outdated file-level comment.  This patch fixes this,
> though in practice this makes no difference because SSSE3 is a subset of
> the other three features anyway.  Indeed, sha256_ni_transform() executes
> SSSE3 instructions such as pshufb.
> 
> Reviewed-by: Roxana Nicolescu <roxana.nicolescu@canonical.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: added #ifdef
> 
> arch/x86/crypto/sha256_ssse3_glue.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


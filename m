Return-Path: <linux-crypto+bounces-147-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B97EF0C8
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 11:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964C21C20323
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B11A719
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE0194;
	Fri, 17 Nov 2023 02:22:59 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3vzo-000bhM-Dy; Fri, 17 Nov 2023 18:22:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 18:22:52 +0800
Date: Fri, 17 Nov 2023 18:22:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kernel test robot <lkp@intel.com>
Cc: Danny Tsen <dtsen@linux.ibm.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: error:
 'gcm_init_htable' accessing 256 bytes in a region of size 224
Message-ID: <ZVc+/IXxz7VgY3jO@gondor.apana.org.au>
References: <202310290004.TQsw1iN1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310290004.TQsw1iN1-lkp@intel.com>

On Sun, Oct 29, 2023 at 12:54:22AM +0800, kernel test robot wrote:
>
>    arch/powerpc/crypto/aes-gcm-p10-glue.c: In function 'gcmp10_init':
> >> arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: error: 'gcm_init_htable' accessing 256 bytes in a region of size 224 [-Werror=stringop-overflow=]
>      121 |         gcm_init_htable(hash->Htable+32, hash->H);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: note: referencing argument 1 of type 'unsigned char[256]'
>    arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: note: referencing argument 2 of type 'unsigned char[16]'
>    arch/powerpc/crypto/aes-gcm-p10-glue.c:41:17: note: in a call to function 'gcm_init_htable'
>       41 | asmlinkage void gcm_init_htable(unsigned char htable[256], unsigned char Xi[16]);
>          |                 ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Danny, can you please look into this error?

Perhaps htable should be changed to 224?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


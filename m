Return-Path: <linux-crypto+bounces-624-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4B8087DA
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Dec 2023 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF161C20862
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Dec 2023 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDC3C487
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Dec 2023 12:35:12 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB713D
	for <linux-crypto@vger.kernel.org>; Thu,  7 Dec 2023 02:36:54 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBBkN-007xh4-Cy; Thu, 07 Dec 2023 18:36:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 Dec 2023 18:36:57 +0800
Date: Thu, 7 Dec 2023 18:36:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ovidiu.panait@windriver.com
Cc: linux-crypto@vger.kernel.org, ebiggers@kernel.org
Subject: [PATCH] crypto: api - Disallow identical driver names
Message-ID: <ZXGgSXjEUmitiFgw@gondor.apana.org.au>
References: <20231206203743.2029620-1-ovidiu.panait@windriver.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206203743.2029620-1-ovidiu.panait@windriver.com>

On Wed, Dec 06, 2023 at 10:37:43PM +0200, ovidiu.panait@windriver.com wrote:
>
> When the alg name contains extra bogus characters after a valid template,
> the bind() call fails, but a duplicated entry is still registered (in this
> case xts(ecb(aes-generic))).
> 
> To fix this, add a check in cryptomgr_schedule_probe() for trailing
> characters after a valid template.

Thanks for the report!

This is definitely not good.  However, I think it's an existing
bug in the algorithm registration code:

---8<---
Disallow registration of two algorithms with identical driver names.

Cc: <stable@vger.kernel.org>
Reported-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 4fe95c448047..85bc279b4233 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -341,6 +341,7 @@ __crypto_register_alg(struct crypto_alg *alg, struct list_head *algs_to_put)
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
+		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


Return-Path: <linux-crypto+bounces-494-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAA801AAB
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 05:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52B8B20BEE
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 04:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23421BA37
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 04:32:42 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842301B3
	for <linux-crypto@vger.kernel.org>; Fri,  1 Dec 2023 19:49:14 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r9H08-006116-28; Sat, 02 Dec 2023 11:49:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Dec 2023 11:49:17 +0800
Date: Sat, 2 Dec 2023 11:49:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Subject: [v3 PATCH 0/4] crypto: Fix chaining support for stream ciphers (arc4
 only for now)
Message-ID: <ZWqpPTHXuMvRmWi+@gondor.apana.org.au>
References: <20230920062551.GB2739@sol.localdomain>
 <ZQvHUc9rd4ud2NCB@gondor.apana.org.au>
 <20230922031030.GB935@sol.localdomain>
 <ZVb38sHNJYJ9x0po@gondor.apana.org.au>
 <20231117054231.GC972@sol.localdomain>
 <ZVctSuGp2SgRUjAM@gondor.apana.org.au>
 <ZWB6jQv4jjBTrRGB@gondor.apana.org.au>
 <20231127222803.GC1463@sol.localdomain>
 <ZWbZEnSPIP5aHydB@gondor.apana.org.au>
 <ZWhcDoBp8wPiWiYa@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWhcDoBp8wPiWiYa@gondor.apana.org.au>

v3 updates the documentation for crypto_lskcipher_encrypt/decrypt.
v2 fixes a crash when no export/import functions are provided.

This series of patches adds the ability to process a skcipher
request in a piecemeal fashion, which is currently only possible
for selected algorithms such as CBC and CTR.

Herbert Xu (4):
  crypto: skcipher - Add internal state support
  crypto: skcipher - Make use of internal state
  crypto: arc4 - Add internal state
  crypto: algif_skcipher - Fix stream cipher chaining

 crypto/algif_skcipher.c   |  71 ++++++++++++++++++++++-
 crypto/arc4.c             |   8 ++-
 crypto/cbc.c              |   6 +-
 crypto/ecb.c              |  10 ++--
 crypto/lskcipher.c        |  42 +++++++++++---
 crypto/skcipher.c         |  80 +++++++++++++++++++++++++-
 include/crypto/if_alg.h   |   2 +
 include/crypto/skcipher.h | 117 +++++++++++++++++++++++++++++++++++---
 8 files changed, 306 insertions(+), 30 deletions(-)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


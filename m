Return-Path: <linux-crypto+bounces-633-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE8809B04
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 05:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E435C1F21361
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F86FA5
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Dec 2023 04:34:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB9D1712;
	Thu,  7 Dec 2023 20:06:26 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBS86-008If7-HF; Fri, 08 Dec 2023 12:06:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 12:06:32 +0800
Date: Fri, 8 Dec 2023 12:06:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-s390@vger.kernel.org,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Jan Glauber <jang@linux.vnet.ibm.com>
Subject: Re: crypto: s390/aes - Fix buffer overread in CTR mode
Message-ID: <ZXKWSF2WwaiwhbJN@gondor.apana.org.au>
References: <ZWWHFeOPcW30OYo1@gondor.apana.org.au>
 <ce50a198e3c59f30376cf54e52d5e749@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce50a198e3c59f30376cf54e52d5e749@linux.ibm.com>

On Tue, Nov 28, 2023 at 02:18:02PM +0100, Harald Freudenberger wrote:
>
> Here is a similar fix for the s390 paes ctr cipher. Compiles and is
> tested. You may merge this with your patch for the s390 aes cipher.

Thank you.  I had to apply this by hand so please check the result
which I've just pushed out to cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


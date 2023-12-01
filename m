Return-Path: <linux-crypto+bounces-456-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A2800B25
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246F11C20D1D
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD125569
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 12:39:46 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F41704;
	Fri,  1 Dec 2023 03:41:12 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r91tG-005jtE-EO; Fri, 01 Dec 2023 19:41:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 19:41:11 +0800
Date: Fri, 1 Dec 2023 19:41:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, olivia@selenic.com,
	syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwrng: core - fix task hung in hwrng_fillfn
Message-ID: <ZWnGV39HJr9uUB2/@gondor.apana.org.au>
References: <ZWmt6wrbxN1W+cnv@gondor.apana.org.au>
 <tencent_0AD55DB29954CFB30D9825850DEE12325D07@qq.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0AD55DB29954CFB30D9825850DEE12325D07@qq.com>

On Fri, Dec 01, 2023 at 07:37:39PM +0800, Edward Adam Davis wrote:
>
> Reduce the scope of critical zone protection.
> The original critical zone contains a too large range, especially like 
> copy_to_user() should not be included in the critical zone.

Which part in particular is taking 143 seconds? The buffer is
only 128 bytes long.  Why is a 128-byte copy taking 143 seconds,
even with a page fault?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


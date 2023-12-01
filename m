Return-Path: <linux-crypto+bounces-488-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65480801912
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5021F2109E
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91D1C26
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Dec 2023 00:41:28 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BE1A6;
	Fri,  1 Dec 2023 15:39:00 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r9D5s-005xu4-QL; Sat, 02 Dec 2023 07:38:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 02 Dec 2023 07:38:58 +0800
Date: Sat, 2 Dec 2023 07:38:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, olivia@selenic.com,
	syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwrng: core - fix task hung in hwrng_fillfn
Message-ID: <ZWpukgSDlA6UFR6e@gondor.apana.org.au>
References: <ZWnGV39HJr9uUB2/@gondor.apana.org.au>
 <tencent_B2D2C5864C49BDAEE0AEC1CC9627E3C6CF06@qq.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B2D2C5864C49BDAEE0AEC1CC9627E3C6CF06@qq.com>

On Fri, Dec 01, 2023 at 08:34:12PM +0800, Edward Adam Davis wrote:
>
> According to splat, after a page fault occurred, the attempt to retrieve 
> rcu_read_lock() failed, resulting in a timeout of 143s. This is my speculation.

Oh I see what's going on.  The reproducer is mapping /dev/hwrng, so
the write to user-space is then triggering another read which then
dead-locks.

Let me think about this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


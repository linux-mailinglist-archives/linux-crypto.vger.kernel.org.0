Return-Path: <linux-crypto+bounces-555-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420738048A1
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 05:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BE01C20D4F
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 04:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC512E6B
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 04:34:55 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3262A1
	for <linux-crypto@vger.kernel.org>; Mon,  4 Dec 2023 20:32:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rAN6V-006wuV-Od; Tue, 05 Dec 2023 12:32:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 Dec 2023 12:32:25 +0800
Date: Tue, 5 Dec 2023 12:32:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: liulongfang <liulongfang@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 10/19] crypto: hisilicon/sec2 - Remove cfb and ofb
Message-ID: <ZW6n2RBUslpeJTrS@gondor.apana.org.au>
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
 <E1r8g9A-005ILj-Sb@formenos.hmeau.com>
 <2f75977b-1383-908d-bf32-5084ef260c53@huawei.com>
 <382efecd-5b2c-a328-3ef3-16d4b2b66590@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382efecd-5b2c-a328-3ef3-16d4b2b66590@huawei.com>

On Mon, Dec 04, 2023 at 10:14:21AM +0800, liulongfang wrote:
.
> Hi Herbert:
> After reviewing the code, I found that there is still a place where the code
> needs to be modified.
> A register value indicating OFB and CFB modes needs to be updated:

Thanks.  I've added this to the patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


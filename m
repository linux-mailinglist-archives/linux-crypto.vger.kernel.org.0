Return-Path: <linux-crypto+bounces-140-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601E7EEBB8
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 05:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C247E281117
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 04:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C981944C
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Nov 2023 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9499A126;
	Thu, 16 Nov 2023 19:58:07 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3pzK-000WgD-Dw; Fri, 17 Nov 2023 11:57:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 11:57:58 +0800
Date: Fri, 17 Nov 2023 11:57:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: starfive - Pad adata with zeroes
Message-ID: <ZVbkxgAgSner0jWJ@gondor.apana.org.au>
References: <20231116021752.420680-1-jiajie.ho@starfivetech.com>
 <ZVWcLJOoLdElVsDd@gondor.apana.org.au>
 <2905f518-95a9-88d4-031c-291ef0373391@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2905f518-95a9-88d4-031c-291ef0373391@starfivetech.com>

On Thu, Nov 16, 2023 at 01:39:57PM +0800, Jia Jie Ho wrote:
>
> I'll update the v2 commit message if you're good with this implementation.
> Thanks for reviewing this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


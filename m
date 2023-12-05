Return-Path: <linux-crypto+bounces-556-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF28048A2
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 05:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF7628142C
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 04:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735212E56
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Dec 2023 04:35:00 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACFA1
	for <linux-crypto@vger.kernel.org>; Mon,  4 Dec 2023 20:33:04 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rAN7D-006wwv-L4; Tue, 05 Dec 2023 12:33:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 05 Dec 2023 12:33:09 +0800
Date: Tue, 5 Dec 2023 12:33:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 14/19] crypto: starfive - Remove cfb and ofb
Message-ID: <ZW6oBcPc4js91/W9@gondor.apana.org.au>
References: <ZWh/nV+g46zhURa9@gondor.apana.org.au>
 <E1r8g9J-005INy-8H@formenos.hmeau.com>
 <0632d81e-724b-43b5-9aa5-6d9b69ba98f2@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0632d81e-724b-43b5-9aa5-6d9b69ba98f2@starfivetech.com>

On Mon, Dec 04, 2023 at 01:21:59PM +0800, Jia Jie Ho wrote:
>
> Hi Herbert,
> There are a few macros for ofb/cfb.
> Could you please help include the following changes too?

Thanks, I've added this to the patch.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


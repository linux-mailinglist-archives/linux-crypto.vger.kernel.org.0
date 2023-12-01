Return-Path: <linux-crypto+bounces-442-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EE800870
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEFF28145C
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA8210E6
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Dec 2023 10:38:04 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18F1FCA;
	Fri,  1 Dec 2023 01:34:17 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8zuK-005gqn-NS; Fri, 01 Dec 2023 17:34:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:34:09 +0800
Date: Fri, 1 Dec 2023 17:34:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: olivia@selenic.com, martin@kaiser.cx, jiajie.ho@starfivetech.com,
	jenny.zhang@starfivetech.com, mmyangfl@gmail.com, robh@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	x86@vger.kernel.org, CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com,
	YunShen@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <ZWmokVNG1ebMVNSM@gondor.apana.org.au>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
 <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>

On Tue, Nov 21, 2023 at 11:29:39AM +0800, LeoLiu-oc wrote:
>
> +static const struct x86_cpu_id via_rng_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);

Rather than moving the whole thing, just add this near the start
of the file:

static const struct x86_cpu_id via_rng_cpu_ids[];

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


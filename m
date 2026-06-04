Return-Path: <linux-crypto+bounces-24876-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YE3HofyIGpL9wAAu9opvQ
	(envelope-from <linux-crypto+bounces-24876-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 05:35:35 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59B63CB40
	for <lists+linux-crypto@lfdr.de>; Thu, 04 Jun 2026 05:35:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b="b0D/6tYe";
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24876-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24876-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 539A43044B93
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2026 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03817349CE0;
	Thu,  4 Jun 2026 03:32:36 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DC26D4E5;
	Thu,  4 Jun 2026 03:32:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543955; cv=none; b=A9aTLjbOJJjuqAFZpneTEdIIBpWw5PlAqR0NIYmnJOz+Bx04MOMPPjdIg5dWX/yj8OwUhwnEIrqFFBGAf8xvk98mgs8aEP7v306yQKjKf7+0cetkQTzcdGt56ZCIiXZRryhli8mBmOsTfszC3dMG20kWO9LRDS3IhQhkWISaxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543955; c=relaxed/simple;
	bh=PilbZsRyQYtzSKbAkjE2LGMyXusRYoB+4xipcFS1R+M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GNg+U8OD505zdiSdEv9vvpHc93bDHvg+zEGokNTWUOpC+q8nyN8V2H++FsYYHPIEwWBoQb2DWNaw+uyqzhkkYye0zZH4yWDK6GzhoOLINQzrvhRqqvKw8U4xEPx5I/Et2298Iul7pioj4lL3Gr3OZEsf4nnpA5Cskvuk6psKJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=b0D/6tYe; arc=none smtp.client-ip=113.46.200.224
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cMgBCSgvMtpZEZrDJ1R+5pwimwPSaByYbNxh3LP7+uM=;
	b=b0D/6tYekJLgMjLMWwjnVuLzmDupBuHI0VQIAXUUfPUs8mTBlUW81/A51fwmxND/9D7AnK+DT
	OZL4NAI8Byt+ENSFJoStoZyERUI9o4QiK983PVPLf3vilQi6iVdy/dCYQoMAbrr86+U1A88di5D
	UmwAH2Vm+B8EFaKNLwT5rdE=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gW90d20Cjz1cyPd;
	Thu,  4 Jun 2026 11:24:33 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C6304056E;
	Thu,  4 Jun 2026 11:32:22 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 11:32:21 +0800
Subject: Re: [PATCH 0/2] HiSilicon TRNG fix and simplification
To: Eric Biggers <ebiggers@kernel.org>, <linux-crypto@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
CC: Olivia Mackall <olivia@selenic.com>, Weili Qian <qianweili@huawei.com>,
	Wei Xu <xuwei5@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260530202624.20768-1-ebiggers@kernel.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <a5df5973-480e-c18b-90bf-99380d24968d@huawei.com>
Date: Thu, 4 Jun 2026 11:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260530202624.20768-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500015.china.huawei.com (7.185.36.143)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24876-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:olivia@selenic.com,m:qianweili@huawei.com,m:xuwei5@hisilicon.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[liulongfang@huawei.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liulongfang@huawei.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,huawei.com:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE59B63CB40

On 2026/5/31 4:26, Eric Biggers wrote:
> This series fixes and greatly simplifies the HiSilicon TRNG driver by
> removing the gratuitous crypto_rng interface, leaving just hwrng which
> is the one that actually matters.
> 
> Note that this mirrors similar changes in other drivers such as qcom-rng
> (https://lore.kernel.org/r/20260530020332.143058-1-ebiggers@kernel.org)
> 
> Eric Biggers (2):
>   crypto: hisi-trng - Remove crypto_rng interface
>   hwrng: hisi-trng - Move hisi-trng into drivers/char/hw_random/
> 
>  MAINTAINERS                            |   2 +-
>  arch/arm64/configs/defconfig           |   2 +-
>  drivers/char/hw_random/Kconfig         |  10 +
>  drivers/char/hw_random/Makefile        |   1 +
>  drivers/char/hw_random/hisi-trng-v2.c  |  98 +++++++
>  drivers/crypto/hisilicon/Kconfig       |   8 -
>  drivers/crypto/hisilicon/Makefile      |   1 -
>  drivers/crypto/hisilicon/trng/Makefile |   2 -
>  drivers/crypto/hisilicon/trng/trng.c   | 390 -------------------------
>  9 files changed, 111 insertions(+), 403 deletions(-)
>  create mode 100644 drivers/char/hw_random/hisi-trng-v2.c
>  delete mode 100644 drivers/crypto/hisilicon/trng/Makefile
>  delete mode 100644 drivers/crypto/hisilicon/trng/trng.c
> 
> 
> base-commit: 5624ea54f3ba5c83d2e5503411a31a8be0278c1e
> prerequisite-patch-id: 07e982b663ac3f8312ca524f6b91b5b38661df5e
> prerequisite-patch-id: 72064361a8f36e015ab0b7e1fa4d364b40d90506
> prerequisite-patch-id: 8978b8e0db7f47935e5f6f0aff14a97f55d3073c
> prerequisite-patch-id: 6aa0e3e93a008279d71e535a3d0cf48643f55e19
>

Acked-by: Longfang Liu <liulongfang@huawei.com>

Thanks.


Return-Path: <linux-crypto+bounces-25008-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Ff1GsbCKGrIJAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25008-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 03:49:58 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B566550B
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 03:49:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=qgQvh89P;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25008-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25008-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8713306D06A
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F22F3600;
	Wed, 10 Jun 2026 01:47:10 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F82FFF9D;
	Wed, 10 Jun 2026 01:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056029; cv=none; b=Om+WPaexGiGKkHKiOgCVT6npx6yoajDvwcc/lUk9d/ufi8C/o68ot6Yw8L6SpqAq32NaFu6L/EYyOsOpeREQZpwXgZVyfEuovRh5xDPtaAj1uiU6nWnM0v6Z3YrDb0Qor96/IP8OQ/Ew5XU2UrKZYEkWh5qOSkWQmf8uv9WpfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056029; c=relaxed/simple;
	bh=YRfMwGHvz751/FzID/tLviLXUrHY7p3dyIMcJG1JHuc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g9VqT7rE/KXXwWl2FzGSvt54lpmG67af/ysZ+Pc/e9hMhHzZhLtL/dJyd+JCy2T/PygLQBRc/fh7r0jVZIGDPBuQoU8IoP7Ku/LhnNFsItvHc7N/teHroGyxflKbHCCm12b70h/jKQRVzOCjbwZqvIISUDBvBzM7Wb1UI7xutKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qgQvh89P; arc=none smtp.client-ip=113.46.200.225
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0GRQowiqy86F6wWwGj99SSIj8J8U6XTDL9K41o7flx4=;
	b=qgQvh89PoSoBxBrmLMijA+U0o1GIaMQyFrhRAhls6Ud73oCpjROz1jkhEKA77hTm9O7I+u1EZ
	mIXBDZ0KGdYCtUg4KFTKsRnJQ1N6PceeggXyOURjtECj6NhBBs2JdlYNVOMZ4ReK+x6paVQFOAf
	dDOFy7alIQntlCUxDkx3Epw=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gZpNF64vvz1K9Vw;
	Wed, 10 Jun 2026 09:39:09 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 920D34056C;
	Wed, 10 Jun 2026 09:47:02 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:47:01 +0800
Subject: Re: [PATCH] MAINTAINERS: update hisilicon zip driver maintainer
To: Chenghai Huang <huangchenghai2@huawei.com>, <shenyang39@huawei.com>,
	<fanghao11@huawei.com>, <qianweili@huawei.com>, <wangzhou1@hisilicon.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20260610013437.1354503-1-huangchenghai2@huawei.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <d0875aef-6efd-6370-99b5-3f055369aa02@huawei.com>
Date: Wed, 10 Jun 2026 09:47:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260610013437.1354503-1-huangchenghai2@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500015.china.huawei.com (7.185.36.143)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25008-lists,linux-crypto=lfdr.de];
	FORGED_SENDER(0.00)[liulongfang@huawei.com,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:huangchenghai2@huawei.com,m:shenyang39@huawei.com,m:fanghao11@huawei.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liulongfang@huawei.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hisilicon.com:url,hisilicon.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 154B566550B

On 2026/6/10 9:34, Chenghai Huang wrote:
> Add Chenghai Huang as the maintainer of the hisilicon zip driver,
> replacing Yang Shen.
> 
> Signed-off-by: Chenghai Huang<huangchenghai2@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..7c66740aeb3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11714,7 +11714,7 @@ W:	http://www.hisilicon.com
>  F:	drivers/spi/spi-hisi-sfc-v3xx.c
>  
>  HISILICON ZIP Controller DRIVER
> -M:	Yang Shen <shenyang39@huawei.com>
> +M:	Chenghai Huang<huangchenghai2@huawei.com>
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
>  L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>

Reviewed-by: Longfang Liu <liulongfang@huawei.com>

Longfang
Thanks.



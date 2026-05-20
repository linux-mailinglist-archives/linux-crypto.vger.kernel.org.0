Return-Path: <linux-crypto+bounces-24332-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMiTCfsMDWqesgUAu9opvQ
	(envelope-from <linux-crypto+bounces-24332-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 03:23:07 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47D58683A
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 03:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14D123010711
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2026 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006AA2DC331;
	Wed, 20 May 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JdkiExo5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96012C21FE;
	Wed, 20 May 2026 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240176; cv=none; b=iadJ1+TTSw/Qe2eCAsxvRdLfR57/+I9QMPc49ClTiXb0i+qeFQa/ohfjF4hmGf1NiL5R3AF1Bo8AEN3kg5xoSnanWwiojNhg0tksemjnqUFHW7dSBDVJrMSb0dEmznfKqfgmI/t06j3qcCWEC8sUeSUn7kU0VwmQpGUlE+3msHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240176; c=relaxed/simple;
	bh=J+PlFOk1ujs9QOqrnqXyHCkJW0H/k0w8NGEgXcwmjVo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H6OhXK1t+v//9Gqxeq6tgX8/QVyzldb/RemWHjmwLPQYbQ0oj1G8k8gVA5NUN4h6JFAiFzWeT+q8pzbPpkB7SZjAOO9dQufjcrWwGmcs3SGd6Gz/dnS9QN1u9mYuVKv3YFr4DIUqhVbOWGKnm66HbOJx7ubh487dXq8wSxA7oJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JdkiExo5; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pZd1tC9dKsdYpmOGjvZUCRQTSExISFSEGWPSRDrvIv4=;
	b=JdkiExo5Qo4pnf3S6tHINSSScmvNuu8lE6ZRRXombmQrZPFoTNN04YYNPTqNwwp9dMy3saoqy
	rNpaTzuVk3uHtE6hxr9SjG7qCBDRPKU8KhC+xC5HIsyzrNxiJ/iGcYK6ccKTafWTuPzsi5J+fCm
	2ieDoaWkPN6FNr6GHVMUTq0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gKtrC0PlZz1prMy;
	Wed, 20 May 2026 09:15:07 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id B842C40561;
	Wed, 20 May 2026 09:22:50 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 09:22:50 +0800
Subject: Re: [PATCH] crypto: hisilicon/sec2 - lower priority for hisilicon
 crypto implementations
To: Chenghai Huang <huangchenghai2@huawei.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <qianweili@huawei.com>, <wangzhou1@hisilicon.com>
References: <20260511004927.3469951-1-huangchenghai2@huawei.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <fe78b23b-37bb-5995-94b5-64fcf9578722@huawei.com>
Date: Wed, 20 May 2026 09:22:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260511004927.3469951-1-huangchenghai2@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500015.china.huawei.com (7.185.36.143)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24332-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liulongfang@huawei.com,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2F47D58683A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/5/11 8:49, Chenghai Huang wrote:
> From: lizhi <lizhi206@huawei.com>
> 
> Lower the priority of HiSilicon's crypto implementations to allow more
> suitable alternatives to be selected. For example, certain kernel
> use-cases do not benefit from HiSilicon's symmetric crypto algorithms.
> This change ensures that more appropriate options are chosen first while
> retaining HiSilicon's implementations as alternatives.
> 
> Signed-off-by: lizhi <lizhi206@huawei.com>
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> index 2471a4dd0b50..77e0e03cbcab 100644
> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> @@ -20,7 +20,7 @@
>  #include "sec.h"
>  #include "sec_crypto.h"
>  
> -#define SEC_PRIORITY		4001
> +#define SEC_PRIORITY		80
>  #define SEC_XTS_MIN_KEY_SIZE	(2 * AES_MIN_KEY_SIZE)
>  #define SEC_XTS_MID_KEY_SIZE	(3 * AES_MIN_KEY_SIZE)
>  #define SEC_XTS_MAX_KEY_SIZE	(2 * AES_MAX_KEY_SIZE)
> 

Reviewed-by: Longfang Liu <liulongfang@huawei.com>

Thanks

Longfang.


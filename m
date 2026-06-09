Return-Path: <linux-crypto+bounces-24982-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e+HSEX1vJ2qMwgIAu9opvQ
	(envelope-from <linux-crypto+bounces-24982-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 09 Jun 2026 03:42:21 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5A65BB78
	for <lists+linux-crypto@lfdr.de>; Tue, 09 Jun 2026 03:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=fKcZc5F7;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24982-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24982-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC1ED301D51A
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Jun 2026 01:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301633F5A8;
	Tue,  9 Jun 2026 01:42:02 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D13242BE;
	Tue,  9 Jun 2026 01:41:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969321; cv=none; b=O0Q/X/b9GYPsxhX7p6lDSY7EgwEv/hPzihc+JGZuJhkVy1AYLxEaNTF9rnpjlYT2OJBhkL77EiME6zZ0fhwEDq6WDk3t9nGZsUkSbcvfI5hdI+rW4vzfi0dVaYnO5ikUhHgjadzVpMdgAGrE2G3ioEfRjCF4QWEvjynWmo05zZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969321; c=relaxed/simple;
	bh=KPgNQ+7RGqhw0lI/52sZeselIXNBJ8bYh4OUUpOxsPw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=tYnMiU5hk/BN6z+NNxvzBTpMlyxc8CCB5P1uKFuo6YnRIcbzQtsDYWWtK6+OYV6ut+AsN/WbXPNS75Tv9eOiIWFEevcdx9W45+wYVaIhRr/IDGeBMe7CdCkTCwawdw1plEmWYNxsvoj8qhM+Kbda2fDA9sUAhhsmycMK+tIsEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fKcZc5F7; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wSMjV0EKHbX25Ohp57F/PucASrZ9gSBPHxplkJUns7s=;
	b=fKcZc5F7/yIMk0gtoTUg2cDKiKnhVwwctrVT0Jk4KuwaCU+h+YMaVD5ST6QG/xg2uqeXlYf+z
	vzmakNjIGpCr7pL983mrVDKODA6hCB5RqnMdMTjY63Hytg/hcjjAucQjz+KKX7HY2H13QNVrNoc
	mgRMaDij8MvpmGBGBhoE4Vo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gZBJq1LVFzRhTP;
	Tue,  9 Jun 2026 09:34:03 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 46482203BC;
	Tue,  9 Jun 2026 09:41:56 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 09:41:56 +0800
Received: from [10.67.120.171] (10.67.120.171) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 09:41:55 +0800
Message-ID: <f07649c7-a668-4c8a-bde8-384c29661c23@huawei.com>
Date: Tue, 9 Jun 2026 09:41:55 +0800
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: huangchenghai <huangchenghai2@huawei.com>
Subject: Re: [PATCH v2 1/5] crypto: hisilicon/zip - add backlog support for
 zip
To: Herbert Xu <herbert@gondor.apana.org.au>, ZongYu Wu <wuzongyu1@huawei.com>
CC: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <fanghao11@huawei.com>,
	<liulongfang@huawei.com>, <qianweili@huawei.com>, <wangzhou1@hisilicon.com>,
	<linwenkai6@hisilicon.com>
References: <20260528115531.174593-1-wuzongyu1@huawei.com>
 <20260528115531.174593-2-wuzongyu1@huawei.com>
 <aiK3dY25BJv4APu_@gondor.apana.org.au>
Content-Language: en-US
In-Reply-To: <aiK3dY25BJv4APu_@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200001.china.huawei.com (7.202.195.16)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24982-lists,linux-crypto=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:wuzongyu1@huawei.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:fanghao11@huawei.com,m:liulongfang@huawei.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:linwenkai6@hisilicon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[huangchenghai2@huawei.com,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangchenghai2@huawei.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10A5A65BB78


在 2026/6/5 19:48, Herbert Xu 写道:
> On Thu, May 28, 2026 at 07:55:27PM +0800, ZongYu Wu wrote:
>> From: Chenghai Huang<huangchenghai2@huawei.com>
>>
>> When the hardware queue is busy, requests are now queued instead of
>> being failed immediately. Queued requests are retried when earlier
>> requests complete, which prevents transient failures under heavy load.
>>
>> The backlog path also provides a fallback mechanism while the hardware
>> is temporarily unavailable, such as during device reset.
>>
>> Signed-off-by: Chenghai Huang<huangchenghai2@huawei.com>
>> Signed-off-by: Zongyu Wu<wuzongyu1@huawei.com>
>> ---
>>   drivers/crypto/hisilicon/zip/zip_crypto.c | 286 ++++++++++++++--------
>>   1 file changed, 183 insertions(+), 103 deletions(-)
> We already have a generic queueing mechanism in the form of
> crypto_engine.
>
> Please add support for acomp to it instead of rolling your own
> queueing mechanism.
>
> Thanks,

OK. I will add the acomp support to crypto_engine

and then implement hisilicon backlog through it.


Thanks,

Chenghai



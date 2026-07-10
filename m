Return-Path: <linux-crypto+bounces-25824-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id th0gCCXmUGqR8AIAu9opvQ
	(envelope-from <linux-crypto+bounces-25824-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 14:31:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7076073ACA8
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 14:31:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JsutOSIg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25824-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25824-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 889EC3046C62
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2026 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FD413D93;
	Fri, 10 Jul 2026 12:27:30 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1841168E
	for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 12:27:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686449; cv=none; b=nfLXm62Tw1MspbEnSiOnYxBo5WFRNug57R3TTKTuZ1g2+H1fW9j0IVCx51BvnMSq3MyxFYGcBkhMBZiabLW+hxgSGLRb7SvMyyAHmaFo/ge8U8zaYVf30sZgH4GzNAH1kqa923zqtx1NjnjEXpJkHs+uZPQiSXgVHGKF/8RqfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686449; c=relaxed/simple;
	bh=rLKCmjRVf9KOpumyHtF+VxJdc7P58Nvlzs8HElmoXlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvEe5tRyCDI6SY+30aXSANyru+0xb+7+bWUmla8gYoXNvELFM60Ty1u03hTVZU88F+kYd/h3j0yeKcluMs70A2qyAc+IxMi5eYreProZ+p4lfZLPNoe4hsqdcF25GdlIdMHl9wjot3wwN6Z2b2R6fkrlBNy21492Y4wxRRYnfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsutOSIg; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f45e206dso2715075e9.1
        for <linux-crypto@vger.kernel.org>; Fri, 10 Jul 2026 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783686447; x=1784291247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WuKkt4ZATcS2uEH6twVx2vS+GDU8r/hOeP29ybwJqOw=;
        b=JsutOSIg+W6NbOGtl1Td0s4GDsVPt0D9i73z0vHyLM02eUHXEGvNLfaDJKR+HIfpDc
         vT1kk8AQQvtixCPqWlInaAhWxOONGGuxU6XG4UThcVTvWlQt1sy2zc8/7zyFzN4dzBhG
         tb5Ult6qC166ZGh/vj8QrtaWGC0XMizZTXKu1Iuv9lG8HiAnATzItkK3yPt2wqCKAtWA
         nGkgdKBoSbEH8zkRyaafj+aNDF6U+9sDy0wmdLyBVLyNyKZ1ccv5S6mNGvp18sypbo9q
         ZJCZ73Nn5KWJCNMOUZ0tGXFYQnuxwdM1yJ5imozp8EuxGcMAYOsASnOFk55UwbNaRGNz
         /i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686447; x=1784291247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WuKkt4ZATcS2uEH6twVx2vS+GDU8r/hOeP29ybwJqOw=;
        b=pB6dVtKLpM4FdvhcWBeNYOvEHDm0NfVy0HH8oyjjEZ7SZVSegvSfJ90Z7zNT+uz1Mk
         hMRLavaqcDCVbW/TBdbFf2Z4LwWBicvQo3XevfxSNpFUn/0v05JaT3dgIgp4Ianycr69
         QLzEsKKKuIMEhW7tHXGGXIrOnY7nuHinDm7at2y+71u9SS0g0ACRBwGXSBw9z4BVFJmP
         dGXSTUSfwBg7UbGcyPnZya9vE0pRafXZ6Q4aKdqiuhzJtxr3vZsxdR9NQEVymklBxf8g
         nl77VF2OOKGS4qUC4gYBj4BJvDYsjzFlZ+Eb9Q9jzm8pnHkpIeAb8rKrnRTkT/JVKpP/
         LSXg==
X-Forwarded-Encrypted: i=1; AHgh+Roc398G8HNmmL3k2D2ywcKzqebUGffQpZUDpMWFje3qpbWFhRPy1taHh/p8badrq37XESdGn6rIFgYTZMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYQxUeglZ7rkwsWYmreGNKUh2YsOL1zyjPJvHVJe+9NO/RZTD
	oMBa61DWm6aEzccuDd2uOcyV7H+bb+gObS5WbIoDkITi6LiDxoatUy56
X-Gm-Gg: AfdE7cldcNq2zk2mE4CNFmqlvh0FElU2jYde9Gjh9cZZoc3icLH5YDsGwhEo7A0RKzv
	m05Wv7NDRrPl9q1jd5YCf6ysXhSShSbB2cWww61dDoWtT8qZddOJF0X/9AWI/mVoD3AL/aI1Fyc
	wjWJ46rr2e5ZIAYIkoPWrUNhRKBNydyrJNWdTkAsLxwhY6B86cjoUv2tKcHPALpvoCSftY4YPXJ
	5qvyBAT8jiY85oSwwM9pRKYMD28/sFdpbeWrHxWIZ1IKJW1QRJGq9+Ty2cVA+wT7BtnvcsqjvRi
	cky4Mv1Y1WSw5R228ENvgSk5aUH8ROrb5o82matCB6DLODFJoL1mNY57V+d2QIH1h0PV2aE3caG
	brbR4lLs6k9RAQzFKot3Kk0oqwYrTvKjt1vLmxuLF3sySfgK9+z7qnwWNJ+ePlFpbwxwNzq2dLr
	e4w9No1rZ1FlnKZzPtV7PckdsKYROg9uAmINvjJig25L801u9aITnJhVNBGi2JyGPZgKk3fviG7
	8iNKCAO
X-Received: by 2002:a05:600d:6447:10b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493f2b24cfbmr24906515e9.4.1783686446545;
        Fri, 10 Jul 2026 05:27:26 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ff432sm130984125e9.4.2026.07.10.05.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 05:27:26 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <5ca48a5f-086d-4372-ab3c-1535dcdbe5fc@gmail.com>
Date: Fri, 10 Jul 2026 13:27:25 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/4] crypto: spacc - Add SPAcc Kconfig and Makefile
To: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, herbert@gondor.apana.org.au, robh@kernel.org
Cc: krzk@kernel.org, conor+dt@kernel.org, Ruud.Derwig@synopsys.com,
 rbannerm@synopsys.com, manjunath.hadli@vayavyalabs.com,
 adityak@vayavyalabs.com, navami.telsang@vayavyalabs.com,
 bhoomikak@vayavyalabs.com
References: <20260707125311.2398031-1-pavitrakumarm@vayavyalabs.com>
 <20260707125311.2398031-5-pavitrakumarm@vayavyalabs.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260707125311.2398031-5-pavitrakumarm@vayavyalabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-25824-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pavitrakumarm@vayavyalabs.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk@kernel.org,m:conor+dt@kernel.org,m:Ruud.Derwig@synopsys.com,m:rbannerm@synopsys.com,m:manjunath.hadli@vayavyalabs.com,m:adityak@vayavyalabs.com,m:navami.telsang@vayavyalabs.com,m:bhoomikak@vayavyalabs.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7076073ACA8

Hi Pavitrakumar,

On 7/7/26 13:53, Pavitrakumar Managutte wrote:
> +config CRYPTO_DEV_SPACC_CONFIG_DEBUG
> +	bool "Enable SPAcc debug logs"
> +	default n
> +	help
> +          Say y to enable additional debug prints and diagnostics in the
> +	  SPAcc driver. Disable this for production builds.

This help text still has the indentation formatting issue that I pointed
out on v15:
https://lore.kernel.org/all/deb73385-a7a9-4ea9-8338-b7da999a5e9c@gmail.com/

- Julian Braha


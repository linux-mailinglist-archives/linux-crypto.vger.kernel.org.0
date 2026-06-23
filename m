Return-Path: <linux-crypto+bounces-25330-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id StpoEEqwOmqODwgAu9opvQ
	(envelope-from <linux-crypto+bounces-25330-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 18:11:54 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88716B8991
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 18:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EXzlyHi1;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25330-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25330-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E2763058896
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAF130D3F4;
	Tue, 23 Jun 2026 16:10:20 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0C30D3EC
	for <linux-crypto@vger.kernel.org>; Tue, 23 Jun 2026 16:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231020; cv=none; b=HPwrRDxj0GPpwXNR+7lMa+suTdnBAn25CCt0XUKs1plL+kPGQqWASyTvCCfgbLCHRzT3lKpLHVwAaLnkvE6Ek2AnVtrnw5Nug85Fo49KYbJJm9i8NlBoB78oo4HACAipRhpKmg5zunX/tneRZJb9puI4NP+Lha2j8ZSbR3ZIkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231020; c=relaxed/simple;
	bh=vmkeJhQtJt96i4XbpAtqOBYm0D3OoH3GxeWDRmVKlNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBUIFLJZyV5B1V2XyItZkOSoa1zX9kYOJHQRN2s8v8wpIVgE+ECJb3e2CzzwvIvVjIlCUuNZACk3o4giqPaDCsY2qhL5osg8fPFXomWf8UPCEiqnnPUvrYcsz7Cqlcpi+tTZ8k8h5rVebZgViJzWorvQEGwG27fyQqeaH2nFxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXzlyHi1; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so54073f8f.1
        for <linux-crypto@vger.kernel.org>; Tue, 23 Jun 2026 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231017; x=1782835817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=87UCq5kht4kVk554m6yLxJyrr/TZGMMBzoXy/EG2byU=;
        b=EXzlyHi1KP1boEdjxJ602Sghexe+GaY39PlGia3jTuoeuv7O0fuYvPkXyeB2Bw3TBu
         x9AmLL28KwNfMdKS71CJ/mu4M0hTDusVrBFwY1hiKSw5y+UObooLrbvspFPVLyaySWzv
         wYI9cqpnnm3BevC0s2BwxoPzvM9Q+LWSGyH5Q7Ji1QMOIlXACpLcPd916cCf5YsfTnnp
         cHFcaswa1h12LO9H63NtDbNz9P2TRWWwO93rY3uOavEoh9eo3h/ZxC2e37UMVi1926IP
         M0dYOT3suJRKUm6ydB71nZ4XMq/k7Hp2OuU8X3fzxP2fiqBGUPJGnzaBzggMJ8UhfYLz
         LZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231017; x=1782835817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87UCq5kht4kVk554m6yLxJyrr/TZGMMBzoXy/EG2byU=;
        b=LteUASasHoF0NiyxJ1jDpHaamcAGZqxh8oDuZt5R63IPnHgmc1DV6cFimmfPZqcFZn
         iufG16Z58VRk/WHpiyk04U6XmE/3Keufi6WeD9oZHFWUAgDKjNI3Uvr3JP4v49RdXCjl
         kVbJEh0mIf36OktptLpJzJ/zpLVt4siHgvyXFFclsPAYUvy6FMYA/GRuBLRoP4/wwvex
         wIsvEogTAyLJmf0ACFHoooLVMOzl6ENKmh/DYRMGRxbn+Q8Tj8yk0uGlvSxotL9kJt0d
         L0Sx3I/o2LJnuUXbojgd1Ma1yDgoeT5Pl/4trb2GLsUtE8/x5YW9vteMUNsVpp1GY2kc
         W9uw==
X-Forwarded-Encrypted: i=1; AFNElJ9Rk01njkpX2wMJJ4WOKb6W2a8WmiaYMuT7065q+khIv+EmVCr5zMnC7JirNLxPIVRcqtWzblPC7Bg0Y74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwxsxC+BIdmK+fWn/esCXD+W/h5oPfcG7vHBcuidEKYMLRt40
	JiJ8Z8iFOZnZ+yLGtkKM6lZF6Gzugvq2WsoL5+ixJBn2Ujqu/M6oG51l
X-Gm-Gg: AfdE7ckLa93VBqvxe1Mt5YY8/xCtSrl+hf06ABNMKk8I3PTfgfj8FxHfK5H6yz1BrSO
	++kA4TIv/kMqbbLZhHjJs42/vxsohXXcvgSwjPx/GSvYAWVPKaylbL3J6uA5iheHCI8TzXSXTMB
	CmuAj0w/gGoNp+J9aRcpaDYU7whYC7oJ4Syt2QSPXw9f6fpbSh8Ia7sr4EUkqfIaxEuIKpdB5K+
	3Umz/Mt0CZ+lJEx9R8iuGFteauBoC0HBllxALcxMMBy05HKat/Bq0AdVYYr+MZN/sscVAr1N7Ku
	yjjHE/HTf6QT/8+VEO4bdYlyf/VFp6vqVa3gmXPV0Fv5Dqc3hVdyHJlb6xvzePc86GCHl8c2U/S
	8FQa+vcaUViijXBTRcba/fUMXK2RsrpIql9NNxCSYhdkcH4UhMiPHQhIh6jFO9+TZgagBQ5n9qN
	IHcNQcQcXUEg+YoR/pCpRdyJ5Dx6VVFMelfxF1YIoeoBdTWaMWFjtLU2Bc8sZivL3AJ8z5coCKU
	JWy990A
X-Received: by 2002:a05:600c:c3ce:20b0:490:b294:c652 with SMTP id 5b1f17b1804b1-49240e85c12mr251094265e9.20.1782231016586;
        Tue, 23 Jun 2026 09:10:16 -0700 (PDT)
Received: from [10.128.11.131] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a712sm358628315e9.13.2026.06.23.09.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:10:15 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <a4af663b-b559-4ca7-a0da-84f9c57861db@gmail.com>
Date: Tue, 23 Jun 2026 17:10:14 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/4] crypto: spacc - Add SPAcc Kconfig and Makefile
To: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, herbert@gondor.apana.org.au, robh@kernel.org
Cc: krzk@kernel.org, conor+dt@kernel.org, Ruud.Derwig@synopsys.com,
 rbannerm@synopsys.com, manjunath.hadli@vayavyalabs.com,
 adityak@vayavyalabs.com, navami.telsang@vayavyalabs.com,
 bhoomikak@vayavyalabs.com
References: <20260619144558.1868995-1-pavitrakumarm@vayavyalabs.com>
 <20260619144558.1868995-5-pavitrakumarm@vayavyalabs.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260619144558.1868995-5-pavitrakumarm@vayavyalabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-25330-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pavitrakumarm@vayavyalabs.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk@kernel.org,m:conor+dt@kernel.org,m:Ruud.Derwig@synopsys.com,m:rbannerm@synopsys.com,m:manjunath.hadli@vayavyalabs.com,m:adityak@vayavyalabs.com,m:navami.telsang@vayavyalabs.com,m:bhoomikak@vayavyalabs.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A88716B8991

Hi Pavitrakumar,

On 6/19/26 15:45, Pavitrakumar Managutte wrote:

> diff --git a/drivers/crypto/dwc-spacc/Kconfig b/drivers/crypto/dwc-spacc/Kconfig
> new file mode 100644
> index 0000000000000..b253f8dc539c1
> --- /dev/null
> +++ b/drivers/crypto/dwc-spacc/Kconfig
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config CRYPTO_DEV_SPACC
> +	tristate "Support for dwc_spacc Security Protocol Accelerator"
> +	depends on HAS_DMA
> +	select CRYPTO_ENGINE
> +	default n
> +
> +	help
> +	  This enables support for SPAcc Hardware Accelerator.
> +
> +config CRYPTO_DEV_SPACC_HASH
> +	bool "Enable HASH functionality"
> +	depends on CRYPTO_DEV_SPACC
> +	default y
> +	select CRYPTO_HASH
> +	select CRYPTO_SHA1
> +	select CRYPTO_MD5
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_HMAC
> +	select CRYPTO_SM3
> +	select CRYPTO_CMAC
> +	select CRYPTO_XCBC
> +	select CRYPTO_AES
> +	select CRYPTO_SM4_GENERIC
> +
> +	help
> +	  Say y to enable Hash functionality of SPAcc.
> +
> +config CRYPTO_DEV_SPACC_AUTODETECT
> +	bool "Enable Autodetect functionality"
> +	depends on CRYPTO_DEV_SPACC
> +	default y
> +	help
> +	  Say y to enable Autodetect functionality of SPAcc.
> +
> +config CRYPTO_DEV_SPACC_DEBUG_TRACE_IO
> +	bool "Enable Trace MMIO reads/writes stats"
> +	depends on CRYPTO_DEV_SPACC
> +	default n
> +	help
> +	  Say y to enable Trace MMIO reads/writes stats.
> +	  To Debug and trace IO register read/write oprations.
> +
> +config CRYPTO_DEV_SPACC_DEBUG_TRACE_DDT
> +	bool "Enable Trace DDT entries stats"
> +	default n
> +	depends on CRYPTO_DEV_SPACC
> +	help
> +	  Say y to enable Enable DDT entry stats.
> +	  To Debug and trace DDT opration
> +
> +config CRYPTO_DEV_SPACC_SECURE_MODE
> +	bool "Enable Spacc secure mode stats"
> +	default n
> +	depends on CRYPTO_DEV_SPACC
> +	help
> +	  Say y to enable SPAcc secure modes stats.
> +
> +config CRYPTO_DEV_SPACC_PRIORITY
> +	int "VSPACC priority value"
> +	depends on CRYPTO_DEV_SPACC
> +	range 0 15
> +	default 1
> +	help
> +	  Default arbitration priority weight for this Virtual SPAcc instance.
> +	  Hardware resets this to 1. Higher values means higher priority.
> +
> +config CRYPTO_DEV_SPACC_INTERNAL_COUNTER
> +	int "SPAcc internal counter value"
> +	depends on CRYPTO_DEV_SPACC
> +	range 100000 1048575
> +	default 100000
> +	help
> +	  This value configures a hardware watchdog counter in the SPAcc engine.
> +	  The counter starts ticking when a completed cryptographic job is
> +	  sitting in the STATUS FIFO. If the job remains unprocessed for the
> +	  configured duration, an interrupt is triggered to ensure it is serviced.
> +
> +config CRYPTO_DEV_SPACC_CONFIG_DEBUG
> +	bool "Enable SPAcc debug logs"
> +	default n
> +	depends on CRYPTO_DEV_SPACC
Just a kconfig style thing, it would be a bit cleaner to factor out the
repeated 'depends on CRYPTO_DEV_SPACC' by wrapping the options
in:
`if CRYPTO_DEV_SPACC .. endif`

- Julian Braha


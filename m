Return-Path: <linux-crypto+bounces-3123-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D22892C40
	for <lists+linux-crypto@lfdr.de>; Sat, 30 Mar 2024 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67421F21B89
	for <lists+linux-crypto@lfdr.de>; Sat, 30 Mar 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8903FBAD;
	Sat, 30 Mar 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKaSRplx"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258283BBFF
	for <linux-crypto@vger.kernel.org>; Sat, 30 Mar 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821523; cv=none; b=jcJhoJ4uhMIGtJuZoAWNiHbsXiLTvPQI0mqEkWvTAYKtPFwUZTAnPGXnBJ1oE9yzz3YVdqcY0mI+/cfE3PrTiu9S9tJ4QuaB3jqkUv5IxePXkjJLV0VVWBgee6gXO1Ym3/YFmYpJJlqUeVMs+wi7243upMdCoEYNlxrXgpx0FG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821523; c=relaxed/simple;
	bh=gznZUdRjC840/RIpKY+qbDdAJIfZQ5O12HDGRmxBxms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mLsIutmq49iL5WRAR3afvtKvtpNosRiDfMGLQWCd0CNi2a9WMdEKERPbbrm1peKzJbTO+X8HSa87Lpk/UaERJciRK4wBKGdVFsMJA4x2ywIylIULfMGc82aKv5JSh28ms5VMdIPl7qlvqZPhjVlFr6FRauljE4w6TtDLF7qkU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKaSRplx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4154bf94fe4so11474755e9.2
        for <linux-crypto@vger.kernel.org>; Sat, 30 Mar 2024 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711821519; x=1712426319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuHz7NbYphgsBERKb7Gi6jBAyiMkVdvzVzWkI73/WU8=;
        b=kKaSRplxr4TSUYPNLjqHl4XCyJCVQfQyGkzLvNg+0dWI596k65bnjwXajEk6ovJFer
         ueWceGhzRm2kmkvMxoBIghdPujTLKTqz9igOkbgQH0LAoOSGS63Fxi7MleO9Hfgt6tEz
         TEaIcVg99h3wZLYxmTs7QmIRl6w15lXuD4i5je5bKDNRSUHEN2dNnn+x0TUOtoQFeTno
         apoi8pj3EhHtxH9u6Hk99H0dNGkLMSkp0TEjD1NqAIu0zJZ2BCXVXV5fgceBt28pJ713
         rSRdUCQXNd+nC5dKoENMe8aqN2uJzUk9DwXmw+qIvRzzDh5cQsm27HSkRzXXBwuwfUP4
         GmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711821519; x=1712426319;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuHz7NbYphgsBERKb7Gi6jBAyiMkVdvzVzWkI73/WU8=;
        b=vr/K4ukZxUKc8ZcHL6iQrsjlfsMiOqU//SF4T1vck9uJ248QH8gNdcqPhlq9yKQ730
         4GI0eyx6kGvz8rbwG+WsHApqR/+TYAD8+CtUfFIeAZat41dLVWgSpID6RSX0a4R8fUEb
         Flf1XShHpvhl2N6KPXs+NAngE5P8MqwCiY0E30pRp8BKizg8l/ZxvLG1OtYH4u6vjqRt
         s6agDQ5DDQmkcpOEAthYEVUUZU/jXpMOk+NIQKr+eF3bBM219OW4JmQOfQCUcN0EwElv
         1/sxqDLA2WR2m5pnKYnM9DomCPqS6tbi1pQfEfmpUwUenpxQ8VorIZp5HP+RfnoOlku4
         uqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7l3fEG9qI1EPNo0i4k4ib5gXR24DeDHFYPRLQfROcuDPofNXhyNqpSrRBNk2x/T21Ev66n6GQZ4pWjAFrP9W4A0xFz3R2TM6vfKlh
X-Gm-Message-State: AOJu0Yy25AV40t6gDyvhG8KiiZ/keiEZsMhhCCDchXoUJj5UZwDD19pi
	CzCXKMBIayRYG0/fSA20wOFCB7KUulpr05LStdqfP74DiFc4LO9xazx8oIrCg1g=
X-Google-Smtp-Source: AGHT+IGqlMz1alWRKxGaognRF10drFVQxV6mNURT1OgHL5DqwKDRbiiGAjlSz2Ygixur7KvLK2brog==
X-Received: by 2002:a05:600c:5349:b0:414:8065:2d23 with SMTP id hi9-20020a05600c534900b0041480652d23mr3858145wmb.20.1711821519529;
        Sat, 30 Mar 2024 10:58:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b004149536479esm9235312wms.12.2024.03.30.10.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 10:58:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Russell King <linux@armlinux.org.uk>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-input@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org>
Subject: Re: [PATCH 00/19] amba: store owner from modules with
 amba_driver_register()
Message-Id: <171182151736.34189.6433134738765363803.b4-ty@linaro.org>
Date: Sat, 30 Mar 2024 18:58:37 +0100
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 26 Mar 2024 21:23:30 +0100, Krzysztof Kozlowski wrote:
> Merging
> =======
> All further patches depend on the first amba patch, therefore please ack
> and this should go via one tree.
> 
> Description
> ===========
> Modules registering driver with amba_driver_register() often forget to
> set .owner field.
> 
> [...]

Applied, thanks!

[01/19] amba: store owner from modules with amba_driver_register()
        (no commit info)
[02/19] coresight: cti: drop owner assignment
        (no commit info)
[03/19] coresight: catu: drop owner assignment
        (no commit info)
[04/19] coresight: etm3x: drop owner assignment
        (no commit info)
[05/19] coresight: etm4x: drop owner assignment
        (no commit info)
[06/19] coresight: funnel: drop owner assignment
        (no commit info)
[07/19] coresight: replicator: drop owner assignment
        (no commit info)
[08/19] coresight: etb10: drop owner assignment
        (no commit info)
[09/19] coresight: stm: drop owner assignment
        (no commit info)
[10/19] coresight: tmc: drop owner assignment
        (no commit info)
[11/19] coresight: tpda: drop owner assignment
        (no commit info)
[12/19] coresight: tpdm: drop owner assignment
        (no commit info)
[13/19] coresight: tpiu: drop owner assignment
        (no commit info)
[14/19] i2c: nomadik: drop owner assignment
        (no commit info)
[15/19] hwrng: nomadik: drop owner assignment
        (no commit info)
[16/19] dmaengine: pl330: drop owner assignment
        (no commit info)
[17/19] Input: ambakmi - drop owner assignment
        (no commit info)
[18/19] memory: pl353-smc: drop owner assignment
        (no commit info)
[19/19] vfio: amba: drop owner assignment
        (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



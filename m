Return-Path: <linux-crypto+bounces-14707-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A974BB02F6D
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Jul 2025 10:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0126917D163
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Jul 2025 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9E1F7098;
	Sun, 13 Jul 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KAjsyGaq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8971E7C23
	for <linux-crypto@vger.kernel.org>; Sun, 13 Jul 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393987; cv=none; b=ZMVrSdDIzNr0t8F83z2xIu2m5UrnmjvhJjKIpokcJKK4wCCS9Y3HiV6mPIeSgm0VusqWcuK4mcJUt7jvgjiXwNjGqnmmscAgrlDJJtwPfgoaEXpMHcXFO6RaJzB4rnwezSF2Vgfc5mnkn9WgVs71W9PJAXe/bY5WZ2SmcUGZHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393987; c=relaxed/simple;
	bh=lXJt/yDsoHDSuPe8QmNNkzF3KEBLxNVR5QCRJEM7U6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmIoZUsg3kBV4ft+nu2ChkaAReYR0661U4mIKeodNjf/iKWcREv7dkXkrYc6m5hH1W76FduP9bYmCPE6ZjjHCAWJNTjU9tUE7SLIRrMJnLxGWgx56985yJy42hFLlN7rE1IbPDoFq7cDmJzDtmgynzH4GlRR83KelQ1NrSuMfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KAjsyGaq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso23335625e9.2
        for <linux-crypto@vger.kernel.org>; Sun, 13 Jul 2025 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752393983; x=1752998783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3MxjLEtpRVyTZFb++atMk5EZAHm1SNpE6rDNgKP3WM=;
        b=KAjsyGaqy53gMzniftyt3noWtbYuECU6ma8NVW+SKilgvESX+YXzSkuG+wogG3DutB
         LfXLV5bstJbPDK1gpiu/mlGvIkhWHcbOeGQoct6jnaDl34mE5OjwaBzXIWiB3ijFhLRG
         huAIRoVaxscaMc99OXH9ytq4Jm51Zab4rZm2OUkr/kfEIh6yico8aKiDDTPv4e5XafPf
         PY0M9Zg58mWPOsZeBCJUKfgqDx5u5n+LpunXEgKWDV48egVYIx+9gT85/k8NeT5k3Jao
         gSmEuhXSr65KhWo8cszu1diFaHZyRGfMCWGeUBVlo2SE+9kJl4y5Y7TQnO00YZrFYGzq
         srMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752393983; x=1752998783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3MxjLEtpRVyTZFb++atMk5EZAHm1SNpE6rDNgKP3WM=;
        b=XZ2u5LFKjt+zFhmGKKhxvbSntX6YP/Bo2T6EfBGNz7rEkN2AekEQFYlgK06WsrN7RZ
         KQx40m1QvciCY8g0rFMEowQ6/1s25xwfyp4EvboNrE7/trC3rgcUlTsm9Gj1Ax9I1g6W
         2H5mhc/fHyLHiNp9mQU1Zwf/3ld4Pv5EpZY2IftgtT0appHUOGwqwtgctdbuAbXlE2yn
         mtT7gnMCJZZRhkb5eSOtd3s7ENibEyFfKwBRYyEgcPk1qMLx75KAtVnjTqwqTVF766uf
         yzHpO7DW9Fsvd8Z1zoXZLcOrH+da2OwE0lELi9e8ztuJ20psQmDIsrmQ4bRTVCcjOO9r
         1M3g==
X-Forwarded-Encrypted: i=1; AJvYcCWSEnKO7rodY2AuGtq4feT7p5I5EcLGT4Z10EELvvoj1lbuYj6JsIDwIgg3d3brMZ32z4v1QIct1aVb8z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjY1ejCKxiZEnttrvk99/RbZ4IkO6QzexyrFvASeWsFMdZM8/L
	Gl9dLYWOhaNLi8CMSGxN40E3N+IZtvK66Efh8sLo6xevn92G9EzkWPzWhpF5lkJ/Q70=
X-Gm-Gg: ASbGncua0GX+JvLEn5ub+8m87Zg3yqKHsm75vY1YH8TvFNibEF/dw3qBTuzuhWofG2h
	kjB0Rq3mvbM2BgrkW/SC3qcO2jZ7xuVCl6O3kX0ybsoloon7vWhzwWXeSGDvaVCRQtspfLe3Sm8
	3OF+JAF//wv30Xngljfvj+RWfhMG2bypZnuiZH9rxdP7+dqSErBmv/N0BK766BngVFUx4ijXyG4
	ovyTMXUReHLz+rCUElCl2TMz/Lg7iaMAD6SPh3/FdB8HN2Tqw/rxcde4OLqUBwzSx5dlyiRmaBw
	EleUE9gWd2zRgQPlnJ4jo2hEYfiv5jAf916VuTNV8Tf4ZTVmgj1YPvr7eI9XVk1Ig3XEWhMpRx1
	EgPS3xVjtM7WHGViSRgXFdklpAW5mbS7ir7eTXYhL8ZGOcWE=
X-Google-Smtp-Source: AGHT+IF2dijl2kk5jegjtYU+p2rAjAUxOPkElW1UrGDWDO80C/PI+gSKcgMJoxorFBd7cfrm8u/VBQ==
X-Received: by 2002:a5d:6a49:0:b0:3a5:2848:2e78 with SMTP id ffacd0b85a97d-3b5f18ceba8mr7079826f8f.28.1752393983475;
        Sun, 13 Jul 2025 01:06:23 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:06:23 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:25 +0200
Subject: [PATCH v2 03/15] dt-bindings: crypto: qcom,prng: document Milos
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-3-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=875;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=lXJt/yDsoHDSuPe8QmNNkzF3KEBLxNVR5QCRJEM7U6s=;
 b=YWlNKu1yk/YAFD8w90VWlOFTNCiHXfhuYzMgW1x9mK56voio6ksNRmFDk/XDI+kjQDc4mizBK
 mmfj6LeJyvMD7UovUB4bVNyGfJtrvgMzTuaEsoMvHBWmXosueoYs69L
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document Milos SoC compatible for the True Random Number Generator.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index ed7e16bd11d33c16d0adf02c38419dbaee87ac48..0fdef054a1a30c363e0d99518351fb18124904f0 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,ipq5332-trng
               - qcom,ipq5424-trng
               - qcom,ipq9574-trng
+              - qcom,milos-trng
               - qcom,qcs615-trng
               - qcom,qcs8300-trng
               - qcom,sa8255p-trng

-- 
2.50.1



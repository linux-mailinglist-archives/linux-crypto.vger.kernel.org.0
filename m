Return-Path: <linux-crypto+bounces-24831-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lJx9DdMIH2qwdwAAu9opvQ
	(envelope-from <linux-crypto+bounces-24831-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 18:46:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEB2630595
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 18:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=Dhp1RuoM;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24831-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24831-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FDC6304D713
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C0371CEA;
	Tue,  2 Jun 2026 16:38:40 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FED36F8E4
	for <linux-crypto@vger.kernel.org>; Tue,  2 Jun 2026 16:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418320; cv=none; b=SWVk2r48visrNBkyODRGgDnybfNvHAOqzZditu9/F6qv049/mVl9+jiQYXy23fXdfwslh/X381u+eCv76yrFhdstSFRl1+4wtHmwzvewxaK8HgACWOvHYApR/8VxauF6IklFmnWl4poUQ7YgT5IJyVENVAJ0BYdfcI7qDQXdFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418320; c=relaxed/simple;
	bh=SqqoX5qQzGE5eNHSgLyrNrWlqXnwPa/uOKYx/N6zAZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deeaQWooMoyifU6zYFnBoaZgTuxuBbk9quFSXuyRJPJrbxCnzvYOkjUgOMhh9bAtU0GNERsC1iseBjqaxUqjVM8E5VqiHUi6Eh9dvgSaLRYzfau75oG05RZRL0SbtDG7+OYWjFjvXosjS76uLO3N8MyGZnX+C+OxR4P28ptWXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dhp1RuoM; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so2188955e9.0
        for <linux-crypto@vger.kernel.org>; Tue, 02 Jun 2026 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780418318; x=1781023118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SqqoX5qQzGE5eNHSgLyrNrWlqXnwPa/uOKYx/N6zAZQ=;
        b=Dhp1RuoMIgkOz1tIgivCGlzcEfCM/F0TwNwrOlD30SOrPUP9X0pk1jKf45MVZXD2qB
         Y0U2Vh/tibUVKER8x1Wo8FLqPs+VhIPGR222R58rC2yCrEfGdyQvYBOE+pEfchOdbhkt
         pU0giNtPmGEguen+ViRMghJUGwIMgKi17GuJksCNJtyfUNChDz/NmidxQjstu3eUEQOs
         xrFrShXa3Na1mri/KdchGz82zqQrrsxTxWshTVVGcANc39kYo8SSegNQ/J3H84x6x7S4
         aphwriiQvgNf31lUKqNreRJvIPavKKUfsDPrxRkdD/3WnNff4c7FXxWQCPyX6HXerUQT
         PGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418318; x=1781023118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqqoX5qQzGE5eNHSgLyrNrWlqXnwPa/uOKYx/N6zAZQ=;
        b=BjCLpuA3NQl6FYBtRm1HlqGpYoJgRz2Y2HYcUFWrd5+A8xwDFq8jvRIdjyvNlUX2zT
         pI0hTSyVfk8Vf8e1CNb/xd78n9kZosi/RlyBtCQSbW6EOtE3NG07+y0ud3QqeJxDixZA
         nw7GZogw+2m63shURu10nI0dl0Ce++daVJwQ6Ly5ZMAtxoHCt8oKg3UG7gK19v7axuTV
         DW7wodhTcptbRB7OvnXeIh113R9WCWi0oVYsf61hAbISJ3wqruRBlscUCE4rEw8OJXR0
         wiFYmGZWxUCioa85WfMumRGzl41pFaVPHCm78V1EjbkWJDNzm6rXqlgh8uDVCFq+JEiT
         Nm0g==
X-Forwarded-Encrypted: i=1; AFNElJ/MFqwnn/XGSRsOb+1jathdZpww4BsRvgqvwM3ZDZKRH8tG00C31egwQuA4h+8MKEcczAEzUi25QlmTX2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmO0TZoqhBPAc4+IT1YyLoRix5uLofpzQmZPysEZiJhhcsgD4
	7J+1B8J8IL/md7aRePn4os4usAIlgxifD32bnFxDqYLRZLI4vW+1LV+y3Fji17ZmPXU=
X-Gm-Gg: Acq92OHdNA0MsqjFTmNB2Jya23yFXBMX44+OpfvZ3aGuK9V/DyjmVisBm3FcKkhtp7i
	ZYIjrGT91JPVEB8uPPhWnniG77hyc96sXFdDSYBy9La+I4crSk28Yh/q2vt+xoA43jRgu4MO6xO
	7yCI4NlDihew0cK5pDGZJAUFYofCsS7DitZ3UnJF4a4tUg/u6p4U383YG7lE8TaLvNRIkm06LTh
	KPb+duun7t2SxcPg24RZI/DEdxW+PI72ODntaasIzw9dT3eExMFWr67ZUDQPlG4SvJRW0VhQMqO
	f1rHJjVIBq3bW+962aYMr672fjuXi5YzWguznWPMcZbc7iKSpLvwXW790Tm1TEE+e/+E+PG1E7f
	6jP5ykCgmi+9fKuQJtGKZhdMCRvWutD+1Y/e716qokOOxz+/lqhgWzpg4hxtjFgVGkjNa5wVODg
	qIkKlzmT93ToTjjnUZ7T8LhOwmTPCCtyh0wls1R0mnxZ4oMA==
X-Received: by 2002:a05:600c:608e:b0:48f:d1c0:5cd3 with SMTP id 5b1f17b1804b1-490b5065ee5mr8757815e9.13.1780418317804;
        Tue, 02 Jun 2026 09:38:37 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4410:9db1:6daa:c0a7:d3cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm407269f8f.10.2026.06.02.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:38:37 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:38:21 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	brgl@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v19 00/14] crypto/dmaengine: qce: introduce BAM locking
 and use DMA for register I/O
Message-ID: <ah8G_ajPS1KhgPP_@linaro.org>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,codeaurora.org,linaro.org,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-24831-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[stephan.gerhold@linaro.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,linaro.org:mid,linaro.org:from_mime,linaro.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEEB2630595

On Tue, May 26, 2026 at 03:10:48PM +0200, Bartosz Golaszewski wrote:
> I feel like I fell into the trap of trying to address pre-existing
> issues reported by sashiko and in the process provoking more reports so
> let this be the last iteration where I do this. Vinod can we get this
> queued for v7.2 now and iron out any previously existing problems in
> tree?

Thanks a lot for working on fixing all these issues!

I agree there is no point addressing all the "pre-existing issues"
pointed out by Sashiko, but have you looked through the other comments
for new issues pointed out for your patches?

Out of curiosity, I was looking a bit at the comments for [PATCH v19
06/14] dmaengine: qcom: bam_dma: add support for BAM locking [1]. There
are 8 open comments there (Critical: 1, High: 6 and Medium: 1). From a
quick look I would say most of these could be valid. The critical one
about the usage of dma_cookie_assign() sounds a bit concerning to me, if
it is true we would be basically breaking parts of the dmaengine API for
consumers by inserting the lock descriptor in front of everything else.

[1]: https://sashiko.dev/#/patchset/20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a%40oss.qualcomm.com?part=6

Thanks,
Stephan

